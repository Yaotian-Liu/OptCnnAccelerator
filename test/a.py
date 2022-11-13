import cocotb
from cocotb.triggers import FallingEdge, Timer
from cocotb.clock import Clock
from cocotb.result import TestSuccess, TestFailure
from cocotb.triggers import RisingEdge
from cocotb.binary import BinaryValue

import numpy as np
import json
from fxpmath import Fxp
import torch

import debugpy

debugpy.listen(4000)
print("Waiting for debugger attach")
debugpy.wait_for_client()


@cocotb.test()
async def test(dut):
    await cocotb.start(Clock(dut.clk, 10, "ns").start())

    dut.reset.value = 1
    for _ in range(3):
        await RisingEdge(dut.clk)
    dut.reset.value = 0

    pof = 4
    poy = 4
    pox = 4
    kernel_size = 5
    CHANNEL_N = 4

    Qtype = "Q5.11"

    # i_f = 6
    # size = 14
    # o_f = 16

    i_f = 3
    size = 10
    o_f = 4
    out_size = size - kernel_size + 1

    fmap = np.random.rand(i_f, size, size) / 10
    wmap = np.random.rand(o_f, i_f, kernel_size, kernel_size) / 10

    def conv2d(fmap, filters):
        return np.array(
            [
                np.multiply(
                    np.lib.stride_tricks.sliding_window_view(fmap, (filter.shape)),
                    filter,
                ).sum(axis=(-3, -2, -1))
                for filter in filters
            ]
        )

    def converter(a):
        bin_list = []
        for e in np.nditer(a):
            x = Fxp(e, dtype=Qtype)
            bin_list.append(x.hex())
        return np.array(bin_list).reshape(a.shape).tolist()

    with open(f"a.json", "w") as f:
        f.write(
            json.dumps(
                {
                    "fmap": fmap.tolist(),
                    "wmap": wmap.tolist(),
                    "conv": conv2d(fmap, wmap).tolist(),
                }
            )
        )

    with open(f"b.json", "w") as f:
        f.write(
            json.dumps(
                {
                    "fmap": converter(fmap),
                    "wmap": converter(wmap),
                    "conv": converter(conv2d(fmap, wmap)),
                }
            )
        )

    dut._id("io_poyInput_master_en", extended=False).value = 1
    for i in range(poy):
        dut._id(f"io_poyInput_clear_{i}", extended=False).value = 0

    for x in range(0, out_size, kernel_size):
        for y in range(0, out_size, kernel_size):
            fmap_buffer = fmap[
                :,
                y : min(size, y + poy + kernel_size - 1),
                x : min(size, x + pox + kernel_size - 1),
            ]

            fmap_buffer = np.pad(
                fmap_buffer,
                (
                    (0,0),
                    (0, int(max(0, poy + kernel_size - 1 - size))),
                    (0, int(max(0, pox + kernel_size - 1 - size))),
                ),
                constant_values=0,
            )

            for fmap_index, fmap_single_channel in enumerate(fmap_buffer):
                for j in range(poy):
                    for i in range(pox):
                        dut._id(
                            f"io_poyInput_activation_buffer_{j}_{i}", extended=False
                        ).value = BinaryValue(
                            Fxp(fmap_single_channel[j][i], dtype=Qtype).bin()
                        )

                wi = 0
                for i in range(pox, pox + kernel_size - 1):
                    for of in range(pof):
                        dut._id(
                            f"io_poyInput_weight_{of}", extended=False
                        ).value = BinaryValue(
                            Fxp(
                                wmap[
                                    of, fmap_index, wi // kernel_size, wi % kernel_size
                                ],
                                dtype=Qtype,
                            ).bin()
                        )
                    await RisingEdge(dut.clk)
                    wi = wi + 1
                    for j in range(poy):
                        dut._id(
                            f"io_poyInput_activation_buffer_standby_{j}", extended=False
                        ).value = BinaryValue(
                            Fxp(fmap_single_channel[j][i], dtype=Qtype).bin()
                        )

                for row in range(poy, poy + kernel_size - 1):
                    await RisingEdge(dut.clk)
                    for i in range(pox):
                        dut._id(
                            f"io_poyInput_activation_buffer_{poy-1}_{i}", extended=False
                        ).value = BinaryValue(
                            Fxp(fmap_single_channel[row][i], dtype=Qtype).bin()
                        )
                    for i in range(pox, pox + kernel_size - 1):
                        for of in range(pof):
                            dut._id(
                                f"io_poyInput_weight_{of}", extended=False
                            ).value = BinaryValue(
                                Fxp(
                                    wmap[
                                        of,
                                        fmap_index,
                                        wi // kernel_size,
                                        wi % kernel_size,
                                    ],
                                    dtype=Qtype,
                                ).bin()
                            )
                        await RisingEdge(dut.clk)
                        wi = wi + 1
                        dut._id(
                            f"io_poyInput_activation_buffer_standby_{poy-1}",
                            extended=False,
                        ).value = BinaryValue(
                            Fxp(fmap_single_channel[row][i], dtype=Qtype).bin()
                        )
                await RisingEdge(dut.clk)
            await RisingEdge(dut.clk)
            dut.io_poyInput_reset_mac.value = True
            print(hex(dut.conv_0_io_output_0_0.value) )
