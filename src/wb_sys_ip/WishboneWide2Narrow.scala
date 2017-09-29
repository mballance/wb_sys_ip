package wb_sys_ip

import std_protocol_if.Wishbone
import chisel3._

class WishboneWide2Narrow(
    val i_p : Wishbone.Parameters,
    val o_p : Wishbone.Parameters) extends Module {
  require(i_p.ADDR_WIDTH == o_p.ADDR_WIDTH)

  val io = IO(new Bundle {
    val i = Flipped(new Wishbone(i_p))
    val o = new Wishbone(o_p)
  })

  // Just assume 32-bit transfers for now
  
  io.i <> io.o
}