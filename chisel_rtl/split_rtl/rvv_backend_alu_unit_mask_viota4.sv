module rvv_backend_alu_unit_mask_viota4
(
  source,
  result_viota4 
);

  input  logic [3:0]              source;
  output logic [3:0][$clog2(4):0] result_viota4;
  
  always_comb begin
    case(source[0])
      1'b0: begin
        result_viota4[0] = 3'd0;
      end
      1'b1: begin
        result_viota4[0] = 3'd1;
      end
      default: begin
        result_viota4[0] = 3'd0;
      end
    endcase

    case(source[1:0])
      2'b00: begin
        result_viota4[1] = 3'd0;
      end
      2'b01,
      2'b10: begin
        result_viota4[1] = 3'd1;
      end
      2'b11: begin
        result_viota4[1] = 3'd2;
      end
      default: begin
        result_viota4[1] = 3'd0;
      end
    endcase

    case(source[2:0])
      3'b000: begin
        result_viota4[2] = 3'd0;
      end
      3'b001,
      3'b010,
      3'b100: begin
        result_viota4[2] = 3'd1;
      end
      3'b011,
      3'b101,
      3'b110: begin
        result_viota4[2] = 3'd2;
      end
      3'b111: begin
        result_viota4[2] = 3'd3;
      end
      default: begin
        result_viota4[2] = 3'd0;
      end
    endcase

    case(source)
      4'b0000: begin
        result_viota4[3] = 3'd0;
      end
      4'b0001,
      4'b0010,
      4'b0100,
      4'b1000: begin
        result_viota4[3] = 3'd1;
      end
      4'b0011,
      4'b0101,
      4'b1001,
      4'b0110,
      4'b1010,
      4'b1100: begin
        result_viota4[3] = 3'd2;
      end
      4'b0111,
      4'b1011,
      4'b1101,
      4'b1110: begin
        result_viota4[3] = 3'd3;
      end
      4'b1111: begin
        result_viota4[3] = 3'd4;
      end
      default: begin
        result_viota4[3] = 3'd0;
      end
    endcase
  end

endmodule
