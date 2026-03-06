module Csr(
  input         clock,
                reset,
  input  [31:0] io_csr_in_value_12,
  output [31:0] io_csr_out_value_0,
                io_csr_out_value_1,
                io_csr_out_value_2,
                io_csr_out_value_3,
                io_csr_out_value_4,
                io_csr_out_value_5,
                io_csr_out_value_6,
                io_csr_out_value_7,
                io_csr_out_value_8,
  input         io_req_valid,
  input  [4:0]  io_req_bits_addr,
  input  [11:0] io_req_bits_index,
  input  [4:0]  io_req_bits_rs1,
  input  [1:0]  io_req_bits_op,
  input         io_rs1_valid,
  input  [31:0] io_rs1_data,
  output        io_rd_valid,
  output [4:0]  io_rd_bits_addr,
  output [31:0] io_rd_bits_data,
  input         io_bru_in_mode_valid,
  input  [1:0]  io_bru_in_mode_bits,
  input         io_bru_in_mcause_valid,
  input  [31:0] io_bru_in_mcause_bits,
  input         io_bru_in_mepc_valid,
  input  [31:0] io_bru_in_mepc_bits,
  input         io_bru_in_mtval_valid,
  input  [31:0] io_bru_in_mtval_bits,
  input         io_bru_in_halt,
                io_bru_in_fault,
                io_bru_in_wfi,
  output [1:0]  io_bru_out_mode,
  output [31:0] io_bru_out_mepc,
                io_bru_out_mtvec,
  input         io_float_in_fflags_valid,
  input  [4:0]  io_float_in_fflags_bits,
  output [2:0]  io_float_out_frm,
  input  [6:0]  io_rvv_vstart,
                io_rvv_vl,
  input  [31:0] io_rvv_vtype,
  input  [1:0]  io_rvv_vxrm,
  input         io_rvv_vxsat,
  output        io_rvv_vstart_write_valid,
  output [6:0]  io_rvv_vstart_write_bits,
  output        io_rvv_vxrm_write_valid,
  output [1:0]  io_rvv_vxrm_write_bits,
  output        io_rvv_vxsat_write_valid,
                io_rvv_vxsat_write_bits,
  output [2:0]  io_rvv_frm,
  input  [3:0]  io_counters_nRetired,
  output        io_halted,
                io_fault,
                io_wfi,
  input         io_irq
);

  reg              req_valid;
  reg  [4:0]       req_bits_addr;
  reg  [11:0]      req_bits_index;
  reg  [4:0]       req_bits_rs1;
  reg  [1:0]       req_bits_op;
  reg              halted;
  reg              fault;
  reg              wfi;
  reg  [1:0]       mode;
  reg  [31:0]      mpc;
  reg  [31:0]      msp;
  reg  [31:0]      mcause;
  reg  [31:0]      mtval;
  reg  [31:0]      mcontext0;
  reg  [31:0]      mcontext1;
  reg  [31:0]      mcontext2;
  reg  [31:0]      mcontext3;
  reg  [31:0]      mcontext4;
  reg  [31:0]      mcontext5;
  reg  [31:0]      mcontext6;
  reg  [31:0]      mcontext7;
  reg  [4:0]       fflags;
  reg  [2:0]       frm;
  reg              mie;
  reg  [31:0]      mtvec;
  reg  [31:0]      mscratch;
  reg  [31:0]      mepc;
  reg  [1:0]       mpp;
  reg  [63:0]      mcycle;
  reg  [63:0]      minstret;
  wire             fflagsEn = req_bits_index == 12'h1;
  wire             frmEn = req_bits_index == 12'h2;
  wire             fcsrEn = req_bits_index == 12'h3;
  wire             vstartEn = req_bits_index == 12'h8;
  wire             vxsatEn = req_bits_index == 12'h9;
  wire             vxrmEn = req_bits_index == 12'hA;
  wire             mstatusEn = req_bits_index == 12'h300;
  wire             misaEn = req_bits_index == 12'h301;
  wire             mieEn = req_bits_index == 12'h304;
  wire             mtvecEn = req_bits_index == 12'h305;
  wire             mscratchEn = req_bits_index == 12'h340;
  wire             mepcEn = req_bits_index == 12'h341;
  wire             mcauseEn = req_bits_index == 12'h342;
  wire             mtvalEn = req_bits_index == 12'h343;
  wire             mcontext0En = req_bits_index == 12'h7C0;
  wire             mcontext1En = req_bits_index == 12'h7C1;
  wire             mcontext2En = req_bits_index == 12'h7C2;
  wire             mcontext3En = req_bits_index == 12'h7C3;
  wire             mcontext4En = req_bits_index == 12'h7C4;
  wire             mcontext5En = req_bits_index == 12'h7C5;
  wire             mcontext6En = req_bits_index == 12'h7C6;
  wire             mcontext7En = req_bits_index == 12'h7C7;
  wire             mpcEn = req_bits_index == 12'h7E0;
  wire             mspEn = req_bits_index == 12'h7E1;
  wire             mcycleEn = req_bits_index == 12'hB00;
  wire             minstretEn = req_bits_index == 12'hB02;
  wire             mcyclehEn = req_bits_index == 12'hB80;
  wire             minstrethEn = req_bits_index == 12'hB82;
  wire             vlEn = req_bits_index == 12'hC20;
  wire             vtypeEn = req_bits_index == 12'hC21;
  wire             vlenbEn = req_bits_index == 12'hC22;
  wire             mvendoridEn = req_bits_index == 12'hF11;
  wire             kscm0En = req_bits_index == 12'hFC4;
  wire             kscm1En = req_bits_index == 12'hFC8;
  wire             kscm2En = req_bits_index == 12'hFCC;
  wire             kscm3En = req_bits_index == 12'hFD0;
  wire             kscm4En = req_bits_index == 12'hFD4;
  wire [31:0]      _rdata_T_174 =
    (fflagsEn ? {27'h0, fflags} : 32'h0) | (frmEn ? {29'h0, frm} : 32'h0)
    | (fcsrEn ? {24'h0, frm, fflags} : 32'h0)
    | (mstatusEn ? {19'h1, mpp, 11'h200} : 32'h0) | (misaEn ? 32'h40201120 : 32'h0)
    | (mieEn ? {31'h0, mie} : 32'h0) | (mtvecEn ? mtvec : 32'h0)
    | (mscratchEn ? mscratch : 32'h0) | (mepcEn ? mepc : 32'h0)
    | (mcauseEn ? mcause : 32'h0) | (mtvalEn ? mtval : 32'h0)
    | (mcontext0En ? mcontext0 : 32'h0) | (mcontext1En ? mcontext1 : 32'h0)
    | (mcontext2En ? mcontext2 : 32'h0) | (mcontext3En ? mcontext3 : 32'h0)
    | (mcontext4En ? mcontext4 : 32'h0) | (mcontext5En ? mcontext5 : 32'h0)
    | (mcontext6En ? mcontext6 : 32'h0) | (mcontext7En ? mcontext7 : 32'h0)
    | (mpcEn ? mpc : 32'h0) | (mspEn ? msp : 32'h0) | (mcycleEn ? mcycle[31:0] : 32'h0)
    | (mcyclehEn ? mcycle[63:32] : 32'h0) | (minstretEn ? minstret[31:0] : 32'h0)
    | (minstrethEn ? minstret[63:32] : 32'h0) | (mvendoridEn ? 32'h426 : 32'h0)
    | (kscm0En ? 32'hC677ABF9 : 32'h0) | (kscm1En ? 32'h485F73DF : 32'h0)
    | (kscm2En ? 32'h9A667D05 : 32'h0) | (kscm3En ? 32'h3579B71C : 32'h0)
    | (kscm4En ? 32'h3B3AFC6A : 32'h0);
  wire [31:0]      _rdata_T_177 =
    {_rdata_T_174[31:7],
     _rdata_T_174[6:0] | (vstartEn ? io_rvv_vstart : 7'h0) | (vlEn ? io_rvv_vl : 7'h0)}
    | (vtypeEn ? io_rvv_vtype : 32'h0);
  wire [1:0]       _GEN = _rdata_T_177[1:0] | (vxrmEn ? io_rvv_vxrm : 2'h0);
  wire [31:0]      rdata =
    {_rdata_T_177[31:2], _GEN[1], _GEN[0] | vxsatEn & io_rvv_vxsat}
    | {27'h0, vlenbEn, 4'h0};
  wire [3:0][31:0] _GEN_0 =
    {{32'h0}, {rdata & ~io_rs1_data}, {rdata | io_rs1_data}, {io_rs1_data}};
  wire [31:0]      wdata = _GEN_0[req_bits_op];
  wire             is_csr_write =
    req_valid & ~((|{req_bits_op == 2'h2, req_bits_op == 2'h1}) & req_bits_rs1 == 5'h0);
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      req_valid <= 1'h0;
      req_bits_addr <= 5'h0;
      req_bits_index <= 12'h0;
      req_bits_rs1 <= 5'h0;
      req_bits_op <= 2'h0;
      halted <= 1'h0;
      fault <= 1'h0;
      wfi <= 1'h0;
      mode <= 2'h0;
      mpc <= 32'h0;
      msp <= 32'h0;
      mcause <= 32'h0;
      mtval <= 32'h0;
      mcontext0 <= 32'h0;
      mcontext1 <= 32'h0;
      mcontext2 <= 32'h0;
      mcontext3 <= 32'h0;
      mcontext4 <= 32'h0;
      mcontext5 <= 32'h0;
      mcontext6 <= 32'h0;
      mcontext7 <= 32'h0;
      fflags <= 5'h0;
      frm <= 3'h0;
      mie <= 1'h0;
      mtvec <= 32'h0;
      mscratch <= 32'h0;
      mepc <= 32'h0;
      mpp <= 2'h0;
      mcycle <= 64'h0;
      minstret <= 64'h0;
    end
    else begin
      req_valid <= io_req_valid;
      if (io_req_valid) begin
        req_bits_addr <= io_req_bits_addr;
        req_bits_index <= io_req_bits_index;
        req_bits_rs1 <= io_req_bits_rs1;
        req_bits_op <= io_req_bits_op;
      end
      halted <= io_bru_in_halt | halted;
      fault <= io_bru_in_fault | fault;
      if (wfi)
        wfi <= ~io_irq;
      else
        wfi <= io_bru_in_wfi;
      if (io_bru_in_mode_valid)
        mode <= io_bru_in_mode_bits;
      if (req_valid & mpcEn)
        mpc <= wdata;
      if (req_valid & mspEn)
        msp <= wdata;
      if (io_bru_in_mcause_valid)
        mcause <= io_bru_in_mcause_bits;
      else if (req_valid & mcauseEn)
        mcause <= wdata;
      if (io_bru_in_mtval_valid)
        mtval <= io_bru_in_mtval_bits;
      else if (req_valid & mtvalEn)
        mtval <= wdata;
      if (req_valid & mcontext0En)
        mcontext0 <= wdata;
      if (req_valid & mcontext1En)
        mcontext1 <= wdata;
      if (req_valid & mcontext2En)
        mcontext2 <= wdata;
      if (req_valid & mcontext3En)
        mcontext3 <= wdata;
      if (req_valid & mcontext4En)
        mcontext4 <= wdata;
      if (req_valid & mcontext5En)
        mcontext5 <= wdata;
      if (req_valid & mcontext6En)
        mcontext6 <= wdata;
      if (req_valid & mcontext7En)
        mcontext7 <= wdata;
      if (io_float_in_fflags_valid)
        fflags <= io_float_in_fflags_bits | fflags;
      else if (req_valid) begin
        if (fcsrEn)
          fflags <= wdata[4:0];
        else if (fflagsEn)
          fflags <= wdata[4:0];
      end
      if (req_valid) begin
        if (fcsrEn)
          frm <= wdata[7:5];
        else if (frmEn)
          frm <= wdata[2:0];
      end
      if (req_valid & mieEn)
        mie <= wdata[0];
      if (req_valid & mtvecEn)
        mtvec <= wdata;
      if (req_valid & mscratchEn)
        mscratch <= wdata;
      if (io_bru_in_mepc_valid)
        mepc <= io_bru_in_mepc_bits;
      else if (req_valid & mepcEn)
        mepc <= wdata;
      if (req_valid & mstatusEn)
        mpp <= wdata[12:11];
      mcycle <=
        is_csr_write & (mcycleEn | mcyclehEn)
          ? {mcyclehEn ? wdata : mcycle[63:32], mcycleEn ? wdata : mcycle[31:0]}
          : mcycle + 64'h1;
      minstret <=
        is_csr_write & (minstretEn | minstrethEn)
          ? {minstrethEn ? wdata : minstret[63:32], minstretEn ? wdata : minstret[31:0]}
          : minstret + {60'h0, io_counters_nRetired};
    end
  end // always @(posedge, posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:21];
    initial begin
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [4:0] i = 5'h0; i < 5'h16; i += 5'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        req_valid = _RANDOM[5'h0][0];
        req_bits_addr = _RANDOM[5'h0][5:1];
        req_bits_index = _RANDOM[5'h0][17:6];
        req_bits_rs1 = _RANDOM[5'h0][22:18];
        req_bits_op = _RANDOM[5'h0][24:23];
        halted = _RANDOM[5'h0][25];
        fault = _RANDOM[5'h0][26];
        wfi = _RANDOM[5'h0][27];
        mode = _RANDOM[5'h0][29:28];
        mpc = {_RANDOM[5'h0][31:30], _RANDOM[5'h1][29:0]};
        msp = {_RANDOM[5'h1][31:30], _RANDOM[5'h2][29:0]};
        mcause = {_RANDOM[5'h2][31:30], _RANDOM[5'h3][29:0]};
        mtval = {_RANDOM[5'h3][31:30], _RANDOM[5'h4][29:0]};
        mcontext0 = {_RANDOM[5'h4][31:30], _RANDOM[5'h5][29:0]};
        mcontext1 = {_RANDOM[5'h5][31:30], _RANDOM[5'h6][29:0]};
        mcontext2 = {_RANDOM[5'h6][31:30], _RANDOM[5'h7][29:0]};
        mcontext3 = {_RANDOM[5'h7][31:30], _RANDOM[5'h8][29:0]};
        mcontext4 = {_RANDOM[5'h8][31:30], _RANDOM[5'h9][29:0]};
        mcontext5 = {_RANDOM[5'h9][31:30], _RANDOM[5'hA][29:0]};
        mcontext6 = {_RANDOM[5'hA][31:30], _RANDOM[5'hB][29:0]};
        mcontext7 = {_RANDOM[5'hB][31:30], _RANDOM[5'hC][29:0]};
        fflags = {_RANDOM[5'hC][31:30], _RANDOM[5'hD][2:0]};
        frm = _RANDOM[5'hD][5:3];
        mie = _RANDOM[5'hD][6];
        mtvec = {_RANDOM[5'hD][31:7], _RANDOM[5'hE][6:0]};
        mscratch = {_RANDOM[5'hE][31:7], _RANDOM[5'hF][6:0]};
        mepc = {_RANDOM[5'hF][31:7], _RANDOM[5'h10][6:0]};
        mpp = _RANDOM[5'h10][8:7];
        mcycle = {_RANDOM[5'h11][31:9], _RANDOM[5'h12], _RANDOM[5'h13][8:0]};
        minstret = {_RANDOM[5'h13][31:9], _RANDOM[5'h14], _RANDOM[5'h15][8:0]};
      `endif // RANDOMIZE_REG_INIT
      if (reset) begin
        req_valid = 1'h0;
        req_bits_addr = 5'h0;
        req_bits_index = 12'h0;
        req_bits_rs1 = 5'h0;
        req_bits_op = 2'h0;
        halted = 1'h0;
        fault = 1'h0;
        wfi = 1'h0;
        mode = 2'h0;
        mpc = 32'h0;
        msp = 32'h0;
        mcause = 32'h0;
        mtval = 32'h0;
        mcontext0 = 32'h0;
        mcontext1 = 32'h0;
        mcontext2 = 32'h0;
        mcontext3 = 32'h0;
        mcontext4 = 32'h0;
        mcontext5 = 32'h0;
        mcontext6 = 32'h0;
        mcontext7 = 32'h0;
        fflags = 5'h0;
        frm = 3'h0;
        mie = 1'h0;
        mtvec = 32'h0;
        mscratch = 32'h0;
        mepc = 32'h0;
        mpp = 2'h0;
        mcycle = 64'h0;
        minstret = 64'h0;
      end
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_csr_out_value_0 = io_csr_in_value_12;
  assign io_csr_out_value_1 = mepc;
  assign io_csr_out_value_2 = mtval;
  assign io_csr_out_value_3 = mcause;
  assign io_csr_out_value_4 = mcycle[31:0];
  assign io_csr_out_value_5 = mcycle[63:32];
  assign io_csr_out_value_6 = minstret[31:0];
  assign io_csr_out_value_7 = minstret[63:32];
  assign io_csr_out_value_8 = mcontext0;
  assign io_rd_valid = req_valid;
  assign io_rd_bits_addr = req_bits_addr;
  assign io_rd_bits_data = rdata;
  assign io_bru_out_mode = mode;
  assign io_bru_out_mepc = mepcEn & req_valid ? wdata : mepc;
  assign io_bru_out_mtvec = mtvecEn & req_valid ? wdata : mtvec;
  assign io_float_out_frm = frmEn & req_valid ? wdata[2:0] : frm;
  assign io_rvv_vstart_write_valid = req_valid & vstartEn;
  assign io_rvv_vstart_write_bits = wdata[6:0];
  assign io_rvv_vxrm_write_valid = req_valid & vxrmEn;
  assign io_rvv_vxrm_write_bits = wdata[1:0];
  assign io_rvv_vxsat_write_valid = req_valid & vxsatEn;
  assign io_rvv_vxsat_write_bits = wdata[0];
  assign io_rvv_frm = frm;
  assign io_halted = halted;
  assign io_fault = fault;
  assign io_wfi = wfi;
endmodule
