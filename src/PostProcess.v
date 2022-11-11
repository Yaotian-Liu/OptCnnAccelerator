module PostProcess #(
  parameter POX      = 3,
  parameter INT_BITS = 3
) (
  input                   clk                  ,
  input                   rst                  ,
  input      [POX*16-1:0] mux_postprocess_data ,
  input                   mux_postprocess_valid,
  input      [      15:0] K                    ,
  input      [      15:0] B                    ,
  input      [POX*16-1:0] bias                 ,
  output reg [POX*16-1:0] relu_out             ,
  output reg              relu_out_valid       ,
  output reg [POX*16-1:0] post_out             ,
  output reg              post_out_valid
);

  wire [POX*16-1:0] relu_out_next;

  wire [POX*16-1:0] post_out_next;
  wire [POX*16-1:0] add_result   ;
  wire [POX*32-1:0] mul_results  ; // wire

  genvar pox;
  generate
    for (pox = 0; pox < POX; pox = pox + 1) begin
      // Cycle 1
      assign add_result[(pox+1)*16-1:pox*16]    = mux_postprocess_data[(pox+1)*16-1:pox*16] + bias;
      assign relu_out_next[(pox+1)*16-1:pox*16] =
        (add_result[(pox+1)*16-1] == 1'b0) ? add_result[(pox+1)*16-1:pox*16] : 16'b0; // ReLU

      // Cycle 2
      assign mul_results[(pox+1)*32-1:pox*32]   = relu_out[(pox+1)*16-1:pox*16] * K;
      assign post_out_next[(pox+1)*16-1:pox*16] =
        mul_results[(pox+1)*32-1-INT_BITS:pox*32+(16-INT_BITS)] + B;
    end
  endgenerate

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      post_out <= 0;
      relu_out <= 0;

      relu_out_valid <= 0;
      post_out_valid <= 0;
    end
    else begin
      relu_out <= relu_out_next;
      post_out <= post_out_next;

      // Need 2 cycles to complete:
      // 1. Add bias + ReLU
      // 2. Batch Normalization
      relu_out_valid <= mux_postprocess_valid;
      post_out_valid <= relu_out_valid;
    end
  end


endmodule