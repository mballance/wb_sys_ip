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

module wishbone_test_master_32_32_4(
  input         clock,
  input         reset,
  input  [31:0] io_addr_base_0,
  input  [31:0] io_addr_base_1,
  input  [31:0] io_addr_base_2,
  input  [31:0] io_addr_base_3,
  output [31:0] io_m_ADR,
  output        io_m_TGA,
  output [2:0]  io_m_CTI,
  output [1:0]  io_m_BTE,
  output [31:0] io_m_DAT_W,
  output        io_m_TGD_W,
  input  [31:0] io_m_DAT_R,
  input         io_m_TGD_R,
  output        io_m_CYC,
  output        io_m_TGC,
  input         io_m_ERR,
  output [3:0]  io_m_SEL,
  output        io_m_STB,
  input         io_m_ACK,
  output        io_m_WE
);
  reg [1:0] reqState;
  reg [31:0] _RAND_24;
  reg [7:0] idleCnt;
  reg [31:0] _RAND_25;
  reg [7:0] idleCounter;
  reg [31:0] _RAND_26;
  reg [31:0] ADR;
  reg [31:0] _RAND_27;
  reg  WE;
  reg [31:0] _RAND_28;
  reg [31:0] DAT_W;
  reg [31:0] _RAND_29;
  reg [31:0] DAT_LAST_R;
  reg [31:0] _RAND_30;
  wire  _T_39;
  wire  _T_40;
  wire  _T_41;
  wire  _T_43;
  wire  _T_44;
  reg [15:0] rand_gen;
  reg [31:0] _RAND_31;
  wire  _T_53;
  wire  _T_54;
  wire  _T_55;
  wire  _T_56;
  wire  _T_57;
  wire  _T_58;
  wire  _T_59;
  wire [14:0] _T_60;
  wire [15:0] _T_61;
  wire [15:0] _GEN_1;
  wire  _T_67;
  wire [1:0] _GEN_2;
  wire [15:0] _GEN_3;
  wire  _T_68;
  wire [1:0] _T_73;
  wire [31:0] _GEN_0;
  wire [31:0] _GEN_4;
  wire [31:0] _GEN_5;
  wire [31:0] _GEN_6;
  wire  _T_75;
  wire [31:0] _GEN_22;
  wire [31:0] _T_81;
  wire [32:0] _T_83;
  wire [31:0] _T_84;
  wire [31:0] _GEN_7;
  wire [1:0] _GEN_8;
  wire [31:0] _GEN_9;
  wire  _GEN_10;
  wire [7:0] _GEN_11;
  wire [31:0] _GEN_12;
  wire [1:0] _GEN_13;
  wire [31:0] _GEN_14;
  wire  _GEN_15;
  wire [7:0] _GEN_16;
  wire [31:0] _GEN_17;
  wire  _T_85;
  wire  _T_86;
  wire [1:0] _GEN_18;
  wire  _T_88;
  wire [8:0] _T_90;
  wire [7:0] _T_91;
  wire [7:0] _GEN_19;
  wire [1:0] _GEN_20;
  wire [7:0] _GEN_21;
  reg  _GEN_23;
  reg [31:0] _RAND_32;
  assign io_m_ADR = ADR;
  assign io_m_TGA = 1'h0;
  assign io_m_CTI = 3'h1;
  assign io_m_BTE = 2'h1;
  assign io_m_DAT_W = DAT_W;
  assign io_m_TGD_W = _GEN_23;
  assign io_m_CYC = _T_44;
  assign io_m_TGC = 1'h0;
  assign io_m_SEL = 4'hf;
  assign io_m_STB = _T_44;
  assign io_m_WE = WE;
  assign _T_39 = reqState == 2'h0;
  assign _T_40 = reqState == 2'h1;
  assign _T_41 = _T_39 | _T_40;
  assign _T_43 = reset == 1'h0;
  assign _T_44 = _T_41 & _T_43;
  assign _T_53 = rand_gen[0];
  assign _T_54 = rand_gen[2];
  assign _T_55 = _T_53 ^ _T_54;
  assign _T_56 = rand_gen[3];
  assign _T_57 = _T_55 ^ _T_56;
  assign _T_58 = rand_gen[5];
  assign _T_59 = _T_57 ^ _T_58;
  assign _T_60 = rand_gen[15:1];
  assign _T_61 = {_T_59,_T_60};
  assign _GEN_1 = _T_39 ? _T_61 : rand_gen;
  assign _T_67 = 2'h0 == reqState;
  assign _GEN_2 = _T_67 ? 2'h1 : reqState;
  assign _GEN_3 = _T_67 ? rand_gen : {{8'd0}, idleCnt};
  assign _T_68 = 2'h1 == reqState;
  assign _T_73 = rand_gen[1:0];
  assign _GEN_0 = _GEN_6;
  assign _GEN_4 = 2'h1 == _T_73 ? io_addr_base_1 : io_addr_base_0;
  assign _GEN_5 = 2'h2 == _T_73 ? io_addr_base_2 : _GEN_4;
  assign _GEN_6 = 2'h3 == _T_73 ? io_addr_base_3 : _GEN_5;
  assign _T_75 = rand_gen[1];
  assign _GEN_22 = {{16'd0}, rand_gen};
  assign _T_81 = _GEN_22 ^ DAT_LAST_R;
  assign _T_83 = _T_81 + 32'h1;
  assign _T_84 = _T_83[31:0];
  assign _GEN_7 = _T_75 ? _T_84 : DAT_W;
  assign _GEN_8 = io_m_ACK ? 2'h2 : _GEN_2;
  assign _GEN_9 = io_m_ACK ? _GEN_0 : ADR;
  assign _GEN_10 = io_m_ACK ? _T_75 : WE;
  assign _GEN_11 = io_m_ACK ? 8'h0 : idleCounter;
  assign _GEN_12 = io_m_ACK ? _GEN_7 : DAT_W;
  assign _GEN_13 = _T_68 ? _GEN_8 : _GEN_2;
  assign _GEN_14 = _T_68 ? _GEN_9 : ADR;
  assign _GEN_15 = _T_68 ? _GEN_10 : WE;
  assign _GEN_16 = _T_68 ? _GEN_11 : idleCounter;
  assign _GEN_17 = _T_68 ? _GEN_12 : DAT_W;
  assign _T_85 = 2'h2 == reqState;
  assign _T_86 = idleCnt == idleCounter;
  assign _GEN_18 = _T_86 ? 2'h0 : _GEN_13;
  assign _T_88 = _T_86 == 1'h0;
  assign _T_90 = idleCounter + 8'h1;
  assign _T_91 = _T_90[7:0];
  assign _GEN_19 = _T_88 ? _T_91 : _GEN_16;
  assign _GEN_20 = _T_85 ? _GEN_18 : _GEN_13;
  assign _GEN_21 = _T_85 ? _GEN_19 : _GEN_16;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_24 = {1{$random}};
  reqState = _RAND_24[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_25 = {1{$random}};
  idleCnt = _RAND_25[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_26 = {1{$random}};
  idleCounter = _RAND_26[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_27 = {1{$random}};
  ADR = _RAND_27[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_28 = {1{$random}};
  WE = _RAND_28[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_29 = {1{$random}};
  DAT_W = _RAND_29[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_30 = {1{$random}};
  DAT_LAST_R = _RAND_30[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_31 = {1{$random}};
  rand_gen = _RAND_31[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_32 = {1{$random}};
  _GEN_23 = _RAND_32[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      reqState <= 2'h0;
    end else begin
      if (_T_85) begin
        if (_T_86) begin
          reqState <= 2'h0;
        end else begin
          if (_T_68) begin
            if (io_m_ACK) begin
              reqState <= 2'h2;
            end else begin
              if (_T_67) begin
                reqState <= 2'h1;
              end
            end
          end else begin
            if (_T_67) begin
              reqState <= 2'h1;
            end
          end
        end
      end else begin
        if (_T_68) begin
          if (io_m_ACK) begin
            reqState <= 2'h2;
          end else begin
            if (_T_67) begin
              reqState <= 2'h1;
            end
          end
        end else begin
          if (_T_67) begin
            reqState <= 2'h1;
          end
        end
      end
    end
    if (reset) begin
      idleCnt <= 8'h0;
    end else begin
      idleCnt <= _GEN_3[7:0];
    end
    if (reset) begin
      idleCounter <= 8'h0;
    end else begin
      if (_T_85) begin
        if (_T_88) begin
          idleCounter <= _T_91;
        end else begin
          if (_T_68) begin
            if (io_m_ACK) begin
              idleCounter <= 8'h0;
            end
          end
        end
      end else begin
        if (_T_68) begin
          if (io_m_ACK) begin
            idleCounter <= 8'h0;
          end
        end
      end
    end
    if (reset) begin
      ADR <= 32'h0;
    end else begin
      if (_T_68) begin
        if (io_m_ACK) begin
          ADR <= _GEN_0;
        end
      end
    end
    if (reset) begin
      WE <= 1'h0;
    end else begin
      if (_T_68) begin
        if (io_m_ACK) begin
          WE <= _T_75;
        end
      end
    end
    if (reset) begin
      DAT_W <= 32'h1;
    end else begin
      if (_T_68) begin
        if (io_m_ACK) begin
          if (_T_75) begin
            DAT_W <= _T_84;
          end
        end
      end
    end
    if (reset) begin
      DAT_LAST_R <= 32'h1;
    end
    if (reset) begin
      rand_gen <= 16'h1;
    end else begin
      if (_T_39) begin
        rand_gen <= _T_61;
      end
    end
  end
endmodule
