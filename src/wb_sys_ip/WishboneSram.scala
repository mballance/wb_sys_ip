package wb_sys_ip

import chisel3._
import chisel3.util._
import chisel3.experimental._
import std_protocol_if.Wishbone

class WishboneSram(val p : WishboneSram.Parameters) extends Module {
  
  val io = IO(new Bundle {
    val s = Flipped(new Wishbone(p.wb_p))
  })
 
  val u_sram = Module(new wb_sram_w(p))
  
  u_sram.io.clk := clock
  u_sram.io.rst := reset
  u_sram.io.ADR := io.s.req.ADR
  u_sram.io.TGA := io.s.req.TGA
  u_sram.io.CTI := io.s.req.CTI
  u_sram.io.BTE := io.s.req.BTE
  u_sram.io.DAT_W := io.s.req.DAT_W
  u_sram.io.TGD_W := io.s.req.TGD_W
  io.s.rsp.DAT_R := u_sram.io.DAT_R
  io.s.rsp.TGD_R := u_sram.io.TGD_R
  u_sram.io.CYC := io.s.req.CYC
  u_sram.io.TGC := io.s.req.TGC
  io.s.rsp.ERR := u_sram.io.ERR
  u_sram.io.SEL := io.s.req.SEL
  u_sram.io.STB := io.s.req.STB
  io.s.rsp.ACK := u_sram.io.ACK
  u_sram.io.WE := io.s.req.WE
  
}

class wb_sram_w(val p : WishboneSram.Parameters) extends BlackBox(
  Map("MEM_ADDR_BITS" -> p.MEM_ADDR_BITS.toInt,
      "WB_ADDRESS_WIDTH" -> p.wb_p.ADDR_WIDTH.toInt,
      "WB_DATA_WIDTH" -> p.wb_p.DATA_WIDTH.toInt,
      "INIT_FILE" -> p.INIT_FILE)) {
  
  val io = IO(new Bundle {
    val clk = Input(Clock())
    val rst = Input(Bool())
    val ADR = Input(UInt(p.wb_p.ADDR_WIDTH.W))
    val TGA = Input(UInt(1.W))
    val CTI = Input(UInt(3.W))
    val BTE = Input(UInt(2.W))
    val DAT_W = Input(UInt(p.wb_p.DATA_WIDTH.W))
    val TGD_W = Input(UInt(1.W))
    val DAT_R = Output(UInt(p.wb_p.DATA_WIDTH.W))
    val TGD_R = Output(UInt(1.W))
    val CYC = Input(Bool())
    val TGC = Input(UInt(1.W))
    val ERR = Output(Bool())
    val SEL = Input(UInt((p.wb_p.DATA_WIDTH/8).W))
    val STB = Input(Bool())
    val ACK = Output(Bool())
    val WE = Input(Bool())
  })
  
}

object WishboneSram {
  class Parameters(
    val MEM_ADDR_BITS : Int = 10,
    val wb_p : Wishbone.Parameters,
    val INIT_FILE : String = ""
  ) { }
  
}