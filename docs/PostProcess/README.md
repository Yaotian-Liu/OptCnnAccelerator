# PostProcess

![image-20221107211024160](./README.assets/image-20221107211024160.png)

Post process includes adding bias and applying batch norm.
$$
\begin{aligned}
x' &= x + b \\
x'' &= \gamma\cdot\frac{x'-\Epsilon[x]}{\sqrt{\mathrm{Var}[x]+\epsilon}}+\beta\\
\Rightarrow
x''&= \frac{\gamma}{\sqrt{\mathrm{Var}[x]+\epsilon}}\cdot x + (\beta+\gamma\cdot\frac{b-\Epsilon[x]}{\sqrt{\mathrm{Var}[x]+\epsilon}}) \\
x'' &=Kx + B,\ \mathrm{where}\ K=\frac{\gamma}{\sqrt{\mathrm{Var}[x]+\epsilon}},\
B=\beta+\gamma\cdot\frac{b-\Epsilon[x]}{\sqrt{\mathrm{Var}[x]+\epsilon}}
\end{aligned}
$$
Here we combine these two processes, resulting in a single linear transformation.

## IO

```verilog
module PostProcess # (
    parameter Pox = 3
) (
    input clk,
    input rst,
    input [Pox-1:0][15:0] mux_out,
    input mux_out_valid,
    input [Pox-1:0][15:0] K,
    input [Pox-1:0][15:0] B,
    output [Pox-1:0][15:0] post_out,
    output post_out_valid
);
```
