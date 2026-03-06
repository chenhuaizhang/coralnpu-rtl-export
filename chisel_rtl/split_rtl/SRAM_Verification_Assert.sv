module SRAM_Verification_Assert(
  input io_fabric_writeDataAddr_valid,
        io_fabric_readDataAddr_valid,
        reset,
        _GEN,
        clock
);

  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if (~reset & {1'h0, io_fabric_writeDataAddr_valid}
          + {1'h0, io_fabric_readDataAddr_valid} > {1'h0, _GEN}) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at Library.scala:234\n");
        if (`STOP_COND_)
          $fatal;
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
endmodule
