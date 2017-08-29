package wb_sys_ip

import chisel3._
import chisel3.util._
import std_protocol_if._
import scopt.OptionParser

class WishboneInterconnectParameters(
    val N_MASTERS  : Int=1,
    val N_SLAVES   : Int=1,
    val wb_p       : WishboneParameters) {
}

class WishboneInterconnect(
    val p : WishboneInterconnectParameters,
    val typename : String = "WishboneInterconnect") extends Module {

    val io = IO(new Bundle {
      val addr_base  = Input(Vec(p.N_SLAVES, UInt(p.wb_p.ADDR_WIDTH.W)))
      val addr_limit = Input(Vec(p.N_SLAVES, UInt(p.wb_p.ADDR_WIDTH.W)))
   
      val m = Vec(p.N_MASTERS, Flipped(new WishboneMaster(p.wb_p)))
      val s = Vec(p.N_SLAVES, new WishboneMaster(p.wb_p))
  });
    
  override def desiredName() : String = typename;
  
  val out_arb = Seq.fill(p.N_SLAVES) ( Module(new LockingRRArbiter(
      new WishboneReqData(p.wb_p), 
      p.N_MASTERS, 
      10000, 
      Some((p : WishboneReqData) => {
        (p.CYC && p.STB)
      }) )))
      
  for (i <- 0 until p.N_MASTERS) {
   
    // Create an array of slave-mux select signals 
    // from the address map. Each element indicates
    // whether this master selects a given slave
    val slave_req = io.addr_base.zip(io.addr_limit).map(e => (
        io.m(i).ADR >= e._1 && io.m(i).ADR <= e._2) &&
        io.m(i).CYC && io.m(i).STB)

    val in_rsp_s = Seq.fill(p.N_SLAVES) (Wire(new WishboneRspData(p.wb_p)))
    val in_rsp_e = Seq.fill(p.N_SLAVES) (Wire(new Bool()))

    // Mux the appropriate slave response back to the master
    // -> Or an error if no slave is selected
    // -> Or tie of the response if no cycle is in progress
    when (io.m(i).CYC && io.m(i).STB) {
      when (slave_req.reduceLeft(_ | _) === Bool(true)) {
        // Drive the master response with a priority mux
        Mux1H(in_rsp_e, in_rsp_s).assign_b2(io.m(i))
      } .otherwise {
        io.m(i).error_rsp()
      }
    } .otherwise {
        io.m(i).park_rsp()
    }
    
    for (j <- 0 until p.N_SLAVES) {
      in_rsp_e(j) := (slave_req(j) && out_arb(j).io.chosen === i.asUInt())
     
      out_arb(j).io.in(i).bits.assign_2b(io.m(i))
     
      // Connect the response from each slave to the response mux
      in_rsp_s(j).assign_2b(io.s(j))
      
      out_arb(j).io.in(i).valid := slave_req(j)

      // Drive the slave request signals from the slave-arbiter output
      when (out_arb(j).io.in.map((f) => f.valid).reduceLeft(_|_)) {
        out_arb(j).io.out.bits.assign_b2(io.s(j));
      } .otherwise {
        // If no master is requesting, deactivate the slave requests
        io.s(j).park_req()
      }
      out_arb(j).io.out.ready := Bool(true);
    }
  }  
}

private object ArbiterCtrl {
  def apply(request: Seq[Bool]): Seq[Bool] = request.length match {
    case 0 => Seq()
    case 1 => Seq(true.B)
    case _ => true.B +: request.tail.init.scanLeft(request.head)(_ || _).map(!_)
  }
}

abstract class LockingArbiterLike[T <: Data](gen: T, n: Int, count: Int, needsLock: Option[T => Bool]) extends Module {
  protected def grant: Seq[Bool]
  protected def choice: UInt
  val io = IO(new ArbiterIO(gen, n))

  io.chosen := choice
  io.out.valid := io.in(io.chosen).valid
  io.out.bits := io.in(io.chosen).bits

  if (count > 1) {
    val lockCount = Counter(count)
    val lockIdx = Reg(UInt())
    val locked = RegInit(Bool(), Bool(false)) // lockCount.value =/= 0.U
    val wantsLock = needsLock.map(_(io.out.bits)).getOrElse(true.B)

    when (io.out.fire()) {
      locked := Bool(true)
      lockIdx := io.chosen
//      when (wantsLock) {
//        lockIdx := io.chosen
//      } .otherwise {
//        locked := Bool(false)
//      }
//      lockCount.inc()
    } .otherwise {
      locked := Bool(false)
    }

    when (locked) { io.chosen := lockIdx }
    
    for ((in, (g, i)) <- io.in zip grant.zipWithIndex)
      in.ready := Mux(locked, lockIdx === i.asUInt, g) && io.out.ready
  } else {
    for ((in, g) <- io.in zip grant)
      in.ready := g && io.out.ready
  }
}

class LockingRRArbiter[T <: Data](gen: T, n: Int, count: Int, needsLock: Option[T => Bool] = None)
    extends LockingArbiterLike[T](gen, n, count, needsLock) {
  private lazy val lastGrant = RegEnable(io.chosen, 0.asUInt(), io.out.fire()) // Change to have reset value
  private lazy val grantMask = (0 until n).map(_.asUInt > lastGrant)
  private lazy val validMask = io.in zip grantMask map { case (in, g) => in.valid && g }

  override protected def grant: Seq[Bool] = {
    val ctrl = ArbiterCtrl((0 until n).map(i => validMask(i)) ++ io.in.map(_.valid))
    (0 until n).map(i => ctrl(i) && grantMask(i) || ctrl(i + n))
  }

  override protected lazy val choice = Wire(init=(n-1).asUInt)
  for (i <- n-2 to 0 by -1)
    when (io.in(i).valid) { choice := i.asUInt }
  for (i <- n-1 to 1 by -1)
    when (validMask(i)) { choice := i.asUInt }
}

class SimpleBundle extends Bundle {
  val v1 = Input(Bool())
  val v2 = Output(Bool())
 
}

class MuxExample extends Module {
  val io = IO(new Bundle {
    val in = Input(Vec(4, new SimpleBundle()))
    val sel = Input(Bits(4.W))
    val out = Output(new SimpleBundle())
  })
 
  io.out := PriorityMux(io.sel, io.in);
  
}

object MuxExampleDriver extends App {
  chisel3.Driver.execute(args, () => new MuxExample())
}

//  val null_args = Seq[String]().toArray;

object WishboneInterconnectDriver extends App {
    var N_MASTERS = 2;
    var N_SLAVES = 4;
    var ADDR_WIDTH = 32;
    var DATA_WIDTH = 32;
 
  var typename = "wishbone_ic_%d_%d_%dx%d".format(
      ADDR_WIDTH, DATA_WIDTH, N_MASTERS, N_SLAVES);
  
  chisel3.Driver.execute(args, () => new WishboneInterconnect(
      new WishboneInterconnectParameters(N_MASTERS, N_SLAVES,
          wb_p=new WishboneParameters(ADDR_WIDTH, DATA_WIDTH)
      ), typename)
  )
}

class NamedRRArbiter[T <: Data](
    gen:T, 
    n: Int,
    val typename : String = "RRArbiter") extends RRArbiter[T](gen, n) {
  
  override def desiredName() : String = typename;
}