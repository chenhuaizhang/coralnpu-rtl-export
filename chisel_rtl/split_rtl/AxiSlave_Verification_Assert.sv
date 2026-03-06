module AxiSlave_Verification_Assert(
  input readIssued_valid,
        reset,
        readDataQueue_io_enq_ready,
        _GEN,
        _GEN_0,
        _GEN_1,
        _GEN_2,
        clock
);

  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if (~reset & ~(~readIssued_valid | readDataQueue_io_enq_ready)) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at AxiSlave.scala:130\n");
        if (`STOP_COND_)
          $fatal;
      end
      if (~reset & {1'h0, _GEN_1} + {1'h0, _GEN} + {1'h0, _GEN_0} > {1'h0, _GEN_2}) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at Library.scala:234\n");
        if (`STOP_COND_)
          $fatal;
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
endmodule
