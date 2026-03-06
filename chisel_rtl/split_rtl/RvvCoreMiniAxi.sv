module RvvCoreMiniAxi(
  input          io_aclk,
                 io_aresetn,
  output         io_axi_slave_write_addr_ready,
  input          io_axi_slave_write_addr_valid,
  input  [31:0]  io_axi_slave_write_addr_bits_addr,
  input  [2:0]   io_axi_slave_write_addr_bits_prot,
  input  [5:0]   io_axi_slave_write_addr_bits_id,
  input  [7:0]   io_axi_slave_write_addr_bits_len,
  input  [2:0]   io_axi_slave_write_addr_bits_size,
  input  [1:0]   io_axi_slave_write_addr_bits_burst,
  input          io_axi_slave_write_addr_bits_lock,
  input  [3:0]   io_axi_slave_write_addr_bits_cache,
                 io_axi_slave_write_addr_bits_qos,
                 io_axi_slave_write_addr_bits_region,
  output         io_axi_slave_write_data_ready,
  input          io_axi_slave_write_data_valid,
  input  [127:0] io_axi_slave_write_data_bits_data,
  input          io_axi_slave_write_data_bits_last,
  input  [15:0]  io_axi_slave_write_data_bits_strb,
  input          io_axi_slave_write_resp_ready,
  output         io_axi_slave_write_resp_valid,
  output [5:0]   io_axi_slave_write_resp_bits_id,
  output [1:0]   io_axi_slave_write_resp_bits_resp,
  output         io_axi_slave_read_addr_ready,
  input          io_axi_slave_read_addr_valid,
  input  [31:0]  io_axi_slave_read_addr_bits_addr,
  input  [2:0]   io_axi_slave_read_addr_bits_prot,
  input  [5:0]   io_axi_slave_read_addr_bits_id,
  input  [7:0]   io_axi_slave_read_addr_bits_len,
  input  [2:0]   io_axi_slave_read_addr_bits_size,
  input  [1:0]   io_axi_slave_read_addr_bits_burst,
  input          io_axi_slave_read_addr_bits_lock,
  input  [3:0]   io_axi_slave_read_addr_bits_cache,
                 io_axi_slave_read_addr_bits_qos,
                 io_axi_slave_read_addr_bits_region,
  input          io_axi_slave_read_data_ready,
  output         io_axi_slave_read_data_valid,
  output [127:0] io_axi_slave_read_data_bits_data,
  output [5:0]   io_axi_slave_read_data_bits_id,
  output [1:0]   io_axi_slave_read_data_bits_resp,
  output         io_axi_slave_read_data_bits_last,
  input          io_axi_master_write_addr_ready,
  output         io_axi_master_write_addr_valid,
  output [31:0]  io_axi_master_write_addr_bits_addr,
  output [2:0]   io_axi_master_write_addr_bits_prot,
  output [5:0]   io_axi_master_write_addr_bits_id,
  output [7:0]   io_axi_master_write_addr_bits_len,
  output [2:0]   io_axi_master_write_addr_bits_size,
  output [1:0]   io_axi_master_write_addr_bits_burst,
  output         io_axi_master_write_addr_bits_lock,
  output [3:0]   io_axi_master_write_addr_bits_cache,
                 io_axi_master_write_addr_bits_qos,
                 io_axi_master_write_addr_bits_region,
  input          io_axi_master_write_data_ready,
  output         io_axi_master_write_data_valid,
  output [127:0] io_axi_master_write_data_bits_data,
  output         io_axi_master_write_data_bits_last,
  output [15:0]  io_axi_master_write_data_bits_strb,
  output         io_axi_master_write_resp_ready,
  input          io_axi_master_write_resp_valid,
  input  [5:0]   io_axi_master_write_resp_bits_id,
  input  [1:0]   io_axi_master_write_resp_bits_resp,
  input          io_axi_master_read_addr_ready,
  output         io_axi_master_read_addr_valid,
  output [31:0]  io_axi_master_read_addr_bits_addr,
  output [2:0]   io_axi_master_read_addr_bits_prot,
  output [5:0]   io_axi_master_read_addr_bits_id,
  output [7:0]   io_axi_master_read_addr_bits_len,
  output [2:0]   io_axi_master_read_addr_bits_size,
  output [1:0]   io_axi_master_read_addr_bits_burst,
  output         io_axi_master_read_addr_bits_lock,
  output [3:0]   io_axi_master_read_addr_bits_cache,
                 io_axi_master_read_addr_bits_qos,
                 io_axi_master_read_addr_bits_region,
  output         io_axi_master_read_data_ready,
  input          io_axi_master_read_data_valid,
  input  [127:0] io_axi_master_read_data_bits_data,
  input  [5:0]   io_axi_master_read_data_bits_id,
  input  [1:0]   io_axi_master_read_data_bits_resp,
  input          io_axi_master_read_data_bits_last,
  output         io_halted,
                 io_fault,
                 io_wfi,
  input          io_irq,
  output [3:0]   io_debug_en,
  output [31:0]  io_debug_addr_0,
                 io_debug_addr_1,
                 io_debug_addr_2,
                 io_debug_addr_3,
                 io_debug_inst_0,
                 io_debug_inst_1,
                 io_debug_inst_2,
                 io_debug_inst_3,
                 io_debug_cycles,
  output         io_debug_dbus_valid,
  output [31:0]  io_debug_dbus_bits_addr,
  output [127:0] io_debug_dbus_bits_wdata,
  output         io_debug_dbus_bits_write,
                 io_debug_dispatch_0_instFire,
  output [31:0]  io_debug_dispatch_0_instAddr,
                 io_debug_dispatch_0_instInst,
  output         io_debug_dispatch_1_instFire,
  output [31:0]  io_debug_dispatch_1_instAddr,
                 io_debug_dispatch_1_instInst,
  output         io_debug_dispatch_2_instFire,
  output [31:0]  io_debug_dispatch_2_instAddr,
                 io_debug_dispatch_2_instInst,
  output         io_debug_dispatch_3_instFire,
  output [31:0]  io_debug_dispatch_3_instAddr,
                 io_debug_dispatch_3_instInst,
  output         io_debug_regfile_writeAddr_0_valid,
  output [4:0]   io_debug_regfile_writeAddr_0_bits,
  output         io_debug_regfile_writeAddr_1_valid,
  output [4:0]   io_debug_regfile_writeAddr_1_bits,
  output         io_debug_regfile_writeAddr_2_valid,
  output [4:0]   io_debug_regfile_writeAddr_2_bits,
  output         io_debug_regfile_writeAddr_3_valid,
  output [4:0]   io_debug_regfile_writeAddr_3_bits,
  output         io_debug_regfile_writeData_0_valid,
  output [4:0]   io_debug_regfile_writeData_0_bits_addr,
  output [31:0]  io_debug_regfile_writeData_0_bits_data,
  output         io_debug_regfile_writeData_1_valid,
  output [4:0]   io_debug_regfile_writeData_1_bits_addr,
  output [31:0]  io_debug_regfile_writeData_1_bits_data,
  output         io_debug_regfile_writeData_2_valid,
  output [4:0]   io_debug_regfile_writeData_2_bits_addr,
  output [31:0]  io_debug_regfile_writeData_2_bits_data,
  output         io_debug_regfile_writeData_3_valid,
  output [4:0]   io_debug_regfile_writeData_3_bits_addr,
  output [31:0]  io_debug_regfile_writeData_3_bits_data,
  output         io_debug_regfile_writeData_4_valid,
  output [4:0]   io_debug_regfile_writeData_4_bits_addr,
  output [31:0]  io_debug_regfile_writeData_4_bits_data,
  output         io_debug_regfile_writeData_5_valid,
  output [4:0]   io_debug_regfile_writeData_5_bits_addr,
  output [31:0]  io_debug_regfile_writeData_5_bits_data,
  output         io_debug_float_writeAddr_valid,
  output [4:0]   io_debug_float_writeAddr_bits,
  output         io_debug_float_writeData_0_valid,
  output [31:0]  io_debug_float_writeData_0_bits_addr,
                 io_debug_float_writeData_0_bits_data,
  output         io_debug_float_writeData_1_valid,
  output [31:0]  io_debug_float_writeData_1_bits_addr,
                 io_debug_float_writeData_1_bits_data,
  output         io_debug_rb_inst_0_valid,
  output [31:0]  io_debug_rb_inst_0_bits_pc,
                 io_debug_rb_inst_0_bits_inst,
  output [6:0]   io_debug_rb_inst_0_bits_idx,
  output [127:0] io_debug_rb_inst_0_bits_data,
  output         io_debug_rb_inst_0_bits_vecWrites_0_valid,
  output [127:0] io_debug_rb_inst_0_bits_vecWrites_0_bits_data,
  output [4:0]   io_debug_rb_inst_0_bits_vecWrites_0_bits_idx,
  output         io_debug_rb_inst_0_bits_vecWrites_1_valid,
  output [127:0] io_debug_rb_inst_0_bits_vecWrites_1_bits_data,
  output [4:0]   io_debug_rb_inst_0_bits_vecWrites_1_bits_idx,
  output         io_debug_rb_inst_0_bits_vecWrites_2_valid,
  output [127:0] io_debug_rb_inst_0_bits_vecWrites_2_bits_data,
  output [4:0]   io_debug_rb_inst_0_bits_vecWrites_2_bits_idx,
  output         io_debug_rb_inst_0_bits_vecWrites_3_valid,
  output [127:0] io_debug_rb_inst_0_bits_vecWrites_3_bits_data,
  output [4:0]   io_debug_rb_inst_0_bits_vecWrites_3_bits_idx,
  output         io_debug_rb_inst_0_bits_vecWrites_4_valid,
  output [127:0] io_debug_rb_inst_0_bits_vecWrites_4_bits_data,
  output [4:0]   io_debug_rb_inst_0_bits_vecWrites_4_bits_idx,
  output         io_debug_rb_inst_0_bits_vecWrites_5_valid,
  output [127:0] io_debug_rb_inst_0_bits_vecWrites_5_bits_data,
  output [4:0]   io_debug_rb_inst_0_bits_vecWrites_5_bits_idx,
  output         io_debug_rb_inst_0_bits_vecWrites_6_valid,
  output [127:0] io_debug_rb_inst_0_bits_vecWrites_6_bits_data,
  output [4:0]   io_debug_rb_inst_0_bits_vecWrites_6_bits_idx,
  output         io_debug_rb_inst_0_bits_vecWrites_7_valid,
  output [127:0] io_debug_rb_inst_0_bits_vecWrites_7_bits_data,
  output [4:0]   io_debug_rb_inst_0_bits_vecWrites_7_bits_idx,
  output         io_debug_rb_inst_0_bits_trap,
                 io_debug_rb_inst_1_valid,
  output [31:0]  io_debug_rb_inst_1_bits_pc,
                 io_debug_rb_inst_1_bits_inst,
  output [6:0]   io_debug_rb_inst_1_bits_idx,
  output [127:0] io_debug_rb_inst_1_bits_data,
  output         io_debug_rb_inst_1_bits_vecWrites_0_valid,
  output [127:0] io_debug_rb_inst_1_bits_vecWrites_0_bits_data,
  output [4:0]   io_debug_rb_inst_1_bits_vecWrites_0_bits_idx,
  output         io_debug_rb_inst_1_bits_vecWrites_1_valid,
  output [127:0] io_debug_rb_inst_1_bits_vecWrites_1_bits_data,
  output [4:0]   io_debug_rb_inst_1_bits_vecWrites_1_bits_idx,
  output         io_debug_rb_inst_1_bits_vecWrites_2_valid,
  output [127:0] io_debug_rb_inst_1_bits_vecWrites_2_bits_data,
  output [4:0]   io_debug_rb_inst_1_bits_vecWrites_2_bits_idx,
  output         io_debug_rb_inst_1_bits_vecWrites_3_valid,
  output [127:0] io_debug_rb_inst_1_bits_vecWrites_3_bits_data,
  output [4:0]   io_debug_rb_inst_1_bits_vecWrites_3_bits_idx,
  output         io_debug_rb_inst_1_bits_vecWrites_4_valid,
  output [127:0] io_debug_rb_inst_1_bits_vecWrites_4_bits_data,
  output [4:0]   io_debug_rb_inst_1_bits_vecWrites_4_bits_idx,
  output         io_debug_rb_inst_1_bits_vecWrites_5_valid,
  output [127:0] io_debug_rb_inst_1_bits_vecWrites_5_bits_data,
  output [4:0]   io_debug_rb_inst_1_bits_vecWrites_5_bits_idx,
  output         io_debug_rb_inst_1_bits_vecWrites_6_valid,
  output [127:0] io_debug_rb_inst_1_bits_vecWrites_6_bits_data,
  output [4:0]   io_debug_rb_inst_1_bits_vecWrites_6_bits_idx,
  output         io_debug_rb_inst_1_bits_vecWrites_7_valid,
  output [127:0] io_debug_rb_inst_1_bits_vecWrites_7_bits_data,
  output [4:0]   io_debug_rb_inst_1_bits_vecWrites_7_bits_idx,
  output         io_debug_rb_inst_1_bits_trap,
                 io_debug_rb_inst_2_valid,
  output [31:0]  io_debug_rb_inst_2_bits_pc,
                 io_debug_rb_inst_2_bits_inst,
  output [6:0]   io_debug_rb_inst_2_bits_idx,
  output [127:0] io_debug_rb_inst_2_bits_data,
  output         io_debug_rb_inst_2_bits_vecWrites_0_valid,
  output [127:0] io_debug_rb_inst_2_bits_vecWrites_0_bits_data,
  output [4:0]   io_debug_rb_inst_2_bits_vecWrites_0_bits_idx,
  output         io_debug_rb_inst_2_bits_vecWrites_1_valid,
  output [127:0] io_debug_rb_inst_2_bits_vecWrites_1_bits_data,
  output [4:0]   io_debug_rb_inst_2_bits_vecWrites_1_bits_idx,
  output         io_debug_rb_inst_2_bits_vecWrites_2_valid,
  output [127:0] io_debug_rb_inst_2_bits_vecWrites_2_bits_data,
  output [4:0]   io_debug_rb_inst_2_bits_vecWrites_2_bits_idx,
  output         io_debug_rb_inst_2_bits_vecWrites_3_valid,
  output [127:0] io_debug_rb_inst_2_bits_vecWrites_3_bits_data,
  output [4:0]   io_debug_rb_inst_2_bits_vecWrites_3_bits_idx,
  output         io_debug_rb_inst_2_bits_vecWrites_4_valid,
  output [127:0] io_debug_rb_inst_2_bits_vecWrites_4_bits_data,
  output [4:0]   io_debug_rb_inst_2_bits_vecWrites_4_bits_idx,
  output         io_debug_rb_inst_2_bits_vecWrites_5_valid,
  output [127:0] io_debug_rb_inst_2_bits_vecWrites_5_bits_data,
  output [4:0]   io_debug_rb_inst_2_bits_vecWrites_5_bits_idx,
  output         io_debug_rb_inst_2_bits_vecWrites_6_valid,
  output [127:0] io_debug_rb_inst_2_bits_vecWrites_6_bits_data,
  output [4:0]   io_debug_rb_inst_2_bits_vecWrites_6_bits_idx,
  output         io_debug_rb_inst_2_bits_vecWrites_7_valid,
  output [127:0] io_debug_rb_inst_2_bits_vecWrites_7_bits_data,
  output [4:0]   io_debug_rb_inst_2_bits_vecWrites_7_bits_idx,
  output         io_debug_rb_inst_2_bits_trap,
                 io_debug_rb_inst_3_valid,
  output [31:0]  io_debug_rb_inst_3_bits_pc,
                 io_debug_rb_inst_3_bits_inst,
  output [6:0]   io_debug_rb_inst_3_bits_idx,
  output [127:0] io_debug_rb_inst_3_bits_data,
  output         io_debug_rb_inst_3_bits_vecWrites_0_valid,
  output [127:0] io_debug_rb_inst_3_bits_vecWrites_0_bits_data,
  output [4:0]   io_debug_rb_inst_3_bits_vecWrites_0_bits_idx,
  output         io_debug_rb_inst_3_bits_vecWrites_1_valid,
  output [127:0] io_debug_rb_inst_3_bits_vecWrites_1_bits_data,
  output [4:0]   io_debug_rb_inst_3_bits_vecWrites_1_bits_idx,
  output         io_debug_rb_inst_3_bits_vecWrites_2_valid,
  output [127:0] io_debug_rb_inst_3_bits_vecWrites_2_bits_data,
  output [4:0]   io_debug_rb_inst_3_bits_vecWrites_2_bits_idx,
  output         io_debug_rb_inst_3_bits_vecWrites_3_valid,
  output [127:0] io_debug_rb_inst_3_bits_vecWrites_3_bits_data,
  output [4:0]   io_debug_rb_inst_3_bits_vecWrites_3_bits_idx,
  output         io_debug_rb_inst_3_bits_vecWrites_4_valid,
  output [127:0] io_debug_rb_inst_3_bits_vecWrites_4_bits_data,
  output [4:0]   io_debug_rb_inst_3_bits_vecWrites_4_bits_idx,
  output         io_debug_rb_inst_3_bits_vecWrites_5_valid,
  output [127:0] io_debug_rb_inst_3_bits_vecWrites_5_bits_data,
  output [4:0]   io_debug_rb_inst_3_bits_vecWrites_5_bits_idx,
  output         io_debug_rb_inst_3_bits_vecWrites_6_valid,
  output [127:0] io_debug_rb_inst_3_bits_vecWrites_6_bits_data,
  output [4:0]   io_debug_rb_inst_3_bits_vecWrites_6_bits_idx,
  output         io_debug_rb_inst_3_bits_vecWrites_7_valid,
  output [127:0] io_debug_rb_inst_3_bits_vecWrites_7_bits_data,
  output [4:0]   io_debug_rb_inst_3_bits_vecWrites_7_bits_idx,
  output         io_debug_rb_inst_3_bits_trap,
                 io_debug_rb_inst_4_valid,
  output [31:0]  io_debug_rb_inst_4_bits_pc,
                 io_debug_rb_inst_4_bits_inst,
  output [6:0]   io_debug_rb_inst_4_bits_idx,
  output [127:0] io_debug_rb_inst_4_bits_data,
  output         io_debug_rb_inst_4_bits_vecWrites_0_valid,
  output [127:0] io_debug_rb_inst_4_bits_vecWrites_0_bits_data,
  output [4:0]   io_debug_rb_inst_4_bits_vecWrites_0_bits_idx,
  output         io_debug_rb_inst_4_bits_vecWrites_1_valid,
  output [127:0] io_debug_rb_inst_4_bits_vecWrites_1_bits_data,
  output [4:0]   io_debug_rb_inst_4_bits_vecWrites_1_bits_idx,
  output         io_debug_rb_inst_4_bits_vecWrites_2_valid,
  output [127:0] io_debug_rb_inst_4_bits_vecWrites_2_bits_data,
  output [4:0]   io_debug_rb_inst_4_bits_vecWrites_2_bits_idx,
  output         io_debug_rb_inst_4_bits_vecWrites_3_valid,
  output [127:0] io_debug_rb_inst_4_bits_vecWrites_3_bits_data,
  output [4:0]   io_debug_rb_inst_4_bits_vecWrites_3_bits_idx,
  output         io_debug_rb_inst_4_bits_vecWrites_4_valid,
  output [127:0] io_debug_rb_inst_4_bits_vecWrites_4_bits_data,
  output [4:0]   io_debug_rb_inst_4_bits_vecWrites_4_bits_idx,
  output         io_debug_rb_inst_4_bits_vecWrites_5_valid,
  output [127:0] io_debug_rb_inst_4_bits_vecWrites_5_bits_data,
  output [4:0]   io_debug_rb_inst_4_bits_vecWrites_5_bits_idx,
  output         io_debug_rb_inst_4_bits_vecWrites_6_valid,
  output [127:0] io_debug_rb_inst_4_bits_vecWrites_6_bits_data,
  output [4:0]   io_debug_rb_inst_4_bits_vecWrites_6_bits_idx,
  output         io_debug_rb_inst_4_bits_vecWrites_7_valid,
  output [127:0] io_debug_rb_inst_4_bits_vecWrites_7_bits_data,
  output [4:0]   io_debug_rb_inst_4_bits_vecWrites_7_bits_idx,
  output         io_debug_rb_inst_4_bits_trap,
                 io_debug_rb_inst_5_valid,
  output [31:0]  io_debug_rb_inst_5_bits_pc,
                 io_debug_rb_inst_5_bits_inst,
  output [6:0]   io_debug_rb_inst_5_bits_idx,
  output [127:0] io_debug_rb_inst_5_bits_data,
  output         io_debug_rb_inst_5_bits_vecWrites_0_valid,
  output [127:0] io_debug_rb_inst_5_bits_vecWrites_0_bits_data,
  output [4:0]   io_debug_rb_inst_5_bits_vecWrites_0_bits_idx,
  output         io_debug_rb_inst_5_bits_vecWrites_1_valid,
  output [127:0] io_debug_rb_inst_5_bits_vecWrites_1_bits_data,
  output [4:0]   io_debug_rb_inst_5_bits_vecWrites_1_bits_idx,
  output         io_debug_rb_inst_5_bits_vecWrites_2_valid,
  output [127:0] io_debug_rb_inst_5_bits_vecWrites_2_bits_data,
  output [4:0]   io_debug_rb_inst_5_bits_vecWrites_2_bits_idx,
  output         io_debug_rb_inst_5_bits_vecWrites_3_valid,
  output [127:0] io_debug_rb_inst_5_bits_vecWrites_3_bits_data,
  output [4:0]   io_debug_rb_inst_5_bits_vecWrites_3_bits_idx,
  output         io_debug_rb_inst_5_bits_vecWrites_4_valid,
  output [127:0] io_debug_rb_inst_5_bits_vecWrites_4_bits_data,
  output [4:0]   io_debug_rb_inst_5_bits_vecWrites_4_bits_idx,
  output         io_debug_rb_inst_5_bits_vecWrites_5_valid,
  output [127:0] io_debug_rb_inst_5_bits_vecWrites_5_bits_data,
  output [4:0]   io_debug_rb_inst_5_bits_vecWrites_5_bits_idx,
  output         io_debug_rb_inst_5_bits_vecWrites_6_valid,
  output [127:0] io_debug_rb_inst_5_bits_vecWrites_6_bits_data,
  output [4:0]   io_debug_rb_inst_5_bits_vecWrites_6_bits_idx,
  output         io_debug_rb_inst_5_bits_vecWrites_7_valid,
  output [127:0] io_debug_rb_inst_5_bits_vecWrites_7_bits_data,
  output [4:0]   io_debug_rb_inst_5_bits_vecWrites_7_bits_idx,
  output         io_debug_rb_inst_5_bits_trap,
                 io_debug_rb_inst_6_valid,
  output [31:0]  io_debug_rb_inst_6_bits_pc,
                 io_debug_rb_inst_6_bits_inst,
  output [6:0]   io_debug_rb_inst_6_bits_idx,
  output [127:0] io_debug_rb_inst_6_bits_data,
  output         io_debug_rb_inst_6_bits_vecWrites_0_valid,
  output [127:0] io_debug_rb_inst_6_bits_vecWrites_0_bits_data,
  output [4:0]   io_debug_rb_inst_6_bits_vecWrites_0_bits_idx,
  output         io_debug_rb_inst_6_bits_vecWrites_1_valid,
  output [127:0] io_debug_rb_inst_6_bits_vecWrites_1_bits_data,
  output [4:0]   io_debug_rb_inst_6_bits_vecWrites_1_bits_idx,
  output         io_debug_rb_inst_6_bits_vecWrites_2_valid,
  output [127:0] io_debug_rb_inst_6_bits_vecWrites_2_bits_data,
  output [4:0]   io_debug_rb_inst_6_bits_vecWrites_2_bits_idx,
  output         io_debug_rb_inst_6_bits_vecWrites_3_valid,
  output [127:0] io_debug_rb_inst_6_bits_vecWrites_3_bits_data,
  output [4:0]   io_debug_rb_inst_6_bits_vecWrites_3_bits_idx,
  output         io_debug_rb_inst_6_bits_vecWrites_4_valid,
  output [127:0] io_debug_rb_inst_6_bits_vecWrites_4_bits_data,
  output [4:0]   io_debug_rb_inst_6_bits_vecWrites_4_bits_idx,
  output         io_debug_rb_inst_6_bits_vecWrites_5_valid,
  output [127:0] io_debug_rb_inst_6_bits_vecWrites_5_bits_data,
  output [4:0]   io_debug_rb_inst_6_bits_vecWrites_5_bits_idx,
  output         io_debug_rb_inst_6_bits_vecWrites_6_valid,
  output [127:0] io_debug_rb_inst_6_bits_vecWrites_6_bits_data,
  output [4:0]   io_debug_rb_inst_6_bits_vecWrites_6_bits_idx,
  output         io_debug_rb_inst_6_bits_vecWrites_7_valid,
  output [127:0] io_debug_rb_inst_6_bits_vecWrites_7_bits_data,
  output [4:0]   io_debug_rb_inst_6_bits_vecWrites_7_bits_idx,
  output         io_debug_rb_inst_6_bits_trap,
                 io_debug_rb_inst_7_valid,
  output [31:0]  io_debug_rb_inst_7_bits_pc,
                 io_debug_rb_inst_7_bits_inst,
  output [6:0]   io_debug_rb_inst_7_bits_idx,
  output [127:0] io_debug_rb_inst_7_bits_data,
  output         io_debug_rb_inst_7_bits_vecWrites_0_valid,
  output [127:0] io_debug_rb_inst_7_bits_vecWrites_0_bits_data,
  output [4:0]   io_debug_rb_inst_7_bits_vecWrites_0_bits_idx,
  output         io_debug_rb_inst_7_bits_vecWrites_1_valid,
  output [127:0] io_debug_rb_inst_7_bits_vecWrites_1_bits_data,
  output [4:0]   io_debug_rb_inst_7_bits_vecWrites_1_bits_idx,
  output         io_debug_rb_inst_7_bits_vecWrites_2_valid,
  output [127:0] io_debug_rb_inst_7_bits_vecWrites_2_bits_data,
  output [4:0]   io_debug_rb_inst_7_bits_vecWrites_2_bits_idx,
  output         io_debug_rb_inst_7_bits_vecWrites_3_valid,
  output [127:0] io_debug_rb_inst_7_bits_vecWrites_3_bits_data,
  output [4:0]   io_debug_rb_inst_7_bits_vecWrites_3_bits_idx,
  output         io_debug_rb_inst_7_bits_vecWrites_4_valid,
  output [127:0] io_debug_rb_inst_7_bits_vecWrites_4_bits_data,
  output [4:0]   io_debug_rb_inst_7_bits_vecWrites_4_bits_idx,
  output         io_debug_rb_inst_7_bits_vecWrites_5_valid,
  output [127:0] io_debug_rb_inst_7_bits_vecWrites_5_bits_data,
  output [4:0]   io_debug_rb_inst_7_bits_vecWrites_5_bits_idx,
  output         io_debug_rb_inst_7_bits_vecWrites_6_valid,
  output [127:0] io_debug_rb_inst_7_bits_vecWrites_6_bits_data,
  output [4:0]   io_debug_rb_inst_7_bits_vecWrites_6_bits_idx,
  output         io_debug_rb_inst_7_bits_vecWrites_7_valid,
  output [127:0] io_debug_rb_inst_7_bits_vecWrites_7_bits_data,
  output [4:0]   io_debug_rb_inst_7_bits_vecWrites_7_bits_idx,
  output         io_debug_rb_inst_7_bits_trap,
                 io_slog_valid,
  output [4:0]   io_slog_addr,
  output [31:0]  io_slog_data,
  input          io_te
);

  wire         _ebus2axi_io_dbus_ready;
  wire [127:0] _ebus2axi_io_dbus_rdata;
  wire         _ebus2axi_io_fault_valid;
  wire         _ebus2axi_io_fault_bits_write;
  wire [31:0]  _ebus2axi_io_fault_bits_addr;
  wire [31:0]  _ebus2axi_io_fault_bits_epc;
  wire         _axiSlave_io_axi_write_addr_ready;
  wire         _axiSlave_io_axi_write_data_ready;
  wire         _axiSlave_io_axi_write_resp_valid;
  wire         _axiSlave_io_axi_read_addr_ready;
  wire         _axiSlave_io_axi_read_data_valid;
  wire         _axiSlave_io_fabric_readDataAddr_valid;
  wire [31:0]  _axiSlave_io_fabric_readDataAddr_bits;
  wire         _axiSlave_io_fabric_writeDataAddr_valid;
  wire [31:0]  _axiSlave_io_fabric_writeDataAddr_bits;
  wire [127:0] _axiSlave_io_fabric_writeDataBits;
  wire [15:0]  _axiSlave_io_fabric_writeDataStrb;
  wire         _fabricMux_io_source_readData_valid;
  wire [127:0] _fabricMux_io_source_readData_bits;
  wire         _fabricMux_io_source_writeResp;
  wire         _fabricMux_io_fabricBusy;
  wire         _fabricMux_io_ports_0_readDataAddr_valid;
  wire [31:0]  _fabricMux_io_ports_0_readDataAddr_bits;
  wire         _fabricMux_io_ports_0_writeDataAddr_valid;
  wire [31:0]  _fabricMux_io_ports_0_writeDataAddr_bits;
  wire [127:0] _fabricMux_io_ports_0_writeDataBits;
  wire [15:0]  _fabricMux_io_ports_0_writeDataStrb;
  wire         _fabricMux_io_ports_1_readDataAddr_valid;
  wire [31:0]  _fabricMux_io_ports_1_readDataAddr_bits;
  wire         _fabricMux_io_ports_1_writeDataAddr_valid;
  wire [31:0]  _fabricMux_io_ports_1_writeDataAddr_bits;
  wire [127:0] _fabricMux_io_ports_1_writeDataBits;
  wire [15:0]  _fabricMux_io_ports_1_writeDataStrb;
  wire [31:0]  _fabricMux_io_ports_2_readDataAddr_bits;
  wire         _fabricMux_io_ports_2_writeDataAddr_valid;
  wire [31:0]  _fabricMux_io_ports_2_writeDataAddr_bits;
  wire [127:0] _fabricMux_io_ports_2_writeDataBits;
  wire [127:0] _dtcmArbiter_io_source_0_readData_bits;
  wire         _dtcmArbiter_io_source_1_readData_valid;
  wire [127:0] _dtcmArbiter_io_source_1_readData_bits;
  wire         _dtcmArbiter_io_fabricBusy_1;
  wire         _dtcmArbiter_io_port_readDataAddr_valid;
  wire [31:0]  _dtcmArbiter_io_port_readDataAddr_bits;
  wire         _dtcmArbiter_io_port_writeDataAddr_valid;
  wire [31:0]  _dtcmArbiter_io_port_writeDataAddr_bits;
  wire [127:0] _dtcmArbiter_io_port_writeDataBits;
  wire [15:0]  _dtcmArbiter_io_port_writeDataStrb;
  wire         _dtcmWrapper_io_fabric_readData_valid;
  wire [127:0] _dtcmWrapper_io_fabric_readData_bits;
  wire [10:0]  _dtcmWrapper_io_sram_address;
  wire         _dtcmWrapper_io_sram_enable;
  wire         _dtcmWrapper_io_sram_isWrite;
  wire [7:0]   _dtcmWrapper_io_sram_writeData_0;
  wire [7:0]   _dtcmWrapper_io_sram_writeData_1;
  wire [7:0]   _dtcmWrapper_io_sram_writeData_2;
  wire [7:0]   _dtcmWrapper_io_sram_writeData_3;
  wire [7:0]   _dtcmWrapper_io_sram_writeData_4;
  wire [7:0]   _dtcmWrapper_io_sram_writeData_5;
  wire [7:0]   _dtcmWrapper_io_sram_writeData_6;
  wire [7:0]   _dtcmWrapper_io_sram_writeData_7;
  wire [7:0]   _dtcmWrapper_io_sram_writeData_8;
  wire [7:0]   _dtcmWrapper_io_sram_writeData_9;
  wire [7:0]   _dtcmWrapper_io_sram_writeData_10;
  wire [7:0]   _dtcmWrapper_io_sram_writeData_11;
  wire [7:0]   _dtcmWrapper_io_sram_writeData_12;
  wire [7:0]   _dtcmWrapper_io_sram_writeData_13;
  wire [7:0]   _dtcmWrapper_io_sram_writeData_14;
  wire [7:0]   _dtcmWrapper_io_sram_writeData_15;
  wire         _dtcmWrapper_io_sram_mask_0;
  wire         _dtcmWrapper_io_sram_mask_1;
  wire         _dtcmWrapper_io_sram_mask_2;
  wire         _dtcmWrapper_io_sram_mask_3;
  wire         _dtcmWrapper_io_sram_mask_4;
  wire         _dtcmWrapper_io_sram_mask_5;
  wire         _dtcmWrapper_io_sram_mask_6;
  wire         _dtcmWrapper_io_sram_mask_7;
  wire         _dtcmWrapper_io_sram_mask_8;
  wire         _dtcmWrapper_io_sram_mask_9;
  wire         _dtcmWrapper_io_sram_mask_10;
  wire         _dtcmWrapper_io_sram_mask_11;
  wire         _dtcmWrapper_io_sram_mask_12;
  wire         _dtcmWrapper_io_sram_mask_13;
  wire         _dtcmWrapper_io_sram_mask_14;
  wire         _dtcmWrapper_io_sram_mask_15;
  wire [7:0]   _dtcm_io_rdata_0;
  wire [7:0]   _dtcm_io_rdata_1;
  wire [7:0]   _dtcm_io_rdata_2;
  wire [7:0]   _dtcm_io_rdata_3;
  wire [7:0]   _dtcm_io_rdata_4;
  wire [7:0]   _dtcm_io_rdata_5;
  wire [7:0]   _dtcm_io_rdata_6;
  wire [7:0]   _dtcm_io_rdata_7;
  wire [7:0]   _dtcm_io_rdata_8;
  wire [7:0]   _dtcm_io_rdata_9;
  wire [7:0]   _dtcm_io_rdata_10;
  wire [7:0]   _dtcm_io_rdata_11;
  wire [7:0]   _dtcm_io_rdata_12;
  wire [7:0]   _dtcm_io_rdata_13;
  wire [7:0]   _dtcm_io_rdata_14;
  wire [7:0]   _dtcm_io_rdata_15;
  wire [127:0] _itcmArbiter_io_source_0_readData_bits;
  wire         _itcmArbiter_io_source_1_readData_valid;
  wire [127:0] _itcmArbiter_io_source_1_readData_bits;
  wire         _itcmArbiter_io_fabricBusy_1;
  wire         _itcmArbiter_io_port_readDataAddr_valid;
  wire [31:0]  _itcmArbiter_io_port_readDataAddr_bits;
  wire         _itcmArbiter_io_port_writeDataAddr_valid;
  wire [31:0]  _itcmArbiter_io_port_writeDataAddr_bits;
  wire [127:0] _itcmArbiter_io_port_writeDataBits;
  wire [15:0]  _itcmArbiter_io_port_writeDataStrb;
  wire         _itcmWrapper_io_fabric_readData_valid;
  wire [127:0] _itcmWrapper_io_fabric_readData_bits;
  wire [8:0]   _itcmWrapper_io_sram_address;
  wire         _itcmWrapper_io_sram_enable;
  wire         _itcmWrapper_io_sram_isWrite;
  wire [7:0]   _itcmWrapper_io_sram_writeData_0;
  wire [7:0]   _itcmWrapper_io_sram_writeData_1;
  wire [7:0]   _itcmWrapper_io_sram_writeData_2;
  wire [7:0]   _itcmWrapper_io_sram_writeData_3;
  wire [7:0]   _itcmWrapper_io_sram_writeData_4;
  wire [7:0]   _itcmWrapper_io_sram_writeData_5;
  wire [7:0]   _itcmWrapper_io_sram_writeData_6;
  wire [7:0]   _itcmWrapper_io_sram_writeData_7;
  wire [7:0]   _itcmWrapper_io_sram_writeData_8;
  wire [7:0]   _itcmWrapper_io_sram_writeData_9;
  wire [7:0]   _itcmWrapper_io_sram_writeData_10;
  wire [7:0]   _itcmWrapper_io_sram_writeData_11;
  wire [7:0]   _itcmWrapper_io_sram_writeData_12;
  wire [7:0]   _itcmWrapper_io_sram_writeData_13;
  wire [7:0]   _itcmWrapper_io_sram_writeData_14;
  wire [7:0]   _itcmWrapper_io_sram_writeData_15;
  wire         _itcmWrapper_io_sram_mask_0;
  wire         _itcmWrapper_io_sram_mask_1;
  wire         _itcmWrapper_io_sram_mask_2;
  wire         _itcmWrapper_io_sram_mask_3;
  wire         _itcmWrapper_io_sram_mask_4;
  wire         _itcmWrapper_io_sram_mask_5;
  wire         _itcmWrapper_io_sram_mask_6;
  wire         _itcmWrapper_io_sram_mask_7;
  wire         _itcmWrapper_io_sram_mask_8;
  wire         _itcmWrapper_io_sram_mask_9;
  wire         _itcmWrapper_io_sram_mask_10;
  wire         _itcmWrapper_io_sram_mask_11;
  wire         _itcmWrapper_io_sram_mask_12;
  wire         _itcmWrapper_io_sram_mask_13;
  wire         _itcmWrapper_io_sram_mask_14;
  wire         _itcmWrapper_io_sram_mask_15;
  wire [7:0]   _itcm_io_rdata_0;
  wire [7:0]   _itcm_io_rdata_1;
  wire [7:0]   _itcm_io_rdata_2;
  wire [7:0]   _itcm_io_rdata_3;
  wire [7:0]   _itcm_io_rdata_4;
  wire [7:0]   _itcm_io_rdata_5;
  wire [7:0]   _itcm_io_rdata_6;
  wire [7:0]   _itcm_io_rdata_7;
  wire [7:0]   _itcm_io_rdata_8;
  wire [7:0]   _itcm_io_rdata_9;
  wire [7:0]   _itcm_io_rdata_10;
  wire [7:0]   _itcm_io_rdata_11;
  wire [7:0]   _itcm_io_rdata_12;
  wire [7:0]   _itcm_io_rdata_13;
  wire [7:0]   _itcm_io_rdata_14;
  wire [7:0]   _itcm_io_rdata_15;
  wire [31:0]  _core_io_csr_out_value_0;
  wire [31:0]  _core_io_csr_out_value_1;
  wire [31:0]  _core_io_csr_out_value_2;
  wire [31:0]  _core_io_csr_out_value_3;
  wire [31:0]  _core_io_csr_out_value_4;
  wire [31:0]  _core_io_csr_out_value_5;
  wire [31:0]  _core_io_csr_out_value_6;
  wire [31:0]  _core_io_csr_out_value_7;
  wire [31:0]  _core_io_csr_out_value_8;
  wire         _core_io_halted;
  wire         _core_io_fault;
  wire         _core_io_wfi;
  wire         _core_io_ibus_valid;
  wire [31:0]  _core_io_ibus_addr;
  wire         _core_io_dbus_valid;
  wire         _core_io_dbus_write;
  wire [31:0]  _core_io_dbus_addr;
  wire [127:0] _core_io_dbus_wdata;
  wire [15:0]  _core_io_dbus_wmask;
  wire         _core_io_ebus_dbus_valid;
  wire         _core_io_ebus_dbus_write;
  wire [31:0]  _core_io_ebus_dbus_pc;
  wire [31:0]  _core_io_ebus_dbus_addr;
  wire [4:0]   _core_io_ebus_dbus_size;
  wire [127:0] _core_io_ebus_dbus_wdata;
  wire [15:0]  _core_io_ebus_dbus_wmask;
  wire         _cg_clk_o;
  wire         _csr_io_fabric_readData_valid;
  wire [127:0] _csr_io_fabric_readData_bits;
  wire         _csr_io_fabric_writeResp;
  wire         _csr_io_reset;
  wire         _csr_io_cg;
  wire [31:0]  _csr_io_pcStart;
  wire         _rst_sync_clk_o;
  wire         _rst_sync_rstn_o;
  wire         _global_reset_T_2 = ~(io_te ? io_aresetn : _rst_sync_rstn_o);
  reg          axiSlaveEnable;
  always @(posedge _rst_sync_clk_o or posedge _global_reset_T_2) begin
    if (_global_reset_T_2)
      axiSlaveEnable <= 1'h0;
    else
      axiSlaveEnable <= 1'h1;
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
        axiSlaveEnable = _RANDOM[/*Zero width*/ 1'b0][0];
      `endif // RANDOMIZE_REG_INIT
      if (_global_reset_T_2)
        axiSlaveEnable = 1'h0;
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  RstSync rst_sync (
    .clk_i  (io_aclk),
    .rstn_i (io_aresetn),
    .clk_en (1'h1),
    .te     (io_te),
    .clk_o  (_rst_sync_clk_o),
    .rstn_o (_rst_sync_rstn_o)
  );
  CoreCSR csr (
    .clock                         (_rst_sync_clk_o),
    .reset                         (_global_reset_T_2),
    .io_fabric_readDataAddr_bits   (_fabricMux_io_ports_2_readDataAddr_bits),
    .io_fabric_readData_valid      (_csr_io_fabric_readData_valid),
    .io_fabric_readData_bits       (_csr_io_fabric_readData_bits),
    .io_fabric_writeDataAddr_valid (_fabricMux_io_ports_2_writeDataAddr_valid),
    .io_fabric_writeDataAddr_bits  (_fabricMux_io_ports_2_writeDataAddr_bits),
    .io_fabric_writeDataBits       (_fabricMux_io_ports_2_writeDataBits),
    .io_fabric_writeResp           (_csr_io_fabric_writeResp),
    .io_reset                      (_csr_io_reset),
    .io_cg                         (_csr_io_cg),
    .io_pcStart                    (_csr_io_pcStart),
    .io_halted                     (_core_io_halted),
    .io_fault                      (_core_io_fault),
    .io_coralnpu_csr_value_0       (_core_io_csr_out_value_0),
    .io_coralnpu_csr_value_1       (_core_io_csr_out_value_1),
    .io_coralnpu_csr_value_2       (_core_io_csr_out_value_2),
    .io_coralnpu_csr_value_3       (_core_io_csr_out_value_3),
    .io_coralnpu_csr_value_4       (_core_io_csr_out_value_4),
    .io_coralnpu_csr_value_5       (_core_io_csr_out_value_5),
    .io_coralnpu_csr_value_6       (_core_io_csr_out_value_6),
    .io_coralnpu_csr_value_7       (_core_io_csr_out_value_7),
    .io_coralnpu_csr_value_8       (_core_io_csr_out_value_8)
  );
  ClockGate cg (
    .clk_i  (_rst_sync_clk_o),
    .enable (io_irq | ~_csr_io_cg & ~_core_io_wfi),
    .te     (io_te),
    .clk_o  (_cg_clk_o)
  );
  RvvCoreMini core (
    .clock                                  (_cg_clk_o),
    .reset                                  (io_te ? ~io_aresetn : _csr_io_reset),
    .io_csr_in_value_0                      (_csr_io_pcStart),
    .io_csr_out_value_0                     (_core_io_csr_out_value_0),
    .io_csr_out_value_1                     (_core_io_csr_out_value_1),
    .io_csr_out_value_2                     (_core_io_csr_out_value_2),
    .io_csr_out_value_3                     (_core_io_csr_out_value_3),
    .io_csr_out_value_4                     (_core_io_csr_out_value_4),
    .io_csr_out_value_5                     (_core_io_csr_out_value_5),
    .io_csr_out_value_6                     (_core_io_csr_out_value_6),
    .io_csr_out_value_7                     (_core_io_csr_out_value_7),
    .io_csr_out_value_8                     (_core_io_csr_out_value_8),
    .io_halted                              (_core_io_halted),
    .io_fault                               (_core_io_fault),
    .io_wfi                                 (_core_io_wfi),
    .io_irq                                 (io_irq),
    .io_ibus_valid                          (_core_io_ibus_valid),
    .io_ibus_addr                           (_core_io_ibus_addr),
    .io_ibus_rdata                          (_itcmArbiter_io_source_0_readData_bits),
    .io_ibus_fault_valid
      (_core_io_ibus_valid & (|(_core_io_ibus_addr[31:13]))),
    .io_dbus_valid                          (_core_io_dbus_valid),
    .io_dbus_write                          (_core_io_dbus_write),
    .io_dbus_addr                           (_core_io_dbus_addr),
    .io_dbus_wdata                          (_core_io_dbus_wdata),
    .io_dbus_wmask                          (_core_io_dbus_wmask),
    .io_dbus_rdata                          (_dtcmArbiter_io_source_0_readData_bits),
    .io_ebus_dbus_valid                     (_core_io_ebus_dbus_valid),
    .io_ebus_dbus_ready                     (_ebus2axi_io_dbus_ready),
    .io_ebus_dbus_write                     (_core_io_ebus_dbus_write),
    .io_ebus_dbus_pc                        (_core_io_ebus_dbus_pc),
    .io_ebus_dbus_addr                      (_core_io_ebus_dbus_addr),
    .io_ebus_dbus_size                      (_core_io_ebus_dbus_size),
    .io_ebus_dbus_wdata                     (_core_io_ebus_dbus_wdata),
    .io_ebus_dbus_wmask                     (_core_io_ebus_dbus_wmask),
    .io_ebus_dbus_rdata                     (_ebus2axi_io_dbus_rdata),
    .io_ebus_fault_valid                    (_ebus2axi_io_fault_valid),
    .io_ebus_fault_bits_write               (_ebus2axi_io_fault_bits_write),
    .io_ebus_fault_bits_addr                (_ebus2axi_io_fault_bits_addr),
    .io_ebus_fault_bits_epc                 (_ebus2axi_io_fault_bits_epc),
    .io_slog_valid                          (io_slog_valid),
    .io_slog_addr                           (io_slog_addr),
    .io_slog_data                           (io_slog_data),
    .io_debug_en                            (io_debug_en),
    .io_debug_addr_0                        (io_debug_addr_0),
    .io_debug_addr_1                        (io_debug_addr_1),
    .io_debug_addr_2                        (io_debug_addr_2),
    .io_debug_addr_3                        (io_debug_addr_3),
    .io_debug_inst_0                        (io_debug_inst_0),
    .io_debug_inst_1                        (io_debug_inst_1),
    .io_debug_inst_2                        (io_debug_inst_2),
    .io_debug_inst_3                        (io_debug_inst_3),
    .io_debug_cycles                        (io_debug_cycles),
    .io_debug_dbus_valid                    (io_debug_dbus_valid),
    .io_debug_dbus_bits_addr                (io_debug_dbus_bits_addr),
    .io_debug_dbus_bits_wdata               (io_debug_dbus_bits_wdata),
    .io_debug_dbus_bits_write               (io_debug_dbus_bits_write),
    .io_debug_dispatch_0_instFire           (io_debug_dispatch_0_instFire),
    .io_debug_dispatch_0_instAddr           (io_debug_dispatch_0_instAddr),
    .io_debug_dispatch_0_instInst           (io_debug_dispatch_0_instInst),
    .io_debug_dispatch_1_instFire           (io_debug_dispatch_1_instFire),
    .io_debug_dispatch_1_instAddr           (io_debug_dispatch_1_instAddr),
    .io_debug_dispatch_1_instInst           (io_debug_dispatch_1_instInst),
    .io_debug_dispatch_2_instFire           (io_debug_dispatch_2_instFire),
    .io_debug_dispatch_2_instAddr           (io_debug_dispatch_2_instAddr),
    .io_debug_dispatch_2_instInst           (io_debug_dispatch_2_instInst),
    .io_debug_dispatch_3_instFire           (io_debug_dispatch_3_instFire),
    .io_debug_dispatch_3_instAddr           (io_debug_dispatch_3_instAddr),
    .io_debug_dispatch_3_instInst           (io_debug_dispatch_3_instInst),
    .io_debug_regfile_writeAddr_0_valid     (io_debug_regfile_writeAddr_0_valid),
    .io_debug_regfile_writeAddr_0_bits      (io_debug_regfile_writeAddr_0_bits),
    .io_debug_regfile_writeAddr_1_valid     (io_debug_regfile_writeAddr_1_valid),
    .io_debug_regfile_writeAddr_1_bits      (io_debug_regfile_writeAddr_1_bits),
    .io_debug_regfile_writeAddr_2_valid     (io_debug_regfile_writeAddr_2_valid),
    .io_debug_regfile_writeAddr_2_bits      (io_debug_regfile_writeAddr_2_bits),
    .io_debug_regfile_writeAddr_3_valid     (io_debug_regfile_writeAddr_3_valid),
    .io_debug_regfile_writeAddr_3_bits      (io_debug_regfile_writeAddr_3_bits),
    .io_debug_regfile_writeData_0_valid     (io_debug_regfile_writeData_0_valid),
    .io_debug_regfile_writeData_0_bits_addr (io_debug_regfile_writeData_0_bits_addr),
    .io_debug_regfile_writeData_0_bits_data (io_debug_regfile_writeData_0_bits_data),
    .io_debug_regfile_writeData_1_valid     (io_debug_regfile_writeData_1_valid),
    .io_debug_regfile_writeData_1_bits_addr (io_debug_regfile_writeData_1_bits_addr),
    .io_debug_regfile_writeData_1_bits_data (io_debug_regfile_writeData_1_bits_data),
    .io_debug_regfile_writeData_2_valid     (io_debug_regfile_writeData_2_valid),
    .io_debug_regfile_writeData_2_bits_addr (io_debug_regfile_writeData_2_bits_addr),
    .io_debug_regfile_writeData_2_bits_data (io_debug_regfile_writeData_2_bits_data),
    .io_debug_regfile_writeData_3_valid     (io_debug_regfile_writeData_3_valid),
    .io_debug_regfile_writeData_3_bits_addr (io_debug_regfile_writeData_3_bits_addr),
    .io_debug_regfile_writeData_3_bits_data (io_debug_regfile_writeData_3_bits_data),
    .io_debug_regfile_writeData_4_valid     (io_debug_regfile_writeData_4_valid),
    .io_debug_regfile_writeData_4_bits_addr (io_debug_regfile_writeData_4_bits_addr),
    .io_debug_regfile_writeData_4_bits_data (io_debug_regfile_writeData_4_bits_data),
    .io_debug_regfile_writeData_5_valid     (io_debug_regfile_writeData_5_valid),
    .io_debug_regfile_writeData_5_bits_addr (io_debug_regfile_writeData_5_bits_addr),
    .io_debug_regfile_writeData_5_bits_data (io_debug_regfile_writeData_5_bits_data),
    .io_debug_float_writeAddr_valid         (io_debug_float_writeAddr_valid),
    .io_debug_float_writeAddr_bits          (io_debug_float_writeAddr_bits),
    .io_debug_float_writeData_0_valid       (io_debug_float_writeData_0_valid),
    .io_debug_float_writeData_0_bits_addr   (io_debug_float_writeData_0_bits_addr),
    .io_debug_float_writeData_0_bits_data   (io_debug_float_writeData_0_bits_data),
    .io_debug_float_writeData_1_valid       (io_debug_float_writeData_1_valid),
    .io_debug_float_writeData_1_bits_addr   (io_debug_float_writeData_1_bits_addr),
    .io_debug_float_writeData_1_bits_data   (io_debug_float_writeData_1_bits_data),
    .io_debug_rb_inst_0_valid               (io_debug_rb_inst_0_valid),
    .io_debug_rb_inst_0_bits_pc             (io_debug_rb_inst_0_bits_pc),
    .io_debug_rb_inst_0_bits_idx            (io_debug_rb_inst_0_bits_idx),
    .io_debug_rb_inst_0_bits_trap           (io_debug_rb_inst_0_bits_trap),
    .io_debug_rb_inst_1_valid               (io_debug_rb_inst_1_valid),
    .io_debug_rb_inst_1_bits_pc             (io_debug_rb_inst_1_bits_pc),
    .io_debug_rb_inst_1_bits_idx            (io_debug_rb_inst_1_bits_idx),
    .io_debug_rb_inst_1_bits_trap           (io_debug_rb_inst_1_bits_trap),
    .io_debug_rb_inst_2_valid               (io_debug_rb_inst_2_valid),
    .io_debug_rb_inst_2_bits_pc             (io_debug_rb_inst_2_bits_pc),
    .io_debug_rb_inst_2_bits_idx            (io_debug_rb_inst_2_bits_idx),
    .io_debug_rb_inst_2_bits_trap           (io_debug_rb_inst_2_bits_trap),
    .io_debug_rb_inst_3_valid               (io_debug_rb_inst_3_valid),
    .io_debug_rb_inst_3_bits_pc             (io_debug_rb_inst_3_bits_pc),
    .io_debug_rb_inst_3_bits_idx            (io_debug_rb_inst_3_bits_idx),
    .io_debug_rb_inst_3_bits_trap           (io_debug_rb_inst_3_bits_trap),
    .io_debug_rb_inst_4_valid               (io_debug_rb_inst_4_valid),
    .io_debug_rb_inst_4_bits_pc             (io_debug_rb_inst_4_bits_pc),
    .io_debug_rb_inst_4_bits_idx            (io_debug_rb_inst_4_bits_idx),
    .io_debug_rb_inst_4_bits_trap           (io_debug_rb_inst_4_bits_trap),
    .io_debug_rb_inst_5_valid               (io_debug_rb_inst_5_valid),
    .io_debug_rb_inst_5_bits_pc             (io_debug_rb_inst_5_bits_pc),
    .io_debug_rb_inst_5_bits_idx            (io_debug_rb_inst_5_bits_idx),
    .io_debug_rb_inst_5_bits_trap           (io_debug_rb_inst_5_bits_trap),
    .io_debug_rb_inst_6_valid               (io_debug_rb_inst_6_valid),
    .io_debug_rb_inst_6_bits_pc             (io_debug_rb_inst_6_bits_pc),
    .io_debug_rb_inst_6_bits_idx            (io_debug_rb_inst_6_bits_idx),
    .io_debug_rb_inst_6_bits_trap           (io_debug_rb_inst_6_bits_trap),
    .io_debug_rb_inst_7_valid               (io_debug_rb_inst_7_valid),
    .io_debug_rb_inst_7_bits_pc             (io_debug_rb_inst_7_bits_pc),
    .io_debug_rb_inst_7_bits_idx            (io_debug_rb_inst_7_bits_idx),
    .io_debug_rb_inst_7_bits_trap           (io_debug_rb_inst_7_bits_trap)
  );
  TCM128 itcm (
    .clock       (_rst_sync_clk_o),
    .io_addr     (_itcmWrapper_io_sram_address),
    .io_enable   (_itcmWrapper_io_sram_enable),
    .io_write    (_itcmWrapper_io_sram_isWrite),
    .io_wdata_0  (_itcmWrapper_io_sram_writeData_0),
    .io_wdata_1  (_itcmWrapper_io_sram_writeData_1),
    .io_wdata_2  (_itcmWrapper_io_sram_writeData_2),
    .io_wdata_3  (_itcmWrapper_io_sram_writeData_3),
    .io_wdata_4  (_itcmWrapper_io_sram_writeData_4),
    .io_wdata_5  (_itcmWrapper_io_sram_writeData_5),
    .io_wdata_6  (_itcmWrapper_io_sram_writeData_6),
    .io_wdata_7  (_itcmWrapper_io_sram_writeData_7),
    .io_wdata_8  (_itcmWrapper_io_sram_writeData_8),
    .io_wdata_9  (_itcmWrapper_io_sram_writeData_9),
    .io_wdata_10 (_itcmWrapper_io_sram_writeData_10),
    .io_wdata_11 (_itcmWrapper_io_sram_writeData_11),
    .io_wdata_12 (_itcmWrapper_io_sram_writeData_12),
    .io_wdata_13 (_itcmWrapper_io_sram_writeData_13),
    .io_wdata_14 (_itcmWrapper_io_sram_writeData_14),
    .io_wdata_15 (_itcmWrapper_io_sram_writeData_15),
    .io_wmask_0  (_itcmWrapper_io_sram_mask_0),
    .io_wmask_1  (_itcmWrapper_io_sram_mask_1),
    .io_wmask_2  (_itcmWrapper_io_sram_mask_2),
    .io_wmask_3  (_itcmWrapper_io_sram_mask_3),
    .io_wmask_4  (_itcmWrapper_io_sram_mask_4),
    .io_wmask_5  (_itcmWrapper_io_sram_mask_5),
    .io_wmask_6  (_itcmWrapper_io_sram_mask_6),
    .io_wmask_7  (_itcmWrapper_io_sram_mask_7),
    .io_wmask_8  (_itcmWrapper_io_sram_mask_8),
    .io_wmask_9  (_itcmWrapper_io_sram_mask_9),
    .io_wmask_10 (_itcmWrapper_io_sram_mask_10),
    .io_wmask_11 (_itcmWrapper_io_sram_mask_11),
    .io_wmask_12 (_itcmWrapper_io_sram_mask_12),
    .io_wmask_13 (_itcmWrapper_io_sram_mask_13),
    .io_wmask_14 (_itcmWrapper_io_sram_mask_14),
    .io_wmask_15 (_itcmWrapper_io_sram_mask_15),
    .io_rdata_0  (_itcm_io_rdata_0),
    .io_rdata_1  (_itcm_io_rdata_1),
    .io_rdata_2  (_itcm_io_rdata_2),
    .io_rdata_3  (_itcm_io_rdata_3),
    .io_rdata_4  (_itcm_io_rdata_4),
    .io_rdata_5  (_itcm_io_rdata_5),
    .io_rdata_6  (_itcm_io_rdata_6),
    .io_rdata_7  (_itcm_io_rdata_7),
    .io_rdata_8  (_itcm_io_rdata_8),
    .io_rdata_9  (_itcm_io_rdata_9),
    .io_rdata_10 (_itcm_io_rdata_10),
    .io_rdata_11 (_itcm_io_rdata_11),
    .io_rdata_12 (_itcm_io_rdata_12),
    .io_rdata_13 (_itcm_io_rdata_13),
    .io_rdata_14 (_itcm_io_rdata_14),
    .io_rdata_15 (_itcm_io_rdata_15)
  );
  SRAM itcmWrapper (
    .clock                         (_rst_sync_clk_o),
    .reset                         (_global_reset_T_2),
    .io_fabric_readDataAddr_valid  (_itcmArbiter_io_port_readDataAddr_valid),
    .io_fabric_readDataAddr_bits   (_itcmArbiter_io_port_readDataAddr_bits),
    .io_fabric_readData_valid      (_itcmWrapper_io_fabric_readData_valid),
    .io_fabric_readData_bits       (_itcmWrapper_io_fabric_readData_bits),
    .io_fabric_writeDataAddr_valid (_itcmArbiter_io_port_writeDataAddr_valid),
    .io_fabric_writeDataAddr_bits  (_itcmArbiter_io_port_writeDataAddr_bits),
    .io_fabric_writeDataBits       (_itcmArbiter_io_port_writeDataBits),
    .io_fabric_writeDataStrb       (_itcmArbiter_io_port_writeDataStrb),
    .io_sram_address               (_itcmWrapper_io_sram_address),
    .io_sram_enable                (_itcmWrapper_io_sram_enable),
    .io_sram_isWrite               (_itcmWrapper_io_sram_isWrite),
    .io_sram_readData_0            (_itcm_io_rdata_0),
    .io_sram_readData_1            (_itcm_io_rdata_1),
    .io_sram_readData_2            (_itcm_io_rdata_2),
    .io_sram_readData_3            (_itcm_io_rdata_3),
    .io_sram_readData_4            (_itcm_io_rdata_4),
    .io_sram_readData_5            (_itcm_io_rdata_5),
    .io_sram_readData_6            (_itcm_io_rdata_6),
    .io_sram_readData_7            (_itcm_io_rdata_7),
    .io_sram_readData_8            (_itcm_io_rdata_8),
    .io_sram_readData_9            (_itcm_io_rdata_9),
    .io_sram_readData_10           (_itcm_io_rdata_10),
    .io_sram_readData_11           (_itcm_io_rdata_11),
    .io_sram_readData_12           (_itcm_io_rdata_12),
    .io_sram_readData_13           (_itcm_io_rdata_13),
    .io_sram_readData_14           (_itcm_io_rdata_14),
    .io_sram_readData_15           (_itcm_io_rdata_15),
    .io_sram_writeData_0           (_itcmWrapper_io_sram_writeData_0),
    .io_sram_writeData_1           (_itcmWrapper_io_sram_writeData_1),
    .io_sram_writeData_2           (_itcmWrapper_io_sram_writeData_2),
    .io_sram_writeData_3           (_itcmWrapper_io_sram_writeData_3),
    .io_sram_writeData_4           (_itcmWrapper_io_sram_writeData_4),
    .io_sram_writeData_5           (_itcmWrapper_io_sram_writeData_5),
    .io_sram_writeData_6           (_itcmWrapper_io_sram_writeData_6),
    .io_sram_writeData_7           (_itcmWrapper_io_sram_writeData_7),
    .io_sram_writeData_8           (_itcmWrapper_io_sram_writeData_8),
    .io_sram_writeData_9           (_itcmWrapper_io_sram_writeData_9),
    .io_sram_writeData_10          (_itcmWrapper_io_sram_writeData_10),
    .io_sram_writeData_11          (_itcmWrapper_io_sram_writeData_11),
    .io_sram_writeData_12          (_itcmWrapper_io_sram_writeData_12),
    .io_sram_writeData_13          (_itcmWrapper_io_sram_writeData_13),
    .io_sram_writeData_14          (_itcmWrapper_io_sram_writeData_14),
    .io_sram_writeData_15          (_itcmWrapper_io_sram_writeData_15),
    .io_sram_mask_0                (_itcmWrapper_io_sram_mask_0),
    .io_sram_mask_1                (_itcmWrapper_io_sram_mask_1),
    .io_sram_mask_2                (_itcmWrapper_io_sram_mask_2),
    .io_sram_mask_3                (_itcmWrapper_io_sram_mask_3),
    .io_sram_mask_4                (_itcmWrapper_io_sram_mask_4),
    .io_sram_mask_5                (_itcmWrapper_io_sram_mask_5),
    .io_sram_mask_6                (_itcmWrapper_io_sram_mask_6),
    .io_sram_mask_7                (_itcmWrapper_io_sram_mask_7),
    .io_sram_mask_8                (_itcmWrapper_io_sram_mask_8),
    .io_sram_mask_9                (_itcmWrapper_io_sram_mask_9),
    .io_sram_mask_10               (_itcmWrapper_io_sram_mask_10),
    .io_sram_mask_11               (_itcmWrapper_io_sram_mask_11),
    .io_sram_mask_12               (_itcmWrapper_io_sram_mask_12),
    .io_sram_mask_13               (_itcmWrapper_io_sram_mask_13),
    .io_sram_mask_14               (_itcmWrapper_io_sram_mask_14),
    .io_sram_mask_15               (_itcmWrapper_io_sram_mask_15)
  );
  FabricArbiter itcmArbiter (
    .clock                           (_rst_sync_clk_o),
    .reset                           (_global_reset_T_2),
    .io_source_0_readDataAddr_valid  (_core_io_ibus_valid),
    .io_source_0_readDataAddr_bits   (_core_io_ibus_addr),
    .io_source_0_readData_bits       (_itcmArbiter_io_source_0_readData_bits),
    .io_source_0_writeDataAddr_valid (1'h0),
    .io_source_0_writeDataAddr_bits  (32'h0),
    .io_source_0_writeDataBits       (128'h0),
    .io_source_0_writeDataStrb       (16'h0),
    .io_source_1_readDataAddr_valid  (_fabricMux_io_ports_0_readDataAddr_valid),
    .io_source_1_readDataAddr_bits   (_fabricMux_io_ports_0_readDataAddr_bits),
    .io_source_1_readData_valid      (_itcmArbiter_io_source_1_readData_valid),
    .io_source_1_readData_bits       (_itcmArbiter_io_source_1_readData_bits),
    .io_source_1_writeDataAddr_valid (_fabricMux_io_ports_0_writeDataAddr_valid),
    .io_source_1_writeDataAddr_bits  (_fabricMux_io_ports_0_writeDataAddr_bits),
    .io_source_1_writeDataBits       (_fabricMux_io_ports_0_writeDataBits),
    .io_source_1_writeDataStrb       (_fabricMux_io_ports_0_writeDataStrb),
    .io_fabricBusy_1                 (_itcmArbiter_io_fabricBusy_1),
    .io_port_readDataAddr_valid      (_itcmArbiter_io_port_readDataAddr_valid),
    .io_port_readDataAddr_bits       (_itcmArbiter_io_port_readDataAddr_bits),
    .io_port_readData_valid          (_itcmWrapper_io_fabric_readData_valid),
    .io_port_readData_bits           (_itcmWrapper_io_fabric_readData_bits),
    .io_port_writeDataAddr_valid     (_itcmArbiter_io_port_writeDataAddr_valid),
    .io_port_writeDataAddr_bits      (_itcmArbiter_io_port_writeDataAddr_bits),
    .io_port_writeDataBits           (_itcmArbiter_io_port_writeDataBits),
    .io_port_writeDataStrb           (_itcmArbiter_io_port_writeDataStrb)
  );
  TCM128_1 dtcm (
    .clock       (_rst_sync_clk_o),
    .io_addr     (_dtcmWrapper_io_sram_address),
    .io_enable   (_dtcmWrapper_io_sram_enable),
    .io_write    (_dtcmWrapper_io_sram_isWrite),
    .io_wdata_0  (_dtcmWrapper_io_sram_writeData_0),
    .io_wdata_1  (_dtcmWrapper_io_sram_writeData_1),
    .io_wdata_2  (_dtcmWrapper_io_sram_writeData_2),
    .io_wdata_3  (_dtcmWrapper_io_sram_writeData_3),
    .io_wdata_4  (_dtcmWrapper_io_sram_writeData_4),
    .io_wdata_5  (_dtcmWrapper_io_sram_writeData_5),
    .io_wdata_6  (_dtcmWrapper_io_sram_writeData_6),
    .io_wdata_7  (_dtcmWrapper_io_sram_writeData_7),
    .io_wdata_8  (_dtcmWrapper_io_sram_writeData_8),
    .io_wdata_9  (_dtcmWrapper_io_sram_writeData_9),
    .io_wdata_10 (_dtcmWrapper_io_sram_writeData_10),
    .io_wdata_11 (_dtcmWrapper_io_sram_writeData_11),
    .io_wdata_12 (_dtcmWrapper_io_sram_writeData_12),
    .io_wdata_13 (_dtcmWrapper_io_sram_writeData_13),
    .io_wdata_14 (_dtcmWrapper_io_sram_writeData_14),
    .io_wdata_15 (_dtcmWrapper_io_sram_writeData_15),
    .io_wmask_0  (_dtcmWrapper_io_sram_mask_0),
    .io_wmask_1  (_dtcmWrapper_io_sram_mask_1),
    .io_wmask_2  (_dtcmWrapper_io_sram_mask_2),
    .io_wmask_3  (_dtcmWrapper_io_sram_mask_3),
    .io_wmask_4  (_dtcmWrapper_io_sram_mask_4),
    .io_wmask_5  (_dtcmWrapper_io_sram_mask_5),
    .io_wmask_6  (_dtcmWrapper_io_sram_mask_6),
    .io_wmask_7  (_dtcmWrapper_io_sram_mask_7),
    .io_wmask_8  (_dtcmWrapper_io_sram_mask_8),
    .io_wmask_9  (_dtcmWrapper_io_sram_mask_9),
    .io_wmask_10 (_dtcmWrapper_io_sram_mask_10),
    .io_wmask_11 (_dtcmWrapper_io_sram_mask_11),
    .io_wmask_12 (_dtcmWrapper_io_sram_mask_12),
    .io_wmask_13 (_dtcmWrapper_io_sram_mask_13),
    .io_wmask_14 (_dtcmWrapper_io_sram_mask_14),
    .io_wmask_15 (_dtcmWrapper_io_sram_mask_15),
    .io_rdata_0  (_dtcm_io_rdata_0),
    .io_rdata_1  (_dtcm_io_rdata_1),
    .io_rdata_2  (_dtcm_io_rdata_2),
    .io_rdata_3  (_dtcm_io_rdata_3),
    .io_rdata_4  (_dtcm_io_rdata_4),
    .io_rdata_5  (_dtcm_io_rdata_5),
    .io_rdata_6  (_dtcm_io_rdata_6),
    .io_rdata_7  (_dtcm_io_rdata_7),
    .io_rdata_8  (_dtcm_io_rdata_8),
    .io_rdata_9  (_dtcm_io_rdata_9),
    .io_rdata_10 (_dtcm_io_rdata_10),
    .io_rdata_11 (_dtcm_io_rdata_11),
    .io_rdata_12 (_dtcm_io_rdata_12),
    .io_rdata_13 (_dtcm_io_rdata_13),
    .io_rdata_14 (_dtcm_io_rdata_14),
    .io_rdata_15 (_dtcm_io_rdata_15)
  );
  SRAM_1 dtcmWrapper (
    .clock                         (_rst_sync_clk_o),
    .reset                         (_global_reset_T_2),
    .io_fabric_readDataAddr_valid  (_dtcmArbiter_io_port_readDataAddr_valid),
    .io_fabric_readDataAddr_bits   (_dtcmArbiter_io_port_readDataAddr_bits),
    .io_fabric_readData_valid      (_dtcmWrapper_io_fabric_readData_valid),
    .io_fabric_readData_bits       (_dtcmWrapper_io_fabric_readData_bits),
    .io_fabric_writeDataAddr_valid (_dtcmArbiter_io_port_writeDataAddr_valid),
    .io_fabric_writeDataAddr_bits  (_dtcmArbiter_io_port_writeDataAddr_bits),
    .io_fabric_writeDataBits       (_dtcmArbiter_io_port_writeDataBits),
    .io_fabric_writeDataStrb       (_dtcmArbiter_io_port_writeDataStrb),
    .io_sram_address               (_dtcmWrapper_io_sram_address),
    .io_sram_enable                (_dtcmWrapper_io_sram_enable),
    .io_sram_isWrite               (_dtcmWrapper_io_sram_isWrite),
    .io_sram_readData_0            (_dtcm_io_rdata_0),
    .io_sram_readData_1            (_dtcm_io_rdata_1),
    .io_sram_readData_2            (_dtcm_io_rdata_2),
    .io_sram_readData_3            (_dtcm_io_rdata_3),
    .io_sram_readData_4            (_dtcm_io_rdata_4),
    .io_sram_readData_5            (_dtcm_io_rdata_5),
    .io_sram_readData_6            (_dtcm_io_rdata_6),
    .io_sram_readData_7            (_dtcm_io_rdata_7),
    .io_sram_readData_8            (_dtcm_io_rdata_8),
    .io_sram_readData_9            (_dtcm_io_rdata_9),
    .io_sram_readData_10           (_dtcm_io_rdata_10),
    .io_sram_readData_11           (_dtcm_io_rdata_11),
    .io_sram_readData_12           (_dtcm_io_rdata_12),
    .io_sram_readData_13           (_dtcm_io_rdata_13),
    .io_sram_readData_14           (_dtcm_io_rdata_14),
    .io_sram_readData_15           (_dtcm_io_rdata_15),
    .io_sram_writeData_0           (_dtcmWrapper_io_sram_writeData_0),
    .io_sram_writeData_1           (_dtcmWrapper_io_sram_writeData_1),
    .io_sram_writeData_2           (_dtcmWrapper_io_sram_writeData_2),
    .io_sram_writeData_3           (_dtcmWrapper_io_sram_writeData_3),
    .io_sram_writeData_4           (_dtcmWrapper_io_sram_writeData_4),
    .io_sram_writeData_5           (_dtcmWrapper_io_sram_writeData_5),
    .io_sram_writeData_6           (_dtcmWrapper_io_sram_writeData_6),
    .io_sram_writeData_7           (_dtcmWrapper_io_sram_writeData_7),
    .io_sram_writeData_8           (_dtcmWrapper_io_sram_writeData_8),
    .io_sram_writeData_9           (_dtcmWrapper_io_sram_writeData_9),
    .io_sram_writeData_10          (_dtcmWrapper_io_sram_writeData_10),
    .io_sram_writeData_11          (_dtcmWrapper_io_sram_writeData_11),
    .io_sram_writeData_12          (_dtcmWrapper_io_sram_writeData_12),
    .io_sram_writeData_13          (_dtcmWrapper_io_sram_writeData_13),
    .io_sram_writeData_14          (_dtcmWrapper_io_sram_writeData_14),
    .io_sram_writeData_15          (_dtcmWrapper_io_sram_writeData_15),
    .io_sram_mask_0                (_dtcmWrapper_io_sram_mask_0),
    .io_sram_mask_1                (_dtcmWrapper_io_sram_mask_1),
    .io_sram_mask_2                (_dtcmWrapper_io_sram_mask_2),
    .io_sram_mask_3                (_dtcmWrapper_io_sram_mask_3),
    .io_sram_mask_4                (_dtcmWrapper_io_sram_mask_4),
    .io_sram_mask_5                (_dtcmWrapper_io_sram_mask_5),
    .io_sram_mask_6                (_dtcmWrapper_io_sram_mask_6),
    .io_sram_mask_7                (_dtcmWrapper_io_sram_mask_7),
    .io_sram_mask_8                (_dtcmWrapper_io_sram_mask_8),
    .io_sram_mask_9                (_dtcmWrapper_io_sram_mask_9),
    .io_sram_mask_10               (_dtcmWrapper_io_sram_mask_10),
    .io_sram_mask_11               (_dtcmWrapper_io_sram_mask_11),
    .io_sram_mask_12               (_dtcmWrapper_io_sram_mask_12),
    .io_sram_mask_13               (_dtcmWrapper_io_sram_mask_13),
    .io_sram_mask_14               (_dtcmWrapper_io_sram_mask_14),
    .io_sram_mask_15               (_dtcmWrapper_io_sram_mask_15)
  );
  FabricArbiter dtcmArbiter (
    .clock                           (_rst_sync_clk_o),
    .reset                           (_global_reset_T_2),
    .io_source_0_readDataAddr_valid  (_core_io_dbus_valid & ~_core_io_dbus_write),
    .io_source_0_readDataAddr_bits   (_core_io_dbus_addr),
    .io_source_0_readData_bits       (_dtcmArbiter_io_source_0_readData_bits),
    .io_source_0_writeDataAddr_valid (_core_io_dbus_valid & _core_io_dbus_write),
    .io_source_0_writeDataAddr_bits  (_core_io_dbus_addr),
    .io_source_0_writeDataBits       (_core_io_dbus_wdata),
    .io_source_0_writeDataStrb       (_core_io_dbus_wmask),
    .io_source_1_readDataAddr_valid  (_fabricMux_io_ports_1_readDataAddr_valid),
    .io_source_1_readDataAddr_bits   (_fabricMux_io_ports_1_readDataAddr_bits),
    .io_source_1_readData_valid      (_dtcmArbiter_io_source_1_readData_valid),
    .io_source_1_readData_bits       (_dtcmArbiter_io_source_1_readData_bits),
    .io_source_1_writeDataAddr_valid (_fabricMux_io_ports_1_writeDataAddr_valid),
    .io_source_1_writeDataAddr_bits  (_fabricMux_io_ports_1_writeDataAddr_bits),
    .io_source_1_writeDataBits       (_fabricMux_io_ports_1_writeDataBits),
    .io_source_1_writeDataStrb       (_fabricMux_io_ports_1_writeDataStrb),
    .io_fabricBusy_1                 (_dtcmArbiter_io_fabricBusy_1),
    .io_port_readDataAddr_valid      (_dtcmArbiter_io_port_readDataAddr_valid),
    .io_port_readDataAddr_bits       (_dtcmArbiter_io_port_readDataAddr_bits),
    .io_port_readData_valid          (_dtcmWrapper_io_fabric_readData_valid),
    .io_port_readData_bits           (_dtcmWrapper_io_fabric_readData_bits),
    .io_port_writeDataAddr_valid     (_dtcmArbiter_io_port_writeDataAddr_valid),
    .io_port_writeDataAddr_bits      (_dtcmArbiter_io_port_writeDataAddr_bits),
    .io_port_writeDataBits           (_dtcmArbiter_io_port_writeDataBits),
    .io_port_writeDataStrb           (_dtcmArbiter_io_port_writeDataStrb)
  );
  FabricMux fabricMux (
    .clock                          (_rst_sync_clk_o),
    .reset                          (_global_reset_T_2),
    .io_source_readDataAddr_valid   (_axiSlave_io_fabric_readDataAddr_valid),
    .io_source_readDataAddr_bits    (_axiSlave_io_fabric_readDataAddr_bits),
    .io_source_readData_valid       (_fabricMux_io_source_readData_valid),
    .io_source_readData_bits        (_fabricMux_io_source_readData_bits),
    .io_source_writeDataAddr_valid  (_axiSlave_io_fabric_writeDataAddr_valid),
    .io_source_writeDataAddr_bits   (_axiSlave_io_fabric_writeDataAddr_bits),
    .io_source_writeDataBits        (_axiSlave_io_fabric_writeDataBits),
    .io_source_writeDataStrb        (_axiSlave_io_fabric_writeDataStrb),
    .io_source_writeResp            (_fabricMux_io_source_writeResp),
    .io_fabricBusy                  (_fabricMux_io_fabricBusy),
    .io_ports_0_readDataAddr_valid  (_fabricMux_io_ports_0_readDataAddr_valid),
    .io_ports_0_readDataAddr_bits   (_fabricMux_io_ports_0_readDataAddr_bits),
    .io_ports_0_readData_valid      (_itcmArbiter_io_source_1_readData_valid),
    .io_ports_0_readData_bits       (_itcmArbiter_io_source_1_readData_bits),
    .io_ports_0_writeDataAddr_valid (_fabricMux_io_ports_0_writeDataAddr_valid),
    .io_ports_0_writeDataAddr_bits  (_fabricMux_io_ports_0_writeDataAddr_bits),
    .io_ports_0_writeDataBits       (_fabricMux_io_ports_0_writeDataBits),
    .io_ports_0_writeDataStrb       (_fabricMux_io_ports_0_writeDataStrb),
    .io_ports_1_readDataAddr_valid  (_fabricMux_io_ports_1_readDataAddr_valid),
    .io_ports_1_readDataAddr_bits   (_fabricMux_io_ports_1_readDataAddr_bits),
    .io_ports_1_readData_valid      (_dtcmArbiter_io_source_1_readData_valid),
    .io_ports_1_readData_bits       (_dtcmArbiter_io_source_1_readData_bits),
    .io_ports_1_writeDataAddr_valid (_fabricMux_io_ports_1_writeDataAddr_valid),
    .io_ports_1_writeDataAddr_bits  (_fabricMux_io_ports_1_writeDataAddr_bits),
    .io_ports_1_writeDataBits       (_fabricMux_io_ports_1_writeDataBits),
    .io_ports_1_writeDataStrb       (_fabricMux_io_ports_1_writeDataStrb),
    .io_ports_2_readDataAddr_bits   (_fabricMux_io_ports_2_readDataAddr_bits),
    .io_ports_2_readData_valid      (_csr_io_fabric_readData_valid),
    .io_ports_2_readData_bits       (_csr_io_fabric_readData_bits),
    .io_ports_2_writeDataAddr_valid (_fabricMux_io_ports_2_writeDataAddr_valid),
    .io_ports_2_writeDataAddr_bits  (_fabricMux_io_ports_2_writeDataAddr_bits),
    .io_ports_2_writeDataBits       (_fabricMux_io_ports_2_writeDataBits),
    .io_ports_2_writeResp           (_csr_io_fabric_writeResp),
    .io_periBusy_0                  (_itcmArbiter_io_fabricBusy_1),
    .io_periBusy_1                  (_dtcmArbiter_io_fabricBusy_1)
  );
  AxiSlave axiSlave (
    .clock                         (_rst_sync_clk_o),
    .reset                         (_global_reset_T_2),
    .io_axi_write_addr_ready       (_axiSlave_io_axi_write_addr_ready),
    .io_axi_write_addr_valid       (io_axi_slave_write_addr_valid & axiSlaveEnable),
    .io_axi_write_addr_bits_addr   (io_axi_slave_write_addr_bits_addr),
    .io_axi_write_addr_bits_prot   (io_axi_slave_write_addr_bits_prot),
    .io_axi_write_addr_bits_id     (io_axi_slave_write_addr_bits_id),
    .io_axi_write_addr_bits_len    (io_axi_slave_write_addr_bits_len),
    .io_axi_write_addr_bits_size   (io_axi_slave_write_addr_bits_size),
    .io_axi_write_addr_bits_burst  (io_axi_slave_write_addr_bits_burst),
    .io_axi_write_addr_bits_lock   (io_axi_slave_write_addr_bits_lock),
    .io_axi_write_addr_bits_cache  (io_axi_slave_write_addr_bits_cache),
    .io_axi_write_addr_bits_qos    (io_axi_slave_write_addr_bits_qos),
    .io_axi_write_addr_bits_region (io_axi_slave_write_addr_bits_region),
    .io_axi_write_data_ready       (_axiSlave_io_axi_write_data_ready),
    .io_axi_write_data_valid       (io_axi_slave_write_data_valid & axiSlaveEnable),
    .io_axi_write_data_bits_data   (io_axi_slave_write_data_bits_data),
    .io_axi_write_data_bits_last   (io_axi_slave_write_data_bits_last),
    .io_axi_write_data_bits_strb   (io_axi_slave_write_data_bits_strb),
    .io_axi_write_resp_ready       (io_axi_slave_write_resp_ready & axiSlaveEnable),
    .io_axi_write_resp_valid       (_axiSlave_io_axi_write_resp_valid),
    .io_axi_write_resp_bits_id     (io_axi_slave_write_resp_bits_id),
    .io_axi_write_resp_bits_resp   (io_axi_slave_write_resp_bits_resp),
    .io_axi_read_addr_ready        (_axiSlave_io_axi_read_addr_ready),
    .io_axi_read_addr_valid        (io_axi_slave_read_addr_valid & axiSlaveEnable),
    .io_axi_read_addr_bits_addr    (io_axi_slave_read_addr_bits_addr),
    .io_axi_read_addr_bits_prot    (io_axi_slave_read_addr_bits_prot),
    .io_axi_read_addr_bits_id      (io_axi_slave_read_addr_bits_id),
    .io_axi_read_addr_bits_len     (io_axi_slave_read_addr_bits_len),
    .io_axi_read_addr_bits_size    (io_axi_slave_read_addr_bits_size),
    .io_axi_read_addr_bits_burst   (io_axi_slave_read_addr_bits_burst),
    .io_axi_read_addr_bits_lock    (io_axi_slave_read_addr_bits_lock),
    .io_axi_read_addr_bits_cache   (io_axi_slave_read_addr_bits_cache),
    .io_axi_read_addr_bits_qos     (io_axi_slave_read_addr_bits_qos),
    .io_axi_read_addr_bits_region  (io_axi_slave_read_addr_bits_region),
    .io_axi_read_data_ready        (io_axi_slave_read_data_ready & axiSlaveEnable),
    .io_axi_read_data_valid        (_axiSlave_io_axi_read_data_valid),
    .io_axi_read_data_bits_data    (io_axi_slave_read_data_bits_data),
    .io_axi_read_data_bits_id      (io_axi_slave_read_data_bits_id),
    .io_axi_read_data_bits_resp    (io_axi_slave_read_data_bits_resp),
    .io_axi_read_data_bits_last    (io_axi_slave_read_data_bits_last),
    .io_fabric_readDataAddr_valid  (_axiSlave_io_fabric_readDataAddr_valid),
    .io_fabric_readDataAddr_bits   (_axiSlave_io_fabric_readDataAddr_bits),
    .io_fabric_readData_valid      (_fabricMux_io_source_readData_valid),
    .io_fabric_readData_bits       (_fabricMux_io_source_readData_bits),
    .io_fabric_writeDataAddr_valid (_axiSlave_io_fabric_writeDataAddr_valid),
    .io_fabric_writeDataAddr_bits  (_axiSlave_io_fabric_writeDataAddr_bits),
    .io_fabric_writeDataBits       (_axiSlave_io_fabric_writeDataBits),
    .io_fabric_writeDataStrb       (_axiSlave_io_fabric_writeDataStrb),
    .io_fabric_writeResp           (_fabricMux_io_source_writeResp),
    .io_periBusy                   (_fabricMux_io_fabricBusy)
  );
  DBus2AxiV2 ebus2axi (
    .clock                       (_rst_sync_clk_o),
    .reset                       (_global_reset_T_2),
    .io_dbus_valid               (_core_io_ebus_dbus_valid),
    .io_dbus_ready               (_ebus2axi_io_dbus_ready),
    .io_dbus_write               (_core_io_ebus_dbus_write),
    .io_dbus_pc                  (_core_io_ebus_dbus_pc),
    .io_dbus_addr                (_core_io_ebus_dbus_addr),
    .io_dbus_size                (_core_io_ebus_dbus_size),
    .io_dbus_wdata               (_core_io_ebus_dbus_wdata),
    .io_dbus_wmask               (_core_io_ebus_dbus_wmask),
    .io_dbus_rdata               (_ebus2axi_io_dbus_rdata),
    .io_axi_write_addr_ready     (io_axi_master_write_addr_ready),
    .io_axi_write_addr_valid     (io_axi_master_write_addr_valid),
    .io_axi_write_addr_bits_addr (io_axi_master_write_addr_bits_addr),
    .io_axi_write_addr_bits_size (io_axi_master_write_addr_bits_size),
    .io_axi_write_data_ready     (io_axi_master_write_data_ready),
    .io_axi_write_data_valid     (io_axi_master_write_data_valid),
    .io_axi_write_data_bits_data (io_axi_master_write_data_bits_data),
    .io_axi_write_data_bits_last (io_axi_master_write_data_bits_last),
    .io_axi_write_data_bits_strb (io_axi_master_write_data_bits_strb),
    .io_axi_write_resp_ready     (io_axi_master_write_resp_ready),
    .io_axi_write_resp_valid     (io_axi_master_write_resp_valid),
    .io_axi_write_resp_bits_resp (io_axi_master_write_resp_bits_resp),
    .io_axi_read_addr_ready      (io_axi_master_read_addr_ready),
    .io_axi_read_addr_valid      (io_axi_master_read_addr_valid),
    .io_axi_read_addr_bits_addr  (io_axi_master_read_addr_bits_addr),
    .io_axi_read_addr_bits_size  (io_axi_master_read_addr_bits_size),
    .io_axi_read_data_ready      (io_axi_master_read_data_ready),
    .io_axi_read_data_valid      (io_axi_master_read_data_valid),
    .io_axi_read_data_bits_data  (io_axi_master_read_data_bits_data),
    .io_axi_read_data_bits_resp  (io_axi_master_read_data_bits_resp),
    .io_fault_valid              (_ebus2axi_io_fault_valid),
    .io_fault_bits_write         (_ebus2axi_io_fault_bits_write),
    .io_fault_bits_addr          (_ebus2axi_io_fault_bits_addr),
    .io_fault_bits_epc           (_ebus2axi_io_fault_bits_epc)
  );
  assign io_axi_slave_write_addr_ready =
    _axiSlave_io_axi_write_addr_ready & axiSlaveEnable;
  assign io_axi_slave_write_data_ready =
    _axiSlave_io_axi_write_data_ready & axiSlaveEnable;
  assign io_axi_slave_write_resp_valid =
    _axiSlave_io_axi_write_resp_valid & axiSlaveEnable;
  assign io_axi_slave_read_addr_ready = _axiSlave_io_axi_read_addr_ready & axiSlaveEnable;
  assign io_axi_slave_read_data_valid = _axiSlave_io_axi_read_data_valid & axiSlaveEnable;
  assign io_axi_master_write_addr_bits_prot = 3'h2;
  assign io_axi_master_write_addr_bits_id = 6'h0;
  assign io_axi_master_write_addr_bits_len = 8'h0;
  assign io_axi_master_write_addr_bits_burst = 2'h1;
  assign io_axi_master_write_addr_bits_lock = 1'h0;
  assign io_axi_master_write_addr_bits_cache = 4'h0;
  assign io_axi_master_write_addr_bits_qos = 4'h0;
  assign io_axi_master_write_addr_bits_region = 4'h0;
  assign io_axi_master_read_addr_bits_prot = 3'h2;
  assign io_axi_master_read_addr_bits_id = 6'h0;
  assign io_axi_master_read_addr_bits_len = 8'h0;
  assign io_axi_master_read_addr_bits_burst = 2'h1;
  assign io_axi_master_read_addr_bits_lock = 1'h0;
  assign io_axi_master_read_addr_bits_cache = 4'h0;
  assign io_axi_master_read_addr_bits_qos = 4'h0;
  assign io_axi_master_read_addr_bits_region = 4'h0;
  assign io_halted = _core_io_halted;
  assign io_fault = _core_io_fault;
  assign io_wfi = _core_io_wfi;
  assign io_debug_rb_inst_0_bits_inst = 32'h0;
  assign io_debug_rb_inst_0_bits_data = 128'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_0_valid = 1'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_0_bits_data = 128'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_0_bits_idx = 5'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_1_valid = 1'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_1_bits_data = 128'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_1_bits_idx = 5'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_2_valid = 1'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_2_bits_data = 128'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_2_bits_idx = 5'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_3_valid = 1'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_3_bits_data = 128'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_3_bits_idx = 5'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_4_valid = 1'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_4_bits_data = 128'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_4_bits_idx = 5'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_5_valid = 1'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_5_bits_data = 128'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_5_bits_idx = 5'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_6_valid = 1'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_6_bits_data = 128'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_6_bits_idx = 5'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_7_valid = 1'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_7_bits_data = 128'h0;
  assign io_debug_rb_inst_0_bits_vecWrites_7_bits_idx = 5'h0;
  assign io_debug_rb_inst_1_bits_inst = 32'h0;
  assign io_debug_rb_inst_1_bits_data = 128'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_0_valid = 1'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_0_bits_data = 128'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_0_bits_idx = 5'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_1_valid = 1'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_1_bits_data = 128'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_1_bits_idx = 5'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_2_valid = 1'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_2_bits_data = 128'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_2_bits_idx = 5'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_3_valid = 1'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_3_bits_data = 128'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_3_bits_idx = 5'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_4_valid = 1'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_4_bits_data = 128'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_4_bits_idx = 5'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_5_valid = 1'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_5_bits_data = 128'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_5_bits_idx = 5'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_6_valid = 1'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_6_bits_data = 128'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_6_bits_idx = 5'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_7_valid = 1'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_7_bits_data = 128'h0;
  assign io_debug_rb_inst_1_bits_vecWrites_7_bits_idx = 5'h0;
  assign io_debug_rb_inst_2_bits_inst = 32'h0;
  assign io_debug_rb_inst_2_bits_data = 128'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_0_valid = 1'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_0_bits_data = 128'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_0_bits_idx = 5'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_1_valid = 1'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_1_bits_data = 128'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_1_bits_idx = 5'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_2_valid = 1'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_2_bits_data = 128'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_2_bits_idx = 5'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_3_valid = 1'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_3_bits_data = 128'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_3_bits_idx = 5'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_4_valid = 1'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_4_bits_data = 128'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_4_bits_idx = 5'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_5_valid = 1'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_5_bits_data = 128'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_5_bits_idx = 5'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_6_valid = 1'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_6_bits_data = 128'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_6_bits_idx = 5'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_7_valid = 1'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_7_bits_data = 128'h0;
  assign io_debug_rb_inst_2_bits_vecWrites_7_bits_idx = 5'h0;
  assign io_debug_rb_inst_3_bits_inst = 32'h0;
  assign io_debug_rb_inst_3_bits_data = 128'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_0_valid = 1'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_0_bits_data = 128'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_0_bits_idx = 5'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_1_valid = 1'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_1_bits_data = 128'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_1_bits_idx = 5'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_2_valid = 1'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_2_bits_data = 128'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_2_bits_idx = 5'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_3_valid = 1'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_3_bits_data = 128'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_3_bits_idx = 5'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_4_valid = 1'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_4_bits_data = 128'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_4_bits_idx = 5'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_5_valid = 1'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_5_bits_data = 128'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_5_bits_idx = 5'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_6_valid = 1'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_6_bits_data = 128'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_6_bits_idx = 5'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_7_valid = 1'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_7_bits_data = 128'h0;
  assign io_debug_rb_inst_3_bits_vecWrites_7_bits_idx = 5'h0;
  assign io_debug_rb_inst_4_bits_inst = 32'h0;
  assign io_debug_rb_inst_4_bits_data = 128'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_0_valid = 1'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_0_bits_data = 128'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_0_bits_idx = 5'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_1_valid = 1'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_1_bits_data = 128'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_1_bits_idx = 5'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_2_valid = 1'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_2_bits_data = 128'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_2_bits_idx = 5'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_3_valid = 1'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_3_bits_data = 128'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_3_bits_idx = 5'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_4_valid = 1'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_4_bits_data = 128'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_4_bits_idx = 5'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_5_valid = 1'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_5_bits_data = 128'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_5_bits_idx = 5'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_6_valid = 1'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_6_bits_data = 128'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_6_bits_idx = 5'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_7_valid = 1'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_7_bits_data = 128'h0;
  assign io_debug_rb_inst_4_bits_vecWrites_7_bits_idx = 5'h0;
  assign io_debug_rb_inst_5_bits_inst = 32'h0;
  assign io_debug_rb_inst_5_bits_data = 128'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_0_valid = 1'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_0_bits_data = 128'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_0_bits_idx = 5'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_1_valid = 1'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_1_bits_data = 128'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_1_bits_idx = 5'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_2_valid = 1'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_2_bits_data = 128'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_2_bits_idx = 5'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_3_valid = 1'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_3_bits_data = 128'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_3_bits_idx = 5'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_4_valid = 1'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_4_bits_data = 128'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_4_bits_idx = 5'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_5_valid = 1'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_5_bits_data = 128'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_5_bits_idx = 5'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_6_valid = 1'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_6_bits_data = 128'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_6_bits_idx = 5'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_7_valid = 1'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_7_bits_data = 128'h0;
  assign io_debug_rb_inst_5_bits_vecWrites_7_bits_idx = 5'h0;
  assign io_debug_rb_inst_6_bits_inst = 32'h0;
  assign io_debug_rb_inst_6_bits_data = 128'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_0_valid = 1'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_0_bits_data = 128'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_0_bits_idx = 5'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_1_valid = 1'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_1_bits_data = 128'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_1_bits_idx = 5'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_2_valid = 1'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_2_bits_data = 128'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_2_bits_idx = 5'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_3_valid = 1'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_3_bits_data = 128'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_3_bits_idx = 5'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_4_valid = 1'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_4_bits_data = 128'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_4_bits_idx = 5'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_5_valid = 1'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_5_bits_data = 128'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_5_bits_idx = 5'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_6_valid = 1'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_6_bits_data = 128'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_6_bits_idx = 5'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_7_valid = 1'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_7_bits_data = 128'h0;
  assign io_debug_rb_inst_6_bits_vecWrites_7_bits_idx = 5'h0;
  assign io_debug_rb_inst_7_bits_inst = 32'h0;
  assign io_debug_rb_inst_7_bits_data = 128'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_0_valid = 1'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_0_bits_data = 128'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_0_bits_idx = 5'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_1_valid = 1'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_1_bits_data = 128'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_1_bits_idx = 5'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_2_valid = 1'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_2_bits_data = 128'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_2_bits_idx = 5'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_3_valid = 1'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_3_bits_data = 128'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_3_bits_idx = 5'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_4_valid = 1'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_4_bits_data = 128'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_4_bits_idx = 5'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_5_valid = 1'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_5_bits_data = 128'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_5_bits_idx = 5'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_6_valid = 1'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_6_bits_data = 128'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_6_bits_idx = 5'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_7_valid = 1'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_7_bits_data = 128'h0;
  assign io_debug_rb_inst_7_bits_vecWrites_7_bits_idx = 5'h0;
endmodule
