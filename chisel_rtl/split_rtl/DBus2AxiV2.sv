module DBus2AxiV2(
  input          clock,
                 reset,
                 io_dbus_valid,
  output         io_dbus_ready,
  input          io_dbus_write,
  input  [31:0]  io_dbus_pc,
                 io_dbus_addr,
  input  [4:0]   io_dbus_size,
  input  [127:0] io_dbus_wdata,
  input  [15:0]  io_dbus_wmask,
  output [127:0] io_dbus_rdata,
  input          io_axi_write_addr_ready,
  output         io_axi_write_addr_valid,
  output [31:0]  io_axi_write_addr_bits_addr,
  output [2:0]   io_axi_write_addr_bits_size,
  input          io_axi_write_data_ready,
  output         io_axi_write_data_valid,
  output [127:0] io_axi_write_data_bits_data,
  output         io_axi_write_data_bits_last,
  output [15:0]  io_axi_write_data_bits_strb,
  output         io_axi_write_resp_ready,
  input          io_axi_write_resp_valid,
  input  [1:0]   io_axi_write_resp_bits_resp,
  input          io_axi_read_addr_ready,
  output         io_axi_read_addr_valid,
  output [31:0]  io_axi_read_addr_bits_addr,
  output [2:0]   io_axi_read_addr_bits_size,
  output         io_axi_read_data_ready,
  input          io_axi_read_data_valid,
  input  [127:0] io_axi_read_data_bits_data,
  input  [1:0]   io_axi_read_data_bits_resp,
  output         io_fault_valid,
                 io_fault_bits_write,
  output [31:0]  io_fault_bits_addr,
                 io_fault_bits_epc
);

  wire         _wdataQueue_io_enq_ready;
  reg          waddrFired;
  wire         io_axi_write_addr_valid_0 = ~waddrFired & io_dbus_valid & io_dbus_write;
  reg          wdataFired;
  wire         wdataQueue_io_enq_valid = ~wdataFired & io_dbus_valid & io_dbus_write;
  reg          wrespReceived;
  wire         io_axi_write_resp_ready_0 = ~wrespReceived & io_dbus_valid & io_dbus_write;
  wire         _waddrFired_T = io_axi_write_addr_ready & io_axi_write_addr_valid_0;
  wire         _wdataFired_T = _wdataQueue_io_enq_ready & wdataQueue_io_enq_valid;
  wire         _wrespReceived_T = io_axi_write_resp_ready_0 & io_axi_write_resp_valid;
  wire         writeFinished =
    (_waddrFired_T | waddrFired) & (_wdataFired_T | wdataFired)
    & (_wrespReceived_T | wrespReceived);
  reg          raddrFired;
  wire         io_axi_read_addr_valid_0 = ~raddrFired & io_dbus_valid & ~io_dbus_write;
  reg          rdataReceived_valid;
  reg  [127:0] rdataReceived_bits;
  wire         io_axi_read_data_ready_0 =
    ~rdataReceived_valid & io_dbus_valid & ~io_dbus_write;
  wire         _raddrFired_T = io_axi_read_addr_ready & io_axi_read_addr_valid_0;
  wire         _readNext_T = io_axi_read_data_ready_0 & io_axi_read_data_valid;
  wire         readFinished =
    (_raddrFired_T | raddrFired) & (_readNext_T | rdataReceived_valid);
  reg  [127:0] readNext;
  always @(posedge clock or posedge reset) begin
    if (reset) begin
      waddrFired <= 1'h0;
      wdataFired <= 1'h0;
      wrespReceived <= 1'h0;
      raddrFired <= 1'h0;
      rdataReceived_valid <= 1'h0;
      rdataReceived_bits <= 128'h0;
      readNext <= 128'h0;
    end
    else begin
      waddrFired <= ~writeFinished & (_waddrFired_T | waddrFired);
      wdataFired <= ~writeFinished & (_wdataFired_T | wdataFired);
      wrespReceived <= ~writeFinished & (_wrespReceived_T | wrespReceived);
      raddrFired <= ~readFinished & (_raddrFired_T | raddrFired);
      rdataReceived_valid <= ~readFinished & (_readNext_T | rdataReceived_valid);
      if (readFinished) begin
        rdataReceived_bits <= 128'h0;
        readNext <= _readNext_T ? io_axi_read_data_bits_data : rdataReceived_bits;
      end
      else if (_readNext_T)
        rdataReceived_bits <= io_axi_read_data_bits_data;
    end
  end // always @(posedge, posedge)
  `ifdef ENABLE_INITIAL_REG_
    `ifdef FIRRTL_BEFORE_INITIAL
      `FIRRTL_BEFORE_INITIAL
    `endif // FIRRTL_BEFORE_INITIAL
    logic [31:0] _RANDOM[0:8];
    initial begin
      `ifdef INIT_RANDOM_PROLOG_
        `INIT_RANDOM_PROLOG_
      `endif // INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_REG_INIT
        for (logic [3:0] i = 4'h0; i < 4'h9; i += 4'h1) begin
          _RANDOM[i] = `RANDOM;
        end
        waddrFired = _RANDOM[4'h0][0];
        wdataFired = _RANDOM[4'h0][1];
        wrespReceived = _RANDOM[4'h0][2];
        raddrFired = _RANDOM[4'h0][3];
        rdataReceived_valid = _RANDOM[4'h0][4];
        rdataReceived_bits =
          {_RANDOM[4'h0][31:5],
           _RANDOM[4'h1],
           _RANDOM[4'h2],
           _RANDOM[4'h3],
           _RANDOM[4'h4][4:0]};
        readNext =
          {_RANDOM[4'h4][31:5],
           _RANDOM[4'h5],
           _RANDOM[4'h6],
           _RANDOM[4'h7],
           _RANDOM[4'h8][4:0]};
      `endif // RANDOMIZE_REG_INIT
      if (reset) begin
        waddrFired = 1'h0;
        wdataFired = 1'h0;
        wrespReceived = 1'h0;
        raddrFired = 1'h0;
        rdataReceived_valid = 1'h0;
        rdataReceived_bits = 128'h0;
        readNext = 128'h0;
      end
    end // initial
    `ifdef FIRRTL_AFTER_INITIAL
      `FIRRTL_AFTER_INITIAL
    `endif // FIRRTL_AFTER_INITIAL
  `endif // ENABLE_INITIAL_REG_
  Queue2_AxiWriteData wdataQueue (
    .clock            (clock),
    .reset            (reset),
    .io_enq_ready     (_wdataQueue_io_enq_ready),
    .io_enq_valid     (wdataQueue_io_enq_valid),
    .io_enq_bits_data (io_dbus_wdata),
    .io_enq_bits_strb (io_dbus_wmask),
    .io_deq_ready     (io_axi_write_data_ready),
    .io_deq_valid     (io_axi_write_data_valid),
    .io_deq_bits_data (io_axi_write_data_bits_data),
    .io_deq_bits_last (io_axi_write_data_bits_last),
    .io_deq_bits_strb (io_axi_write_data_bits_strb)
  );
  assign io_dbus_ready = io_dbus_write ? writeFinished : readFinished;
  assign io_dbus_rdata = readNext;
  assign io_axi_write_addr_valid = io_axi_write_addr_valid_0;
  assign io_axi_write_addr_bits_addr = io_dbus_addr;
  assign io_axi_write_addr_bits_size =
    io_dbus_size[0]
      ? 3'h0
      : io_dbus_size[1]
          ? 3'h1
          : io_dbus_size[2] ? 3'h2 : io_dbus_size[3] ? 3'h3 : {2'h2, ~(io_dbus_size[4])};
  assign io_axi_write_resp_ready = io_axi_write_resp_ready_0;
  assign io_axi_read_addr_valid = io_axi_read_addr_valid_0;
  assign io_axi_read_addr_bits_addr = io_dbus_addr;
  assign io_axi_read_addr_bits_size =
    io_dbus_size[0]
      ? 3'h0
      : io_dbus_size[1]
          ? 3'h1
          : io_dbus_size[2] ? 3'h2 : io_dbus_size[3] ? 3'h3 : {2'h2, ~(io_dbus_size[4])};
  assign io_axi_read_data_ready = io_axi_read_data_ready_0;
  assign io_fault_valid =
    io_dbus_valid
    & (io_dbus_write
         ? io_axi_write_resp_valid & (|io_axi_write_resp_bits_resp)
         : io_axi_read_data_valid & (|io_axi_read_data_bits_resp));
  assign io_fault_bits_write = io_dbus_write;
  assign io_fault_bits_addr = io_dbus_addr;
  assign io_fault_bits_epc = io_dbus_pc;
endmodule
