module Mux #(
  parameter CHANNEL_N = 2,
  parameter POX       = 4,
  parameter POY       = 4
) (
  input                              clk               ,
  input                              rst               ,
  input      [ CHANNEL_N*POX*16-1:0] all_serializer_out,
  input                              mac_output_valid  ,
  input      [      $clog2(POY)-1:0] mac_valid_number  ,
  output reg [$clog2(CHANNEL_N)-1:0] mux_sel           ,
  output reg [           POX*16-1:0] mux_out           ,
  output reg                         mux_out_valid
);

  wire [CHANNEL_N-1:0] mux_sel_next; // wire

  reg  [$clog2(POY*CHANNEL_N)-1:0] transmit_cnt     ;
  wire [$clog2(POY*CHANNEL_N)-1:0] transmit_cnt_next;

  wire [CHANNEL_N-1:0] all_serializer_out_array[POX*16-1:0];

  genvar c;
  generate
    for (c = 0; c < CHANNEL_N; c = c + 1) begin
      assign all_serializer_out_array[c] = all_serializer_out[(c+1)*POX*16-1:c*POX*16];
    end
  endgenerate

  assign mux_sel_next = mac_output_valid ? 1'b1 :
    (transmit_cnt == mac_valid_number - 1) ?
    ((mux_sel == CHANNEL_N - 1) ?  1'b0 : mux_sel + 1'b1) : mux_sel;

  assign transmit_cnt_next = mac_output_valid ? transmit_cnt + 1'b1 :
    (transmit_cnt == mac_valid_number - 1) ?  1'b0 :
    (mux_sel > 0) ? transmit_cnt + 1'b1 : transmit_cnt;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      mux_sel       <= 0;
      transmit_cnt  <= 0;
      mux_out       <= 0;
      mux_out_valid <= 0;
    end
    else begin
      mux_sel       <= mux_sel_next;
      transmit_cnt  <= transmit_cnt_next;
      mux_out       <= all_serializer_out_array[mux_sel];
      mux_out_valid <= (mux_sel > 0); // When mux_sel is not 0, output valid
    end
  end

endmodule