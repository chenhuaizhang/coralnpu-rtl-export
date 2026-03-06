module rvv_backend_mul_unit_mul8 (
  out,
  in0, in0_is_signed,
  in1, in1_is_signed
);

input [7:0] in0;
input       in0_is_signed;
input [7:0] in1;
input       in1_is_signed;

output [15:0] out;

wire [8:0] in0_int = {in0_is_signed&in0[7],in0};
wire [8:0] in1_int = {in1_is_signed&in1[7],in1};

wire [17:0] out_int = {{9{in0_int[8]}},in0_int} * {{9{in1_int[8]}},in1_int};

assign out = out_int[0+:16];

endmodule
