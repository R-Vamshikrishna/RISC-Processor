`timescale 1ns / 1ps
module RAM(
// Input Ports
input I_clk,
input I_WriteEnable,
input [15:0] I_address,
input [15:0] I_data,
// Output Ports
output reg  [15:0] O_data
);
reg [15:0] memory [8:0];
initial begin
    memory[0] = 16'b1000000011111110;
    memory[1] = 16'b1000100111101101;
    memory[2] = 16'b0010001000100000;
    memory[3] = 16'b1000001100000001;
    memory[4] = 16'b1000010000000001;
    memory[5] = 16'b0000001101110000;
    memory[6] = 16'b1100000000000101;
    memory[7] = 0;
    memory[8] = 0;
    O_data    = 16'b0000000000000000;   
end
always@(negedge I_clk) begin
    if(I_WriteEnable) begin
        memory[I_address[15:0]] <= I_data; 
    end
    O_data <= memory[I_address[15:0]];
end
endmodule
