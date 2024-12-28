`timescale 1ns / 1ps
module Instruction_Decoder(
//input ports
input I_clk,
input I_enable,
input [15:0] I_instruction,
//output ports
output reg [4:0] O_ALU,  // Operation for ALU 
output reg [2:0] O_Ra ,  // Address of Destination Register
output reg [2:0] O_Rb ,  // Address of Register A
output reg [2:0] O_Rd ,  // Address of Register B
output reg [15:0] O_immediate, // Address of Immediate 
output reg O_WriteEnable // Write Enable
);

initial begin
    O_ALU <= 0;
    O_Rd <= 0;
    O_Ra <= 0;
    O_Rb <= 0;
    O_immediate <= 0;
    O_WriteEnable <= 0;  
end

always@(negedge I_clk) begin
    if(I_enable) begin
        O_ALU <= I_instruction[15:11];
        O_Ra  <= I_instruction[10:8];
        O_Rb  <= I_instruction[7:5];
        O_Rd  <= I_instruction[4:2];
        O_immediate <= I_instruction[7:0];
        case(I_instruction[15:11])
            4'b0111 : O_WriteEnable <= 0;
            4'b1100 : O_WriteEnable <= 0;
            4'b1101 : O_WriteEnable <= 0;
            default : O_WriteEnable <= 1;
        endcase
    end
end   
endmodule
