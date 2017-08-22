package wb_sys_ip

import std_protocol_if.WishboneParameters
import chisel3._
import chisel3.util._
import std_protocol_if._

class WishboneTestMasterParameters(
    val N_SLAVES  : Int=1,
    val wb_p      : WishboneParameters) {
}

class WishboneTestMaster(
    p : WishboneTestMasterParameters,
    val typename : String = "WishboneTestMaster") extends Module {
  val io = IO(new Bundle {
    val addr_base = Input(Vec(p.N_SLAVES, UInt(p.wb_p.ADDR_WIDTH.W)))
    val m = new WishboneMaster(p.wb_p)
  });
  
  override def desiredName() : String = typename;
  
 
  val sADDR_REQ :: sWAIT_ACK :: sIDLE :: Nil = Enum(3)
  val reqState = RegInit(sADDR_REQ)
  val idleCnt = RegInit(UInt(8.W), 0.asUInt())
  val idleCounter = RegInit(UInt(8.W), 0.asUInt())
  val ADR = RegInit(UInt(p.wb_p.ADDR_WIDTH.W), 0.asUInt())
  val WE = RegInit(UInt(1.W), 0.asUInt())
  
  io.m.STB := (reqState === sADDR_REQ || reqState === sWAIT_ACK)
  io.m.CYC := (reqState === sADDR_REQ || reqState === sWAIT_ACK)
  
  val inc = (reqState === sADDR_REQ)
  val rand_gen = LFSR16(inc);
  
  val n_slave_bits = 1;
  val rw_bit = (n_slave_bits);
  val addr_offset_bit = (rw_bit+1)
  val addr_offset_bits = 2
  
  io.m.ADR := ADR;
  io.m.WE := WE;
  
  switch (reqState) {
    is (sADDR_REQ) {
      reqState := sWAIT_ACK
      idleCnt := rand_gen
      // TODO: need to do a proper ceil() calculation on the bits
      ADR := (io.addr_base(rand_gen(n_slave_bits,0)) +
        (rand_gen(addr_offset_bit+addr_offset_bits, addr_offset_bit) * 4.asUInt()));
      WE := (rand_gen(rw_bit) === 1.asUInt())
    }
    is (sWAIT_ACK) {
      when (io.m.ACK) {
        reqState := sIDLE
        ADR := 0.asUInt();
        WE := 0.asUInt();
        idleCounter := 0.asUInt()
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

object WishboneTestMaster extends App {
  var N_SLAVES = 4;
  var ADDR_WIDTH = 32;
  var DATA_WIDTH = 32;
  
  var typename = "wishbone_test_master_%d_%d_%d".format(
      ADDR_WIDTH, DATA_WIDTH, N_SLAVES);
  
  chisel3.Driver.execute(args, () => new WishboneTestMaster(
      new WishboneTestMasterParameters(N_SLAVES,
          wb_p=new WishboneParameters(ADDR_WIDTH, DATA_WIDTH)
          ), typename)
  )
}
