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
  reg [31:0] _RAND_29;
  reg [7:0] idleCnt;
  reg [31:0] _RAND_30;
  reg [7:0] idleCounter;
  reg [31:0] _RAND_31;
  reg [31:0] ADR;
  reg [31:0] _RAND_32;
  reg  WE;
  reg [31:0] _RAND_33;
  wire  _T_35;
  wire  _T_36;
  wire  _T_37;
  reg [15:0] rand_gen;
  reg [31:0] _RAND_34;
  wire  _T_43;
  wire  _T_44;
  wire  _T_45;
  wire  _T_46;
  wire  _T_47;
  wire  _T_48;
  wire  _T_49;
  wire [14:0] _T_50;
  wire [15:0] _T_51;
  wire [15:0] _GEN_1;
  wire  _T_52;
  wire [1:0] _T_53;
  wire [2:0] _T_55;
  wire [5:0] _T_57;
  wire [31:0] _GEN_0;
  wire [31:0] _GEN_2;
  wire [31:0] _GEN_3;
  wire [31:0] _GEN_4;
  wire [31:0] _GEN_21;
  wire [32:0] _T_58;
  wire [31:0] _T_59;
  wire  _T_60;
  wire [1:0] _GEN_5;
  wire [15:0] _GEN_6;
  wire [31:0] _GEN_7;
  wire  _GEN_8;
  wire  _T_63;
  wire [1:0] _GEN_9;
  wire [31:0] _GEN_10;
  wire  _GEN_11;
  wire [7:0] _GEN_12;
  wire [1:0] _GEN_13;
  wire [31:0] _GEN_14;
  wire  _GEN_15;
  wire [7:0] _GEN_16;
  wire  _T_67;
  wire  _T_68;
  wire [1:0] _GEN_17;
  wire  _T_70;
  wire [8:0] _T_72;
  wire [7:0] _T_73;
  wire [7:0] _GEN_18;
  wire [1:0] _GEN_19;
  wire [7:0] _GEN_20;
  reg  _GEN_22;
  reg [31:0] _RAND_35;
  reg [2:0] _GEN_23;
  reg [31:0] _RAND_36;
  reg [1:0] _GEN_24;
  reg [31:0] _RAND_37;
  reg [31:0] _GEN_25;
  reg [31:0] _RAND_38;
  reg  _GEN_26;
  reg [31:0] _RAND_39;
  reg  _GEN_27;
  reg [31:0] _RAND_40;
  reg [3:0] _GEN_28;
  reg [31:0] _RAND_41;
  assign io_m_ADR = ADR;
  assign io_m_TGA = _GEN_22;
  assign io_m_CTI = _GEN_23;
  assign io_m_BTE = _GEN_24;
  assign io_m_DAT_W = _GEN_25;
  assign io_m_TGD_W = _GEN_26;
  assign io_m_CYC = _T_37;
  assign io_m_TGC = _GEN_27;
  assign io_m_SEL = _GEN_28;
  assign io_m_STB = _T_37;
  assign io_m_WE = WE;
  assign _T_35 = reqState == 2'h0;
  assign _T_36 = reqState == 2'h1;
  assign _T_37 = _T_35 | _T_36;
  assign _T_43 = rand_gen[0];
  assign _T_44 = rand_gen[2];
  assign _T_45 = _T_43 ^ _T_44;
  assign _T_46 = rand_gen[3];
  assign _T_47 = _T_45 ^ _T_46;
  assign _T_48 = rand_gen[5];
  assign _T_49 = _T_47 ^ _T_48;
  assign _T_50 = rand_gen[15:1];
  assign _T_51 = {_T_49,_T_50};
  assign _GEN_1 = _T_35 ? _T_51 : rand_gen;
  assign _T_52 = 2'h0 == reqState;
  assign _T_53 = rand_gen[1:0];
  assign _T_55 = rand_gen[4:2];
  assign _T_57 = _T_55 * 3'h4;
  assign _GEN_0 = _GEN_4;
  assign _GEN_2 = 2'h1 == _T_53 ? io_addr_base_1 : io_addr_base_0;
  assign _GEN_3 = 2'h2 == _T_53 ? io_addr_base_2 : _GEN_2;
  assign _GEN_4 = 2'h3 == _T_53 ? io_addr_base_3 : _GEN_3;
  assign _GEN_21 = {{26'd0}, _T_57};
  assign _T_58 = _GEN_0 + _GEN_21;
  assign _T_59 = _T_58[31:0];
  assign _T_60 = rand_gen[1];
  assign _GEN_5 = _T_52 ? 2'h1 : reqState;
  assign _GEN_6 = _T_52 ? rand_gen : {{8'd0}, idleCnt};
  assign _GEN_7 = _T_52 ? _T_59 : ADR;
  assign _GEN_8 = _T_52 ? _T_60 : WE;
  assign _T_63 = 2'h1 == reqState;
  assign _GEN_9 = io_m_ACK ? 2'h2 : _GEN_5;
  assign _GEN_10 = io_m_ACK ? 32'h0 : _GEN_7;
  assign _GEN_11 = io_m_ACK ? 1'h0 : _GEN_8;
  assign _GEN_12 = io_m_ACK ? 8'h0 : idleCounter;
  assign _GEN_13 = _T_63 ? _GEN_9 : _GEN_5;
  assign _GEN_14 = _T_63 ? _GEN_10 : _GEN_7;
  assign _GEN_15 = _T_63 ? _GEN_11 : _GEN_8;
  assign _GEN_16 = _T_63 ? _GEN_12 : idleCounter;
  assign _T_67 = 2'h2 == reqState;
  assign _T_68 = idleCnt == idleCounter;
  assign _GEN_17 = _T_68 ? 2'h0 : _GEN_13;
  assign _T_70 = _T_68 == 1'h0;
  assign _T_72 = idleCounter + 8'h1;
  assign _T_73 = _T_72[7:0];
  assign _GEN_18 = _T_70 ? _T_73 : _GEN_16;
  assign _GEN_19 = _T_67 ? _GEN_17 : _GEN_13;
  assign _GEN_20 = _T_67 ? _GEN_18 : _GEN_16;
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifndef verilator
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_29 = {1{$random}};
  reqState = _RAND_29[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_30 = {1{$random}};
  idleCnt = _RAND_30[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_31 = {1{$random}};
  idleCounter = _RAND_31[7:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_32 = {1{$random}};
  ADR = _RAND_32[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_33 = {1{$random}};
  WE = _RAND_33[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_34 = {1{$random}};
  rand_gen = _RAND_34[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_35 = {1{$random}};
  _GEN_22 = _RAND_35[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_36 = {1{$random}};
  _GEN_23 = _RAND_36[2:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_37 = {1{$random}};
  _GEN_24 = _RAND_37[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_38 = {1{$random}};
  _GEN_25 = _RAND_38[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_39 = {1{$random}};
  _GEN_26 = _RAND_39[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_40 = {1{$random}};
  _GEN_27 = _RAND_40[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_41 = {1{$random}};
  _GEN_28 = _RAND_41[3:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      reqState <= 2'h0;
    end else begin
      if (_T_67) begin
        if (_T_68) begin
          reqState <= 2'h0;
        end else begin
          if (_T_63) begin
            if (io_m_ACK) begin
              reqState <= 2'h2;
            end else begin
              if (_T_52) begin
                reqState <= 2'h1;
              end
            end
          end else begin
            if (_T_52) begin
              reqState <= 2'h1;
            end
          end
        end
      end else begin
        if (_T_63) begin
          if (io_m_ACK) begin
            reqState <= 2'h2;
          end else begin
            if (_T_52) begin
              reqState <= 2'h1;
            end
          end
        end else begin
          if (_T_52) begin
            reqState <= 2'h1;
          end
        end
      end
    end
    if (reset) begin
      idleCnt <= 8'h0;
    end else begin
      idleCnt <= _GEN_6[7:0];
    end
    if (reset) begin
      idleCounter <= 8'h0;
    end else begin
      if (_T_67) begin
        if (_T_70) begin
          idleCounter <= _T_73;
        end else begin
          if (_T_63) begin
            if (io_m_ACK) begin
              idleCounter <= 8'h0;
            end
          end
        end
      end else begin
        if (_T_63) begin
          if (io_m_ACK) begin
            idleCounter <= 8'h0;
          end
        end
      end
    end
    if (reset) begin
      ADR <= 32'h0;
    end else begin
      if (_T_63) begin
        if (io_m_ACK) begin
          ADR <= 32'h0;
        end else begin
          if (_T_52) begin
            ADR <= _T_59;
          end
        end
      end else begin
        if (_T_52) begin
          ADR <= _T_59;
        end
      end
    end
    if (reset) begin
      WE <= 1'h0;
    end else begin
      if (_T_63) begin
        if (io_m_ACK) begin
          WE <= 1'h0;
        end else begin
          if (_T_52) begin
            WE <= _T_60;
          end
        end
      end else begin
        if (_T_52) begin
          WE <= _T_60;
        end
      end
    end
    if (reset) begin
      rand_gen <= 16'h1;
    end else begin
      if (_T_35) begin
        rand_gen <= _T_51;
      end
    end
  end
endmodule
