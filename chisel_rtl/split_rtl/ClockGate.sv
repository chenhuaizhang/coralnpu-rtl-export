module ClockGate(
  input         clk_i,
  input         enable,  // '1' passthrough, '0' disable.
  input         te,      // test enable
  output        clk_o
);

///////////////////////////
/// ClockGate Selection ///
///////////////////////////
`ifdef USE_TSMC12FFC
  // TSMC12FFC Specific ClockGate
  CKLNQD10BWP6T20P96CPDLVT u_cg(
    .TE(te),
    .E(enable),
    .CP(clk_i),
    .Q(clk_o)
  );
`elsif USE_GF22
  // GF22 Specific ClockGate
  SC7P5T_CKGPRELATNX8_CSC36L u_cg (
    .CLK(clk_i),
    .E(enable),
    .TE(te),
    .Z(clk_o)
  );

`elsif FPGA_XILINX
  // Xilinx FPGA Specific ClockGate
  BUFGCE #(
    .SIM_DEVICE("ULTRASCALE_PLUS")
  ) u_bufgce (
    .I (clk_i),
    .CE(enable | te),
    .O (clk_o)
  );
`else
  // Default: Verilator implementation
  logic en_latch /* verilator clock_enable */;
  always_latch begin
    if (!clk_i) begin
      en_latch = enable | te;
    end
  end
  assign clk_o = en_latch & clk_i;
`endif

endmodule  // ClockGate
