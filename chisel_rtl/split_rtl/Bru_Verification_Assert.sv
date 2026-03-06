module Bru_Verification_Assert(
  input io_rs1_valid,
        stateReg_valid,
        _ignore_WIRE_5,
        _ignore_WIRE_4,
        _ignore_WIRE_7,
        _ignore_WIRE_6,
        _ignore_WIRE_1,
        _ignore_WIRE_0,
        _ignore_WIRE_3,
        _ignore_WIRE_2,
        reset,
        io_rs2_valid,
        clock
);

  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if (~reset
          & {~(stateReg_valid & ~io_rs1_valid),
             _ignore_WIRE_7,
             _ignore_WIRE_6,
             _ignore_WIRE_5,
             _ignore_WIRE_4,
             _ignore_WIRE_3,
             _ignore_WIRE_2,
             _ignore_WIRE_1,
             _ignore_WIRE_0} == 9'h0) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at Bru.scala:289\n");
        if (`STOP_COND_)
          $fatal;
      end
      if (~reset
          & {~(stateReg_valid & ~io_rs2_valid),
             _ignore_WIRE_7,
             _ignore_WIRE_6,
             _ignore_WIRE_5,
             _ignore_WIRE_4,
             _ignore_WIRE_3,
             _ignore_WIRE_2,
             _ignore_WIRE_1,
             _ignore_WIRE_0} == 9'h0) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at Bru.scala:290\n");
        if (`STOP_COND_)
          $fatal;
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
endmodule
