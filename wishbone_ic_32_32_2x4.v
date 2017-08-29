`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif

module LockingRRArbiter(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [31:0] io_in_0_bits_ADR,
  input         io_in_0_bits_TGA,
  input  [2:0]  io_in_0_bits_CTI,
  input  [1:0]  io_in_0_bits_BTE,
  input  [31:0] io_in_0_bits_DAT_W,
  input         io_in_0_bits_TGD_W,
  input         io_in_0_bits_CYC,
  input         io_in_0_bits_TGC,
  input  [3:0]  io_in_0_bits_SEL,
  input         io_in_0_bits_STB,
  input         io_in_0_bits_WE,
  input         io_in_1_valid,
  input  [31:0] io_in_1_bits_ADR,
  input         io_in_1_bits_TGA,
  input  [2:0]  io_in_1_bits_CTI,
  input  [1:0]  io_in_1_bits_BTE,
  input  [31:0] io_in_1_bits_DAT_W,
  input         io_in_1_bits_TGD_W,
  input         io_in_1_bits_CYC,
  input         io_in_1_bits_TGC,
  input  [3:0]  io_in_1_bits_SEL,
  input         io_in_1_bits_STB,
  input         io_in_1_bits_WE,
  input         io_out_ready,
  output        io_out_valid,
  output [31:0] io_out_bits_ADR,
  output        io_out_bits_TGA,
  output [2:0]  io_out_bits_CTI,
  output [1:0]  io_out_bits_BTE,
  output [31:0] io_out_bits_DAT_W,
  output        io_out_bits_TGD_W,
  output        io_out_bits_CYC,
  output        io_out_bits_TGC,
  output [3:0]  io_out_bits_SEL,
  output        io_out_bits_STB,
  output        io_out_bits_WE,
  output        io_chosen
);
  wire  choice;
  wire  _GEN_0_valid;
  wire  _GEN_13;
  wire [31:0] _GEN_14;
  wire  _GEN_15;
  wire [2:0] _GEN_16;
  wire [1:0] _GEN_17;
  wire [31:0] _GEN_18;
  wire  _GEN_19;
  wire  _GEN_20;
  wire  _GEN_21;
  wire [3:0] _GEN_22;
  wire  _GEN_23;
  wire  _GEN_24;
  wire  _GEN_1_bits_WE;
  wire  _GEN_2_bits_STB;
  wire [3:0] _GEN_3_bits_SEL;
  wire  _GEN_4_bits_TGC;
  wire  _GEN_5_bits_CYC;
  wire  _GEN_6_bits_TGD_W;
  wire [31:0] _GEN_7_bits_DAT_W;
  wire [1:0] _GEN_8_bits_BTE;
  wire [2:0] _GEN_9_bits_CTI;
  wire  _GEN_10_bits_TGA;
  wire [31:0] _GEN_11_bits_ADR;
  reg  _T_62;
  reg [31:0] _RAND_0;
  reg  _T_65;
  reg [31:0] _RAND_1;
  wire  _T_67;
  wire  _GEN_25;
  wire  _GEN_26;
  wire  _T_70;
  wire  _GEN_27;
  wire  _GEN_28;
  reg  lastGrant;
  reg [31:0] _RAND_2;
  wire  _GEN_29;
  wire  grantMask_1;
  wire  validMask_1;
  wire  _GEN_30;
  wire  _GEN_31;
  assign io_out_valid = _GEN_0_valid;
  assign io_out_bits_ADR = _GEN_11_bits_ADR;
  assign io_out_bits_TGA = _GEN_10_bits_TGA;
  assign io_out_bits_CTI = _GEN_9_bits_CTI;
  assign io_out_bits_BTE = _GEN_8_bits_BTE;
  assign io_out_bits_DAT_W = _GEN_7_bits_DAT_W;
  assign io_out_bits_TGD_W = _GEN_6_bits_TGD_W;
  assign io_out_bits_CYC = _GEN_5_bits_CYC;
  assign io_out_bits_TGC = _GEN_4_bits_TGC;
  assign io_out_bits_SEL = _GEN_3_bits_SEL;
  assign io_out_bits_STB = _GEN_2_bits_STB;
  assign io_out_bits_WE = _GEN_1_bits_WE;
  assign io_chosen = _GEN_28;
  assign choice = _GEN_31;
  assign _GEN_0_valid = _GEN_13;
  assign _GEN_13 = io_chosen ? io_in_1_valid : io_in_0_valid;
  assign _GEN_14 = io_chosen ? io_in_1_bits_ADR : io_in_0_bits_ADR;
  assign _GEN_15 = io_chosen ? io_in_1_bits_TGA : io_in_0_bits_TGA;
  assign _GEN_16 = io_chosen ? io_in_1_bits_CTI : io_in_0_bits_CTI;
  assign _GEN_17 = io_chosen ? io_in_1_bits_BTE : io_in_0_bits_BTE;
  assign _GEN_18 = io_chosen ? io_in_1_bits_DAT_W : io_in_0_bits_DAT_W;
  assign _GEN_19 = io_chosen ? io_in_1_bits_TGD_W : io_in_0_bits_TGD_W;
  assign _GEN_20 = io_chosen ? io_in_1_bits_CYC : io_in_0_bits_CYC;
  assign _GEN_21 = io_chosen ? io_in_1_bits_TGC : io_in_0_bits_TGC;
  assign _GEN_22 = io_chosen ? io_in_1_bits_SEL : io_in_0_bits_SEL;
  assign _GEN_23 = io_chosen ? io_in_1_bits_STB : io_in_0_bits_STB;
  assign _GEN_24 = io_chosen ? io_in_1_bits_WE : io_in_0_bits_WE;
  assign _GEN_1_bits_WE = _GEN_24;
  assign _GEN_2_bits_STB = _GEN_23;
  assign _GEN_3_bits_SEL = _GEN_22;
  assign _GEN_4_bits_TGC = _GEN_21;
  assign _GEN_5_bits_CYC = _GEN_20;
  assign _GEN_6_bits_TGD_W = _GEN_19;
  assign _GEN_7_bits_DAT_W = _GEN_18;
  assign _GEN_8_bits_BTE = _GEN_17;
  assign _GEN_9_bits_CTI = _GEN_16;
  assign _GEN_10_bits_TGA = _GEN_15;
  assign _GEN_11_bits_ADR = _GEN_14;
  assign _T_67 = io_out_ready & io_out_valid;
  assign _GEN_25 = _T_67 ? 1'h1 : _T_65;
  assign _GEN_26 = _T_67 ? io_chosen : _T_62;
  assign _T_70 = _T_67 == 1'h0;
  assign _GEN_27 = _T_70 ? 1'h0 : _GEN_25;
  assign _GEN_28 = _T_65 ? _T_62 : choice;
  assign _GEN_29 = _T_67 ? io_chosen : lastGrant;
  assign grantMask_1 = 1'h1 > lastGrant;
  assign validMask_1 = io_in_1_valid & grantMask_1;
  assign _GEN_30 = io_in_0_valid ? 1'h0 : 1'h1;
  assign _GEN_31 = validMask_1 ? 1'h1 : _GEN_30;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{$random}};
  _T_62 = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{$random}};
  _T_65 = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{$random}};
  lastGrant = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (_T_67) begin
      _T_62 <= io_chosen;
    end
    if (reset) begin
      _T_65 <= 1'h0;
    end else begin
      if (_T_70) begin
        _T_65 <= 1'h0;
      end else begin
        if (_T_67) begin
          _T_65 <= 1'h1;
        end
      end
    end
    if (reset) begin
      lastGrant <= 1'h0;
    end else begin
      if (_T_67) begin
        lastGrant <= io_chosen;
      end
    end
  end
endmodule
module wishbone_ic_32_32_2x4(
  input         clock,
  input         reset,
  input  [31:0] io_addr_base_0,
  input  [31:0] io_addr_base_1,
  input  [31:0] io_addr_base_2,
  input  [31:0] io_addr_base_3,
  input  [31:0] io_addr_limit_0,
  input  [31:0] io_addr_limit_1,
  input  [31:0] io_addr_limit_2,
  input  [31:0] io_addr_limit_3,
  input  [31:0] io_m_0_ADR,
  input         io_m_0_TGA,
  input  [2:0]  io_m_0_CTI,
  input  [1:0]  io_m_0_BTE,
  input  [31:0] io_m_0_DAT_W,
  input         io_m_0_TGD_W,
  output [31:0] io_m_0_DAT_R,
  output        io_m_0_TGD_R,
  input         io_m_0_CYC,
  input         io_m_0_TGC,
  output        io_m_0_ERR,
  input  [3:0]  io_m_0_SEL,
  input         io_m_0_STB,
  output        io_m_0_ACK,
  input         io_m_0_WE,
  input  [31:0] io_m_1_ADR,
  input         io_m_1_TGA,
  input  [2:0]  io_m_1_CTI,
  input  [1:0]  io_m_1_BTE,
  input  [31:0] io_m_1_DAT_W,
  input         io_m_1_TGD_W,
  output [31:0] io_m_1_DAT_R,
  output        io_m_1_TGD_R,
  input         io_m_1_CYC,
  input         io_m_1_TGC,
  output        io_m_1_ERR,
  input  [3:0]  io_m_1_SEL,
  input         io_m_1_STB,
  output        io_m_1_ACK,
  input         io_m_1_WE,
  output [31:0] io_s_0_ADR,
  output        io_s_0_TGA,
  output [2:0]  io_s_0_CTI,
  output [1:0]  io_s_0_BTE,
  output [31:0] io_s_0_DAT_W,
  output        io_s_0_TGD_W,
  input  [31:0] io_s_0_DAT_R,
  input         io_s_0_TGD_R,
  output        io_s_0_CYC,
  output        io_s_0_TGC,
  input         io_s_0_ERR,
  output [3:0]  io_s_0_SEL,
  output        io_s_0_STB,
  input         io_s_0_ACK,
  output        io_s_0_WE,
  output [31:0] io_s_1_ADR,
  output        io_s_1_TGA,
  output [2:0]  io_s_1_CTI,
  output [1:0]  io_s_1_BTE,
  output [31:0] io_s_1_DAT_W,
  output        io_s_1_TGD_W,
  input  [31:0] io_s_1_DAT_R,
  input         io_s_1_TGD_R,
  output        io_s_1_CYC,
  output        io_s_1_TGC,
  input         io_s_1_ERR,
  output [3:0]  io_s_1_SEL,
  output        io_s_1_STB,
  input         io_s_1_ACK,
  output        io_s_1_WE,
  output [31:0] io_s_2_ADR,
  output        io_s_2_TGA,
  output [2:0]  io_s_2_CTI,
  output [1:0]  io_s_2_BTE,
  output [31:0] io_s_2_DAT_W,
  output        io_s_2_TGD_W,
  input  [31:0] io_s_2_DAT_R,
  input         io_s_2_TGD_R,
  output        io_s_2_CYC,
  output        io_s_2_TGC,
  input         io_s_2_ERR,
  output [3:0]  io_s_2_SEL,
  output        io_s_2_STB,
  input         io_s_2_ACK,
  output        io_s_2_WE,
  output [31:0] io_s_3_ADR,
  output        io_s_3_TGA,
  output [2:0]  io_s_3_CTI,
  output [1:0]  io_s_3_BTE,
  output [31:0] io_s_3_DAT_W,
  output        io_s_3_TGD_W,
  input  [31:0] io_s_3_DAT_R,
  input         io_s_3_TGD_R,
  output        io_s_3_CYC,
  output        io_s_3_TGC,
  input         io_s_3_ERR,
  output [3:0]  io_s_3_SEL,
  output        io_s_3_STB,
  input         io_s_3_ACK,
  output        io_s_3_WE
);
  wire  out_arb_0_clock;
  wire  out_arb_0_reset;
  wire  out_arb_0_io_in_0_valid;
  wire [31:0] out_arb_0_io_in_0_bits_ADR;
  wire  out_arb_0_io_in_0_bits_TGA;
  wire [2:0] out_arb_0_io_in_0_bits_CTI;
  wire [1:0] out_arb_0_io_in_0_bits_BTE;
  wire [31:0] out_arb_0_io_in_0_bits_DAT_W;
  wire  out_arb_0_io_in_0_bits_TGD_W;
  wire  out_arb_0_io_in_0_bits_CYC;
  wire  out_arb_0_io_in_0_bits_TGC;
  wire [3:0] out_arb_0_io_in_0_bits_SEL;
  wire  out_arb_0_io_in_0_bits_STB;
  wire  out_arb_0_io_in_0_bits_WE;
  wire  out_arb_0_io_in_1_valid;
  wire [31:0] out_arb_0_io_in_1_bits_ADR;
  wire  out_arb_0_io_in_1_bits_TGA;
  wire [2:0] out_arb_0_io_in_1_bits_CTI;
  wire [1:0] out_arb_0_io_in_1_bits_BTE;
  wire [31:0] out_arb_0_io_in_1_bits_DAT_W;
  wire  out_arb_0_io_in_1_bits_TGD_W;
  wire  out_arb_0_io_in_1_bits_CYC;
  wire  out_arb_0_io_in_1_bits_TGC;
  wire [3:0] out_arb_0_io_in_1_bits_SEL;
  wire  out_arb_0_io_in_1_bits_STB;
  wire  out_arb_0_io_in_1_bits_WE;
  wire  out_arb_0_io_out_ready;
  wire  out_arb_0_io_out_valid;
  wire [31:0] out_arb_0_io_out_bits_ADR;
  wire  out_arb_0_io_out_bits_TGA;
  wire [2:0] out_arb_0_io_out_bits_CTI;
  wire [1:0] out_arb_0_io_out_bits_BTE;
  wire [31:0] out_arb_0_io_out_bits_DAT_W;
  wire  out_arb_0_io_out_bits_TGD_W;
  wire  out_arb_0_io_out_bits_CYC;
  wire  out_arb_0_io_out_bits_TGC;
  wire [3:0] out_arb_0_io_out_bits_SEL;
  wire  out_arb_0_io_out_bits_STB;
  wire  out_arb_0_io_out_bits_WE;
  wire  out_arb_0_io_chosen;
  wire  out_arb_1_clock;
  wire  out_arb_1_reset;
  wire  out_arb_1_io_in_0_valid;
  wire [31:0] out_arb_1_io_in_0_bits_ADR;
  wire  out_arb_1_io_in_0_bits_TGA;
  wire [2:0] out_arb_1_io_in_0_bits_CTI;
  wire [1:0] out_arb_1_io_in_0_bits_BTE;
  wire [31:0] out_arb_1_io_in_0_bits_DAT_W;
  wire  out_arb_1_io_in_0_bits_TGD_W;
  wire  out_arb_1_io_in_0_bits_CYC;
  wire  out_arb_1_io_in_0_bits_TGC;
  wire [3:0] out_arb_1_io_in_0_bits_SEL;
  wire  out_arb_1_io_in_0_bits_STB;
  wire  out_arb_1_io_in_0_bits_WE;
  wire  out_arb_1_io_in_1_valid;
  wire [31:0] out_arb_1_io_in_1_bits_ADR;
  wire  out_arb_1_io_in_1_bits_TGA;
  wire [2:0] out_arb_1_io_in_1_bits_CTI;
  wire [1:0] out_arb_1_io_in_1_bits_BTE;
  wire [31:0] out_arb_1_io_in_1_bits_DAT_W;
  wire  out_arb_1_io_in_1_bits_TGD_W;
  wire  out_arb_1_io_in_1_bits_CYC;
  wire  out_arb_1_io_in_1_bits_TGC;
  wire [3:0] out_arb_1_io_in_1_bits_SEL;
  wire  out_arb_1_io_in_1_bits_STB;
  wire  out_arb_1_io_in_1_bits_WE;
  wire  out_arb_1_io_out_ready;
  wire  out_arb_1_io_out_valid;
  wire [31:0] out_arb_1_io_out_bits_ADR;
  wire  out_arb_1_io_out_bits_TGA;
  wire [2:0] out_arb_1_io_out_bits_CTI;
  wire [1:0] out_arb_1_io_out_bits_BTE;
  wire [31:0] out_arb_1_io_out_bits_DAT_W;
  wire  out_arb_1_io_out_bits_TGD_W;
  wire  out_arb_1_io_out_bits_CYC;
  wire  out_arb_1_io_out_bits_TGC;
  wire [3:0] out_arb_1_io_out_bits_SEL;
  wire  out_arb_1_io_out_bits_STB;
  wire  out_arb_1_io_out_bits_WE;
  wire  out_arb_1_io_chosen;
  wire  out_arb_2_clock;
  wire  out_arb_2_reset;
  wire  out_arb_2_io_in_0_valid;
  wire [31:0] out_arb_2_io_in_0_bits_ADR;
  wire  out_arb_2_io_in_0_bits_TGA;
  wire [2:0] out_arb_2_io_in_0_bits_CTI;
  wire [1:0] out_arb_2_io_in_0_bits_BTE;
  wire [31:0] out_arb_2_io_in_0_bits_DAT_W;
  wire  out_arb_2_io_in_0_bits_TGD_W;
  wire  out_arb_2_io_in_0_bits_CYC;
  wire  out_arb_2_io_in_0_bits_TGC;
  wire [3:0] out_arb_2_io_in_0_bits_SEL;
  wire  out_arb_2_io_in_0_bits_STB;
  wire  out_arb_2_io_in_0_bits_WE;
  wire  out_arb_2_io_in_1_valid;
  wire [31:0] out_arb_2_io_in_1_bits_ADR;
  wire  out_arb_2_io_in_1_bits_TGA;
  wire [2:0] out_arb_2_io_in_1_bits_CTI;
  wire [1:0] out_arb_2_io_in_1_bits_BTE;
  wire [31:0] out_arb_2_io_in_1_bits_DAT_W;
  wire  out_arb_2_io_in_1_bits_TGD_W;
  wire  out_arb_2_io_in_1_bits_CYC;
  wire  out_arb_2_io_in_1_bits_TGC;
  wire [3:0] out_arb_2_io_in_1_bits_SEL;
  wire  out_arb_2_io_in_1_bits_STB;
  wire  out_arb_2_io_in_1_bits_WE;
  wire  out_arb_2_io_out_ready;
  wire  out_arb_2_io_out_valid;
  wire [31:0] out_arb_2_io_out_bits_ADR;
  wire  out_arb_2_io_out_bits_TGA;
  wire [2:0] out_arb_2_io_out_bits_CTI;
  wire [1:0] out_arb_2_io_out_bits_BTE;
  wire [31:0] out_arb_2_io_out_bits_DAT_W;
  wire  out_arb_2_io_out_bits_TGD_W;
  wire  out_arb_2_io_out_bits_CYC;
  wire  out_arb_2_io_out_bits_TGC;
  wire [3:0] out_arb_2_io_out_bits_SEL;
  wire  out_arb_2_io_out_bits_STB;
  wire  out_arb_2_io_out_bits_WE;
  wire  out_arb_2_io_chosen;
  wire  out_arb_3_clock;
  wire  out_arb_3_reset;
  wire  out_arb_3_io_in_0_valid;
  wire [31:0] out_arb_3_io_in_0_bits_ADR;
  wire  out_arb_3_io_in_0_bits_TGA;
  wire [2:0] out_arb_3_io_in_0_bits_CTI;
  wire [1:0] out_arb_3_io_in_0_bits_BTE;
  wire [31:0] out_arb_3_io_in_0_bits_DAT_W;
  wire  out_arb_3_io_in_0_bits_TGD_W;
  wire  out_arb_3_io_in_0_bits_CYC;
  wire  out_arb_3_io_in_0_bits_TGC;
  wire [3:0] out_arb_3_io_in_0_bits_SEL;
  wire  out_arb_3_io_in_0_bits_STB;
  wire  out_arb_3_io_in_0_bits_WE;
  wire  out_arb_3_io_in_1_valid;
  wire [31:0] out_arb_3_io_in_1_bits_ADR;
  wire  out_arb_3_io_in_1_bits_TGA;
  wire [2:0] out_arb_3_io_in_1_bits_CTI;
  wire [1:0] out_arb_3_io_in_1_bits_BTE;
  wire [31:0] out_arb_3_io_in_1_bits_DAT_W;
  wire  out_arb_3_io_in_1_bits_TGD_W;
  wire  out_arb_3_io_in_1_bits_CYC;
  wire  out_arb_3_io_in_1_bits_TGC;
  wire [3:0] out_arb_3_io_in_1_bits_SEL;
  wire  out_arb_3_io_in_1_bits_STB;
  wire  out_arb_3_io_in_1_bits_WE;
  wire  out_arb_3_io_out_ready;
  wire  out_arb_3_io_out_valid;
  wire [31:0] out_arb_3_io_out_bits_ADR;
  wire  out_arb_3_io_out_bits_TGA;
  wire [2:0] out_arb_3_io_out_bits_CTI;
  wire [1:0] out_arb_3_io_out_bits_BTE;
  wire [31:0] out_arb_3_io_out_bits_DAT_W;
  wire  out_arb_3_io_out_bits_TGD_W;
  wire  out_arb_3_io_out_bits_CYC;
  wire  out_arb_3_io_out_bits_TGC;
  wire [3:0] out_arb_3_io_out_bits_SEL;
  wire  out_arb_3_io_out_bits_STB;
  wire  out_arb_3_io_out_bits_WE;
  wire  out_arb_3_io_chosen;
  wire  _T_194;
  wire  _T_195;
  wire  _T_196;
  wire  _T_197;
  wire  _T_198;
  wire  _T_199;
  wire  _T_200;
  wire  _T_201;
  wire  _T_202;
  wire  _T_203;
  wire  _T_204;
  wire  _T_205;
  wire  _T_206;
  wire  _T_207;
  wire  _T_208;
  wire  _T_209;
  wire  _T_210;
  wire  _T_211;
  wire  _T_212;
  wire  _T_213;
  wire [31:0] _T_215_DAT_R;
  wire  _T_215_TGD_R;
  wire  _T_215_ERR;
  wire  _T_215_ACK;
  wire [31:0] _T_217_DAT_R;
  wire  _T_217_TGD_R;
  wire  _T_217_ERR;
  wire  _T_217_ACK;
  wire [31:0] _T_219_DAT_R;
  wire  _T_219_TGD_R;
  wire  _T_219_ERR;
  wire  _T_219_ACK;
  wire [31:0] _T_221_DAT_R;
  wire  _T_221_TGD_R;
  wire  _T_221_ERR;
  wire  _T_221_ACK;
  wire  _T_223;
  wire  _T_225;
  wire  _T_227;
  wire  _T_229;
  wire  _T_230;
  wire  _T_231;
  wire  _T_232;
  wire  _T_233;
  wire [1:0] _T_237;
  wire [32:0] _T_238;
  wire [34:0] _T_239;
  wire [34:0] _T_241;
  wire [1:0] _T_242;
  wire [32:0] _T_243;
  wire [34:0] _T_244;
  wire [34:0] _T_246;
  wire [1:0] _T_247;
  wire [32:0] _T_248;
  wire [34:0] _T_249;
  wire [34:0] _T_251;
  wire [1:0] _T_252;
  wire [32:0] _T_253;
  wire [34:0] _T_254;
  wire [34:0] _T_256;
  wire [34:0] _T_257;
  wire [34:0] _T_258;
  wire [34:0] _T_259;
  wire [31:0] _T_261_DAT_R;
  wire  _T_261_TGD_R;
  wire  _T_261_ERR;
  wire  _T_261_ACK;
  wire [34:0] _T_263;
  wire  _T_264;
  wire  _T_265;
  wire  _T_266;
  wire [31:0] _T_267;
  wire  _T_269;
  wire  _GEN_4;
  wire  _GEN_5;
  wire  _T_273;
  wire  _GEN_10;
  wire  _GEN_11;
  wire  _T_277;
  wire  _T_278;
  wire  _T_279;
  wire [31:0] _GEN_12;
  wire  _GEN_13;
  wire [2:0] _GEN_14;
  wire [1:0] _GEN_15;
  wire [31:0] _GEN_16;
  wire  _GEN_17;
  wire  _GEN_18;
  wire  _GEN_19;
  wire [3:0] _GEN_20;
  wire  _GEN_21;
  wire  _GEN_22;
  wire  _T_281;
  wire  _GEN_23;
  wire  _GEN_24;
  wire  _T_286;
  wire  _T_287;
  wire  _T_288;
  wire [31:0] _GEN_25;
  wire  _GEN_26;
  wire [2:0] _GEN_27;
  wire [1:0] _GEN_28;
  wire [31:0] _GEN_29;
  wire  _GEN_30;
  wire  _GEN_31;
  wire  _GEN_32;
  wire [3:0] _GEN_33;
  wire  _GEN_34;
  wire  _GEN_35;
  wire  _T_290;
  wire  _GEN_36;
  wire  _GEN_37;
  wire  _T_295;
  wire  _T_296;
  wire  _T_297;
  wire [31:0] _GEN_38;
  wire  _GEN_39;
  wire [2:0] _GEN_40;
  wire [1:0] _GEN_41;
  wire [31:0] _GEN_42;
  wire  _GEN_43;
  wire  _GEN_44;
  wire  _GEN_45;
  wire [3:0] _GEN_46;
  wire  _GEN_47;
  wire  _GEN_48;
  wire  _T_299;
  wire  _GEN_49;
  wire  _GEN_50;
  wire  _T_304;
  wire  _T_305;
  wire  _T_306;
  wire [31:0] _GEN_51;
  wire  _GEN_52;
  wire [2:0] _GEN_53;
  wire [1:0] _GEN_54;
  wire [31:0] _GEN_55;
  wire  _GEN_56;
  wire  _GEN_57;
  wire  _GEN_58;
  wire [3:0] _GEN_59;
  wire  _GEN_60;
  wire  _GEN_61;
  wire  _T_308;
  wire  _GEN_62;
  wire  _GEN_63;
  wire  _T_312;
  wire  _T_313;
  wire  _T_314;
  wire  _T_315;
  wire  _T_316;
  wire  _T_317;
  wire  _T_318;
  wire  _T_319;
  wire  _T_320;
  wire  _T_321;
  wire  _T_322;
  wire  _T_323;
  wire  _T_324;
  wire  _T_325;
  wire  _T_326;
  wire  _T_327;
  wire  _T_328;
  wire  _T_329;
  wire  _T_330;
  wire  _T_331;
  wire [31:0] _T_333_DAT_R;
  wire  _T_333_TGD_R;
  wire  _T_333_ERR;
  wire  _T_333_ACK;
  wire [31:0] _T_335_DAT_R;
  wire  _T_335_TGD_R;
  wire  _T_335_ERR;
  wire  _T_335_ACK;
  wire [31:0] _T_337_DAT_R;
  wire  _T_337_TGD_R;
  wire  _T_337_ERR;
  wire  _T_337_ACK;
  wire [31:0] _T_339_DAT_R;
  wire  _T_339_TGD_R;
  wire  _T_339_ERR;
  wire  _T_339_ACK;
  wire  _T_341;
  wire  _T_343;
  wire  _T_345;
  wire  _T_347;
  wire  _T_348;
  wire  _T_349;
  wire  _T_350;
  wire  _T_351;
  wire [1:0] _T_355;
  wire [32:0] _T_356;
  wire [34:0] _T_357;
  wire [34:0] _T_359;
  wire [1:0] _T_360;
  wire [32:0] _T_361;
  wire [34:0] _T_362;
  wire [34:0] _T_364;
  wire [1:0] _T_365;
  wire [32:0] _T_366;
  wire [34:0] _T_367;
  wire [34:0] _T_369;
  wire [1:0] _T_370;
  wire [32:0] _T_371;
  wire [34:0] _T_372;
  wire [34:0] _T_374;
  wire [34:0] _T_375;
  wire [34:0] _T_376;
  wire [34:0] _T_377;
  wire [31:0] _T_379_DAT_R;
  wire  _T_379_TGD_R;
  wire  _T_379_ERR;
  wire  _T_379_ACK;
  wire [34:0] _T_381;
  wire  _T_382;
  wire  _T_383;
  wire  _T_384;
  wire [31:0] _T_385;
  wire  _T_387;
  wire  _GEN_68;
  wire  _GEN_69;
  wire  _T_391;
  wire  _GEN_74;
  wire  _GEN_75;
  wire  _T_395;
  wire  _T_396;
  wire [31:0] _GEN_76;
  wire  _GEN_77;
  wire [2:0] _GEN_78;
  wire [1:0] _GEN_79;
  wire [31:0] _GEN_80;
  wire  _GEN_81;
  wire  _GEN_82;
  wire  _GEN_83;
  wire [3:0] _GEN_84;
  wire  _GEN_85;
  wire  _GEN_86;
  wire  _GEN_87;
  wire  _GEN_88;
  wire  _T_404;
  wire  _T_405;
  wire [31:0] _GEN_89;
  wire  _GEN_90;
  wire [2:0] _GEN_91;
  wire [1:0] _GEN_92;
  wire [31:0] _GEN_93;
  wire  _GEN_94;
  wire  _GEN_95;
  wire  _GEN_96;
  wire [3:0] _GEN_97;
  wire  _GEN_98;
  wire  _GEN_99;
  wire  _GEN_100;
  wire  _GEN_101;
  wire  _T_413;
  wire  _T_414;
  wire [31:0] _GEN_102;
  wire  _GEN_103;
  wire [2:0] _GEN_104;
  wire [1:0] _GEN_105;
  wire [31:0] _GEN_106;
  wire  _GEN_107;
  wire  _GEN_108;
  wire  _GEN_109;
  wire [3:0] _GEN_110;
  wire  _GEN_111;
  wire  _GEN_112;
  wire  _GEN_113;
  wire  _GEN_114;
  wire  _T_422;
  wire  _T_423;
  wire [31:0] _GEN_115;
  wire  _GEN_116;
  wire [2:0] _GEN_117;
  wire [1:0] _GEN_118;
  wire [31:0] _GEN_119;
  wire  _GEN_120;
  wire  _GEN_121;
  wire  _GEN_122;
  wire [3:0] _GEN_123;
  wire  _GEN_124;
  wire  _GEN_125;
  wire  _GEN_126;
  wire  _GEN_127;
  LockingRRArbiter out_arb_0 (
    .clock(out_arb_0_clock),
    .reset(out_arb_0_reset),
    .io_in_0_valid(out_arb_0_io_in_0_valid),
    .io_in_0_bits_ADR(out_arb_0_io_in_0_bits_ADR),
    .io_in_0_bits_TGA(out_arb_0_io_in_0_bits_TGA),
    .io_in_0_bits_CTI(out_arb_0_io_in_0_bits_CTI),
    .io_in_0_bits_BTE(out_arb_0_io_in_0_bits_BTE),
    .io_in_0_bits_DAT_W(out_arb_0_io_in_0_bits_DAT_W),
    .io_in_0_bits_TGD_W(out_arb_0_io_in_0_bits_TGD_W),
    .io_in_0_bits_CYC(out_arb_0_io_in_0_bits_CYC),
    .io_in_0_bits_TGC(out_arb_0_io_in_0_bits_TGC),
    .io_in_0_bits_SEL(out_arb_0_io_in_0_bits_SEL),
    .io_in_0_bits_STB(out_arb_0_io_in_0_bits_STB),
    .io_in_0_bits_WE(out_arb_0_io_in_0_bits_WE),
    .io_in_1_valid(out_arb_0_io_in_1_valid),
    .io_in_1_bits_ADR(out_arb_0_io_in_1_bits_ADR),
    .io_in_1_bits_TGA(out_arb_0_io_in_1_bits_TGA),
    .io_in_1_bits_CTI(out_arb_0_io_in_1_bits_CTI),
    .io_in_1_bits_BTE(out_arb_0_io_in_1_bits_BTE),
    .io_in_1_bits_DAT_W(out_arb_0_io_in_1_bits_DAT_W),
    .io_in_1_bits_TGD_W(out_arb_0_io_in_1_bits_TGD_W),
    .io_in_1_bits_CYC(out_arb_0_io_in_1_bits_CYC),
    .io_in_1_bits_TGC(out_arb_0_io_in_1_bits_TGC),
    .io_in_1_bits_SEL(out_arb_0_io_in_1_bits_SEL),
    .io_in_1_bits_STB(out_arb_0_io_in_1_bits_STB),
    .io_in_1_bits_WE(out_arb_0_io_in_1_bits_WE),
    .io_out_ready(out_arb_0_io_out_ready),
    .io_out_valid(out_arb_0_io_out_valid),
    .io_out_bits_ADR(out_arb_0_io_out_bits_ADR),
    .io_out_bits_TGA(out_arb_0_io_out_bits_TGA),
    .io_out_bits_CTI(out_arb_0_io_out_bits_CTI),
    .io_out_bits_BTE(out_arb_0_io_out_bits_BTE),
    .io_out_bits_DAT_W(out_arb_0_io_out_bits_DAT_W),
    .io_out_bits_TGD_W(out_arb_0_io_out_bits_TGD_W),
    .io_out_bits_CYC(out_arb_0_io_out_bits_CYC),
    .io_out_bits_TGC(out_arb_0_io_out_bits_TGC),
    .io_out_bits_SEL(out_arb_0_io_out_bits_SEL),
    .io_out_bits_STB(out_arb_0_io_out_bits_STB),
    .io_out_bits_WE(out_arb_0_io_out_bits_WE),
    .io_chosen(out_arb_0_io_chosen)
  );
  LockingRRArbiter out_arb_1 (
    .clock(out_arb_1_clock),
    .reset(out_arb_1_reset),
    .io_in_0_valid(out_arb_1_io_in_0_valid),
    .io_in_0_bits_ADR(out_arb_1_io_in_0_bits_ADR),
    .io_in_0_bits_TGA(out_arb_1_io_in_0_bits_TGA),
    .io_in_0_bits_CTI(out_arb_1_io_in_0_bits_CTI),
    .io_in_0_bits_BTE(out_arb_1_io_in_0_bits_BTE),
    .io_in_0_bits_DAT_W(out_arb_1_io_in_0_bits_DAT_W),
    .io_in_0_bits_TGD_W(out_arb_1_io_in_0_bits_TGD_W),
    .io_in_0_bits_CYC(out_arb_1_io_in_0_bits_CYC),
    .io_in_0_bits_TGC(out_arb_1_io_in_0_bits_TGC),
    .io_in_0_bits_SEL(out_arb_1_io_in_0_bits_SEL),
    .io_in_0_bits_STB(out_arb_1_io_in_0_bits_STB),
    .io_in_0_bits_WE(out_arb_1_io_in_0_bits_WE),
    .io_in_1_valid(out_arb_1_io_in_1_valid),
    .io_in_1_bits_ADR(out_arb_1_io_in_1_bits_ADR),
    .io_in_1_bits_TGA(out_arb_1_io_in_1_bits_TGA),
    .io_in_1_bits_CTI(out_arb_1_io_in_1_bits_CTI),
    .io_in_1_bits_BTE(out_arb_1_io_in_1_bits_BTE),
    .io_in_1_bits_DAT_W(out_arb_1_io_in_1_bits_DAT_W),
    .io_in_1_bits_TGD_W(out_arb_1_io_in_1_bits_TGD_W),
    .io_in_1_bits_CYC(out_arb_1_io_in_1_bits_CYC),
    .io_in_1_bits_TGC(out_arb_1_io_in_1_bits_TGC),
    .io_in_1_bits_SEL(out_arb_1_io_in_1_bits_SEL),
    .io_in_1_bits_STB(out_arb_1_io_in_1_bits_STB),
    .io_in_1_bits_WE(out_arb_1_io_in_1_bits_WE),
    .io_out_ready(out_arb_1_io_out_ready),
    .io_out_valid(out_arb_1_io_out_valid),
    .io_out_bits_ADR(out_arb_1_io_out_bits_ADR),
    .io_out_bits_TGA(out_arb_1_io_out_bits_TGA),
    .io_out_bits_CTI(out_arb_1_io_out_bits_CTI),
    .io_out_bits_BTE(out_arb_1_io_out_bits_BTE),
    .io_out_bits_DAT_W(out_arb_1_io_out_bits_DAT_W),
    .io_out_bits_TGD_W(out_arb_1_io_out_bits_TGD_W),
    .io_out_bits_CYC(out_arb_1_io_out_bits_CYC),
    .io_out_bits_TGC(out_arb_1_io_out_bits_TGC),
    .io_out_bits_SEL(out_arb_1_io_out_bits_SEL),
    .io_out_bits_STB(out_arb_1_io_out_bits_STB),
    .io_out_bits_WE(out_arb_1_io_out_bits_WE),
    .io_chosen(out_arb_1_io_chosen)
  );
  LockingRRArbiter out_arb_2 (
    .clock(out_arb_2_clock),
    .reset(out_arb_2_reset),
    .io_in_0_valid(out_arb_2_io_in_0_valid),
    .io_in_0_bits_ADR(out_arb_2_io_in_0_bits_ADR),
    .io_in_0_bits_TGA(out_arb_2_io_in_0_bits_TGA),
    .io_in_0_bits_CTI(out_arb_2_io_in_0_bits_CTI),
    .io_in_0_bits_BTE(out_arb_2_io_in_0_bits_BTE),
    .io_in_0_bits_DAT_W(out_arb_2_io_in_0_bits_DAT_W),
    .io_in_0_bits_TGD_W(out_arb_2_io_in_0_bits_TGD_W),
    .io_in_0_bits_CYC(out_arb_2_io_in_0_bits_CYC),
    .io_in_0_bits_TGC(out_arb_2_io_in_0_bits_TGC),
    .io_in_0_bits_SEL(out_arb_2_io_in_0_bits_SEL),
    .io_in_0_bits_STB(out_arb_2_io_in_0_bits_STB),
    .io_in_0_bits_WE(out_arb_2_io_in_0_bits_WE),
    .io_in_1_valid(out_arb_2_io_in_1_valid),
    .io_in_1_bits_ADR(out_arb_2_io_in_1_bits_ADR),
    .io_in_1_bits_TGA(out_arb_2_io_in_1_bits_TGA),
    .io_in_1_bits_CTI(out_arb_2_io_in_1_bits_CTI),
    .io_in_1_bits_BTE(out_arb_2_io_in_1_bits_BTE),
    .io_in_1_bits_DAT_W(out_arb_2_io_in_1_bits_DAT_W),
    .io_in_1_bits_TGD_W(out_arb_2_io_in_1_bits_TGD_W),
    .io_in_1_bits_CYC(out_arb_2_io_in_1_bits_CYC),
    .io_in_1_bits_TGC(out_arb_2_io_in_1_bits_TGC),
    .io_in_1_bits_SEL(out_arb_2_io_in_1_bits_SEL),
    .io_in_1_bits_STB(out_arb_2_io_in_1_bits_STB),
    .io_in_1_bits_WE(out_arb_2_io_in_1_bits_WE),
    .io_out_ready(out_arb_2_io_out_ready),
    .io_out_valid(out_arb_2_io_out_valid),
    .io_out_bits_ADR(out_arb_2_io_out_bits_ADR),
    .io_out_bits_TGA(out_arb_2_io_out_bits_TGA),
    .io_out_bits_CTI(out_arb_2_io_out_bits_CTI),
    .io_out_bits_BTE(out_arb_2_io_out_bits_BTE),
    .io_out_bits_DAT_W(out_arb_2_io_out_bits_DAT_W),
    .io_out_bits_TGD_W(out_arb_2_io_out_bits_TGD_W),
    .io_out_bits_CYC(out_arb_2_io_out_bits_CYC),
    .io_out_bits_TGC(out_arb_2_io_out_bits_TGC),
    .io_out_bits_SEL(out_arb_2_io_out_bits_SEL),
    .io_out_bits_STB(out_arb_2_io_out_bits_STB),
    .io_out_bits_WE(out_arb_2_io_out_bits_WE),
    .io_chosen(out_arb_2_io_chosen)
  );
  LockingRRArbiter out_arb_3 (
    .clock(out_arb_3_clock),
    .reset(out_arb_3_reset),
    .io_in_0_valid(out_arb_3_io_in_0_valid),
    .io_in_0_bits_ADR(out_arb_3_io_in_0_bits_ADR),
    .io_in_0_bits_TGA(out_arb_3_io_in_0_bits_TGA),
    .io_in_0_bits_CTI(out_arb_3_io_in_0_bits_CTI),
    .io_in_0_bits_BTE(out_arb_3_io_in_0_bits_BTE),
    .io_in_0_bits_DAT_W(out_arb_3_io_in_0_bits_DAT_W),
    .io_in_0_bits_TGD_W(out_arb_3_io_in_0_bits_TGD_W),
    .io_in_0_bits_CYC(out_arb_3_io_in_0_bits_CYC),
    .io_in_0_bits_TGC(out_arb_3_io_in_0_bits_TGC),
    .io_in_0_bits_SEL(out_arb_3_io_in_0_bits_SEL),
    .io_in_0_bits_STB(out_arb_3_io_in_0_bits_STB),
    .io_in_0_bits_WE(out_arb_3_io_in_0_bits_WE),
    .io_in_1_valid(out_arb_3_io_in_1_valid),
    .io_in_1_bits_ADR(out_arb_3_io_in_1_bits_ADR),
    .io_in_1_bits_TGA(out_arb_3_io_in_1_bits_TGA),
    .io_in_1_bits_CTI(out_arb_3_io_in_1_bits_CTI),
    .io_in_1_bits_BTE(out_arb_3_io_in_1_bits_BTE),
    .io_in_1_bits_DAT_W(out_arb_3_io_in_1_bits_DAT_W),
    .io_in_1_bits_TGD_W(out_arb_3_io_in_1_bits_TGD_W),
    .io_in_1_bits_CYC(out_arb_3_io_in_1_bits_CYC),
    .io_in_1_bits_TGC(out_arb_3_io_in_1_bits_TGC),
    .io_in_1_bits_SEL(out_arb_3_io_in_1_bits_SEL),
    .io_in_1_bits_STB(out_arb_3_io_in_1_bits_STB),
    .io_in_1_bits_WE(out_arb_3_io_in_1_bits_WE),
    .io_out_ready(out_arb_3_io_out_ready),
    .io_out_valid(out_arb_3_io_out_valid),
    .io_out_bits_ADR(out_arb_3_io_out_bits_ADR),
    .io_out_bits_TGA(out_arb_3_io_out_bits_TGA),
    .io_out_bits_CTI(out_arb_3_io_out_bits_CTI),
    .io_out_bits_BTE(out_arb_3_io_out_bits_BTE),
    .io_out_bits_DAT_W(out_arb_3_io_out_bits_DAT_W),
    .io_out_bits_TGD_W(out_arb_3_io_out_bits_TGD_W),
    .io_out_bits_CYC(out_arb_3_io_out_bits_CYC),
    .io_out_bits_TGC(out_arb_3_io_out_bits_TGC),
    .io_out_bits_SEL(out_arb_3_io_out_bits_SEL),
    .io_out_bits_STB(out_arb_3_io_out_bits_STB),
    .io_out_bits_WE(out_arb_3_io_out_bits_WE),
    .io_chosen(out_arb_3_io_chosen)
  );
  assign io_m_0_DAT_R = _T_261_DAT_R;
  assign io_m_0_TGD_R = _T_261_TGD_R;
  assign io_m_0_ERR = _GEN_11;
  assign io_m_0_ACK = _GEN_10;
  assign io_m_1_DAT_R = _T_379_DAT_R;
  assign io_m_1_TGD_R = _T_379_TGD_R;
  assign io_m_1_ERR = _GEN_75;
  assign io_m_1_ACK = _GEN_74;
  assign io_s_0_ADR = _GEN_76;
  assign io_s_0_TGA = _GEN_77;
  assign io_s_0_CTI = _GEN_78;
  assign io_s_0_BTE = _GEN_79;
  assign io_s_0_DAT_W = _GEN_80;
  assign io_s_0_TGD_W = _GEN_81;
  assign io_s_0_CYC = _GEN_87;
  assign io_s_0_TGC = _GEN_83;
  assign io_s_0_SEL = _GEN_84;
  assign io_s_0_STB = _GEN_88;
  assign io_s_0_WE = _GEN_86;
  assign io_s_1_ADR = _GEN_89;
  assign io_s_1_TGA = _GEN_90;
  assign io_s_1_CTI = _GEN_91;
  assign io_s_1_BTE = _GEN_92;
  assign io_s_1_DAT_W = _GEN_93;
  assign io_s_1_TGD_W = _GEN_94;
  assign io_s_1_CYC = _GEN_100;
  assign io_s_1_TGC = _GEN_96;
  assign io_s_1_SEL = _GEN_97;
  assign io_s_1_STB = _GEN_101;
  assign io_s_1_WE = _GEN_99;
  assign io_s_2_ADR = _GEN_102;
  assign io_s_2_TGA = _GEN_103;
  assign io_s_2_CTI = _GEN_104;
  assign io_s_2_BTE = _GEN_105;
  assign io_s_2_DAT_W = _GEN_106;
  assign io_s_2_TGD_W = _GEN_107;
  assign io_s_2_CYC = _GEN_113;
  assign io_s_2_TGC = _GEN_109;
  assign io_s_2_SEL = _GEN_110;
  assign io_s_2_STB = _GEN_114;
  assign io_s_2_WE = _GEN_112;
  assign io_s_3_ADR = _GEN_115;
  assign io_s_3_TGA = _GEN_116;
  assign io_s_3_CTI = _GEN_117;
  assign io_s_3_BTE = _GEN_118;
  assign io_s_3_DAT_W = _GEN_119;
  assign io_s_3_TGD_W = _GEN_120;
  assign io_s_3_CYC = _GEN_126;
  assign io_s_3_TGC = _GEN_122;
  assign io_s_3_SEL = _GEN_123;
  assign io_s_3_STB = _GEN_127;
  assign io_s_3_WE = _GEN_125;
  assign out_arb_0_clock = clock;
  assign out_arb_0_reset = reset;
  assign out_arb_0_io_in_0_valid = _T_198;
  assign out_arb_0_io_in_0_bits_ADR = io_m_0_ADR;
  assign out_arb_0_io_in_0_bits_TGA = io_m_0_TGA;
  assign out_arb_0_io_in_0_bits_CTI = io_m_0_CTI;
  assign out_arb_0_io_in_0_bits_BTE = io_m_0_BTE;
  assign out_arb_0_io_in_0_bits_DAT_W = io_m_0_DAT_W;
  assign out_arb_0_io_in_0_bits_TGD_W = io_m_0_TGD_W;
  assign out_arb_0_io_in_0_bits_CYC = io_m_0_CYC;
  assign out_arb_0_io_in_0_bits_TGC = io_m_0_TGC;
  assign out_arb_0_io_in_0_bits_SEL = io_m_0_SEL;
  assign out_arb_0_io_in_0_bits_STB = io_m_0_STB;
  assign out_arb_0_io_in_0_bits_WE = io_m_0_WE;
  assign out_arb_0_io_in_1_valid = _T_316;
  assign out_arb_0_io_in_1_bits_ADR = io_m_1_ADR;
  assign out_arb_0_io_in_1_bits_TGA = io_m_1_TGA;
  assign out_arb_0_io_in_1_bits_CTI = io_m_1_CTI;
  assign out_arb_0_io_in_1_bits_BTE = io_m_1_BTE;
  assign out_arb_0_io_in_1_bits_DAT_W = io_m_1_DAT_W;
  assign out_arb_0_io_in_1_bits_TGD_W = io_m_1_TGD_W;
  assign out_arb_0_io_in_1_bits_CYC = io_m_1_CYC;
  assign out_arb_0_io_in_1_bits_TGC = io_m_1_TGC;
  assign out_arb_0_io_in_1_bits_SEL = io_m_1_SEL;
  assign out_arb_0_io_in_1_bits_STB = io_m_1_STB;
  assign out_arb_0_io_in_1_bits_WE = io_m_1_WE;
  assign out_arb_0_io_out_ready = 1'h1;
  assign out_arb_1_clock = clock;
  assign out_arb_1_reset = reset;
  assign out_arb_1_io_in_0_valid = _T_203;
  assign out_arb_1_io_in_0_bits_ADR = io_m_0_ADR;
  assign out_arb_1_io_in_0_bits_TGA = io_m_0_TGA;
  assign out_arb_1_io_in_0_bits_CTI = io_m_0_CTI;
  assign out_arb_1_io_in_0_bits_BTE = io_m_0_BTE;
  assign out_arb_1_io_in_0_bits_DAT_W = io_m_0_DAT_W;
  assign out_arb_1_io_in_0_bits_TGD_W = io_m_0_TGD_W;
  assign out_arb_1_io_in_0_bits_CYC = io_m_0_CYC;
  assign out_arb_1_io_in_0_bits_TGC = io_m_0_TGC;
  assign out_arb_1_io_in_0_bits_SEL = io_m_0_SEL;
  assign out_arb_1_io_in_0_bits_STB = io_m_0_STB;
  assign out_arb_1_io_in_0_bits_WE = io_m_0_WE;
  assign out_arb_1_io_in_1_valid = _T_321;
  assign out_arb_1_io_in_1_bits_ADR = io_m_1_ADR;
  assign out_arb_1_io_in_1_bits_TGA = io_m_1_TGA;
  assign out_arb_1_io_in_1_bits_CTI = io_m_1_CTI;
  assign out_arb_1_io_in_1_bits_BTE = io_m_1_BTE;
  assign out_arb_1_io_in_1_bits_DAT_W = io_m_1_DAT_W;
  assign out_arb_1_io_in_1_bits_TGD_W = io_m_1_TGD_W;
  assign out_arb_1_io_in_1_bits_CYC = io_m_1_CYC;
  assign out_arb_1_io_in_1_bits_TGC = io_m_1_TGC;
  assign out_arb_1_io_in_1_bits_SEL = io_m_1_SEL;
  assign out_arb_1_io_in_1_bits_STB = io_m_1_STB;
  assign out_arb_1_io_in_1_bits_WE = io_m_1_WE;
  assign out_arb_1_io_out_ready = 1'h1;
  assign out_arb_2_clock = clock;
  assign out_arb_2_reset = reset;
  assign out_arb_2_io_in_0_valid = _T_208;
  assign out_arb_2_io_in_0_bits_ADR = io_m_0_ADR;
  assign out_arb_2_io_in_0_bits_TGA = io_m_0_TGA;
  assign out_arb_2_io_in_0_bits_CTI = io_m_0_CTI;
  assign out_arb_2_io_in_0_bits_BTE = io_m_0_BTE;
  assign out_arb_2_io_in_0_bits_DAT_W = io_m_0_DAT_W;
  assign out_arb_2_io_in_0_bits_TGD_W = io_m_0_TGD_W;
  assign out_arb_2_io_in_0_bits_CYC = io_m_0_CYC;
  assign out_arb_2_io_in_0_bits_TGC = io_m_0_TGC;
  assign out_arb_2_io_in_0_bits_SEL = io_m_0_SEL;
  assign out_arb_2_io_in_0_bits_STB = io_m_0_STB;
  assign out_arb_2_io_in_0_bits_WE = io_m_0_WE;
  assign out_arb_2_io_in_1_valid = _T_326;
  assign out_arb_2_io_in_1_bits_ADR = io_m_1_ADR;
  assign out_arb_2_io_in_1_bits_TGA = io_m_1_TGA;
  assign out_arb_2_io_in_1_bits_CTI = io_m_1_CTI;
  assign out_arb_2_io_in_1_bits_BTE = io_m_1_BTE;
  assign out_arb_2_io_in_1_bits_DAT_W = io_m_1_DAT_W;
  assign out_arb_2_io_in_1_bits_TGD_W = io_m_1_TGD_W;
  assign out_arb_2_io_in_1_bits_CYC = io_m_1_CYC;
  assign out_arb_2_io_in_1_bits_TGC = io_m_1_TGC;
  assign out_arb_2_io_in_1_bits_SEL = io_m_1_SEL;
  assign out_arb_2_io_in_1_bits_STB = io_m_1_STB;
  assign out_arb_2_io_in_1_bits_WE = io_m_1_WE;
  assign out_arb_2_io_out_ready = 1'h1;
  assign out_arb_3_clock = clock;
  assign out_arb_3_reset = reset;
  assign out_arb_3_io_in_0_valid = _T_213;
  assign out_arb_3_io_in_0_bits_ADR = io_m_0_ADR;
  assign out_arb_3_io_in_0_bits_TGA = io_m_0_TGA;
  assign out_arb_3_io_in_0_bits_CTI = io_m_0_CTI;
  assign out_arb_3_io_in_0_bits_BTE = io_m_0_BTE;
  assign out_arb_3_io_in_0_bits_DAT_W = io_m_0_DAT_W;
  assign out_arb_3_io_in_0_bits_TGD_W = io_m_0_TGD_W;
  assign out_arb_3_io_in_0_bits_CYC = io_m_0_CYC;
  assign out_arb_3_io_in_0_bits_TGC = io_m_0_TGC;
  assign out_arb_3_io_in_0_bits_SEL = io_m_0_SEL;
  assign out_arb_3_io_in_0_bits_STB = io_m_0_STB;
  assign out_arb_3_io_in_0_bits_WE = io_m_0_WE;
  assign out_arb_3_io_in_1_valid = _T_331;
  assign out_arb_3_io_in_1_bits_ADR = io_m_1_ADR;
  assign out_arb_3_io_in_1_bits_TGA = io_m_1_TGA;
  assign out_arb_3_io_in_1_bits_CTI = io_m_1_CTI;
  assign out_arb_3_io_in_1_bits_BTE = io_m_1_BTE;
  assign out_arb_3_io_in_1_bits_DAT_W = io_m_1_DAT_W;
  assign out_arb_3_io_in_1_bits_TGD_W = io_m_1_TGD_W;
  assign out_arb_3_io_in_1_bits_CYC = io_m_1_CYC;
  assign out_arb_3_io_in_1_bits_TGC = io_m_1_TGC;
  assign out_arb_3_io_in_1_bits_SEL = io_m_1_SEL;
  assign out_arb_3_io_in_1_bits_STB = io_m_1_STB;
  assign out_arb_3_io_in_1_bits_WE = io_m_1_WE;
  assign out_arb_3_io_out_ready = 1'h1;
  assign _T_194 = io_m_0_ADR >= io_addr_base_0;
  assign _T_195 = io_m_0_ADR <= io_addr_limit_0;
  assign _T_196 = _T_194 & _T_195;
  assign _T_197 = _T_196 & io_m_0_CYC;
  assign _T_198 = _T_197 & io_m_0_STB;
  assign _T_199 = io_m_0_ADR >= io_addr_base_1;
  assign _T_200 = io_m_0_ADR <= io_addr_limit_1;
  assign _T_201 = _T_199 & _T_200;
  assign _T_202 = _T_201 & io_m_0_CYC;
  assign _T_203 = _T_202 & io_m_0_STB;
  assign _T_204 = io_m_0_ADR >= io_addr_base_2;
  assign _T_205 = io_m_0_ADR <= io_addr_limit_2;
  assign _T_206 = _T_204 & _T_205;
  assign _T_207 = _T_206 & io_m_0_CYC;
  assign _T_208 = _T_207 & io_m_0_STB;
  assign _T_209 = io_m_0_ADR >= io_addr_base_3;
  assign _T_210 = io_m_0_ADR <= io_addr_limit_3;
  assign _T_211 = _T_209 & _T_210;
  assign _T_212 = _T_211 & io_m_0_CYC;
  assign _T_213 = _T_212 & io_m_0_STB;
  assign _T_215_DAT_R = io_s_0_DAT_R;
  assign _T_215_TGD_R = io_s_0_TGD_R;
  assign _T_215_ERR = io_s_0_ERR;
  assign _T_215_ACK = io_s_0_ACK;
  assign _T_217_DAT_R = io_s_1_DAT_R;
  assign _T_217_TGD_R = io_s_1_TGD_R;
  assign _T_217_ERR = io_s_1_ERR;
  assign _T_217_ACK = io_s_1_ACK;
  assign _T_219_DAT_R = io_s_2_DAT_R;
  assign _T_219_TGD_R = io_s_2_TGD_R;
  assign _T_219_ERR = io_s_2_ERR;
  assign _T_219_ACK = io_s_2_ACK;
  assign _T_221_DAT_R = io_s_3_DAT_R;
  assign _T_221_TGD_R = io_s_3_TGD_R;
  assign _T_221_ERR = io_s_3_ERR;
  assign _T_221_ACK = io_s_3_ACK;
  assign _T_223 = _T_278;
  assign _T_225 = _T_287;
  assign _T_227 = _T_296;
  assign _T_229 = _T_305;
  assign _T_230 = io_m_0_CYC & io_m_0_STB;
  assign _T_231 = _T_198 | _T_203;
  assign _T_232 = _T_231 | _T_208;
  assign _T_233 = _T_232 | _T_213;
  assign _T_237 = {_T_215_ERR,_T_215_ACK};
  assign _T_238 = {_T_215_DAT_R,_T_215_TGD_R};
  assign _T_239 = {_T_238,_T_237};
  assign _T_241 = _T_223 ? _T_239 : 35'h0;
  assign _T_242 = {_T_217_ERR,_T_217_ACK};
  assign _T_243 = {_T_217_DAT_R,_T_217_TGD_R};
  assign _T_244 = {_T_243,_T_242};
  assign _T_246 = _T_225 ? _T_244 : 35'h0;
  assign _T_247 = {_T_219_ERR,_T_219_ACK};
  assign _T_248 = {_T_219_DAT_R,_T_219_TGD_R};
  assign _T_249 = {_T_248,_T_247};
  assign _T_251 = _T_227 ? _T_249 : 35'h0;
  assign _T_252 = {_T_221_ERR,_T_221_ACK};
  assign _T_253 = {_T_221_DAT_R,_T_221_TGD_R};
  assign _T_254 = {_T_253,_T_252};
  assign _T_256 = _T_229 ? _T_254 : 35'h0;
  assign _T_257 = _T_241 | _T_246;
  assign _T_258 = _T_257 | _T_251;
  assign _T_259 = _T_258 | _T_256;
  assign _T_261_DAT_R = _T_267;
  assign _T_261_TGD_R = _T_266;
  assign _T_261_ERR = _T_265;
  assign _T_261_ACK = _T_264;
  assign _T_263 = _T_259;
  assign _T_264 = _T_263[0];
  assign _T_265 = _T_263[1];
  assign _T_266 = _T_263[2];
  assign _T_267 = _T_263[34:3];
  assign _T_269 = _T_233 == 1'h0;
  assign _GEN_4 = _T_269 ? 1'h1 : _T_261_ACK;
  assign _GEN_5 = _T_269 ? 1'h1 : _T_261_ERR;
  assign _T_273 = _T_230 == 1'h0;
  assign _GEN_10 = _T_273 ? 1'h0 : _GEN_4;
  assign _GEN_11 = _T_273 ? 1'h0 : _GEN_5;
  assign _T_277 = out_arb_0_io_chosen == 1'h0;
  assign _T_278 = _T_198 & _T_277;
  assign _T_279 = out_arb_0_io_in_0_valid | out_arb_0_io_in_1_valid;
  assign _GEN_12 = out_arb_0_io_out_bits_ADR;
  assign _GEN_13 = out_arb_0_io_out_bits_TGA;
  assign _GEN_14 = out_arb_0_io_out_bits_CTI;
  assign _GEN_15 = out_arb_0_io_out_bits_BTE;
  assign _GEN_16 = out_arb_0_io_out_bits_DAT_W;
  assign _GEN_17 = out_arb_0_io_out_bits_TGD_W;
  assign _GEN_18 = out_arb_0_io_out_bits_CYC;
  assign _GEN_19 = out_arb_0_io_out_bits_TGC;
  assign _GEN_20 = out_arb_0_io_out_bits_SEL;
  assign _GEN_21 = out_arb_0_io_out_bits_STB;
  assign _GEN_22 = out_arb_0_io_out_bits_WE;
  assign _T_281 = _T_279 == 1'h0;
  assign _GEN_23 = _T_281 ? 1'h0 : _GEN_18;
  assign _GEN_24 = _T_281 ? 1'h0 : _GEN_21;
  assign _T_286 = out_arb_1_io_chosen == 1'h0;
  assign _T_287 = _T_203 & _T_286;
  assign _T_288 = out_arb_1_io_in_0_valid | out_arb_1_io_in_1_valid;
  assign _GEN_25 = out_arb_1_io_out_bits_ADR;
  assign _GEN_26 = out_arb_1_io_out_bits_TGA;
  assign _GEN_27 = out_arb_1_io_out_bits_CTI;
  assign _GEN_28 = out_arb_1_io_out_bits_BTE;
  assign _GEN_29 = out_arb_1_io_out_bits_DAT_W;
  assign _GEN_30 = out_arb_1_io_out_bits_TGD_W;
  assign _GEN_31 = out_arb_1_io_out_bits_CYC;
  assign _GEN_32 = out_arb_1_io_out_bits_TGC;
  assign _GEN_33 = out_arb_1_io_out_bits_SEL;
  assign _GEN_34 = out_arb_1_io_out_bits_STB;
  assign _GEN_35 = out_arb_1_io_out_bits_WE;
  assign _T_290 = _T_288 == 1'h0;
  assign _GEN_36 = _T_290 ? 1'h0 : _GEN_31;
  assign _GEN_37 = _T_290 ? 1'h0 : _GEN_34;
  assign _T_295 = out_arb_2_io_chosen == 1'h0;
  assign _T_296 = _T_208 & _T_295;
  assign _T_297 = out_arb_2_io_in_0_valid | out_arb_2_io_in_1_valid;
  assign _GEN_38 = out_arb_2_io_out_bits_ADR;
  assign _GEN_39 = out_arb_2_io_out_bits_TGA;
  assign _GEN_40 = out_arb_2_io_out_bits_CTI;
  assign _GEN_41 = out_arb_2_io_out_bits_BTE;
  assign _GEN_42 = out_arb_2_io_out_bits_DAT_W;
  assign _GEN_43 = out_arb_2_io_out_bits_TGD_W;
  assign _GEN_44 = out_arb_2_io_out_bits_CYC;
  assign _GEN_45 = out_arb_2_io_out_bits_TGC;
  assign _GEN_46 = out_arb_2_io_out_bits_SEL;
  assign _GEN_47 = out_arb_2_io_out_bits_STB;
  assign _GEN_48 = out_arb_2_io_out_bits_WE;
  assign _T_299 = _T_297 == 1'h0;
  assign _GEN_49 = _T_299 ? 1'h0 : _GEN_44;
  assign _GEN_50 = _T_299 ? 1'h0 : _GEN_47;
  assign _T_304 = out_arb_3_io_chosen == 1'h0;
  assign _T_305 = _T_213 & _T_304;
  assign _T_306 = out_arb_3_io_in_0_valid | out_arb_3_io_in_1_valid;
  assign _GEN_51 = out_arb_3_io_out_bits_ADR;
  assign _GEN_52 = out_arb_3_io_out_bits_TGA;
  assign _GEN_53 = out_arb_3_io_out_bits_CTI;
  assign _GEN_54 = out_arb_3_io_out_bits_BTE;
  assign _GEN_55 = out_arb_3_io_out_bits_DAT_W;
  assign _GEN_56 = out_arb_3_io_out_bits_TGD_W;
  assign _GEN_57 = out_arb_3_io_out_bits_CYC;
  assign _GEN_58 = out_arb_3_io_out_bits_TGC;
  assign _GEN_59 = out_arb_3_io_out_bits_SEL;
  assign _GEN_60 = out_arb_3_io_out_bits_STB;
  assign _GEN_61 = out_arb_3_io_out_bits_WE;
  assign _T_308 = _T_306 == 1'h0;
  assign _GEN_62 = _T_308 ? 1'h0 : _GEN_57;
  assign _GEN_63 = _T_308 ? 1'h0 : _GEN_60;
  assign _T_312 = io_m_1_ADR >= io_addr_base_0;
  assign _T_313 = io_m_1_ADR <= io_addr_limit_0;
  assign _T_314 = _T_312 & _T_313;
  assign _T_315 = _T_314 & io_m_1_CYC;
  assign _T_316 = _T_315 & io_m_1_STB;
  assign _T_317 = io_m_1_ADR >= io_addr_base_1;
  assign _T_318 = io_m_1_ADR <= io_addr_limit_1;
  assign _T_319 = _T_317 & _T_318;
  assign _T_320 = _T_319 & io_m_1_CYC;
  assign _T_321 = _T_320 & io_m_1_STB;
  assign _T_322 = io_m_1_ADR >= io_addr_base_2;
  assign _T_323 = io_m_1_ADR <= io_addr_limit_2;
  assign _T_324 = _T_322 & _T_323;
  assign _T_325 = _T_324 & io_m_1_CYC;
  assign _T_326 = _T_325 & io_m_1_STB;
  assign _T_327 = io_m_1_ADR >= io_addr_base_3;
  assign _T_328 = io_m_1_ADR <= io_addr_limit_3;
  assign _T_329 = _T_327 & _T_328;
  assign _T_330 = _T_329 & io_m_1_CYC;
  assign _T_331 = _T_330 & io_m_1_STB;
  assign _T_333_DAT_R = io_s_0_DAT_R;
  assign _T_333_TGD_R = io_s_0_TGD_R;
  assign _T_333_ERR = io_s_0_ERR;
  assign _T_333_ACK = io_s_0_ACK;
  assign _T_335_DAT_R = io_s_1_DAT_R;
  assign _T_335_TGD_R = io_s_1_TGD_R;
  assign _T_335_ERR = io_s_1_ERR;
  assign _T_335_ACK = io_s_1_ACK;
  assign _T_337_DAT_R = io_s_2_DAT_R;
  assign _T_337_TGD_R = io_s_2_TGD_R;
  assign _T_337_ERR = io_s_2_ERR;
  assign _T_337_ACK = io_s_2_ACK;
  assign _T_339_DAT_R = io_s_3_DAT_R;
  assign _T_339_TGD_R = io_s_3_TGD_R;
  assign _T_339_ERR = io_s_3_ERR;
  assign _T_339_ACK = io_s_3_ACK;
  assign _T_341 = _T_396;
  assign _T_343 = _T_405;
  assign _T_345 = _T_414;
  assign _T_347 = _T_423;
  assign _T_348 = io_m_1_CYC & io_m_1_STB;
  assign _T_349 = _T_316 | _T_321;
  assign _T_350 = _T_349 | _T_326;
  assign _T_351 = _T_350 | _T_331;
  assign _T_355 = {_T_333_ERR,_T_333_ACK};
  assign _T_356 = {_T_333_DAT_R,_T_333_TGD_R};
  assign _T_357 = {_T_356,_T_355};
  assign _T_359 = _T_341 ? _T_357 : 35'h0;
  assign _T_360 = {_T_335_ERR,_T_335_ACK};
  assign _T_361 = {_T_335_DAT_R,_T_335_TGD_R};
  assign _T_362 = {_T_361,_T_360};
  assign _T_364 = _T_343 ? _T_362 : 35'h0;
  assign _T_365 = {_T_337_ERR,_T_337_ACK};
  assign _T_366 = {_T_337_DAT_R,_T_337_TGD_R};
  assign _T_367 = {_T_366,_T_365};
  assign _T_369 = _T_345 ? _T_367 : 35'h0;
  assign _T_370 = {_T_339_ERR,_T_339_ACK};
  assign _T_371 = {_T_339_DAT_R,_T_339_TGD_R};
  assign _T_372 = {_T_371,_T_370};
  assign _T_374 = _T_347 ? _T_372 : 35'h0;
  assign _T_375 = _T_359 | _T_364;
  assign _T_376 = _T_375 | _T_369;
  assign _T_377 = _T_376 | _T_374;
  assign _T_379_DAT_R = _T_385;
  assign _T_379_TGD_R = _T_384;
  assign _T_379_ERR = _T_383;
  assign _T_379_ACK = _T_382;
  assign _T_381 = _T_377;
  assign _T_382 = _T_381[0];
  assign _T_383 = _T_381[1];
  assign _T_384 = _T_381[2];
  assign _T_385 = _T_381[34:3];
  assign _T_387 = _T_351 == 1'h0;
  assign _GEN_68 = _T_387 ? 1'h1 : _T_379_ACK;
  assign _GEN_69 = _T_387 ? 1'h1 : _T_379_ERR;
  assign _T_391 = _T_348 == 1'h0;
  assign _GEN_74 = _T_391 ? 1'h0 : _GEN_68;
  assign _GEN_75 = _T_391 ? 1'h0 : _GEN_69;
  assign _T_395 = out_arb_0_io_chosen;
  assign _T_396 = _T_316 & _T_395;
  assign _GEN_76 = _T_279 ? out_arb_0_io_out_bits_ADR : _GEN_12;
  assign _GEN_77 = _T_279 ? out_arb_0_io_out_bits_TGA : _GEN_13;
  assign _GEN_78 = _T_279 ? out_arb_0_io_out_bits_CTI : _GEN_14;
  assign _GEN_79 = _T_279 ? out_arb_0_io_out_bits_BTE : _GEN_15;
  assign _GEN_80 = _T_279 ? out_arb_0_io_out_bits_DAT_W : _GEN_16;
  assign _GEN_81 = _T_279 ? out_arb_0_io_out_bits_TGD_W : _GEN_17;
  assign _GEN_82 = _T_279 ? out_arb_0_io_out_bits_CYC : _GEN_23;
  assign _GEN_83 = _T_279 ? out_arb_0_io_out_bits_TGC : _GEN_19;
  assign _GEN_84 = _T_279 ? out_arb_0_io_out_bits_SEL : _GEN_20;
  assign _GEN_85 = _T_279 ? out_arb_0_io_out_bits_STB : _GEN_24;
  assign _GEN_86 = _T_279 ? out_arb_0_io_out_bits_WE : _GEN_22;
  assign _GEN_87 = _T_281 ? 1'h0 : _GEN_82;
  assign _GEN_88 = _T_281 ? 1'h0 : _GEN_85;
  assign _T_404 = out_arb_1_io_chosen;
  assign _T_405 = _T_321 & _T_404;
  assign _GEN_89 = _T_288 ? out_arb_1_io_out_bits_ADR : _GEN_25;
  assign _GEN_90 = _T_288 ? out_arb_1_io_out_bits_TGA : _GEN_26;
  assign _GEN_91 = _T_288 ? out_arb_1_io_out_bits_CTI : _GEN_27;
  assign _GEN_92 = _T_288 ? out_arb_1_io_out_bits_BTE : _GEN_28;
  assign _GEN_93 = _T_288 ? out_arb_1_io_out_bits_DAT_W : _GEN_29;
  assign _GEN_94 = _T_288 ? out_arb_1_io_out_bits_TGD_W : _GEN_30;
  assign _GEN_95 = _T_288 ? out_arb_1_io_out_bits_CYC : _GEN_36;
  assign _GEN_96 = _T_288 ? out_arb_1_io_out_bits_TGC : _GEN_32;
  assign _GEN_97 = _T_288 ? out_arb_1_io_out_bits_SEL : _GEN_33;
  assign _GEN_98 = _T_288 ? out_arb_1_io_out_bits_STB : _GEN_37;
  assign _GEN_99 = _T_288 ? out_arb_1_io_out_bits_WE : _GEN_35;
  assign _GEN_100 = _T_290 ? 1'h0 : _GEN_95;
  assign _GEN_101 = _T_290 ? 1'h0 : _GEN_98;
  assign _T_413 = out_arb_2_io_chosen;
  assign _T_414 = _T_326 & _T_413;
  assign _GEN_102 = _T_297 ? out_arb_2_io_out_bits_ADR : _GEN_38;
  assign _GEN_103 = _T_297 ? out_arb_2_io_out_bits_TGA : _GEN_39;
  assign _GEN_104 = _T_297 ? out_arb_2_io_out_bits_CTI : _GEN_40;
  assign _GEN_105 = _T_297 ? out_arb_2_io_out_bits_BTE : _GEN_41;
  assign _GEN_106 = _T_297 ? out_arb_2_io_out_bits_DAT_W : _GEN_42;
  assign _GEN_107 = _T_297 ? out_arb_2_io_out_bits_TGD_W : _GEN_43;
  assign _GEN_108 = _T_297 ? out_arb_2_io_out_bits_CYC : _GEN_49;
  assign _GEN_109 = _T_297 ? out_arb_2_io_out_bits_TGC : _GEN_45;
  assign _GEN_110 = _T_297 ? out_arb_2_io_out_bits_SEL : _GEN_46;
  assign _GEN_111 = _T_297 ? out_arb_2_io_out_bits_STB : _GEN_50;
  assign _GEN_112 = _T_297 ? out_arb_2_io_out_bits_WE : _GEN_48;
  assign _GEN_113 = _T_299 ? 1'h0 : _GEN_108;
  assign _GEN_114 = _T_299 ? 1'h0 : _GEN_111;
  assign _T_422 = out_arb_3_io_chosen;
  assign _T_423 = _T_331 & _T_422;
  assign _GEN_115 = _T_306 ? out_arb_3_io_out_bits_ADR : _GEN_51;
  assign _GEN_116 = _T_306 ? out_arb_3_io_out_bits_TGA : _GEN_52;
  assign _GEN_117 = _T_306 ? out_arb_3_io_out_bits_CTI : _GEN_53;
  assign _GEN_118 = _T_306 ? out_arb_3_io_out_bits_BTE : _GEN_54;
  assign _GEN_119 = _T_306 ? out_arb_3_io_out_bits_DAT_W : _GEN_55;
  assign _GEN_120 = _T_306 ? out_arb_3_io_out_bits_TGD_W : _GEN_56;
  assign _GEN_121 = _T_306 ? out_arb_3_io_out_bits_CYC : _GEN_62;
  assign _GEN_122 = _T_306 ? out_arb_3_io_out_bits_TGC : _GEN_58;
  assign _GEN_123 = _T_306 ? out_arb_3_io_out_bits_SEL : _GEN_59;
  assign _GEN_124 = _T_306 ? out_arb_3_io_out_bits_STB : _GEN_63;
  assign _GEN_125 = _T_306 ? out_arb_3_io_out_bits_WE : _GEN_61;
  assign _GEN_126 = _T_308 ? 1'h0 : _GEN_121;
  assign _GEN_127 = _T_308 ? 1'h0 : _GEN_124;
endmodule
