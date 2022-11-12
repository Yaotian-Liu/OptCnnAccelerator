// Generator : SpinalHDL v1.7.3a    git head : 38229e39085a1ea7357f1e0369e5b01f1e4c5739
// Component : Multiplier
// Git hash  : 4d21e68e12242243faae35297094eeefccdbcefe


module Multiplier #(parameter INT_BITS = 4) (
  input  [15:0] io_op1   ,
  input  [15:0] io_op2   ,
  output [15:0] io_output
);

  wire [20:0] _zz__zz_io_output    ;
  wire [20:0] _zz__zz_io_output_1  ;
  wire [31:0] _zz__zz_io_output_2  ;
  wire [47:0] _zz__zz_io_output_3  ;
  wire [47:0] _zz__zz_io_output_4  ;
  wire [31:0] _zz__zz_io_output_5  ;
  wire [15:0] _zz__zz_io_output_6  ;
  wire [15:0] _zz__zz_io_output_7  ;
  wire [20:0] _zz_when_AFix_l756   ;
  wire [15:0] _zz_when_AFix_l756_1 ;
  wire [20:0] _zz_when_AFix_l756_2 ;
  wire [15:0] _zz__zz_io_output_1_1;
  wire [15:0] _zz__zz_io_output_1_2;
  wire [15:0] _zz__zz_io_output_1_3;
  wire [15:0] _zz__zz_io_output_1_4;
  wire [15:0] _zz__zz_io_output_1_5;
  wire [20:0] _zz__zz_io_output_1_6;
  wire [20:0] _zz_when_AFix_l761   ;
  wire [20:0] _zz_when_AFix_l761_1 ;
  wire [15:0] _zz_when_AFix_l761_2 ;
  wire [15:0] _zz_when_AFix_l761_3 ;
  wire [15:0] _zz_io_output_2      ;
  wire [15:0] _zz_io_output_3      ;
  wire [20:0] _zz_io_output        ;
  reg  [15:0] _zz_io_output_1      ;
  wire        when_AFix_l756       ;
  wire        when_AFix_l761       ;

  assign _zz__zz_io_output_1   = (_zz__zz_io_output_2 >>> (15-INT_BITS));
  assign _zz__zz_io_output     = _zz__zz_io_output_1;
  assign _zz__zz_io_output_2   = _zz__zz_io_output_3[31 : 0];
  assign _zz__zz_io_output_3   = _zz__zz_io_output_4;
  assign _zz__zz_io_output_4   = ($signed(_zz__zz_io_output_5) * $signed(_zz__zz_io_output_7));
  assign _zz__zz_io_output_6   = io_op1;
  assign _zz__zz_io_output_5   = {{16{_zz__zz_io_output_6[15]}}, _zz__zz_io_output_6};
  assign _zz__zz_io_output_7   = io_op2;
  assign _zz_when_AFix_l756_1  = {1'b0,15'h7fff};
  assign _zz_when_AFix_l756    = {{(1 + INT_BITS){_zz_when_AFix_l756_1[15]}}, _zz_when_AFix_l756_1};
  assign _zz_when_AFix_l756_2  = _zz_io_output;
  assign _zz__zz_io_output_1_2 = 16'h7fff;
  assign _zz__zz_io_output_1_1 = _zz__zz_io_output_1_2;
  assign _zz__zz_io_output_1_4 = 16'h8000;
  assign _zz__zz_io_output_1_3 = _zz__zz_io_output_1_4;
  assign _zz__zz_io_output_1_6 = _zz_io_output;
  assign _zz__zz_io_output_1_5 = _zz__zz_io_output_1_6[15:0];
  assign _zz_when_AFix_l761    = _zz_io_output;
  assign _zz_when_AFix_l761_2  = _zz_when_AFix_l761_3;
  assign _zz_when_AFix_l761_1  = {{(1 + INT_BITS){_zz_when_AFix_l761_2[15]}}, _zz_when_AFix_l761_2};
  assign _zz_when_AFix_l761_3  = 16'h8000;
  assign _zz_io_output_3       = _zz_io_output_1;
  assign _zz_io_output_2       = _zz_io_output_3;
  assign _zz_io_output         = _zz__zz_io_output;
  assign when_AFix_l756        = ($signed(_zz_when_AFix_l756) < $signed(_zz_when_AFix_l756_2));
  always @(*) begin
    if(when_AFix_l756) begin
      _zz_io_output_1 = _zz__zz_io_output_1_1;
    end else begin
      if(when_AFix_l761) begin
        _zz_io_output_1 = _zz__zz_io_output_1_3;
      end else begin
        _zz_io_output_1 = _zz__zz_io_output_1_5;
      end
    end
  end

  assign when_AFix_l761 = ($signed(_zz_when_AFix_l761) < $signed(_zz_when_AFix_l761_1));
  assign io_output      = _zz_io_output_2;

endmodule
