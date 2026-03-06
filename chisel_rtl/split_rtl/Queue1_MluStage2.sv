module Queue1_MluStage2(
  input         clock,
                reset,
                io_enq_valid,
  input  [4:0]  io_enq_bits_rd,
  input  [2:0]  io_enq_bits_op,
  input  [65:0] io_enq_bits_prod,
  output        io_deq_valid,
  output [4:0]  io_deq_bits_rd,
  output [2:0]  io_deq_bits_op,
  output [65:0] io_deq_bits_prod
);

  reg [73:0] ram;
  reg        full;
  always @(posedge clock or posedge reset) begin
    if (reset)
      full <= 1'h0;
    else if (~(io_enq_valid == full))
      full <= io_enq_valid;
  end // always @(posedge, posedge)
  always @(posedge clock) begin
    if (io_enq_valid)
      ram <= {io_enq_bits_rd, io_enq_bits_op, io_enq_bits_prod};
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:2];
    initial begin
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [1:0] i = 2'h0; i < 2'h3; i += 2'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        full = _RANDOM[2'h0][0];
        ram = {_RANDOM[2'h0][31:1], _RANDOM[2'h1], _RANDOM[2'h2][10:0]};
      `endif // RANDOMIZE_REG_INIT
      if (reset)
        full = 1'h0;
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_deq_valid = full;
  assign io_deq_bits_rd = ram[73:69];
  assign io_deq_bits_op = ram[68:66];
  assign io_deq_bits_prod = ram[65:0];
endmodule
