module SRAM(
  input          clock,
                 reset,
                 io_fabric_readDataAddr_valid,
  input  [31:0]  io_fabric_readDataAddr_bits,
  output         io_fabric_readData_valid,
  output [127:0] io_fabric_readData_bits,
  input          io_fabric_writeDataAddr_valid,
  input  [31:0]  io_fabric_writeDataAddr_bits,
  input  [127:0] io_fabric_writeDataBits,
  input  [15:0]  io_fabric_writeDataStrb,
  output [8:0]   io_sram_address,
  output         io_sram_enable,
                 io_sram_isWrite,
  input  [7:0]   io_sram_readData_0,
                 io_sram_readData_1,
                 io_sram_readData_2,
                 io_sram_readData_3,
                 io_sram_readData_4,
                 io_sram_readData_5,
                 io_sram_readData_6,
                 io_sram_readData_7,
                 io_sram_readData_8,
                 io_sram_readData_9,
                 io_sram_readData_10,
                 io_sram_readData_11,
                 io_sram_readData_12,
                 io_sram_readData_13,
                 io_sram_readData_14,
                 io_sram_readData_15,
  output [7:0]   io_sram_writeData_0,
                 io_sram_writeData_1,
                 io_sram_writeData_2,
                 io_sram_writeData_3,
                 io_sram_writeData_4,
                 io_sram_writeData_5,
                 io_sram_writeData_6,
                 io_sram_writeData_7,
                 io_sram_writeData_8,
                 io_sram_writeData_9,
                 io_sram_writeData_10,
                 io_sram_writeData_11,
                 io_sram_writeData_12,
                 io_sram_writeData_13,
                 io_sram_writeData_14,
                 io_sram_writeData_15,
  output         io_sram_mask_0,
                 io_sram_mask_1,
                 io_sram_mask_2,
                 io_sram_mask_3,
                 io_sram_mask_4,
                 io_sram_mask_5,
                 io_sram_mask_6,
                 io_sram_mask_7,
                 io_sram_mask_8,
                 io_sram_mask_9,
                 io_sram_mask_10,
                 io_sram_mask_11,
                 io_sram_mask_12,
                 io_sram_mask_13,
                 io_sram_mask_14,
                 io_sram_mask_15
);

  reg readIssued;
  always @(posedge clock or posedge reset) begin
    if (reset)
      readIssued <= 1'h0;
    else
      readIssued <= io_fabric_readDataAddr_valid & ~io_fabric_writeDataAddr_valid;
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
        readIssued = _RANDOM[/*Zero width*/ 1'b0][0];
      `endif // RANDOMIZE_REG_INIT
      if (reset)
        readIssued = 1'h0;
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  assign io_fabric_readData_valid = readIssued;
  assign io_fabric_readData_bits =
    readIssued
      ? {io_sram_readData_0,
         io_sram_readData_1,
         io_sram_readData_2,
         io_sram_readData_3,
         io_sram_readData_4,
         io_sram_readData_5,
         io_sram_readData_6,
         io_sram_readData_7,
         io_sram_readData_8,
         io_sram_readData_9,
         io_sram_readData_10,
         io_sram_readData_11,
         io_sram_readData_12,
         io_sram_readData_13,
         io_sram_readData_14,
         io_sram_readData_15}
      : 128'h0;
  assign io_sram_address =
    (io_fabric_writeDataAddr_valid ? io_fabric_writeDataAddr_bits[12:4] : 9'h0)
    | (io_fabric_readDataAddr_valid ? io_fabric_readDataAddr_bits[12:4] : 9'h0);
  assign io_sram_enable = io_fabric_writeDataAddr_valid | io_fabric_readDataAddr_valid;
  assign io_sram_isWrite = io_fabric_writeDataAddr_valid;
  assign io_sram_writeData_0 =
    io_fabric_writeDataAddr_valid ? io_fabric_writeDataBits[7:0] : 8'h0;
  assign io_sram_writeData_1 =
    io_fabric_writeDataAddr_valid ? io_fabric_writeDataBits[15:8] : 8'h0;
  assign io_sram_writeData_2 =
    io_fabric_writeDataAddr_valid ? io_fabric_writeDataBits[23:16] : 8'h0;
  assign io_sram_writeData_3 =
    io_fabric_writeDataAddr_valid ? io_fabric_writeDataBits[31:24] : 8'h0;
  assign io_sram_writeData_4 =
    io_fabric_writeDataAddr_valid ? io_fabric_writeDataBits[39:32] : 8'h0;
  assign io_sram_writeData_5 =
    io_fabric_writeDataAddr_valid ? io_fabric_writeDataBits[47:40] : 8'h0;
  assign io_sram_writeData_6 =
    io_fabric_writeDataAddr_valid ? io_fabric_writeDataBits[55:48] : 8'h0;
  assign io_sram_writeData_7 =
    io_fabric_writeDataAddr_valid ? io_fabric_writeDataBits[63:56] : 8'h0;
  assign io_sram_writeData_8 =
    io_fabric_writeDataAddr_valid ? io_fabric_writeDataBits[71:64] : 8'h0;
  assign io_sram_writeData_9 =
    io_fabric_writeDataAddr_valid ? io_fabric_writeDataBits[79:72] : 8'h0;
  assign io_sram_writeData_10 =
    io_fabric_writeDataAddr_valid ? io_fabric_writeDataBits[87:80] : 8'h0;
  assign io_sram_writeData_11 =
    io_fabric_writeDataAddr_valid ? io_fabric_writeDataBits[95:88] : 8'h0;
  assign io_sram_writeData_12 =
    io_fabric_writeDataAddr_valid ? io_fabric_writeDataBits[103:96] : 8'h0;
  assign io_sram_writeData_13 =
    io_fabric_writeDataAddr_valid ? io_fabric_writeDataBits[111:104] : 8'h0;
  assign io_sram_writeData_14 =
    io_fabric_writeDataAddr_valid ? io_fabric_writeDataBits[119:112] : 8'h0;
  assign io_sram_writeData_15 =
    io_fabric_writeDataAddr_valid ? io_fabric_writeDataBits[127:120] : 8'h0;
  assign io_sram_mask_0 = ~io_fabric_writeDataAddr_valid | io_fabric_writeDataStrb[0];
  assign io_sram_mask_1 = ~io_fabric_writeDataAddr_valid | io_fabric_writeDataStrb[1];
  assign io_sram_mask_2 = ~io_fabric_writeDataAddr_valid | io_fabric_writeDataStrb[2];
  assign io_sram_mask_3 = ~io_fabric_writeDataAddr_valid | io_fabric_writeDataStrb[3];
  assign io_sram_mask_4 = ~io_fabric_writeDataAddr_valid | io_fabric_writeDataStrb[4];
  assign io_sram_mask_5 = ~io_fabric_writeDataAddr_valid | io_fabric_writeDataStrb[5];
  assign io_sram_mask_6 = ~io_fabric_writeDataAddr_valid | io_fabric_writeDataStrb[6];
  assign io_sram_mask_7 = ~io_fabric_writeDataAddr_valid | io_fabric_writeDataStrb[7];
  assign io_sram_mask_8 = ~io_fabric_writeDataAddr_valid | io_fabric_writeDataStrb[8];
  assign io_sram_mask_9 = ~io_fabric_writeDataAddr_valid | io_fabric_writeDataStrb[9];
  assign io_sram_mask_10 = ~io_fabric_writeDataAddr_valid | io_fabric_writeDataStrb[10];
  assign io_sram_mask_11 = ~io_fabric_writeDataAddr_valid | io_fabric_writeDataStrb[11];
  assign io_sram_mask_12 = ~io_fabric_writeDataAddr_valid | io_fabric_writeDataStrb[12];
  assign io_sram_mask_13 = ~io_fabric_writeDataAddr_valid | io_fabric_writeDataStrb[13];
  assign io_sram_mask_14 = ~io_fabric_writeDataAddr_valid | io_fabric_writeDataStrb[14];
  assign io_sram_mask_15 = ~io_fabric_writeDataAddr_valid | io_fabric_writeDataStrb[15];
endmodule
