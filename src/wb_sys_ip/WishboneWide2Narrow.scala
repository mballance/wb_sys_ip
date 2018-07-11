package wb_sys_ip

import std_protocol_if.Wishbone
import chisel3._
import chisel3.util.Cat

class WishboneWide2Narrow(
    val i_p : Wishbone.Parameters,
    val o_p : Wishbone.Parameters) extends Module {
  require(i_p.ADDR_WIDTH == o_p.ADDR_WIDTH)

  val io = IO(new Bundle {
    val i = Flipped(new Wishbone(i_p))
    val o = new Wishbone(o_p)
  })

  // Just assume 32-bit transfers for now

  io.o.req.ADR := io.i.req.ADR
  io.o.req.BTE := io.i.req.BTE
  io.o.req.CTI := io.i.req.CTI
  io.o.req.CYC := io.i.req.CYC
  // TODO: assume 64 to 32 for now
  when (io.i.req.SEL(3,0) =/= 0.asUInt()) {
    io.o.req.DAT_W := io.i.req.DAT_W(31,0)
    io.o.req.SEL := io.i.req.SEL(3,0)
  } .otherwise {
    io.o.req.DAT_W := io.i.req.DAT_W(63,32)
    io.o.req.SEL := io.i.req.SEL(7,4)
  }
  io.o.req.STB := io.i.req.STB
  io.o.req.TGA := io.i.req.TGA
  io.o.req.TGC := io.i.req.TGC
  io.o.req.TGD_W := io.i.req.TGD_W
  io.o.req.WE := io.i.req.WE

  io.i.rsp.ACK := io.o.rsp.ACK
  io.i.rsp.ERR := io.o.rsp.ERR
  io.i.rsp.TGD_R := io.o.rsp.TGD_R
//  io.i.rsp.DAT_R(63,32) := io.o.rsp.DAT_R
  io.i.rsp.DAT_R := Cat(io.o.rsp.DAT_R, io.o.rsp.DAT_R)
//  io.i.rsp.DAT_R(31,0) := io.o.rsp.DAT_R(31,0)
  
//  io.i <> io.o
}