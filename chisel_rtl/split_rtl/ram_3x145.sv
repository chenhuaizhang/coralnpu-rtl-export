module ram_3x145(
  input  [1:0]   R0_addr,
  input          R0_en,
                 R0_clk,
  output [144:0] R0_data,
  input  [1:0]   W0_addr,
  input          W0_en,
                 W0_clk,
  input  [144:0] W0_data
);

  reg [144:0] Memory[0:2];
  always @(posedge W0_clk) begin
    if (W0_en & 1'h1)
      Memory[W0_addr] <= W0_data;
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_MEM_
    reg [159:0] _RANDOM_MEM;
    initial begin
      `INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_MEM_INIT
        for (logic [1:0] i = 2'h0; i < 2'h3; i += 2'h1) begin
          for (logic [7:0] j = 8'h0; j < 8'hA0; j += 8'h20) begin
            _RANDOM_MEM[j +: 32] = `RANDOM;
          end
          Memory[i] = _RANDOM_MEM[144:0];
        end
      `endif // RANDOMIZE_MEM_INIT
    end // initial
  `endif // ENABLE_INITIAL_MEM_
  assign R0_data = R0_en ? Memory[R0_addr] : 145'bx;
endmodule
