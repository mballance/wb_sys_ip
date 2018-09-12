package wb_sys_ip

import chisel3.Bool
import chisel3.Bundle
import chisel3.Flipped
import chisel3.Module
import chisel3.RegInit
import chisel3.fromtIntToLiteral
import chisel3.util.Enum
import chisel3.util.Fill
import chisel3.util.is
import chisel3.util.switch
import chisel3.when
import std_protocol_if.AXI4
import std_protocol_if.Wishbone

class Wishbone32Master2Axi64 extends Module {

  val io = IO(new Bundle {
    val wb = Flipped(new Wishbone(new Wishbone.Parameters(32,32)))
    val axi = new AXI4(new AXI4.Parameters(22, 64))
  });
  
  io.wb.rsp.ERR := Bool(false)
 
  // Access state machine
//  val sWaitWBReq :: sWaitAxiReadAddrAck :: sWaitAxiWriteAddrAck :: sWaitAxiWriteDataAck :: Nil = Enum(4)
//  val access_state = RegInit(sWaitWBReq)
//  
//  when (access_state === sWaitAxiWriteAddrAck || 
//      access_state === sWaitAxiWriteDataAck) {
//    switch (io.wb.req.SEL) {
//    is (1.asUInt()) {
//      io.axi.wreq.WDATA := Fill(8, io.wb.req.DAT_W(7,0))
//      when (io.wb.req.ADR(2) === 1.asUInt()) {
//        io.axi.wreq.WSTRB := (1 << 4).asUInt()
//      } .otherwise {
//        io.axi.wreq.WSTRB := 1.asUInt()
//      }
//    }
//    
//    is (2.asUInt()) {
//      io.axi.wreq.WDATA := Fill(8, io.wb.req.DAT_W(7,0))
//      when (io.wb.req.ADR(2) === 1.asUInt()) {
//        io.axi.wreq.WSTRB := (2 << 4).asUInt()
//      } .otherwise {
//        io.axi.wreq.WSTRB := 2.asUInt()
//      }
//    }
//    
//    is (4.asUInt()) {
//      io.axi.wreq.WDATA := Fill(8, io.wb.req.DAT_W(7,0))
//      when (io.wb.req.ADR(2) === 1.asUInt()) {
//        io.axi.wreq.WSTRB := (4 << 4).asUInt()
//      } .otherwise {
//        io.axi.wreq.WSTRB := 4.asUInt()
//      }
//    }
//    
//    is (8.asUInt()) {
//      io.axi.wreq.WDATA := Fill(8, io.wb.req.DAT_W(7,0))
//      when (io.wb.req.ADR(2) === 1.asUInt()) {
//        io.axi.wreq.WSTRB := (8 << 4).asUInt()
//      } .otherwise {
//        io.axi.wreq.WSTRB := 8.asUInt()
//      }
//    }
//    
//    is (3.asUInt()) {
//      io.axi.wreq.WDATA := Fill(4, io.wb.req.DAT_W(15,0))
//      when (io.wb.req.ADR(2) === 1.asUInt()) {
//        io.axi.wreq.WSTRB := (3 << 4).asUInt()
//      } .otherwise {
//        io.axi.wreq.WSTRB := 3.asUInt()
//      }
//    }
//    
//    is (0xC.asUInt()) {
//      io.axi.wreq.WDATA := Fill(4, io.wb.req.DAT_W(15,0))
//      when (io.wb.req.ADR(2) === 1.asUInt()) {
//        io.axi.wreq.WSTRB := (0xC << 4).asUInt()
//      } .otherwise {
//        io.axi.wreq.WSTRB := 0xC.asUInt()
//      }
//    }
//    
//    is (0xF.asUInt()) {
//      io.axi.wreq.WDATA := Fill(2, io.wb.req.DAT_W)
//      when (io.wb.req.ADR(2) === 1.asUInt()) {
//        io.axi.wreq.WSTRB := (0xF << 4).asUInt()
//      } .otherwise {
//        io.axi.wreq.WSTRB := 0xF.asUInt()
//      }
//    }
//    }
//    io.axi.wreq.WLAST := Bool(true)
//  } .otherwise {
//    io.axi.wreq.WDATA := 0.asUInt()
//    io.axi.wreq.WSTRB := 0.asUInt()
//    io.axi.wreq.WLAST := Bool(false)
//  }
// 
//  switch (access_state) {
//    is (sWaitWBReq) {
//      when (io.wb.req.CYC && io.wb.req.STB) {
//        when (io.wb.req.WE) {
//          access_state := sWaitAxiWriteAddrAck
//        }
//      }
//    }
//    
//    is (sWaitAxiReadAddrAck) {
//      
//    }
//  }
  
  
}