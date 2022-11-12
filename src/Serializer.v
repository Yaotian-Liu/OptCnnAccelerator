module Serializer #(
  parameter POX = 3,
  parameter POY = 3
) (
  input                       clk             ,
  input                       rst             ,
  input      [POY*POX*16-1:0] mac_output      ,
  input                       mac_output_valid,
  input                       mux_sel         ,
  output reg [    POX*16-1:0] serializer_out
);

  reg [POY*POX*16-1:0] mac_output_reg     ;
  reg [POY*POX*16-1:0] mac_output_reg_next; // wire

  wire [POX*16-1:0] serializer_out_next;

  // The first element of mac_output
  assign serializer_out_next = mac_output_reg[POX*16-1:0];

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
    for (poy = 0; poy < POY; poy = poy + 1) begin
      always @(*) begin
        if (mac_output_valid) begin
          mac_output_reg_next[(poy+1)*(POX*16)-1 : poy*(POX*16)]
            = mac_output[(poy+1)*(POX*16)-1 : poy*(POX*16)];
        end
        else begin
          if (mux_sel) begin
            if (poy < POY - 1)
              mac_output_reg_next[(poy+1)*(POX*16)-1 : poy*(POX*16)]
                = mac_output_reg[(poy+2)*(POX*16)-1 : (poy+1)*(POX*16)];
            else mac_output_reg_next[(poy+1)*(POX*16)-1 : poy*(POX*16)] = 0;
          end
          else mac_output_reg_next[(poy+1)*(POX*16)-1 : poy*(POX*16)]
            = mac_output_reg[(poy+1)*(POX*16)-1 : poy*(POX*16)];
        end
      end
    end
  endgenerate

endmodule