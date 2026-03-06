module Queue1_MluStage1(
  input        clock,
               reset,
               io_enq_valid,
  input  [4:0] io_enq_bits_rd,
  input  [2:0] io_enq_bits_op,
  input  [3:0] io_enq_bits_sel,
  output       io_deq_valid,
  output [4:0] io_deq_bits_rd,
  output [2:0] io_deq_bits_op,
  output [3:0] io_deq_bits_sel
);

  reg [11:0] ram;
  reg        full;
  always @(posedge clock or posedge reset) begin
    if (reset)
      full <= 1'h0;
    else if (~(io_enq_valid == full))
      full <= io_enq_valid;
  end // always @(posedge, posedge)
  always @(posedge clock) begin
    if (io_enq_valid)
      ram <= {io_enq_bits_rd, io_enq_bits_op, io_enq_bits_sel};
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:0];
    initial begin
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        _RANDOM[/*Zero width*/ 1'b0] = `RANDOM;
        full = _RANDOM[/*Zero width*/ 1'b0][0];
        ram = _RANDOM[/*Zero width*/ 1'b0][12:1];
      `endif // RANDOMIZE_REG_INIT
      if (reset)
        full = 1'h0;
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_deq_valid = full;
  assign io_deq_bits_rd = ram[11:7];
  assign io_deq_bits_op = ram[6:4];
  assign io_deq_bits_sel = ram[3:0];
endmodule
