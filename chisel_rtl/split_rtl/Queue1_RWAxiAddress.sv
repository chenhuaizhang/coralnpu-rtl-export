module Queue1_RWAxiAddress(
  input         clock,
                reset,
  output        io_enq_ready,
  input         io_enq_valid,
  input  [31:0] io_enq_bits_addr_addr,
  input  [2:0]  io_enq_bits_addr_prot,
  input  [5:0]  io_enq_bits_addr_id,
  input  [7:0]  io_enq_bits_addr_len,
  input  [2:0]  io_enq_bits_addr_size,
  input  [1:0]  io_enq_bits_addr_burst,
  input         io_enq_bits_addr_lock,
  input  [3:0]  io_enq_bits_addr_cache,
                io_enq_bits_addr_qos,
                io_enq_bits_addr_region,
  input         io_enq_bits_write,
                io_deq_ready,
  output        io_deq_valid,
  output [31:0] io_deq_bits_addr_addr,
  output [5:0]  io_deq_bits_addr_id,
  output [7:0]  io_deq_bits_addr_len,
  output [2:0]  io_deq_bits_addr_size,
  output [1:0]  io_deq_bits_addr_burst,
  output        io_deq_bits_write
);

  reg  [67:0] ram;
  wire        io_enq_ready_0;
  reg         full;
  wire        do_enq = io_enq_ready_0 & io_enq_valid;
  assign io_enq_ready_0 = io_deq_ready | ~full;
  always @(posedge clock or posedge reset) begin
    if (reset)
      full <= 1'h0;
    else if (~(do_enq == (io_deq_ready & full)))
      full <= do_enq;
  end // always @(posedge, posedge)
  always @(posedge clock) begin
    if (do_enq)
      ram <=
        {io_enq_bits_addr_addr,
         io_enq_bits_addr_prot,
         io_enq_bits_addr_id,
         io_enq_bits_addr_len,
         io_enq_bits_addr_size,
         io_enq_bits_addr_burst,
         io_enq_bits_addr_lock,
         io_enq_bits_addr_cache,
         io_enq_bits_addr_qos,
         io_enq_bits_addr_region,
         io_enq_bits_write};
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
        ram = {_RANDOM[2'h0][31:1], _RANDOM[2'h1], _RANDOM[2'h2][4:0]};
      `endif // RANDOMIZE_REG_INIT
      if (reset)
        full = 1'h0;
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_enq_ready = io_enq_ready_0;
  assign io_deq_valid = full;
  assign io_deq_bits_addr_addr = ram[67:36];
  assign io_deq_bits_addr_id = ram[32:27];
  assign io_deq_bits_addr_len = ram[26:19];
  assign io_deq_bits_addr_size = ram[18:16];
  assign io_deq_bits_addr_burst = ram[15:14];
  assign io_deq_bits_write = ram[0];
endmodule
