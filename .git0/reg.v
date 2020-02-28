`timescale 1ns/1ps

module rf(
    input clk,
    input nrst,
    input [4:0] rd_addrA,
    input [4:0] rd_addrB,
    output reg [31:0] rd_dataA,
    output reg [31:0] rd_dataB,
    input wr_en,
    input [4:0] wr_addr,
    input [31:0] wr_data
);

integer i;
reg [31:0] r [31:0]; //32 32-bit registers

always @ (posedge clk or negedge nrst) begin
  if(!nrst) begin
    //set all registers to 0 
    for(i=0;i<32;i=i+1) begin
      r[i] <= 0;
    end
  end
  else
    if(wr_en)
      if(wr_addr != 0) // if not reg 0, write.
        r[wr_addr] <= wr_data;
end

always @ (*) begin
  rd_dataA <= r[rd_addrA];
  rd_dataB <= r[rd_addrB];
end

endmodule
