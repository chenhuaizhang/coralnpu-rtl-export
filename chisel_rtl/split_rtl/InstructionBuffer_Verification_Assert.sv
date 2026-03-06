module InstructionBuffer_Verification_Assert(
  input _GEN,
        _GEN_0,
        _GEN_1,
        _GEN_2,
        reset,
        clock
);

  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if (~reset & (~_GEN & _GEN_0 | ~_GEN_0 & _GEN_1 | ~_GEN_1 & _GEN_2)) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed: OneHotInOrder - Instructions not dispatched in order.\n");
        if (`STOP_COND_)
          $fatal;
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
endmodule
