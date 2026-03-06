module FRegfile_Verification_Assert(
  input reset,
        scoreboard_error,
        clock
);

  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if (~reset & scoreboard_error) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at FRegfile.scala:47\n");
        if (`STOP_COND_)
          $fatal;
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
endmodule
