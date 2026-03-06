module CoralNPURRArbiter(
  input         clock,
                reset,
  output        io_in_0_ready,
  input         io_in_0_valid,
  input  [31:0] io_in_0_bits_addr,
  input  [2:0]  io_in_0_bits_prot,
  input  [5:0]  io_in_0_bits_id,
  input  [7:0]  io_in_0_bits_len,
  input  [2:0]  io_in_0_bits_size,
  input  [1:0]  io_in_0_bits_burst,
  input         io_in_0_bits_lock,
  input  [3:0]  io_in_0_bits_cache,
                io_in_0_bits_qos,
                io_in_0_bits_region,
  output        io_in_1_ready,
  input         io_in_1_valid,
  input  [31:0] io_in_1_bits_addr,
  input  [2:0]  io_in_1_bits_prot,
  input  [5:0]  io_in_1_bits_id,
  input  [7:0]  io_in_1_bits_len,
  input  [2:0]  io_in_1_bits_size,
  input  [1:0]  io_in_1_bits_burst,
  input         io_in_1_bits_lock,
  input  [3:0]  io_in_1_bits_cache,
                io_in_1_bits_qos,
                io_in_1_bits_region,
  input         io_out_ready,
  output        io_out_valid,
  output [31:0] io_out_bits_addr,
  output [2:0]  io_out_bits_prot,
  output [5:0]  io_out_bits_id,
  output [7:0]  io_out_bits_len,
  output [2:0]  io_out_bits_size,
  output [1:0]  io_out_bits_burst,
  output        io_out_bits_lock,
  output [3:0]  io_out_bits_cache,
                io_out_bits_qos,
                io_out_bits_region,
  output        io_chosen
);

  wire io_chosen_choice;
  wire io_out_valid_0 = io_chosen_choice ? io_in_1_valid : io_in_0_valid;
  reg  ctrl_validMask_grantMask_lastGrant;
  wire ctrl_validMask_1 = io_in_1_valid & ~ctrl_validMask_grantMask_lastGrant;
  assign io_chosen_choice = ctrl_validMask_1 | ~io_in_0_valid;
  always @(posedge clock or posedge reset) begin
    if (reset)
      ctrl_validMask_grantMask_lastGrant <= 1'h0;
    else if (io_out_ready & io_out_valid_0)
      ctrl_validMask_grantMask_lastGrant <= io_chosen_choice;
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
        ctrl_validMask_grantMask_lastGrant = _RANDOM[/*Zero width*/ 1'b0][0];
      `endif // RANDOMIZE_REG_INIT
      if (reset)
        ctrl_validMask_grantMask_lastGrant = 1'h0;
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_in_0_ready = ~ctrl_validMask_1 & io_out_ready;
  assign io_in_1_ready =
    (~ctrl_validMask_grantMask_lastGrant | ~(ctrl_validMask_1 | io_in_0_valid))
    & io_out_ready;
  assign io_out_valid = io_out_valid_0;
  assign io_out_bits_addr = io_chosen_choice ? io_in_1_bits_addr : io_in_0_bits_addr;
  assign io_out_bits_prot = io_chosen_choice ? io_in_1_bits_prot : io_in_0_bits_prot;
  assign io_out_bits_id = io_chosen_choice ? io_in_1_bits_id : io_in_0_bits_id;
  assign io_out_bits_len = io_chosen_choice ? io_in_1_bits_len : io_in_0_bits_len;
  assign io_out_bits_size = io_chosen_choice ? io_in_1_bits_size : io_in_0_bits_size;
  assign io_out_bits_burst = io_chosen_choice ? io_in_1_bits_burst : io_in_0_bits_burst;
  assign io_out_bits_lock = io_chosen_choice ? io_in_1_bits_lock : io_in_0_bits_lock;
  assign io_out_bits_cache = io_chosen_choice ? io_in_1_bits_cache : io_in_0_bits_cache;
  assign io_out_bits_qos = io_chosen_choice ? io_in_1_bits_qos : io_in_0_bits_qos;
  assign io_out_bits_region =
    io_chosen_choice ? io_in_1_bits_region : io_in_0_bits_region;
  assign io_chosen = io_chosen_choice;
endmodule
