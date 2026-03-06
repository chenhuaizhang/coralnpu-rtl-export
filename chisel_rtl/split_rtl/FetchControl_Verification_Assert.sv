module FetchControl_Verification_Assert(
  input predecode_firstJumpOH_2,
        predecode_firstJumpOH_3,
        predecode_firstJumpOH_0,
        predecode_firstJumpOH_1,
        reset,
        _GEN,
        clock
);

  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if (~reset
          & {1'h0, {1'h0, predecode_firstJumpOH_0} + {1'h0, predecode_firstJumpOH_1}}
          + {1'h0,
             {1'h0, predecode_firstJumpOH_2}
               + {1'h0, predecode_firstJumpOH_3}} > {2'h0, _GEN}) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at Library.scala:234\n");
        if (`STOP_COND_)
          $fatal;
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
endmodule
