`timescale 1ns / 1ps
module RegisterHandler(
// Input Ports
input I_clk,
input I_enable,
input I_WriteEnable,
input [2:0] I_Ra,
input [2:0] I_Rb,
input [2:0] I_Rd,
input [15:0] I_data,
// Output Ports
output reg [15:0] O_dataA,
output reg [15:0] O_dataB
);

reg [15:0] register [7:0];
integer count;
initial begin
    O_dataA <= 16'b0000000000000000;
    O_dataB <= 16'b0000000000000000;
    for(count = 0 ; count < 8 ; count=count+1) begin
        register[count] = 16'b0000000000000000;    
    end  
end
always@(negedge I_clk) begin
    if(I_enable) begin
        if(I_WriteEnable) register[I_Rd] <= I_data ; 
        
        O_dataA <= register[I_Ra];
        O_dataB <= register[I_Rb];
    end
end 
endmodule
