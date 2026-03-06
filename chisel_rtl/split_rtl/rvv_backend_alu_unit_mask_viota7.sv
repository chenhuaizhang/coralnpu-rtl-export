module rvv_backend_alu_unit_mask_viota7
(
  source,
  result_viota7
);

  input  logic [6:0]      source;
  output logic [6:0][2:0] result_viota7;
  
  logic [3:0][2:0]        result_viota4;

  rvv_backend_alu_unit_mask_viota4
  u_viota4
  (
    .source(source[3:0]),
    .result_viota4(result_viota4)
  );
  
  assign result_viota7[3:0] = result_viota4;

  always_comb begin
    case(source[4])
      1'b0: begin
        result_viota7[4] = result_viota4[3];
      end
      1'b1: begin
        result_viota7[4] = result_viota4[3]+1'b1;
      end
      default: begin
        result_viota7[4] = result_viota4[3];
      end
    endcase

    case(source[5:4])
      2'b00: begin
        result_viota7[5] = result_viota4[3];
      end
      2'b01,
      2'b10: begin
        result_viota7[5] = result_viota4[3]+1'b1;
      end
      2'b11: begin
        result_viota7[5] = result_viota4[3]+2'd2;
      end
      default: begin
        result_viota7[5] = result_viota4[3];
      end
    endcase

    case(source[6:4])
      3'b000: begin
        result_viota7[6] = result_viota4[3];
      end
      3'b001,
      3'b010,
      3'b100: begin
        result_viota7[6] = result_viota4[3]+1'b1;
      end
      3'b011,
      3'b101,
      3'b110: begin
        result_viota7[6] = result_viota4[3]+2'd2;
      end
      3'b111: begin
        result_viota7[6] = result_viota4[3]+2'd3;
      end
      default: begin
        result_viota7[6] = result_viota4[3];
      end
    endcase
  end

endmodule
