module rvv_backend_alu_unit_mask_viota32
(
  source,
  result_viota32
);

  input  logic [31:0]               source;
  output logic [31:0][$clog2(32):0] result_viota32;
  
  logic [3:0][6:0][2:0]             result_viota7;
  logic      [6:0][2:0]             sum_20to14;
  logic      [6:0][2:0]             carry_20to14;
  logic      [6:0][2:0]             sum_27to21;
  logic      [6:0][2:0]             carry_27to21;
  logic      [6:0][2:0]             cout_27to21;
  logic      [3:0][2:0]             result_viota4;
  logic      [3:0][2:0]             sum_31to28;
  logic      [3:0][2:0]             carry_31to28;
  logic      [3:0][2:0]             cout_31to28;
  
  genvar                            j;

  // calculate
  generate
    for(j=0;j<4;j++) begin: GET_VIOTA7_FOR_27_0_BIT
      rvv_backend_alu_unit_mask_viota7
      u_viota7
      (
        .source(source[j*7 +: 7]),
        .result_viota7(result_viota7[j])
      );
    end
  endgenerate

  rvv_backend_alu_unit_mask_viota4
  u_viota4
  (
    .source(source[31:28]),
    .result_viota4(result_viota4)
  );

  generate
    for(j=0;j<7;j++) begin: GET_VIOTA32_27_0
      assign result_viota32[j] = ($clog2(32)+1)'(result_viota7[0][j]);
      assign result_viota32[j+7] = ($clog2(32)+1)'(result_viota7[1][j])+($clog2(32)+1)'(result_viota7[0][6]);
      assign result_viota32[j+14] = ($clog2(32)+1)'(sum_20to14[j])+($clog2(32)+1)'({carry_20to14[j],1'b0});
      assign result_viota32[j+21] = ($clog2(32)+1)'(sum_27to21[j])+($clog2(32)+1)'({({1'b0,carry_27to21[j]})+($clog2(32)+1)'({1'b0,cout_27to21[j]}),1'b0});


      compressor_3_2
      #(
        .WIDTH        (3)
      )
      viota32_20to14
      (
        .src1         (result_viota7[0][6]),
        .src2         (result_viota7[1][6]),
        .src3         (result_viota7[2][j]),
        .result_sum   (sum_20to14[j]),
        .result_carry (carry_20to14[j])
      );
      
      compressor_4_2
      #(
        .WIDTH        (3)
      )
      viota32_27to21
      (
        .src1         (result_viota7[0][6]),
        .src2         (result_viota7[1][6]),
        .src3         (result_viota7[2][6]),
        .src4         (result_viota7[3][j]),
        .cin          ('0),
        .result_sum   (sum_27to21[j]),
        .result_carry (carry_27to21[j]),
        .result_cout  (cout_27to21[j])
      );
    end

    for(j=0;j<4;j++) begin: GET_VIOTA32_31_28
      assign result_viota32[j+28] = ($clog2(32)+1)'(sum_31to28[j])+
                                    ($clog2(32)+1)'({({1'b0,carry_31to28[j]})+
                                    ($clog2(32)+1)'({1'b0,cout_31to28[j]}),1'b0});

      compressor_4_2
      #(
        .WIDTH        (3)
      )
      viota32_31to28
      (
        .src1         (result_viota7[0][6]),
        .src2         (result_viota7[1][6]),
        .src3         (result_viota7[2][6]),
        .src4         (result_viota7[3][6]),
        .cin          (result_viota4[j]),
        .result_sum   (sum_31to28[j]),
        .result_carry (carry_31to28[j]),
        .result_cout  (cout_31to28[j])
      );
    end
  endgenerate
  
endmodule
