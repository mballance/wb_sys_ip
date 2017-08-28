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
  reg [31:0] _RAND_26;
  reg [7:0] idleCnt;
  reg [31:0] _RAND_27;
  reg [7:0] idleCounter;
  reg [31:0] _RAND_28;
  reg [31:0] ADR;
  reg [31:0] _RAND_29;
  reg  WE;
  reg [31:0] _RAND_30;
  reg [31:0] DAT_W;
  reg [31:0] _RAND_31;
  reg [31:0] DAT_LAST_R;
  reg [31:0] _RAND_32;
  wire  _T_39;
  wire  _T_40;
  wire  _T_41;
  reg [15:0] rand_gen;
  reg [31:0] _RAND_33;
  wire  _T_47;
  wire  _T_48;
  wire  _T_49;
  wire  _T_50;
  wire  _T_51;
  wire  _T_52;
  wire  _T_53;
  wire [14:0] _T_54;
  wire [15:0] _T_55;
  wire [15:0] _GEN_1;
  wire  _T_59;
  wire [1:0] _GEN_2;
  wire [15:0] _GEN_3;
  wire  _T_60;
  wire [1:0] _T_65;
  wire [31:0] _GEN_0;
  wire [31:0] _GEN_4;
  wire [31:0] _GEN_5;
  wire [31:0] _GEN_6;
  wire  _T_67;
  wire [31:0] _GEN_22;
  wire [31:0] _T_73;
  wire [32:0] _T_75;
  wire [31:0] _T_76;
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
  wire  _T_77;
  wire  _T_78;
  wire [1:0] _GEN_18;
  wire  _T_80;
  wire [8:0] _T_82;
  wire [7:0] _T_83;
  wire [7:0] _GEN_19;
  wire [1:0] _GEN_20;
  wire [7:0] _GEN_21;
  reg  _GEN_23;
  reg [31:0] _RAND_34;
  reg  _GEN_24;
  reg [31:0] _RAND_35;
  reg  _GEN_25;
  reg [31:0] _RAND_36;
  assign io_m_ADR = ADR;
  assign io_m_TGA = _GEN_23;
  assign io_m_CTI = 3'h1;
  assign io_m_BTE = 2'h1;
  assign io_m_DAT_W = DAT_W;
  assign io_m_TGD_W = _GEN_24;
  assign io_m_CYC = _T_41;
  assign io_m_TGC = _GEN_25;
  assign io_m_SEL = 4'hf;
  assign io_m_STB = _T_41;
  assign io_m_WE = WE;
  assign _T_39 = reqState == 2'h0;
  assign _T_40 = reqState == 2'h1;
  assign _T_41 = _T_39 | _T_40;
  assign _T_47 = rand_gen[0];
  assign _T_48 = rand_gen[2];
  assign _T_49 = _T_47 ^ _T_48;
  assign _T_50 = rand_gen[3];
  assign _T_51 = _T_49 ^ _T_50;
  assign _T_52 = rand_gen[5];
  assign _T_53 = _T_51 ^ _T_52;
  assign _T_54 = rand_gen[15:1];
  assign _T_55 = {_T_53,_T_54};
  assign _GEN_1 = _T_39 ? _T_55 : rand_gen;
  assign _T_59 = 2'h0 == reqState;
  assign _GEN_2 = _T_59 ? 2'h1 : reqState;
  assign _GEN_3 = _T_59 ? rand_gen : {{8'd0}, idleCnt};
  assign _T_60 = 2'h1 == reqState;
  assign _T_65 = rand_gen[1:0];
  assign _GEN_0 = _GEN_6;
  assign _GEN_4 = 2'h1 == _T_65 ? io_addr_base_1 : io_addr_base_0;
  assign _GEN_5 = 2'h2 == _T_65 ? io_addr_base_2 : _GEN_4;
  assign _GEN_6 = 2'h3 == _T_65 ? io_addr_base_3 : _GEN_5;
  assign _T_67 = rand_gen[1];
  assign _GEN_22 = {{16'd0}, rand_gen};
  assign _T_73 = _GEN_22 ^ DAT_LAST_R;
  assign _T_75 = _T_73 + 32'h1;
  assign _T_76 = _T_75[31:0];
  assign _GEN_7 = _T_67 ? _T_76 : DAT_W;
  assign _GEN_8 = io_m_ACK ? 2'h2 : _GEN_2;
  assign _GEN_9 = io_m_ACK ? _GEN_0 : ADR;
  assign _GEN_10 = io_m_ACK ? _T_67 : WE;
  assign _GEN_11 = io_m_ACK ? 8'h0 : idleCounter;
  assign _GEN_12 = io_m_ACK ? _GEN_7 : DAT_W;
  assign _GEN_13 = _T_60 ? _GEN_8 : _GEN_2;
  assign _GEN_14 = _T_60 ? _GEN_9 : ADR;
  assign _GEN_15 = _T_60 ? _GEN_10 : WE;
  assign _GEN_16 = _T_60 ? _GEN_11 : idleCounter;
  assign _GEN_17 = _T_60 ? _GEN_12 : DAT_W;
  assign _T_77 = 2'h2 == reqState;
  assign _T_78 = idleCnt == idleCounter;
  assign _GEN_18 = _T_78 ? 2'h0 : _GEN_13;
  assign _T_80 = _T_78 == 1'h0;
  assign _T_82 = idleCounter + 8'h1;
  assign _T_83 = _T_82[7:0];
  assign _GEN_19 = _T_80 ? _T_83 : _GEN_16;
  assign _GEN_20 = _T_77 ? _GEN_18 : _GEN_13;
  assign _GEN_21 = _T_77 ? _GEN_19 : _GEN_16;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_26 = {1{$random}};
  reqState = _RAND_26[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_27 = {1{$random}};
  idleCnt = _RAND_27[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_28 = {1{$random}};
  idleCounter = _RAND_28[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_29 = {1{$random}};
  ADR = _RAND_29[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_30 = {1{$random}};
  WE = _RAND_30[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_31 = {1{$random}};
  DAT_W = _RAND_31[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_32 = {1{$random}};
  DAT_LAST_R = _RAND_32[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_33 = {1{$random}};
  rand_gen = _RAND_33[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_34 = {1{$random}};
  _GEN_23 = _RAND_34[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_35 = {1{$random}};
  _GEN_24 = _RAND_35[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_36 = {1{$random}};
  _GEN_25 = _RAND_36[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      reqState <= 2'h0;
    end else begin
      if (_T_77) begin
        if (_T_78) begin
          reqState <= 2'h0;
        end else begin
          if (_T_60) begin
            if (io_m_ACK) begin
              reqState <= 2'h2;
            end else begin
              if (_T_59) begin
                reqState <= 2'h1;
              end
            end
          end else begin
            if (_T_59) begin
              reqState <= 2'h1;
            end
          end
        end
      end else begin
        if (_T_60) begin
          if (io_m_ACK) begin
            reqState <= 2'h2;
          end else begin
            if (_T_59) begin
              reqState <= 2'h1;
            end
          end
        end else begin
          if (_T_59) begin
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
      if (_T_77) begin
        if (_T_80) begin
          idleCounter <= _T_83;
        end else begin
          if (_T_60) begin
            if (io_m_ACK) begin
              idleCounter <= 8'h0;
            end
          end
        end
      end else begin
        if (_T_60) begin
          if (io_m_ACK) begin
            idleCounter <= 8'h0;
          end
        end
      end
    end
    if (reset) begin
      ADR <= 32'h0;
    end else begin
      if (_T_60) begin
        if (io_m_ACK) begin
          ADR <= _GEN_0;
        end
      end
    end
    if (reset) begin
      WE <= 1'h0;
    end else begin
      if (_T_60) begin
        if (io_m_ACK) begin
          WE <= _T_67;
        end
      end
    end
    if (reset) begin
      DAT_W <= 32'h1;
    end else begin
      if (_T_60) begin
        if (io_m_ACK) begin
          if (_T_67) begin
            DAT_W <= _T_76;
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
        rand_gen <= _T_55;
      end
    end
  end
endmodule
