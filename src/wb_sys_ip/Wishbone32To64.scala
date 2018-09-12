package wb_sys_ip

import chisel3._
import chisel3.util._
import std_protocol_if.Wishbone

class Wishbone32To64 extends Module {
  
  val io = IO(new Bundle {
    val i = Flipped(new Wishbone(new Wishbone.Parameters(32, 32)))
    val o = new Wishbone(new Wishbone.Parameters(32, 64))
  })

  io.o.req.ADR := io.i.req.ADR
  io.o.req.BTE := io.i.req.BTE
  io.o.req.CTI := io.i.req.CTI
  io.o.req.CYC := io.i.req.CYC
  
  // Route SEL to the correct lanes and DAT_R
  when (io.i.req.ADR(2) === 1.asUInt()) {
    io.o.req.SEL := Cat(io.i.req.SEL, Fill(4, 0.asUInt()))
    io.i.rsp.DAT_R := io.o.rsp.DAT_R(63,32)
  } .otherwise {
    io.o.req.SEL := Cat(Fill(4, 0.asUInt()), io.i.req.SEL)
    io.i.rsp.DAT_R := io.o.rsp.DAT_R(31,0)
  }
  
  // Always pass write data through as-is
  io.o.req.DAT_W := Cat(io.i.req.DAT_W, io.i.req.DAT_W)
  
  io.o.req.STB := io.i.req.STB
  io.o.req.TGA := io.i.req.TGA
  io.o.req.TGC := io.i.req.TGC
  io.o.req.TGD_W := io.i.req.TGD_W
  io.o.req.WE := io.i.req.WE

  io.i.rsp.ACK := io.o.rsp.ACK
  io.i.rsp.ERR := io.o.rsp.ERR
  io.i.rsp.TGD_R := io.o.rsp.TGD_R
  
}