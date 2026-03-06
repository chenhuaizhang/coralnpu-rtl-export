module CircularBufferMulti_2_Verification_Assert(
  input [3:0] io_nEnqueued,
              io_enqValid,
              io_deqReady,
  input       reset,
  input [3:0] _GEN,
  input       clock
);

  `ifndef SYNTHESIS
    wire [4:0] _GEN_0 = {1'h0, io_nEnqueued};
    wire [4:0] _GEN_1 = {1'h0, io_enqValid};
    always @(posedge clock) begin
      if (~reset & {1'h0, _GEN_0 + _GEN_1} - {2'h0, io_deqReady} > {2'h0, _GEN}) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at CircularBufferMulti.scala:43\n");
        if (`STOP_COND_)
          $fatal;
      end
      if (~reset & _GEN_1 > {1'h0, _GEN} - _GEN_0) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at CircularBufferMulti.scala:44\n");
        if (`STOP_COND_)
          $fatal;
      end
      if (~reset & io_deqReady > io_nEnqueued) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at CircularBufferMulti.scala:46\n");
        if (`STOP_COND_)
          $fatal;
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
endmodule
