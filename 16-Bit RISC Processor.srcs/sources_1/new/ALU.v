`timescale 1ns / 1ps
module ALU(
// Input Ports
input I_clk  ,
input I_enable ,
input [4:0]  I_opcode ,
input [15:0] I_dataA ,
input [15:0] I_dataB ,
input [7:0]  I_immediate ,
// Output Ports
output [15:0] O_data,
output reg O_shouldbranch
);
reg [17:0] result ;
wire [3:0] opcode ;
wire check ;

localparam Add = 0,
           Sub = 1,
           OR  = 2,
           AND = 3,
           XOR = 4,
           NOT = 5,
           LRG = 8,
           COM = 9,
           LSR = 10,
           RSR = 11,
           JA = 12,
           JR = 13;
           
// assign statements
assign check = I_opcode[0];
assign opcode = I_opcode[4:1];
// Assigning the output
assign O_data = result[15:0];
// Initial Block            
initial begin
    result = 0;
end
always@(negedge I_clk) begin
    if(I_enable) begin
        case(opcode)
            Add : begin
                  result <= (check?($signed(I_dataA)+$signed(I_dataB)):(I_dataA+I_dataB));
                  O_shouldbranch <= 0;         
                  end
            Sub : begin
                  result <= (check?($signed(I_dataA)-$signed(I_dataB)):(I_dataA-I_dataB));
                  O_shouldbranch <= 0;
                  end 
            OR  : begin
                  result <= I_dataA | I_dataB; 
                  O_shouldbranch <= 0; 
                  end            
            AND : begin
                  result <= I_dataA & I_dataB;
                  O_shouldbranch <= 0;
                  end
            XOR : begin
                  result <= I_dataA ^ I_dataB;
                  O_shouldbranch <= 0;
                  end
            NOT : begin
                  result <= ~I_dataA;
                  O_shouldbranch <= 0;  
                  end 
            LRG : begin
                  result <= (check ? ({I_immediate,8'h00}):({8'h00,I_immediate}));
                  O_shouldbranch <= 0;
                  end
            COM : begin
                    if(check)begin
                    result[0] <= ($signed(I_dataA) == $signed(I_dataB))? 1 : 0;
                    result[1] <= ($signed(I_dataA) == 0)? 1 : 0;
                    result[2] <= ($signed(I_dataB) == 0)? 1 : 0;
                    result[3] <= ($signed(I_dataA) > $signed(I_dataB))? 1 : 0;
                    result[4] <= ($signed(I_dataA) < $signed(I_dataB))? 1 : 0;
                    end
                    else begin
                    result[0] <= (I_dataA) == (I_dataB)? 1 : 0;
                    result[1] <= (I_dataA) == 0? 1 : 0;
                    result[2] <= (I_dataB) == 0? 1 : 0;
                    result[3] <= (I_dataA) > (I_dataB)? 1 : 0;
                    result[4] <= (I_dataA) <(I_dataB)? 1 : 0;
                    end
                    O_shouldbranch <= 0;
                  end
            LSR : begin
                  result <= (I_dataA)<<(I_dataB[3:0]);
                  O_shouldbranch <= 0;
                  end 
            RSR : begin
                  result <= (I_dataA)>>(I_dataB[3:0]);
                  O_shouldbranch <= 0;
                  end 
            JA  : begin
                  result <= check ?  I_dataA : I_immediate ;
                  O_shouldbranch <= 1;
                  end  
            JR  : begin
                  result <= I_dataA;
                  O_shouldbranch <= I_dataB[{check,I_immediate[1:0]}];               
                  end              
        endcase
    end
end           
endmodule
