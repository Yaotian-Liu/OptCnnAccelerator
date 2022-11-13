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

    Qtype = "Q4.12"

    # i_f = 6
    # size = 14
    # o_f = 16

    i_f = 3
    size = 10
    o_f = 4
    out_size = size - kernel_size + 1

    fmap = np.random.rand(i_f, size, size)
    wmap = np.random.rand(o_f, i_f, kernel_size, kernel_size)

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

    def converter(listOrNumber):
        return (
            map(converter, listOrNumber)
            if type(listOrNumber) == "<class 'list'>"
            else Fxp(listOrNumber, dtype=Qtype).bin()
        )
    print(converter(fmap.tolist()))
    with open(f"a.json", "w") as f:
        f.write(
            json.dumps(
                {
                    "fmap": converter(fmap.tolist()),
                    "wmap": wmap.tolist(),
                    "conv": conv2d(fmap, wmap).tolist(),
                }
            )
        )

    dut._id("io_poyInput_master_en", extended=False).value = 1
    for i in range(poy):
        dut._id(f"io_poyInput_clear_{i}", extended=False).value = 0

    for x in range(0, out_size, kernel_size):
        for y in range(0, out_size, kernel_size):
            fmap_buffer = fmap[
                :, y : y + poy + kernel_size - 1, x : x + pox + kernel_size - 1
            ]

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
                    for j in range(poy):
                        dut._id(
                            f"io_poyInput_activation_buffer_standby_{j}", extended=False
                        ).value = BinaryValue(
                            Fxp(fmap_single_channel[j][i], dtype=Qtype).bin()
                        )
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

                for row in range(poy, kernel_size):
                    for i in range(pox):
                        dut._id(
                            f"io_poyInput_activation_buffer_{poy-1}_{i}", extended=False
                        ).value = BinaryValue(
                            Fxp(fmap_single_channel[row][i], dtype=Qtype).bin()
                        )
                    for i in range(pox, pox + kernel_size - 1):
                        dut._id(
                            f"io_poyInput_activation_buffer_standby_{poy-1}",
                            extended=False,
                        ).value = BinaryValue(
                            Fxp(fmap_single_channel[row][i], dtype=Qtype).bin()
                        )
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