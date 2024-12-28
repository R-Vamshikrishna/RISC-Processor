`timescale 1ns / 1ps
module TBDecoder();
reg [15:0] I_instruction;
reg I_clk;             
reg I_enable;            
wire [4:0] O_ALU;               
wire [2:0] O_Rd ;               
wire [2:0] O_Ra ;               
wire [2:0] O_Rb ;               
wire [15:0] O_immediate;  
wire O_WriteEnable;        
Instruction_Decoder DecoderBlock(
.I_instruction     (I_instruction),
.I_clk             (I_clk        ),
.I_enable          (I_enable     ),
.O_ALU             (O_ALU        ),  
.O_Rd              (O_Rd         ),  
.O_Ra              (O_Ra         ),  
.O_Rb              (O_Rb         ),  
.O_immediate       (O_immediate  ), 
.O_WriteEnable     (O_WriteEnable)
);
initial begin
    I_clk = 0; 
    I_enable = 0;
    I_instruction = 16'b0000000000000000;
    
    #10 I_instruction = 16'b0001010110000100;
    #10 I_enable = 1;
end
always begin
    #5 I_clk = ~I_clk;
end
endmodule
