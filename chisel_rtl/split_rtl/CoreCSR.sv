module CoreCSR(
  input          clock,
                 reset,
  input  [31:0]  io_fabric_readDataAddr_bits,
  output         io_fabric_readData_valid,
  output [127:0] io_fabric_readData_bits,
  input          io_fabric_writeDataAddr_valid,
  input  [31:0]  io_fabric_writeDataAddr_bits,
  input  [127:0] io_fabric_writeDataBits,
  output         io_fabric_writeResp,
                 io_reset,
                 io_cg,
  output [31:0]  io_pcStart,
  input          io_halted,
                 io_fault,
  input  [31:0]  io_coralnpu_csr_value_0,
                 io_coralnpu_csr_value_1,
                 io_coralnpu_csr_value_2,
                 io_coralnpu_csr_value_3,
                 io_coralnpu_csr_value_4,
                 io_coralnpu_csr_value_5,
                 io_coralnpu_csr_value_6,
                 io_coralnpu_csr_value_7,
                 io_coralnpu_csr_value_8
);

  reg  [31:0]  resetReg;
  reg  [31:0]  pcStartReg;
  reg  [31:0]  statusReg;
  wire         readDataValid =
    io_fabric_readDataAddr_bits == 32'h0 | io_fabric_readDataAddr_bits == 32'h108
    | io_fabric_readDataAddr_bits == 32'h100 | io_fabric_readDataAddr_bits == 32'h118
    | io_fabric_readDataAddr_bits == 32'h110 | io_fabric_readDataAddr_bits == 32'h10C
    | io_fabric_readDataAddr_bits == 32'h11C | io_fabric_readDataAddr_bits == 32'h114
    | io_fabric_readDataAddr_bits == 32'h120 | io_fabric_readDataAddr_bits == 32'h104
    | io_fabric_readDataAddr_bits == 32'h8 | io_fabric_readDataAddr_bits == 32'h4;
  reg          readDataNext_pipe_v;
  reg  [127:0] readDataNext_pipe_b;
  wire         _io_fabric_writeResp_T_1 = io_fabric_writeDataAddr_bits == 32'h0;
  wire         _io_fabric_writeResp_T_2 = io_fabric_writeDataAddr_bits == 32'h4;
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      resetReg <= 32'h3;
      pcStartReg <= 32'h0;
      statusReg <= 32'h0;
      readDataNext_pipe_v <= 1'h0;
    end
    else begin
      if (io_fabric_writeDataAddr_valid & _io_fabric_writeResp_T_1)
        resetReg <= io_fabric_writeDataBits[31:0];
      if (io_fabric_writeDataAddr_valid & _io_fabric_writeResp_T_2)
        pcStartReg <= io_fabric_writeDataBits[63:32];
      statusReg <= {30'h0, io_fault, io_halted};
      readDataNext_pipe_v <= readDataValid;
    end
  end // always @(posedge, posedge)
  wire         _GEN = io_fabric_readDataAddr_bits[31:4] == 28'h0;
  wire         _GEN_0 = io_fabric_readDataAddr_bits[31:4] == 28'h10;
  wire         _GEN_1 = io_fabric_readDataAddr_bits[31:4] == 28'h11;
  always @(posedge clock) begin
    if (readDataValid)
      readDataNext_pipe_b <=
        {_GEN_1 ? io_coralnpu_csr_value_7 : _GEN_0 ? io_coralnpu_csr_value_3 : 32'h0,
         _GEN_1
           ? io_coralnpu_csr_value_6
           : _GEN_0 ? io_coralnpu_csr_value_2 : _GEN ? statusReg : 32'h0,
         _GEN_1
           ? io_coralnpu_csr_value_5
           : _GEN_0 ? io_coralnpu_csr_value_1 : _GEN ? pcStartReg : 32'h0,
         _GEN_1
           ? io_coralnpu_csr_value_4
           : _GEN_0
               ? io_coralnpu_csr_value_0
               : io_fabric_readDataAddr_bits[31:4] == 28'h12
                   ? io_coralnpu_csr_value_8
                   : _GEN ? resetReg : 32'h0};
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:7];
    initial begin
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [3:0] i = 4'h0; i < 4'h8; i += 4'h1) begin
          _RANDOM[i[2:0]] = `RANDOM;
        end
        resetReg = _RANDOM[3'h0];
        pcStartReg = _RANDOM[3'h1];
        statusReg = _RANDOM[3'h2];
        readDataNext_pipe_v = _RANDOM[3'h3][0];
        readDataNext_pipe_b =
          {_RANDOM[3'h3][31:1],
           _RANDOM[3'h4],
           _RANDOM[3'h5],
           _RANDOM[3'h6],
           _RANDOM[3'h7][0]};
      `endif // RANDOMIZE_REG_INIT
      if (reset) begin
        resetReg = 32'h3;
        pcStartReg = 32'h0;
        statusReg = 32'h0;
        readDataNext_pipe_v = 1'h0;
      end
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_fabric_readData_valid = readDataNext_pipe_v;
  assign io_fabric_readData_bits = readDataNext_pipe_b;
  assign io_fabric_writeResp =
    io_fabric_writeDataAddr_valid & (_io_fabric_writeResp_T_2 | _io_fabric_writeResp_T_1);
  assign io_reset = resetReg[0];
  assign io_cg = resetReg[1];
  assign io_pcStart = pcStartReg;
endmodule
