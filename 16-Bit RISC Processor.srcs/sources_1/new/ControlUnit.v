`timescale 1ns / 1ps
// This Module directs in which order things are going to happen and makes operations in a sequential Way
module ControlUnit(
// Input Ports
input I_clk,
input I_reset,
// Output Ports
output O_Fetch,         // Enable Fetch
output O_Decoder,       // Enable Decoder 
output O_RegisterRead,  // Enable Read
output O_RegisterWrite, // Enable Write
output O_EnableALU,     // Enable ALU
output O_EnableMemory   // Enable Memory
);
reg [5:0] state;
initial state <= 6'b000001;
always @(negedge I_clk) begin 
    if(I_reset) state <= 6'b0000001;
    else begin
        case(state)
            6'b000001: state <= 6'b000010;
            6'b000010: state <= 6'b000100;
            6'b000100: state <= 6'b001000;
            6'b001000: state <= 6'b010000;
            6'b010000: state <= 6'b100000;
            default  : state <= 6'b000001;
        endcase
    end
end
assign O_Fetch = state[0];
assign O_Decoder = state[1];
assign O_RegisterRead = state[2] | state[4];
assign O_EnableALU = state[3];
assign O_RegisterWrite = state[4];
assign O_EnableMemory = state[5];
endmodule
