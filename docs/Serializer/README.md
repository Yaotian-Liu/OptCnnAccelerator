# Serializer

Serialize the output of MAC in order to reduce the number of adders (for bias) and batch normalization computing units.

![image-20221105223352139](./README.assets/image-20221105223352139.png)

In the above figure, the output is serialized twice.
The first time is not explicitly depicted, not written in the box, which transform the Poy * Pox width of data into Pox.
The second one is implemented by the MUX.

The above is realizable due to 2 * Poy < Nkx * Nky * Nif.

Actually, if
$$
N*Poy < Nkx*Nky*Nif
$$
Then there can be N serializations.

## IO

```verilog
module Serializer #(
  parameter POX = 3,
  parameter POY = 3
) (
  input                               clk                  ,
  input                               rst                  ,
  input      [POY-1:0][POX-1:0][15:0] mac_output           ,
  input                               mac_output_valid     ,
  input                               serializer_out_signal, // when chosen by MUX
  output reg [POX-1:0][   15:0]       serializer_out
);
```
