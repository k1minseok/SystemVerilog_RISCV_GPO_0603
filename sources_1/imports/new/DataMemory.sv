`timescale 1ns / 1ps

module DataMemory (  // RAM
    input logic        clk,
    input logic        ce,
    input logic        wr_en,
    input logic [ 7:0] addr,
    input logic [31:0] wdata,

    output logic [31:0] rdata
);
    logic [31:0] ram[0:2**6-1];

    initial begin  // initial for test
        int i;
        for (i = 0; i < 2**6; i++) begin
            ram[i] = 100 + i;
        end
        ram[62] = 32'h8765_4321;  // 0xf0f0 f0f0
        ram[63] = -252645136;  // 0xf0f0 f0f0
    end

    assign rdata = ram[addr[7:2]];

    always_ff @(posedge clk) begin
        if (wr_en & ce) ram[addr[7:2]] <= wdata;
    end
endmodule
