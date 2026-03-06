module Bru_1(
  input         clock,
                reset,
                io_req_valid,
                io_req_bits_fwd,
  input  [3:0]  io_req_bits_op,
  input  [31:0] io_req_bits_pc,
                io_req_bits_target,
  input  [4:0]  io_req_bits_link,
  input         io_rs1_valid,
  input  [31:0] io_rs1_data,
  input         io_rs2_valid,
  input  [31:0] io_rs2_data,
  output        io_rd_valid,
  output [4:0]  io_rd_bits_addr,
  output [31:0] io_rd_bits_data,
  output        io_taken_valid,
  output [31:0] io_taken_value,
  input  [31:0] io_target_data
);

  reg         stateReg_valid;
  reg         stateReg_bits_fwd;
  reg  [3:0]  stateReg_bits_op;
  reg  [31:0] stateReg_bits_target;
  reg         stateReg_bits_linkValid;
  reg  [4:0]  stateReg_bits_linkAddr;
  reg  [31:0] stateReg_bits_linkData;
  wire        _ignore_T_2 = stateReg_bits_op == 4'h8;
  wire        _ignore_T_3 = stateReg_bits_op == 4'h9;
  wire        _ignore_T_4 = stateReg_bits_op == 4'hA;
  wire        _ignore_T_5 = stateReg_bits_op == 4'hB;
  wire        _ignore_T_6 = stateReg_bits_op == 4'hC;
  wire [31:0] nextState_linkData = io_req_bits_pc + 32'h4;
  wire        _nextState_target_T = io_req_bits_op == 4'h1;
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      stateReg_valid <= 1'h0;
      stateReg_bits_fwd <= 1'h0;
      stateReg_bits_op <= 4'h0;
      stateReg_bits_target <= 32'h0;
      stateReg_bits_linkValid <= 1'h0;
      stateReg_bits_linkAddr <= 5'h0;
      stateReg_bits_linkData <= 32'h0;
    end
    else begin
      stateReg_valid <= io_req_valid;
      if (io_req_valid) begin
        stateReg_bits_fwd <= io_req_valid & io_req_bits_fwd;
        stateReg_bits_op <= io_req_bits_op;
        stateReg_bits_target <=
          io_req_bits_fwd
            ? nextState_linkData
            : _nextState_target_T ? io_target_data & 32'hFFFFFFFE : io_req_bits_target;
        stateReg_bits_linkValid <=
          io_req_valid & (|io_req_bits_link)
          & (|{_nextState_target_T, io_req_bits_op == 4'h0});
        stateReg_bits_linkAddr <= io_req_bits_link;
        stateReg_bits_linkData <= nextState_linkData;
      end
    end
  end // always @(posedge, posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:3];
    initial begin
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [2:0] i = 3'h0; i < 3'h4; i += 3'h1) begin
          _RANDOM[i[1:0]] = `RANDOM;
        end
        stateReg_valid = _RANDOM[2'h0][0];
        stateReg_bits_fwd = _RANDOM[2'h0][1];
        stateReg_bits_op = _RANDOM[2'h0][5:2];
        stateReg_bits_target = {_RANDOM[2'h0][31:6], _RANDOM[2'h1][5:0]};
        stateReg_bits_linkValid = _RANDOM[2'h2][6];
        stateReg_bits_linkAddr = _RANDOM[2'h2][11:7];
        stateReg_bits_linkData = {_RANDOM[2'h2][31:12], _RANDOM[2'h3][11:0]};
      `endif // RANDOMIZE_REG_INIT
      if (reset) begin
        stateReg_valid = 1'h0;
        stateReg_bits_fwd = 1'h0;
        stateReg_bits_op = 4'h0;
        stateReg_bits_target = 32'h0;
        stateReg_bits_linkValid = 1'h0;
        stateReg_bits_linkAddr = 5'h0;
        stateReg_bits_linkData = 32'h0;
      end
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_rd_valid = stateReg_valid & stateReg_bits_linkValid;
  assign io_rd_bits_addr = stateReg_bits_linkAddr;
  assign io_rd_bits_data = stateReg_bits_linkData;
  assign io_taken_valid =
    stateReg_valid
    & (stateReg_bits_op == 4'hD
       | (stateReg_bits_op == 4'h7
            ? io_rs1_data >= io_rs2_data != stateReg_bits_fwd
            : stateReg_bits_op == 4'h6
                ? io_rs1_data < io_rs2_data != stateReg_bits_fwd
                : stateReg_bits_op == 4'h5
                    ? $signed(io_rs1_data) >= $signed(io_rs2_data) != stateReg_bits_fwd
                    : stateReg_bits_op == 4'h4
                        ? $signed(io_rs1_data) < $signed(io_rs2_data) != stateReg_bits_fwd
                        : stateReg_bits_op == 4'h3
                            ? io_rs1_data != io_rs2_data != stateReg_bits_fwd
                            : stateReg_bits_op == 4'h2
                                ? io_rs1_data == io_rs2_data != stateReg_bits_fwd
                                : (stateReg_bits_op == 4'h1 | ~(|stateReg_bits_op))
                                  & ~stateReg_bits_fwd));
  assign io_taken_value = stateReg_bits_target;
endmodule
