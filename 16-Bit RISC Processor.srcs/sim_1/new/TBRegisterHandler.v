`timescale 1ns / 1ps
module TBRegisterHandler();
reg I_clk;         
reg I_enable;      
reg I_WriteEnable; 
reg [2:0] I_Ra;    
reg [2:0] I_Rb;    
reg [2:0] I_Rd;    
reg [15:0] I_data; 
wire [15:0] O_dataA;
wire [15:0] O_dataB;

RegisterHandler HandlerBlock(
.I_clk         (I_clk        ),
.I_enable      (I_enable     ),
.I_WriteEnable (I_WriteEnable),
.I_Ra          (I_Ra         ),
.I_Rb          (I_Rb         ),
.I_Rd          (I_Rd         ),
.I_data        (I_data       ),
.O_dataA       (O_dataA      ),
.O_dataB       (O_dataB      )
);

initial begin
    I_clk = 0 ;      
    I_enable =0 ;   
    I_WriteEnable =0 ; 
    I_Ra = 0; 
    I_Rb = 0; 
    I_Rd = 0;
    I_data = 0; 
    
    // Start TestCase
    #7
    I_enable = 1;
    I_Rb = 3'b001;
    I_Ra = 3'b000;
    I_Rd = 3'b000;
    I_data = 16'hFFFF;
    I_WriteEnable = 1'b1;
    
    #10 
    I_WriteEnable = 1'b0;
    I_Rd = 3'b010;
    I_data = 16'h2222;
    
    #10
    I_WriteEnable = 1'b1;
    
    #10 
    I_data = 16'h3333;
    
    #10
    I_WriteEnable = 1'b0;
    I_Rd = 3'b000;
    I_data = 16'hFEED;
    
    #10
    I_Rd = 3'b100;
    I_data = 16'h4444;
    
    #10
    I_WriteEnable = 1'b1;
    
    #50
    I_Ra = 3'b100;
    I_Rb = 3'b100;
    
    #20 
    $finish;
end

always begin
    #5 I_clk = ~I_clk;
end
endmodule
