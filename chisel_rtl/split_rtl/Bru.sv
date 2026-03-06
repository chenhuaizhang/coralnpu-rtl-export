module Bru(
  input         clock,
                reset,
                io_req_valid,
                io_req_bits_fwd,
  input  [3:0]  io_req_bits_op,
  input  [31:0] io_req_bits_pc,
                io_req_bits_target,
  input  [4:0]  io_req_bits_link,
  output        io_csr_in_mode_valid,
  output [1:0]  io_csr_in_mode_bits,
  output        io_csr_in_mcause_valid,
  output [31:0] io_csr_in_mcause_bits,
  output        io_csr_in_mepc_valid,
  output [31:0] io_csr_in_mepc_bits,
  output        io_csr_in_mtval_valid,
  output [31:0] io_csr_in_mtval_bits,
  output        io_csr_in_halt,
                io_csr_in_fault,
                io_csr_in_wfi,
  input  [1:0]  io_csr_out_mode,
  input  [31:0] io_csr_out_mepc,
                io_csr_out_mtvec,
  input         io_rs1_valid,
  input  [31:0] io_rs1_data,
  input         io_rs2_valid,
  input  [31:0] io_rs2_data,
  output        io_rd_valid,
  output [4:0]  io_rd_bits_addr,
  output [31:0] io_rd_bits_data,
  output        io_taken_valid,
  output [31:0] io_taken_value,
  input  [31:0] io_target_data,
  output        io_interlock,
  input         io_fault_manager_valid,
  input  [31:0] io_fault_manager_bits_mepc,
                io_fault_manager_bits_mtval,
                io_fault_manager_bits_mcause
);

  wire        io_csr_in_fault_0;
  reg         stateReg_valid;
  reg         stateReg_bits_fwd;
  reg  [3:0]  stateReg_bits_op;
  reg  [31:0] stateReg_bits_target;
  reg         stateReg_bits_linkValid;
  reg  [4:0]  stateReg_bits_linkAddr;
  reg  [31:0] stateReg_bits_linkData;
  reg  [31:0] stateReg_bits_pcEx;
  wire        _io_csr_in_fault_T = io_csr_out_mode == 2'h0;
  wire        _io_csr_in_mcause_bits_T_4 = io_csr_out_mode == 2'h1;
  wire        _ignore_T_2 = stateReg_bits_op == 4'h8;
  wire        _ignore_T_3 = stateReg_bits_op == 4'h9;
  wire        _ignore_T_4 = stateReg_bits_op == 4'hA;
  wire        _ignore_T_5 = stateReg_bits_op == 4'hB;
  wire        _ignore_T_7 = stateReg_bits_op == 4'hD;
  wire        usageFault =
    stateReg_valid
    & (_io_csr_in_mcause_bits_T_4 ? (|{_ignore_T_5, _ignore_T_4}) : _ignore_T_2);
  assign io_csr_in_fault_0 = usageFault & _io_csr_in_fault_T;
  wire        _ignore_T_6 = stateReg_bits_op == 4'hC;
  wire [31:0] nextState_linkData = io_req_bits_pc + 32'h4;
  wire        _nextState_target_T = io_req_bits_op == 4'h1;
  wire [31:0] mtvec = {io_csr_out_mtvec[31:2], 2'h0};
  wire        _pipeline0Target_call_T = io_req_bits_op == 4'hB;
  wire        stateRegValid = io_req_valid | io_fault_manager_valid;
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      stateReg_valid <= 1'h0;
      stateReg_bits_fwd <= 1'h0;
      stateReg_bits_op <= 4'h0;
      stateReg_bits_target <= 32'h0;
      stateReg_bits_linkValid <= 1'h0;
      stateReg_bits_linkAddr <= 5'h0;
      stateReg_bits_linkData <= 32'h0;
      stateReg_bits_pcEx <= 32'h0;
    end
    else begin
      stateReg_valid <= stateRegValid;
      if (stateRegValid) begin
        stateReg_bits_fwd <= io_req_valid & io_req_bits_fwd;
        stateReg_bits_op <= io_fault_manager_valid ? 4'hD : io_req_bits_op;
        stateReg_bits_target <=
          io_fault_manager_valid
            ? mtvec
            : io_req_bits_fwd
                ? nextState_linkData
                : _nextState_target_T
                    ? io_target_data & 32'hFFFFFFFE
                    : io_req_bits_op == 4'h9
                        ? mtvec
                        : (|{_pipeline0Target_call_T & _io_csr_in_fault_T,
                             _pipeline0Target_call_T & _io_csr_in_mcause_bits_T_4,
                             io_req_bits_op == 4'hA,
                             io_req_bits_op == 4'h8})
                            ? io_csr_out_mepc
                            : io_req_bits_op == 4'hC
                                ? nextState_linkData
                                : io_req_bits_target;
        stateReg_bits_linkValid <=
          io_req_valid & (|io_req_bits_link)
          & (|{_nextState_target_T, io_req_bits_op == 4'h0});
        stateReg_bits_linkAddr <= io_req_bits_link;
        stateReg_bits_linkData <= nextState_linkData;
        stateReg_bits_pcEx <= io_req_bits_pc;
      end
    end
  end // always @(posedge, posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:4];
    initial begin
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [2:0] i = 3'h0; i < 3'h5; i += 3'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        stateReg_valid = _RANDOM[3'h0][0];
        stateReg_bits_fwd = _RANDOM[3'h0][1];
        stateReg_bits_op = _RANDOM[3'h0][5:2];
        stateReg_bits_target = {_RANDOM[3'h0][31:6], _RANDOM[3'h1][5:0]};
        stateReg_bits_linkValid = _RANDOM[3'h2][6];
        stateReg_bits_linkAddr = _RANDOM[3'h2][11:7];
        stateReg_bits_linkData = {_RANDOM[3'h2][31:12], _RANDOM[3'h3][11:0]};
        stateReg_bits_pcEx = {_RANDOM[3'h3][31:12], _RANDOM[3'h4][11:0]};
      `endif // RANDOMIZE_REG_INIT
      if (reset) begin
        stateReg_valid = 1'h0;
        stateReg_bits_fwd = 1'h0;
        stateReg_bits_op = 4'h0;
        stateReg_bits_target = 32'h0;
        stateReg_bits_linkValid = 1'h0;
        stateReg_bits_linkAddr = 5'h0;
        stateReg_bits_linkData = 32'h0;
        stateReg_bits_pcEx = 32'h0;
      end
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_csr_in_mode_valid =
    stateReg_valid
    & (_io_csr_in_mcause_bits_T_4
         ? (|{_ignore_T_7, _ignore_T_5, _ignore_T_4, _ignore_T_3, _ignore_T_2})
         : _ignore_T_5);
  assign io_csr_in_mode_bits = {1'h0, ~(_ignore_T_5 & _io_csr_in_fault_T)};
  assign io_csr_in_mcause_valid =
    stateReg_valid & (usageFault | _ignore_T_3 | _io_csr_in_mcause_bits_T_4 & _ignore_T_2)
    | io_fault_manager_valid;
  assign io_csr_in_mcause_bits =
    io_fault_manager_valid
      ? io_fault_manager_bits_mcause
      : {27'h0,
         _ignore_T_3 & _io_csr_in_fault_T
           ? 5'hB
           : _ignore_T_3 & _io_csr_in_mcause_bits_T_4
               ? 5'h8
               : _ignore_T_2 ? 5'h3 : usageFault ? 5'h19 : 5'h0};
  assign io_csr_in_mepc_valid = stateReg_valid & _ignore_T_3 | io_fault_manager_valid;
  assign io_csr_in_mepc_bits =
    io_fault_manager_valid ? io_fault_manager_bits_mepc : stateReg_bits_pcEx;
  assign io_csr_in_mtval_valid = usageFault | io_fault_manager_valid;
  assign io_csr_in_mtval_bits =
    io_fault_manager_valid ? io_fault_manager_bits_mtval : stateReg_bits_pcEx;
  assign io_csr_in_halt =
    stateReg_valid & _ignore_T_4 & _io_csr_in_fault_T | io_csr_in_fault_0;
  assign io_csr_in_fault = io_csr_in_fault_0;
  assign io_csr_in_wfi = stateReg_valid & _ignore_T_6;
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
                                : stateReg_bits_op == 4'h1 | ~(|stateReg_bits_op)
                                    ? ~stateReg_bits_fwd
                                    : stateReg_bits_op == 4'hC
                                      | (stateReg_bits_op == 4'hB
                                           ? _io_csr_in_fault_T
                                           : stateReg_bits_op == 4'hA
                                               ? _io_csr_in_mcause_bits_T_4
                                               : stateReg_bits_op == 4'h9
                                                 | stateReg_bits_op == 4'h8
                                                 & _io_csr_in_mcause_bits_T_4)));
  assign io_taken_value = stateReg_bits_target;
  assign io_interlock =
    stateReg_valid & (|{_ignore_T_7, _ignore_T_5, _ignore_T_4, _ignore_T_3, _ignore_T_2});
endmodule
