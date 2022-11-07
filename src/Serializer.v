module Serializer #(
  parameter POX = 3,
  parameter POY = 3
) (
  input                               clk                  ,
  input                               rst                  ,
  input      [POY-1:0][POX-1:0][15:0] mac_output           ,
  input                               mac_output_valid     ,
  input                               serializer_out_signal,
  output reg [POX-1:0][   15:0]       serializer_out
);

  reg [POY-1:0][POX-1:0][15:0] mac_output_reg     ;
  reg [POY-1:0][POX-1:0][15:0] mac_output_reg_next; // wire

  reg [15:0] serializer_out_next; // wire

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      serializer_out <= 0;
      mac_output_reg <= 0;
    end
    else begin
      serializer_out <= serializer_out_next;
      mac_output_reg <= mac_output_reg_next;
    end
  end

  genvar poy;
  generate
    for (poy = 0; poy < POY; poy = poy + 1)
      always @(*) begin
        if (mac_output_valid)
          mac_output_reg_next = mac_output;
        else begin
          if (serializer_out_signal) begin
            if (poy == 0)
              serializer_out_next = mac_output_reg[poy];
            else if (poy < POY - 1)
              mac_output_reg_next[poy] = mac_output_reg[poy+1];
            else ;
          end
        end
      end
  endgenerate

endmodule