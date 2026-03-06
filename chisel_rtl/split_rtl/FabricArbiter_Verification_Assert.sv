module FabricArbiter_Verification_Assert(
  input io_source_1_readDataAddr_valid,
        io_source_1_writeDataAddr_valid,
        io_source_0_readDataAddr_valid,
        io_source_0_writeDataAddr_valid,
        reset,
        clock
);

  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if (~reset
          & (io_source_0_readDataAddr_valid & io_source_0_writeDataAddr_valid
             | io_source_1_readDataAddr_valid & io_source_1_writeDataAddr_valid)) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at Fabric.scala:31\n");
        if (`STOP_COND_)
          $fatal;
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
endmodule
