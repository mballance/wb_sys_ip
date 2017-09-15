package wb_sys_ip

import chisel3._
import chisel3.util._
import std_protocol_if._

class WishboneTestMasterParameters(
    val N_SLAVES  : Int=1,
    val wb_p      : Wishbone.Parameters) {
}

/*
 *   assign _T_43 = rand_gen[0];
  assign _T_44 = rand_gen[2];
  assign _T_45 = _T_43 ^ _T_44;
  assign _T_46 = rand_gen[3];
  assign _T_47 = _T_45 ^ _T_46;
  assign _T_48 = rand_gen[5];
  assign _T_49 = _T_47 ^ _T_48;
  assign _T_50 = rand_gen[15:1];
  assign _T_51 = {_T_49,_T_50};
  assign _GEN_1 = _T_35 ? _T_51 : rand_gen;
 */

class WishboneTestMaster(
    p : WishboneTestMasterParameters,
    val typename : String = "WishboneTestMaster") extends Module {
  val io = IO(new Bundle {
    val addr_base = Input(Vec(p.N_SLAVES, UInt(p.wb_p.ADDR_WIDTH.W)))
    val m = new Wishbone(p.wb_p)
  });
  
  override def desiredName() : String = typename;
  
 
  val sADDR_REQ :: sWAIT_ACK :: sIDLE :: Nil = Enum(3)
  val reqState = RegInit(sADDR_REQ)
  val idleCnt = RegInit(UInt(8.W), 0.asUInt())
  val idleCounter = RegInit(UInt(8.W), 0.asUInt())
  val ADR = RegInit(UInt(p.wb_p.ADDR_WIDTH.W), 0.asUInt())
  val WE = RegInit(UInt(1.W), 0.asUInt())
  val DAT_W = RegInit(UInt(p.wb_p.DATA_WIDTH.W), 1.asUInt())
  val DAT_LAST_R = RegInit(UInt(p.wb_p.DATA_WIDTH.W), 1.asUInt())
  
  io.m.req.STB := ((reqState === sADDR_REQ || reqState === sWAIT_ACK) && reset === Bool(false))
  io.m.req.CYC := ((reqState === sADDR_REQ || reqState === sWAIT_ACK) && reset === Bool(false)) 
  
  val inc = (reqState === sADDR_REQ)
  val rand_gen = LFSR16(inc);
  
  val n_slave_bits = 1;
  val rw_bit = (n_slave_bits);
  val addr_offset_bit = (rw_bit+1)
  val addr_offset_bits = 2
  
  io.m.req.ADR := ADR;
  io.m.req.WE := WE;
  io.m.req.DAT_W := DAT_W;
  io.m.req.CTI := 1.asUInt()
  io.m.req.BTE := 1.asUInt()
  io.m.req.SEL := 15.asUInt()
  io.m.req.TGA := 0.asUInt()
  io.m.req.TGC := 0.asUInt()
  
  switch (reqState) {
    is (sADDR_REQ) {
      reqState := sWAIT_ACK
      idleCnt := rand_gen
    }
    is (sWAIT_ACK) {
      when (io.m.rsp.ACK) {
        if (WE == 0.asUInt()) {
          DAT_LAST_R := io.m.rsp.DAT_R;
        }
        reqState := sIDLE
        ADR := 0.asUInt();
        WE := 0.asUInt();
        idleCounter := 0.asUInt()
       
        // Setup for the next access
        // TODO: need to do a proper ceil() calculation on the bits
//        ADR := (io.addr_base(rand_gen(n_slave_bits,0)) +
//          (rand_gen(addr_offset_bit+addr_offset_bits, addr_offset_bit) * 4.asUInt()));
        ADR := io.addr_base(rand_gen(n_slave_bits,0))
        WE := (rand_gen(rw_bit) === 1.asUInt())
      
        when (rand_gen(rw_bit) === 1.asUInt()) {
          DAT_W := (rand_gen ^ DAT_LAST_R) + 1.asUInt();
        }
      }
    }
    is (sIDLE) {
      when (idleCnt === idleCounter) {
        reqState := sADDR_REQ       
      } .otherwise {
        idleCounter := idleCounter + 1.asUInt()
      }
    }
  }
}

object WishboneTestMasterDriver extends App {
  var N_SLAVES = 4;
  var ADDR_WIDTH = 32;
  var DATA_WIDTH = 32;
  
  var typename = "wishbone_test_master_%d_%d_%d".format(
      ADDR_WIDTH, DATA_WIDTH, N_SLAVES);
  
  val null_args = Array[String]()
  
  chisel3.Driver.execute(null_args, () => new WishboneTestMaster(
      new WishboneTestMasterParameters(N_SLAVES,
          wb_p=new Wishbone.Parameters(ADDR_WIDTH, DATA_WIDTH)
          ), typename)
  )
}
