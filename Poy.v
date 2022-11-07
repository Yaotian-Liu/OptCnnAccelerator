// Generator : SpinalHDL v1.7.3    git head : aeaeece704fe43c766e0d36a93f2ecbb8a9f2003
// Component : Poy
// Git hash  : a06d673b111a71f9a8fbffc81fe2f8d67a63553f

`timescale 1ns/1ps

module Poy (
  input      [15:0]   io_weight,
  input      [15:0]   io_activation_buffer_0_0,
  input      [15:0]   io_activation_buffer_0_1,
  input      [15:0]   io_activation_buffer_0_2,
  input      [15:0]   io_activation_buffer_1_0,
  input      [15:0]   io_activation_buffer_1_1,
  input      [15:0]   io_activation_buffer_1_2,
  input      [15:0]   io_activation_buffer_2_0,
  input      [15:0]   io_activation_buffer_2_1,
  input      [15:0]   io_activation_buffer_2_2,
  input      [15:0]   io_activation_buffer_standby_0,
  input      [15:0]   io_activation_buffer_standby_1,
  input      [15:0]   io_activation_buffer_standby_2,
  output     [15:0]   io_output_0_0,
  output     [15:0]   io_output_0_1,
  output     [15:0]   io_output_0_2,
  output     [15:0]   io_output_1_0,
  output     [15:0]   io_output_1_1,
  output     [15:0]   io_output_1_2,
  output     [15:0]   io_output_2_0,
  output     [15:0]   io_output_2_1,
  output     [15:0]   io_output_2_2,
  input               io_clear,
  input               clk,
  input               reset
);
  localparam ActivationSource_BUFFER_1 = 2'd0;
  localparam ActivationSource_FIFO = 2'd1;
  localparam ActivationSource_SHIFT = 2'd2;

  wire       [15:0]   pox_array_0_io_activation_fifo_out_0;
  wire       [15:0]   pox_array_0_io_activation_fifo_out_1;
  wire       [15:0]   pox_array_0_io_activation_fifo_out_2;
  wire       [15:0]   pox_array_0_io_output_0;
  wire       [15:0]   pox_array_0_io_output_1;
  wire       [15:0]   pox_array_0_io_output_2;
  wire       [15:0]   pox_array_1_io_activation_fifo_out_0;
  wire       [15:0]   pox_array_1_io_activation_fifo_out_1;
  wire       [15:0]   pox_array_1_io_activation_fifo_out_2;
  wire       [15:0]   pox_array_1_io_output_0;
  wire       [15:0]   pox_array_1_io_output_1;
  wire       [15:0]   pox_array_1_io_output_2;
  wire       [15:0]   pox_array_2_io_activation_fifo_out_0;
  wire       [15:0]   pox_array_2_io_activation_fifo_out_1;
  wire       [15:0]   pox_array_2_io_activation_fifo_out_2;
  wire       [15:0]   pox_array_2_io_output_0;
  wire       [15:0]   pox_array_2_io_output_1;
  wire       [15:0]   pox_array_2_io_output_2;
  wire       [3:0]    _zz_counter_valueNext;
  wire       [0:0]    _zz_counter_valueNext_1;
  wire                counter_willIncrement;
  wire                counter_willClear;
  reg        [3:0]    counter_valueNext;
  reg        [3:0]    counter_value;
  wire                counter_willOverflowIfInc;
  wire                counter_willOverflow;
  wire       [1:0]    _zz_io_activation_source_from;
  wire       [1:0]    _zz_io_activation_source_from_1;
  `ifndef SYNTHESIS
  reg [63:0] _zz_io_activation_source_from_string;
  reg [63:0] _zz_io_activation_source_from_1_string;
  `endif


  assign _zz_counter_valueNext_1 = counter_willIncrement;
  assign _zz_counter_valueNext = {3'd0, _zz_counter_valueNext_1};
  Pox pox_array_0 (
    .io_weight                    (io_weight[15:0]                           ), //i
    .io_activation_buffer_0       (io_activation_buffer_0_0[15:0]            ), //i
    .io_activation_buffer_1       (io_activation_buffer_0_1[15:0]            ), //i
    .io_activation_buffer_2       (io_activation_buffer_0_2[15:0]            ), //i
    .io_activation_fifo_in_0      (pox_array_1_io_activation_fifo_out_0[15:0]), //i
    .io_activation_fifo_in_1      (pox_array_1_io_activation_fifo_out_1[15:0]), //i
    .io_activation_fifo_in_2      (pox_array_1_io_activation_fifo_out_2[15:0]), //i
    .io_activation_buffer_standby (io_activation_buffer_standby_0[15:0]      ), //i
    .io_activation_source_from    (_zz_io_activation_source_from[1:0]        ), //i
    .io_activation_fifo_out_0     (pox_array_0_io_activation_fifo_out_0[15:0]), //o
    .io_activation_fifo_out_1     (pox_array_0_io_activation_fifo_out_1[15:0]), //o
    .io_activation_fifo_out_2     (pox_array_0_io_activation_fifo_out_2[15:0]), //o
    .io_clear                     (io_clear                                  ), //i
    .io_output_0                  (pox_array_0_io_output_0[15:0]             ), //o
    .io_output_1                  (pox_array_0_io_output_1[15:0]             ), //o
    .io_output_2                  (pox_array_0_io_output_2[15:0]             ), //o
    .clk                          (clk                                       ), //i
    .reset                        (reset                                     )  //i
  );
  Pox pox_array_1 (
    .io_weight                    (io_weight[15:0]                           ), //i
    .io_activation_buffer_0       (io_activation_buffer_1_0[15:0]            ), //i
    .io_activation_buffer_1       (io_activation_buffer_1_1[15:0]            ), //i
    .io_activation_buffer_2       (io_activation_buffer_1_2[15:0]            ), //i
    .io_activation_fifo_in_0      (pox_array_2_io_activation_fifo_out_0[15:0]), //i
    .io_activation_fifo_in_1      (pox_array_2_io_activation_fifo_out_1[15:0]), //i
    .io_activation_fifo_in_2      (pox_array_2_io_activation_fifo_out_2[15:0]), //i
    .io_activation_buffer_standby (io_activation_buffer_standby_1[15:0]      ), //i
    .io_activation_source_from    (_zz_io_activation_source_from_1[1:0]      ), //i
    .io_activation_fifo_out_0     (pox_array_1_io_activation_fifo_out_0[15:0]), //o
    .io_activation_fifo_out_1     (pox_array_1_io_activation_fifo_out_1[15:0]), //o
    .io_activation_fifo_out_2     (pox_array_1_io_activation_fifo_out_2[15:0]), //o
    .io_clear                     (io_clear                                  ), //i
    .io_output_0                  (pox_array_1_io_output_0[15:0]             ), //o
    .io_output_1                  (pox_array_1_io_output_1[15:0]             ), //o
    .io_output_2                  (pox_array_1_io_output_2[15:0]             ), //o
    .clk                          (clk                                       ), //i
    .reset                        (reset                                     )  //i
  );
  Pox pox_array_2 (
    .io_weight                    (io_weight[15:0]                           ), //i
    .io_activation_buffer_0       (io_activation_buffer_2_0[15:0]            ), //i
    .io_activation_buffer_1       (io_activation_buffer_2_1[15:0]            ), //i
    .io_activation_buffer_2       (io_activation_buffer_2_2[15:0]            ), //i
    .io_activation_fifo_in_0      (16'h0                                     ), //i
    .io_activation_fifo_in_1      (16'h0                                     ), //i
    .io_activation_fifo_in_2      (16'h0                                     ), //i
    .io_activation_buffer_standby (io_activation_buffer_standby_2[15:0]      ), //i
    .io_activation_source_from    (ActivationSource_BUFFER_1                 ), //i
    .io_activation_fifo_out_0     (pox_array_2_io_activation_fifo_out_0[15:0]), //o
    .io_activation_fifo_out_1     (pox_array_2_io_activation_fifo_out_1[15:0]), //o
    .io_activation_fifo_out_2     (pox_array_2_io_activation_fifo_out_2[15:0]), //o
    .io_clear                     (io_clear                                  ), //i
    .io_output_0                  (pox_array_2_io_output_0[15:0]             ), //o
    .io_output_1                  (pox_array_2_io_output_1[15:0]             ), //o
    .io_output_2                  (pox_array_2_io_output_2[15:0]             ), //o
    .clk                          (clk                                       ), //i
    .reset                        (reset                                     )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(_zz_io_activation_source_from)
      ActivationSource_BUFFER_1 : _zz_io_activation_source_from_string = "BUFFER_1";
      ActivationSource_FIFO : _zz_io_activation_source_from_string = "FIFO    ";
      ActivationSource_SHIFT : _zz_io_activation_source_from_string = "SHIFT   ";
      default : _zz_io_activation_source_from_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_io_activation_source_from_1)
      ActivationSource_BUFFER_1 : _zz_io_activation_source_from_1_string = "BUFFER_1";
      ActivationSource_FIFO : _zz_io_activation_source_from_1_string = "FIFO    ";
      ActivationSource_SHIFT : _zz_io_activation_source_from_1_string = "SHIFT   ";
      default : _zz_io_activation_source_from_1_string = "????????";
    endcase
  end
  `endif

  assign counter_willIncrement = 1'b0;
  assign counter_willClear = 1'b0;
  assign counter_willOverflowIfInc = (counter_value == 4'b1000);
  assign counter_willOverflow = (counter_willOverflowIfInc && counter_willIncrement);
  always @(*) begin
    if(counter_willOverflow) begin
      counter_valueNext = 4'b0000;
    end else begin
      counter_valueNext = (counter_value + _zz_counter_valueNext);
    end
    if(counter_willClear) begin
      counter_valueNext = 4'b0000;
    end
  end

  assign _zz_io_activation_source_from = ((counter_value < 4'b0011) ? ActivationSource_BUFFER_1 : ActivationSource_FIFO);
  assign io_output_0_0 = pox_array_0_io_output_0;
  assign io_output_0_1 = pox_array_0_io_output_1;
  assign io_output_0_2 = pox_array_0_io_output_2;
  assign _zz_io_activation_source_from_1 = ((counter_value < 4'b0011) ? ActivationSource_BUFFER_1 : ActivationSource_FIFO);
  assign io_output_1_0 = pox_array_1_io_output_0;
  assign io_output_1_1 = pox_array_1_io_output_1;
  assign io_output_1_2 = pox_array_1_io_output_2;
  assign io_output_2_0 = pox_array_2_io_output_0;
  assign io_output_2_1 = pox_array_2_io_output_1;
  assign io_output_2_2 = pox_array_2_io_output_2;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      counter_value <= 4'b0000;
    end else begin
      counter_value <= counter_valueNext;
    end
  end


endmodule

//Pox replaced by Pox

//Pox replaced by Pox

module Pox (
  input      [15:0]   io_weight,
  input      [15:0]   io_activation_buffer_0,
  input      [15:0]   io_activation_buffer_1,
  input      [15:0]   io_activation_buffer_2,
  input      [15:0]   io_activation_fifo_in_0,
  input      [15:0]   io_activation_fifo_in_1,
  input      [15:0]   io_activation_fifo_in_2,
  input      [15:0]   io_activation_buffer_standby,
  input      [1:0]    io_activation_source_from,
  output     [15:0]   io_activation_fifo_out_0,
  output     [15:0]   io_activation_fifo_out_1,
  output     [15:0]   io_activation_fifo_out_2,
  input               io_clear,
  output     [15:0]   io_output_0,
  output     [15:0]   io_output_1,
  output     [15:0]   io_output_2,
  input               clk,
  input               reset
);
  localparam ActivationSource_BUFFER_1 = 2'd0;
  localparam ActivationSource_FIFO = 2'd1;
  localparam ActivationSource_SHIFT = 2'd2;

  wire       [15:0]   pe_array_0_io_activation_shift_out;
  wire       [15:0]   pe_array_0_io_output;
  wire       [15:0]   pe_array_1_io_activation_shift_out;
  wire       [15:0]   pe_array_1_io_output;
  wire       [15:0]   pe_array_2_io_activation_shift_out;
  wire       [15:0]   pe_array_2_io_output;
  reg        [15:0]   _zz_io_activation_fifo_out_0;
  reg        [15:0]   _zz_io_activation_fifo_out_0_1;
  reg        [15:0]   _zz_io_activation_fifo_out_0_2;
  reg        [15:0]   _zz_io_activation_fifo_out_1;
  reg        [15:0]   _zz_io_activation_fifo_out_1_1;
  reg        [15:0]   _zz_io_activation_fifo_out_1_2;
  reg        [15:0]   _zz_io_activation_fifo_out_2;
  reg        [15:0]   _zz_io_activation_fifo_out_2_1;
  reg        [15:0]   _zz_io_activation_fifo_out_2_2;
  `ifndef SYNTHESIS
  reg [63:0] io_activation_source_from_string;
  `endif


  PE pe_array_0 (
    .io_weight                 (io_weight[15:0]                         ), //i
    .io_activation_buffer      (io_activation_buffer_0[15:0]            ), //i
    .io_activation_fifo        (io_activation_fifo_in_0[15:0]           ), //i
    .io_activation_shift_in    (pe_array_1_io_activation_shift_out[15:0]), //i
    .io_activation_source_from (io_activation_source_from[1:0]          ), //i
    .io_activation_shift_out   (pe_array_0_io_activation_shift_out[15:0]), //o
    .io_reset_mac              (io_clear                                ), //i
    .io_output                 (pe_array_0_io_output[15:0]              ), //o
    .clk                       (clk                                     ), //i
    .reset                     (reset                                   )  //i
  );
  PE pe_array_1 (
    .io_weight                 (io_weight[15:0]                         ), //i
    .io_activation_buffer      (io_activation_buffer_1[15:0]            ), //i
    .io_activation_fifo        (io_activation_fifo_in_1[15:0]           ), //i
    .io_activation_shift_in    (pe_array_2_io_activation_shift_out[15:0]), //i
    .io_activation_source_from (io_activation_source_from[1:0]          ), //i
    .io_activation_shift_out   (pe_array_1_io_activation_shift_out[15:0]), //o
    .io_reset_mac              (io_clear                                ), //i
    .io_output                 (pe_array_1_io_output[15:0]              ), //o
    .clk                       (clk                                     ), //i
    .reset                     (reset                                   )  //i
  );
  PE pe_array_2 (
    .io_weight                 (io_weight[15:0]                         ), //i
    .io_activation_buffer      (io_activation_buffer_2[15:0]            ), //i
    .io_activation_fifo        (io_activation_fifo_in_2[15:0]           ), //i
    .io_activation_shift_in    (io_activation_buffer_standby[15:0]      ), //i
    .io_activation_source_from (io_activation_source_from[1:0]          ), //i
    .io_activation_shift_out   (pe_array_2_io_activation_shift_out[15:0]), //o
    .io_reset_mac              (io_clear                                ), //i
    .io_output                 (pe_array_2_io_output[15:0]              ), //o
    .clk                       (clk                                     ), //i
    .reset                     (reset                                   )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_activation_source_from)
      ActivationSource_BUFFER_1 : io_activation_source_from_string = "BUFFER_1";
      ActivationSource_FIFO : io_activation_source_from_string = "FIFO    ";
      ActivationSource_SHIFT : io_activation_source_from_string = "SHIFT   ";
      default : io_activation_source_from_string = "????????";
    endcase
  end
  `endif

  assign io_activation_fifo_out_0 = _zz_io_activation_fifo_out_0_2;
  assign io_output_0 = pe_array_0_io_output;
  assign io_activation_fifo_out_1 = _zz_io_activation_fifo_out_1_2;
  assign io_output_1 = pe_array_1_io_output;
  assign io_activation_fifo_out_2 = _zz_io_activation_fifo_out_2_2;
  assign io_output_2 = pe_array_2_io_output;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      _zz_io_activation_fifo_out_0 <= 16'h0;
      _zz_io_activation_fifo_out_0_1 <= 16'h0;
      _zz_io_activation_fifo_out_0_2 <= 16'h0;
      _zz_io_activation_fifo_out_1 <= 16'h0;
      _zz_io_activation_fifo_out_1_1 <= 16'h0;
      _zz_io_activation_fifo_out_1_2 <= 16'h0;
      _zz_io_activation_fifo_out_2 <= 16'h0;
      _zz_io_activation_fifo_out_2_1 <= 16'h0;
      _zz_io_activation_fifo_out_2_2 <= 16'h0;
    end else begin
      _zz_io_activation_fifo_out_0 <= pe_array_0_io_activation_shift_out;
      _zz_io_activation_fifo_out_0_1 <= _zz_io_activation_fifo_out_0;
      _zz_io_activation_fifo_out_0_2 <= _zz_io_activation_fifo_out_0_1;
      _zz_io_activation_fifo_out_1 <= pe_array_1_io_activation_shift_out;
      _zz_io_activation_fifo_out_1_1 <= _zz_io_activation_fifo_out_1;
      _zz_io_activation_fifo_out_1_2 <= _zz_io_activation_fifo_out_1_1;
      _zz_io_activation_fifo_out_2 <= pe_array_2_io_activation_shift_out;
      _zz_io_activation_fifo_out_2_1 <= _zz_io_activation_fifo_out_2;
      _zz_io_activation_fifo_out_2_2 <= _zz_io_activation_fifo_out_2_1;
    end
  end


endmodule

//PE replaced by PE

//PE replaced by PE

//PE replaced by PE

//PE replaced by PE

//PE replaced by PE

//PE replaced by PE

//PE replaced by PE

//PE replaced by PE

module PE (
  input      [15:0]   io_weight,
  input      [15:0]   io_activation_buffer,
  input      [15:0]   io_activation_fifo,
  input      [15:0]   io_activation_shift_in,
  input      [1:0]    io_activation_source_from,
  output     [15:0]   io_activation_shift_out,
  input               io_reset_mac,
  output     [15:0]   io_output,
  input               clk,
  input               reset
);
  localparam ActivationSource_BUFFER_1 = 2'd0;
  localparam ActivationSource_FIFO = 2'd1;
  localparam ActivationSource_SHIFT = 2'd2;

  reg        [15:0]   mac_9_io_activation;
  wire       [15:0]   mac_9_io_output;
  reg        [15:0]   mac_9_io_activation_regNext;
  `ifndef SYNTHESIS
  reg [63:0] io_activation_source_from_string;
  `endif


  MAC mac_9 (
    .io_weight     (io_weight[15:0]          ), //i
    .io_activation (mac_9_io_activation[15:0]), //i
    .io_output     (mac_9_io_output[15:0]    ), //o
    .io_clear      (io_reset_mac             ), //i
    .clk           (clk                      ), //i
    .reset         (reset                    )  //i
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_activation_source_from)
      ActivationSource_BUFFER_1 : io_activation_source_from_string = "BUFFER_1";
      ActivationSource_FIFO : io_activation_source_from_string = "FIFO    ";
      ActivationSource_SHIFT : io_activation_source_from_string = "SHIFT   ";
      default : io_activation_source_from_string = "????????";
    endcase
  end
  `endif

  always @(*) begin
    case(io_activation_source_from)
      ActivationSource_BUFFER_1 : begin
        mac_9_io_activation = io_activation_buffer;
      end
      ActivationSource_FIFO : begin
        mac_9_io_activation = io_activation_fifo;
      end
      default : begin
        mac_9_io_activation = io_activation_shift_in;
      end
    endcase
  end

  assign io_output = mac_9_io_output;
  assign io_activation_shift_out = mac_9_io_activation_regNext;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      mac_9_io_activation_regNext <= 16'h0;
    end else begin
      mac_9_io_activation_regNext <= mac_9_io_activation;
    end
  end


endmodule

//MAC replaced by MAC

//MAC replaced by MAC

//MAC replaced by MAC

//MAC replaced by MAC

//MAC replaced by MAC

//MAC replaced by MAC

//MAC replaced by MAC

//MAC replaced by MAC

module MAC (
  input      [15:0]   io_weight,
  input      [15:0]   io_activation,
  output     [15:0]   io_output,
  input               io_clear,
  input               clk,
  input               reset
);

  wire       [24:0]   _zz_accumulator;
  wire       [31:0]   _zz_accumulator_1;
  wire       [31:0]   _zz_accumulator_2;
  wire       [22:0]   _zz_accumulator_3;
  wire       [31:0]   _zz_accumulator_4;
  reg        [15:0]   accumulator;

  assign _zz_accumulator = (_zz_accumulator_1 >>> 7);
  assign _zz_accumulator_1 = ($signed(_zz_accumulator_2) + $signed(_zz_accumulator_4));
  assign _zz_accumulator_3 = ({7'd0,accumulator} <<< 7);
  assign _zz_accumulator_2 = {{9{_zz_accumulator_3[22]}}, _zz_accumulator_3};
  assign _zz_accumulator_4 = ($signed(io_weight) * $signed(io_activation));
  assign io_output = accumulator;
  always @(posedge clk or posedge reset) begin
    if(reset) begin
      accumulator <= 16'h0;
    end else begin
      if(io_clear) begin
        accumulator <= 16'h0;
      end else begin
        accumulator <= _zz_accumulator[15:0];
      end
    end
  end


endmodule
