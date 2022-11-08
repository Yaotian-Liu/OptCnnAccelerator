module PostProcess #(parameter POX = 3) (
  input                   clk                  ,
  input                   rst                  ,
  input      [POX*16-1:0] mux_postprocess_data ,
  input                   mux_postprocess_valid,
  input      [POX*16-1:0] K                    ,
  input      [POX*16-1:0] B                    ,
  output reg [POX*16-1:0] post_out             ,
  output reg              post_out_valid
);

  genvar pox;
  generate
    for (pox = 0; pox < POX; pox = pox + 1) begin
      ;
    end
  endgenerate

endmodule