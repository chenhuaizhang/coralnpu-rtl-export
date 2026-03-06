module rvv_backend_decode_unit
(
  inst_valid_cq2de,
  inst_cq2de,
  uop_index_remain,
  uop_valid_de2uq,
  uop_de2uq
);
//
// interface signals
//
  // CQ to Decoder unit signals
  input   logic                         inst_valid_cq2de;
  input   RVVCmd                        inst_cq2de;
  input   logic [`UOP_INDEX_WIDTH-1:0]  uop_index_remain;
  
  // Decoder unit to Uops Queue signals
  output  logic       [`NUM_DE_UOP-1:0] uop_valid_de2uq;
  output  UOP_QUEUE_t [`NUM_DE_UOP-1:0] uop_de2uq;

//
// internal signals
//
  RVVOpCode                             inst_opcode;     // inst original encoding[6:0]
  logic                                 valid_ari;
  logic                                 valid_lsu;

  // decoded arithmetic uops
  logic       [`NUM_DE_UOP-1:0]         uop_valid_ari;
  UOP_QUEUE_t [`NUM_DE_UOP-1:0]         uop_ari;

  // decoded LSU uops
  logic       [`NUM_DE_UOP-1:0]         uop_valid_lsu;
  UOP_QUEUE_t [`NUM_DE_UOP-1:0]         uop_lsu;

//
// decode
//
  assign inst_opcode  = inst_cq2de.opcode;
 
  // decode opcode
  assign valid_lsu    = (inst_valid_cq2de==1'b1) & ((inst_opcode==LOAD) | (inst_opcode==STORE));
  
  assign valid_ari    = (inst_valid_cq2de==1'b1) & (inst_opcode==RVV);
  
  // decode LSU instruction 
  rvv_backend_decode_unit_lsu u_lsu_decode
  (
    .inst_valid        (valid_lsu),
    .inst              (inst_cq2de),
    .uop_index_remain  (uop_index_remain),
    .uop_valid         (uop_valid_lsu),
    .uop               (uop_lsu)
  );

  // decode arithmetic instruction
  rvv_backend_decode_unit_ari u_ari_decode
  (
    .inst_valid        (valid_ari),
    .inst              (inst_cq2de),
    .uop_index_remain  (uop_index_remain),
    .uop_valid         (uop_valid_ari),
    .uop               (uop_ari)
  );

  // output
  always_comb begin 
    uop_valid_de2uq     = 'b0;
    uop_de2uq           = 'b0;
    
    case(1'b1)
      valid_lsu: begin
        uop_valid_de2uq = uop_valid_lsu;
        uop_de2uq       = uop_lsu;
      end
  
      valid_ari: begin
        uop_valid_de2uq = uop_valid_ari;
        uop_de2uq       = uop_ari;
      end
    endcase
  end

endmodule
