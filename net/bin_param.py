import sys
import torch
import json
import numpy as np
from fxpmath import Fxp

DTYPE_LIST = [f"Q{n}.{16-n}" for n in range(1, 17)]


def generate_json_bin_param(dtype="Q4.12"):
    param = torch.load("params.pth")
    new_param = dict()

    for k, v in param.items():
        if "num_batches_tracked" in k:
            continue
        else:
            new_param[k] = v

    EPSILON = 1e-5

    merge_lists = [
        [
            "conv1.2.weight",
            "conv1.2.bias",
            "conv1.2.running_mean",
            "conv1.2.running_var",
        ],
        [
            "conv2.2.weight",
            "conv2.2.bias",
            "conv2.2.running_mean",
            "conv2.2.running_var",
        ],
    ]

    for i, merge_list in enumerate(merge_lists):

        weight = new_param.pop(merge_list[0])
        bias = new_param.pop(merge_list[1])
        mean = new_param.pop(merge_list[2])
        var = new_param.pop(merge_list[3])

        fusion_K = weight / torch.sqrt(var + EPSILON)
        fusion_B = bias - weight * mean / torch.sqrt(var + EPSILON)

        new_param[f"conv{i+1}.2.fusion_K"] = fusion_K
        new_param[f"conv{i+1}.2.fusion_B"] = fusion_B

    fixed_point_bin_param = {}

    for key, value in new_param.items():
        shape = value.shape

        value = np.array(value.to("cpu"))

        bin_list = []

        for e in np.nditer(value):
            x = Fxp(e, dtype=dtype)
            bin_list.append(x.bin())

        bin_array = np.array(bin_list).reshape(shape).tolist()

        fixed_point_bin_param[key] = bin_array

    with open(f"bin_param_{dtype}.json", "w") as f:
        f.write(json.dumps(fixed_point_bin_param))


def generate_test_bin_data(dtype="Q4.12"):
    test_data = np.array(torch.load("test_data")).reshape(28, 28)
    shape = test_data.shape

    new_data_bin = []

    for d in np.nditer(test_data):
        new_data_bin.append(Fxp(float(d), dtype=dtype).bin())

    new_data_bin = np.array(new_data_bin).reshape(shape).tolist()

    test_data_dict = dict()
    test_data_dict["test_data"] = new_data_bin
    with open(f"bin_test_data_{dtype}.json", "w") as f:
        f.write(json.dumps(test_data_dict))


if __name__ == "__main__":
    dtype = sys.argv[1]
    if dtype not in DTYPE_LIST:
        print("Not supported!")
    else:
        generate_json_bin_param(dtype)
        generate_test_bin_data(dtype)
