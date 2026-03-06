module Queue3_AxiWriteData(
  input          clock,
                 reset,
  output         io_enq_ready,
  input          io_enq_valid,
  input  [127:0] io_enq_bits_data,
  input          io_enq_bits_last,
  input  [15:0]  io_enq_bits_strb,
  input          io_deq_ready,
  output         io_deq_valid,
  output [127:0] io_deq_bits_data,
  output         io_deq_bits_last,
  output [15:0]  io_deq_bits_strb
);

  wire [144:0] _ram_ext_R0_data;
  reg  [1:0]   enq_ptr_value;
  reg  [1:0]   deq_ptr_value;
  reg          maybe_full;
  wire         ptr_match = enq_ptr_value == deq_ptr_value;
  wire         empty = ptr_match & ~maybe_full;
  wire         full = ptr_match & maybe_full;
  wire         do_enq = ~full & io_enq_valid;
  wire         do_deq = io_deq_ready & ~empty;
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      enq_ptr_value <= 2'h0;
      deq_ptr_value <= 2'h0;
      maybe_full <= 1'h0;
    end
    else begin
      if (do_enq)
        enq_ptr_value <= enq_ptr_value == 2'h2 ? 2'h0 : enq_ptr_value + 2'h1;
      if (do_deq)
        deq_ptr_value <= deq_ptr_value == 2'h2 ? 2'h0 : deq_ptr_value + 2'h1;
      if (~(do_enq == do_deq))
        maybe_full <= do_enq;
    end
  end // always @(posedge, posedge)
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
        enq_ptr_value = _RANDOM[/*Zero width*/ 1'b0][1:0];
        deq_ptr_value = _RANDOM[/*Zero width*/ 1'b0][3:2];
        maybe_full = _RANDOM[/*Zero width*/ 1'b0][4];
      `endif // RANDOMIZE_REG_INIT
      if (reset) begin
        enq_ptr_value = 2'h0;
        deq_ptr_value = 2'h0;
        maybe_full = 1'h0;
      end
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  ram_3x145 ram_ext (
    .R0_addr (deq_ptr_value),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .R0_data (_ram_ext_R0_data),
    .W0_addr (enq_ptr_value),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data ({io_enq_bits_data, io_enq_bits_last, io_enq_bits_strb})
  );
  assign io_enq_ready = ~full;
  assign io_deq_valid = ~empty;
  assign io_deq_bits_data = _ram_ext_R0_data[144:17];
  assign io_deq_bits_last = _ram_ext_R0_data[16];
  assign io_deq_bits_strb = _ram_ext_R0_data[15:0];
endmodule
