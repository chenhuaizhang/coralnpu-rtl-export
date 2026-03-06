module ram_2x8(
  input        R0_addr,
               R0_en,
               R0_clk,
  output [7:0] R0_data,
  input        W0_addr,
               W0_en,
               W0_clk,
  input  [7:0] W0_data
);

  reg [7:0] Memory[0:1];
  always @(posedge W0_clk) begin
    if (W0_en & 1'h1)
      Memory[W0_addr] <= W0_data;
  end // always @(posedge)
  `ifdef ENABLE_INITIAL_MEM_
    reg [31:0] _RANDOM_MEM;
    initial begin
      `INIT_RANDOM_PROLOG_
      `ifdef RANDOMIZE_MEM_INIT
        for (logic [1:0] i = 2'h0; i < 2'h2; i += 2'h1) begin
          _RANDOM_MEM = `RANDOM;
          Memory[i[0]] = _RANDOM_MEM[7:0];
        end
      `endif // RANDOMIZE_MEM_INIT
    end // initial
  `endif // ENABLE_INITIAL_MEM_
  assign R0_data = R0_en ? Memory[R0_addr] : 8'bx;
endmodule
