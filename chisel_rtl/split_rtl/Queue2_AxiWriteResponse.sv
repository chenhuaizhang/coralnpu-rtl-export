module Queue2_AxiWriteResponse(
  input        clock,
               reset,
  output       io_enq_ready,
  input        io_enq_valid,
  input  [5:0] io_enq_bits_id,
  input  [1:0] io_enq_bits_resp,
  input        io_deq_ready,
  output       io_deq_valid,
  output [5:0] io_deq_bits_id,
  output [1:0] io_deq_bits_resp
);

  wire [7:0] _ram_ext_R0_data;
  reg        wrap;
  reg        wrap_1;
  reg        maybe_full;
  wire       ptr_match = wrap == wrap_1;
  wire       empty = ptr_match & ~maybe_full;
  wire       full = ptr_match & maybe_full;
  wire       do_enq = ~full & io_enq_valid;
  wire       do_deq = io_deq_ready & ~empty;
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      wrap <= 1'h0;
      wrap_1 <= 1'h0;
      maybe_full <= 1'h0;
    end
    else begin
      if (do_enq)
        wrap <= wrap - 1'h1;
      if (do_deq)
        wrap_1 <= wrap_1 - 1'h1;
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
        wrap = _RANDOM[/*Zero width*/ 1'b0][0];
        wrap_1 = _RANDOM[/*Zero width*/ 1'b0][1];
        maybe_full = _RANDOM[/*Zero width*/ 1'b0][2];
      `endif // RANDOMIZE_REG_INIT
      if (reset) begin
        wrap = 1'h0;
        wrap_1 = 1'h0;
        maybe_full = 1'h0;
      end
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  ram_2x8 ram_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .R0_data (_ram_ext_R0_data),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data ({io_enq_bits_id, io_enq_bits_resp})
  );
  assign io_enq_ready = ~full;
  assign io_deq_valid = ~empty;
  assign io_deq_bits_id = _ram_ext_R0_data[7:2];
  assign io_deq_bits_resp = _ram_ext_R0_data[1:0];
endmodule
