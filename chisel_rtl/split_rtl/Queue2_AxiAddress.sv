module Queue2_AxiAddress(
  input         clock,
                reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [31:0] io_enq_bits_addr,
  input  [2:0]  io_enq_bits_prot,
  input  [5:0]  io_enq_bits_id,
  input  [7:0]  io_enq_bits_len,
  input  [2:0]  io_enq_bits_size,
  input  [1:0]  io_enq_bits_burst,
  input         io_enq_bits_lock,
  input  [3:0]  io_enq_bits_cache,
                io_enq_bits_qos,
                io_enq_bits_region,
  input         io_deq_ready,
  output        io_deq_valid,
  output [31:0] io_deq_bits_addr,
  output [2:0]  io_deq_bits_prot,
  output [5:0]  io_deq_bits_id,
  output [7:0]  io_deq_bits_len,
  output [2:0]  io_deq_bits_size,
  output [1:0]  io_deq_bits_burst,
  output        io_deq_bits_lock,
  output [3:0]  io_deq_bits_cache,
                io_deq_bits_qos,
                io_deq_bits_region
);

  wire [66:0] _ram_ext_R0_data;
  reg         wrap;
  reg         wrap_1;
  reg         maybe_full;
  wire        ptr_match = wrap == wrap_1;
  wire        empty = ptr_match & ~maybe_full;
  wire        full = ptr_match & maybe_full;
  wire        do_enq = ~full & io_enq_valid;
  wire        do_deq = io_deq_ready & ~empty;
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
  ram_2x67 ram_ext (
    .R0_addr (wrap_1),
    .R0_en   (1'h1),
    .R0_clk  (clock),
    .R0_data (_ram_ext_R0_data),
    .W0_addr (wrap),
    .W0_en   (do_enq),
    .W0_clk  (clock),
    .W0_data
      ({io_enq_bits_addr,
        io_enq_bits_prot,
        io_enq_bits_id,
        io_enq_bits_len,
        io_enq_bits_size,
        io_enq_bits_burst,
        io_enq_bits_lock,
        io_enq_bits_cache,
        io_enq_bits_qos,
        io_enq_bits_region})
  );
  assign io_enq_ready = ~full;
  assign io_deq_valid = ~empty;
  assign io_deq_bits_addr = _ram_ext_R0_data[66:35];
  assign io_deq_bits_prot = _ram_ext_R0_data[34:32];
  assign io_deq_bits_id = _ram_ext_R0_data[31:26];
  assign io_deq_bits_len = _ram_ext_R0_data[25:18];
  assign io_deq_bits_size = _ram_ext_R0_data[17:15];
  assign io_deq_bits_burst = _ram_ext_R0_data[14:13];
  assign io_deq_bits_lock = _ram_ext_R0_data[12];
  assign io_deq_bits_cache = _ram_ext_R0_data[11:8];
  assign io_deq_bits_qos = _ram_ext_R0_data[7:4];
  assign io_deq_bits_region = _ram_ext_R0_data[3:0];
endmodule
