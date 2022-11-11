module Post_top #(
  parameter INT_BITS  = 4, // Q{INT_IBTS}.{16-INT_BITS}
  parameter POX       = 3,
  parameter POY       = 3,
  parameter CHANNEL_N = 2  // The number of connected channels.
) (
  input                             clk             ,
  input                             rst             ,
  input  [CHANNEL_N*POY*POX*16-1:0] mac_to_serialzer, // data from MAC
  input                             mac_output_valid, // data valid signal from MAC
  input  [                    15:0] K               , // K for BN
  input  [                    15:0] B               , // B for BN
  input  [              POX*16-1:0] bias            , // bias for CONV
  output [              POX*16-1:0] relu_out        , // result of CONV+ReLU
  output                            relu_out_valid  ,
  output [              POX*16-1:0] post_out        , // result of CONV+ReLU+BN
  output                            post_out_valid
);

  wire [CHANNEL_N*POX*16-1:0] all_serializer_out;

  wire [$clog2(CHANNEL_N)-1:0] mux_sel        ;
  wire [        CHANNEL_N-1:0] mux_sel_one_hot;

  wire [POX*16-1:0] mux_postprocess_data ;
  wire              mux_postprocess_valid;

  Mux #(
    .CHANNEL_N(CHANNEL_N),
    .POX      (POX      ),
    .POY      (POY      )
  ) U_Mux (
    .clk               (clk                  ),
    .rst               (rst                  ),
    .all_serializer_out(all_serializer_out   ),
    .mac_output_valid  (mac_output_valid     ),
    .mux_sel           (mux_sel              ),
    .mux_out           (mux_postprocess_data ),
    .mux_out_valid     (mux_postprocess_valid)
  );

  genvar c;
  generate
    for (c = 0; c < CHANNEL_N; c = c + 1) begin
      assign mux_sel_one_hot[c] = (mux_sel == c);

      Serializer #(
        .POX(POX),
        .POY(POY)
      ) U_Serializer (
        .clk             (clk                                              ),
        .rst             (rst                                              ),
        .mac_output      (mac_to_serialzer[(c+1)*POY*POX*16-1:c*POY*POX*16]),
        .mac_output_valid(mac_output_valid                                 ),
        .mux_sel         (mux_sel                                          ),
        .serializer_out  (all_serializer_out[(c+1)*POX*16-1:c*POX*16]      )
      );
    end
  endgenerate

  PostProcess #(
    .POX     (POX     ),
    .INT_BITS(INT_BITS)
  ) U_PostProcess (
    .clk                  (clk                  ),
    .rst                  (rst                  ),
    .mux_postprocess_data (mux_postprocess_data ),
    .mux_postprocess_valid(mux_postprocess_valid),
    .K                    (K                    ),
    .B                    (B                    ),
    .bias                 (bias                 ),
    .relu_out             (relu_out             ),
    .relu_out_valid       (relu_out_valid       ),
    .post_out             (post_out             ),
    .post_out_valid       (post_out_valid       )
  );

endmodule