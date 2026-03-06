module Alu_Verification_Assert(
  input io_rs1_valid,
        _GEN,
        valid,
        reset,
        io_rs2_valid,
        _rs1Only_WIRE_5,
        _rs1Only_WIRE_4,
        _rs1Only_WIRE_7,
        _rs1Only_WIRE_6,
        _rs1Only_WIRE_1,
        _rs1Only_WIRE_0,
        _rs1Only_WIRE_3,
        _rs1Only_WIRE_2,
        clock
);

  `ifndef SYNTHESIS
    always @(posedge clock) begin
      if (~reset & valid & ~io_rs1_valid & ~_GEN) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at Alu.scala:159\n");
        if (`STOP_COND_)
          $fatal;
      end
      if (~reset & valid & ~io_rs2_valid
          & {_rs1Only_WIRE_7,
             _rs1Only_WIRE_6,
             _rs1Only_WIRE_5,
             _rs1Only_WIRE_4,
             _rs1Only_WIRE_3,
             _rs1Only_WIRE_2,
             _rs1Only_WIRE_1,
             _rs1Only_WIRE_0} == 8'h0) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at Alu.scala:160\n");
        if (`STOP_COND_)
          $fatal;
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
endmodule
