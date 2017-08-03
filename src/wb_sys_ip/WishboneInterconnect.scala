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
    
  val in_rsp = Seq.fill(p.N_MASTERS) ( Wire(new WishboneMaster(p.wb_p) ))
  val out_rsp = Seq.fill(p.N_SLAVES) ( Wire(new WishboneMaster(p.wb_p) ))
  
  for (i <- 0 until p.N_MASTERS) {
    // Drive back to master
    in_rsp(i).assign_rsp2p(io.m(i));
  }
  
  val out_arb = Seq.fill(p.N_SLAVES) ( Module(new RRArbiter(
      new WishboneMaster(p.wb_p), p.N_MASTERS)) )

  // For each slave, hook up all masters
  for (i <- 0 until p.N_SLAVES) {
    for (j <- 0 until p.N_MASTERS) {
      val m_sel = io.addr_base.indexWhere((p:UInt) => (io.m(j).ADR >= p))
      val m_ex = (io.addr_base.exists((p:UInt) => (io.m(j).ADR >= p)) &&
          io.addr_limit.exists((p:UInt) => (io.m(j).ADR <= p)));
      out_arb(i).io.in(j).bits.assign_p2req(io.m(j))

      when (m_ex && m_sel === i.asUInt()) {
        out_arb(i).io.in(j).valid := Bool(true);
      } .otherwise {
        out_arb(i).io.in(j).valid := Bool(false);
      }
      
      // Propagate slave response back to active master
      when (out_arb(i).io.in(j).ready /* out_arb(i).io.in(j).valid && 
          out_arb(i).io.chosen === j.asUInt() */) {
          in_rsp(j) := out_rsp(i);
      } .otherwise {
          in_rsp(j).park_rsp();
      }
    }
    out_arb(i).io.out.bits.assign_req2p(io.s(i));
  }
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
