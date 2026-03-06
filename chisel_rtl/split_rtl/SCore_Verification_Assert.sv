module SCore_Verification_Assert(
  input csr_io_rd_valid,
        alu_0_io_rd_valid,
        bru_0_io_rd_valid,
        io_rvvcore_rd_0_valid,
        reset,
        _GEN,
        alu_1_io_rd_valid,
        bru_1_io_rd_valid,
        io_rvvcore_rd_1_valid,
        alu_2_io_rd_valid,
        bru_2_io_rd_valid,
        io_rvvcore_rd_2_valid,
        alu_3_io_rd_valid,
        bru_3_io_rd_valid,
        io_rvvcore_rd_3_valid,
        clock
);

  `ifndef SYNTHESIS
    wire [3:0] _GEN_0 = {3'h0, _GEN};
    always @(posedge clock) begin
      if (~reset
          & {1'h0,
             {1'h0, {1'h0, csr_io_rd_valid} + {1'h0, alu_0_io_rd_valid}}
               + {2'h0, bru_0_io_rd_valid}}
          + {3'h0, io_rvvcore_rd_0_valid} > _GEN_0) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at SCore.scala:315\n");
        if (`STOP_COND_)
          $fatal;
      end
      if (~reset
          & {1'h0,
             {1'h0, {1'h0, alu_1_io_rd_valid} + {1'h0, bru_1_io_rd_valid}}
               + {2'h0, io_rvvcore_rd_1_valid}} > _GEN_0) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at SCore.scala:315\n");
        if (`STOP_COND_)
          $fatal;
      end
      if (~reset
          & {1'h0,
             {1'h0, {1'h0, alu_2_io_rd_valid} + {1'h0, bru_2_io_rd_valid}}
               + {2'h0, io_rvvcore_rd_2_valid}} > _GEN_0) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at SCore.scala:315\n");
        if (`STOP_COND_)
          $fatal;
      end
      if (~reset
          & {1'h0,
             {1'h0, {1'h0, alu_3_io_rd_valid} + {1'h0, bru_3_io_rd_valid}}
               + {2'h0, io_rvvcore_rd_3_valid}} > _GEN_0) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at SCore.scala:315\n");
        if (`STOP_COND_)
          $fatal;
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
endmodule
