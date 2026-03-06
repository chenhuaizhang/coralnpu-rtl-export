module RetirementBuffer_Verification_Assert(
  input _GEN,
        _GEN_0,
        _GEN_1,
        _GEN_2,
        reset,
        clock
);

  `ifndef SYNTHESIS
    wire seenFalseV_1 = ~_GEN_0 | ~_GEN;
    wire seenFalseV_2 = seenFalseV_1 | ~_GEN_1;
    always @(posedge clock) begin
      if (~reset
          & (seenFalseV_1 & _GEN | seenFalseV_2 & _GEN_1 | (seenFalseV_2 | ~_GEN_2)
             & _GEN_2)) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at RetirementBuffer.scala:85\n");
        if (`STOP_COND_)
          $fatal;
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
endmodule
