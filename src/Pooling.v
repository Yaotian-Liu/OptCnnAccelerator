module Pooling #(parameter POX = 4) (
  input                     clk              ,
  input                     rst              ,
  input      [  POX*16-1:0] post_to_pooling  ,
  input                     post_out_valid   ,
  output reg [POX/2*16-1:0] pooling_out      ,
  output reg                pooling_out_valid
);

  // Use to indicate the status of pooling operation
  // status == 0: processing the first two result
  // status == 1: processing the second two and ready to output
  reg status;

  wire [POX/2*16-1:0] compare_results;
  reg  [POX/2*16-1:0] pooling_reg    ;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      status            <= 0;
      pooling_out_valid <= 0;
    end
    else begin
      status            <= post_out_valid ? status + 1'b1 : status;
      pooling_out_valid <= status ? 1'b0 : 1'b1;
    end
  end

  genvar half_pox;
  generate
    for(half_pox = 0; half_pox < POX / 2 - 1; half_pox = half_pox + 1) begin
      // The compare results of two inputs
      assign compare_results[(half_pox+1)*16-1:half_pox*16] =
        post_to_pooling[(2*half_pox+1)*16-1:(2*half_pox)*16] >
          post_to_pooling[(2*(half_pox+1))*16-1:(2*half_pox+1)*16] ?
            post_to_pooling[(2*half_pox+1)*16-1:(2*half_pox)*16] :
              post_to_pooling[(2*(half_pox+1))*16-1:(2*half_pox+1)*16];

      always @(posedge clk or posedge rst) begin
        if (rst) begin
          pooling_reg[(half_pox+1)*16-1:half_pox*16] <= 0;
          pooling_out[(half_pox+1)*16-1:half_pox*16] <= 0;
        end
        else if (post_out_valid) begin
          case (status)
            1'b0 : begin
              pooling_reg[(half_pox+1)*16-1:half_pox*16] <=
                compare_results[(half_pox+1)*16-1:half_pox*16];
            end

            1'b1 : begin
              pooling_out[(half_pox+1)*16-1:half_pox*16] <=
                compare_results[(half_pox+1)*16-1:half_pox*16] >
                  pooling_reg[(half_pox+1)*16-1:half_pox*16] ?
                    compare_results[(half_pox+1)*16-1:half_pox*16]  :
                      pooling_reg[(half_pox+1)*16-1:half_pox*16];
            end
          endcase
        end
        else ; // If ~post_out_valid, do nothing
      end
    end
  endgenerate


endmodule