module Csr_Verification_Assert(
  input [11:0] csr_address,
  input        _GEN,
               _GEN_0,
               _GEN_1,
               _GEN_2,
               _GEN_3,
               _GEN_4,
               _GEN_5,
               _GEN_6,
               _GEN_7,
               _GEN_8,
               _GEN_9,
               _GEN_10,
               _GEN_11,
               _GEN_12,
               _GEN_13,
               _GEN_14,
               _GEN_15,
               _GEN_16,
               _GEN_17,
               _GEN_18,
               _GEN_19,
               _GEN_20,
               _GEN_21,
               _GEN_22,
               _GEN_23,
               _GEN_24,
               _GEN_25,
               _GEN_26,
               _GEN_27,
               _GEN_28,
               _GEN_29,
               _GEN_30,
               _GEN_31,
               _GEN_32,
               _GEN_33,
               _GEN_34,
               _GEN_35,
               req_valid,
               reset,
               io_halted,
               io_wfi,
               io_fault,
               _GEN_36,
               io_rs1_valid,
               clock
);

  `ifndef SYNTHESIS
    wire marchidEn = csr_address == 12'hF12;
    wire mimpidEn = csr_address == 12'hF13;
    wire mhartidEn = csr_address == 12'hF14;
    wire kisaEn = csr_address == 12'hFC0;
    always @(posedge clock) begin
      if (~reset & req_valid
          & ~(csr_address == 12'h0 | _GEN | _GEN_0 | _GEN_1 | _GEN_2 | _GEN_3 | _GEN_4
              | _GEN_5 | _GEN_6 | _GEN_7 | _GEN_8 | _GEN_9 | _GEN_10 | _GEN_11 | _GEN_12
              | csr_address == 12'h7A0 | csr_address == 12'h7A1 | csr_address == 12'h7A2
              | csr_address == 12'h7A4 | csr_address == 12'h7B0 | csr_address == 12'h7B1
              | csr_address == 12'h7B2 | csr_address == 12'h7B3 | _GEN_13 | _GEN_14
              | _GEN_15 | _GEN_16 | _GEN_17 | _GEN_18 | _GEN_19 | _GEN_20 | _GEN_21
              | _GEN_22 | _GEN_23 | _GEN_24 | _GEN_25 | _GEN_26 | _GEN_27 | _GEN_28
              | _GEN_29 | _GEN_30 | marchidEn | mimpidEn | mhartidEn | kisaEn | _GEN_31
              | _GEN_32 | _GEN_33 | _GEN_34 | _GEN_35)) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at Csr.scala:312\n");
        if (`STOP_COND_)
          $fatal;
      end
      if (~reset & io_fault & ~io_halted & ~io_wfi) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at Csr.scala:383\n");
        if (`STOP_COND_)
          $fatal;
      end
      if (~reset
          & {1'h0,
             {1'h0,
              {1'h0,
               {1'h0, {1'h0, _GEN} + {1'h0, _GEN_0}}
                 + {1'h0, {1'h0, _GEN_1} + {1'h0, _GEN_5} + {1'h0, _GEN_6}}}
                + {1'h0,
                   {1'h0, {1'h0, _GEN_7} + {1'h0, _GEN_8}}
                     + {1'h0, {1'h0, _GEN_9} + {1'h0, _GEN_10} + {1'h0, _GEN_11}}}}
               + {1'h0,
                  {1'h0,
                   {1'h0, {1'h0, _GEN_12} + {1'h0, _GEN_13}}
                     + {1'h0, {1'h0, _GEN_14} + {1'h0, _GEN_15} + {1'h0, _GEN_16}}}
                    + {1'h0,
                       {1'h0, {1'h0, _GEN_17} + {1'h0, _GEN_18}}
                         + {1'h0, {1'h0, _GEN_19} + {1'h0, _GEN_20} + {1'h0, _GEN_21}}}}}
          + {1'h0,
             {1'h0,
              {1'h0,
               {1'h0, {1'h0, _GEN_22} + {1'h0, _GEN_23}}
                 + {1'h0, {1'h0, _GEN_25} + {1'h0, _GEN_24} + {1'h0, _GEN_26}}}
                + {1'h0,
                   {1'h0, {1'h0, _GEN_30} + {1'h0, marchidEn}}
                     + {1'h0, {1'h0, mimpidEn} + {1'h0, mhartidEn} + {1'h0, kisaEn}}}}
               + {1'h0,
                  {1'h0,
                   {1'h0, {1'h0, _GEN_31} + {1'h0, _GEN_32}}
                     + {1'h0, {1'h0, _GEN_33} + {1'h0, _GEN_34} + {1'h0, _GEN_35}}}
                    + {1'h0,
                       {1'h0, {1'h0, _GEN_2} + {1'h0, _GEN_27} + {1'h0, _GEN_28}}
                         + {1'h0,
                            {1'h0, _GEN_4} + {1'h0, _GEN_3}
                              + {1'h0, _GEN_29}}}}} > {5'h0, _GEN_36}) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at Library.scala:234\n");
        if (`STOP_COND_)
          $fatal;
      end
      if (~reset & req_valid & ~io_rs1_valid) begin
        if (`ASSERT_VERBOSE_COND_)
          $error("Assertion failed at Csr.scala:612\n");
        if (`STOP_COND_)
          $fatal;
      end
    end // always @(posedge)
  `endif // not def SYNTHESIS
endmodule
