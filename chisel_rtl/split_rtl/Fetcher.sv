module Fetcher(
  input          clock,
                 reset,
                 io_ctrl_valid,
  input  [31:0]  io_ctrl_bits,
  output         io_fetch_valid,
  output [31:0]  io_fetch_bits_addr,
                 io_fetch_bits_inst_0,
                 io_fetch_bits_inst_1,
                 io_fetch_bits_inst_2,
                 io_fetch_bits_inst_3,
  output         io_fetch_bits_fault,
                 io_ibus_valid,
  input          io_ibus_ready,
  output [31:0]  io_ibus_addr,
  input  [127:0] io_ibus_rdata,
  input          io_ibus_fault_valid
);

  reg         ibusCmd_valid;
  reg  [31:0] ibusCmd_bits;
  reg         fault;
  wire        ibusFired = io_ctrl_valid & io_ibus_ready;
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      ibusCmd_valid <= 1'h0;
      ibusCmd_bits <= 32'h0;
      fault <= 1'h0;
    end
    else begin
      ibusCmd_valid <= ibusFired;
      ibusCmd_bits <= ibusFired ? io_ctrl_bits : 32'h0;
      fault <= io_ibus_fault_valid;
    end
  end // always @(posedge, posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:1];
    initial begin
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [1:0] i = 2'h0; i < 2'h2; i += 2'h1) begin
          _RANDOM[i[0]] = `RANDOM;
        end
        ibusCmd_valid = _RANDOM[1'h0][0];
        ibusCmd_bits = {_RANDOM[1'h0][31:1], _RANDOM[1'h1][0]};
        fault = _RANDOM[1'h1][1];
      `endif // RANDOMIZE_REG_INIT
      if (reset) begin
        ibusCmd_valid = 1'h0;
        ibusCmd_bits = 32'h0;
        fault = 1'h0;
      end
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_fetch_valid = ibusCmd_valid;
  assign io_fetch_bits_addr = ibusCmd_bits;
  assign io_fetch_bits_inst_0 = io_ibus_rdata[31:0];
  assign io_fetch_bits_inst_1 = io_ibus_rdata[63:32];
  assign io_fetch_bits_inst_2 = io_ibus_rdata[95:64];
  assign io_fetch_bits_inst_3 = io_ibus_rdata[127:96];
  assign io_fetch_bits_fault = fault;
  assign io_ibus_valid = io_ctrl_valid;
  assign io_ibus_addr = {io_ctrl_bits[31:4], 4'h0};
endmodule
