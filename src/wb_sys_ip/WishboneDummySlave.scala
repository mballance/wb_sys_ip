package wb_sys_ip

import chisel3._
import chisel3.util._
import std_protocol_if._

class WishboneDummySlave(
    p : Wishbone.Parameters = new Wishbone.Parameters()
    ) extends Module {
  
  val io = IO(new Bundle {
    val s = Flipped(new Wishbone(p))
  });

  val req = (io.s.req.CYC & io.s.req.STB);
  val ack = RegNext(req);
 
  io.s.rsp.ACK := ack
  io.s.rsp.DAT_R := 0.asUInt()
  io.s.rsp.ERR := 0.asUInt();
  
}