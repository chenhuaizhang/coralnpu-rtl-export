module Mlu_Verification_Assert(
  input io_rs1_0_valid,
        stage2Input_q_io_deq_valid,
        _GEN,
        reset,
        io_rs2_0_valid,
        io_rs1_1_valid,
        _GEN_0,
        io_rs2_1_valid,
        io_rs1_2_valid,
        _GEN_1,
        io_rs2_2_valid,
        io_rs1_3_valid,
        _GEN_2,
        io_rs2_3_valid,
        clock
);

  `ifndef SYNTHESIS
    wire _GEN_3 = stage2Input_q_io_deq_valid & _GEN;
    wire _GEN_4 = stage2Input_q_io_deq_valid & _GEN_0;
    wire _GEN_5 = stage2Input_q_io_deq_valid & _GEN_1;
    wire _GEN_6 = stage2Input_q_io_deq_valid & _GEN_2;
    always @(posedge clock) begin
      if (~reset & _GEN_3 & ~io_rs1_0_valid) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at Mlu.scala:122\n");
        if (`STOP_COND_)
          $fatal;
      end
      if (~reset & _GEN_3 & ~io_rs2_0_valid) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at Mlu.scala:123\n");
        if (`STOP_COND_)
          $fatal;
      end
      if (~reset & _GEN_4 & ~io_rs1_1_valid) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at Mlu.scala:122\n");
        if (`STOP_COND_)
          $fatal;
      end
      if (~reset & _GEN_4 & ~io_rs2_1_valid) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at Mlu.scala:123\n");
        if (`STOP_COND_)
          $fatal;
      end
      if (~reset & _GEN_5 & ~io_rs1_2_valid) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at Mlu.scala:122\n");
        if (`STOP_COND_)
          $fatal;
      end
      if (~reset & _GEN_5 & ~io_rs2_2_valid) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at Mlu.scala:123\n");
        if (`STOP_COND_)
          $fatal;
      end
      if (~reset & _GEN_6 & ~io_rs1_3_valid) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at Mlu.scala:122\n");
        if (`STOP_COND_)
          $fatal;
      end
      if (~reset & _GEN_6 & ~io_rs2_3_valid) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at Mlu.scala:123\n");
        if (`STOP_COND_)
          $fatal;
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
endmodule
