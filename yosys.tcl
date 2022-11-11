yosys read_verilog ./src/Mux.v ./src/Post_top.v ./src/PostProcess.v ./src/Serializer.v ./src/Pooling.v
yosys hierarchy -top Post_top
yosys proc
yosys opt
yosys stat