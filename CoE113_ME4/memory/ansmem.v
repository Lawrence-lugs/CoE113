`timescale 1ns/1ps
`define MEM_DEPTH  4096
`define MEM_WIDTH  8
`define WORD_WIDTH 32

module ansmem(
    input clk,
    input [`WORD_WIDTH - 1:0] data_addr,
    input data_wr,
    input [`WORD_WIDTH - 1:0] data_in,          // output of processor
    output reg [`WORD_WIDTH - 1:0] data_out     // input to processor
);

    reg [`MEM_WIDTH-1:0] memory [0:`MEM_DEPTH-1];

    initial begin
        $readmemh("ansmem_parse.txt", memory);
    end

    // Read data port
    always @ (*)
        data_out <= {memory[data_addr],
                    memory[data_addr+1],
                    memory[data_addr+2],
                    memory[data_addr+3]};

    // Write data port
    always @ (posedge clk)
        if (data_wr) begin
            memory[data_addr] <= data_in[31:24];
            memory[data_addr+1] <= data_in[23:16];
            memory[data_addr+2] <= data_in[15:8];
            memory[data_addr+3] <= data_in[7:0];
        end

endmodule
