`timescale 1ns / 1ps
module RISCProcessor();
reg clk;
reg reset;
reg RAM_WriteEnable = 0;
reg [15:0] dataI = 0;

wire [2:0] Ra;
wire [2:0] Rb;
wire [2:0] Rd;
wire [15:0] dataA;
wire [15:0] dataB;
wire [15:0] dataD;
wire [15:0] dataO;
wire [4:0] opcode;
wire [1:0] opcodePC;
wire [7:0] immediate;
wire [15:0] pcO;

wire shouldbranch;
wire Fetch        ;
wire Decoder      ;
wire RegisterRead ;
wire RegisterWrite;
wire EnableALU    ;
wire EnableMemory ;
wire RegisterWE;
wire update;

assign RegisterWrite = RegisterWE & update ;
assign opcodePC = (reset) ? 2'b11 : ((shouldbranch) ? 2'b10 :((EnableMemory) ? 2'b01 :2'b00));

// Instantiations
Instruction_Decoder DecoderBlock(
.I_instruction     (dataO      ),
.I_clk             (clk        ),
.I_enable          (Decoder    ),
.O_ALU             (opcode     ),  
.O_Rd              (Rd         ),  
.O_Ra              (Ra         ),  
.O_Rb              (Rb         ),  
.O_immediate       (immediate  ), 
.O_WriteEnable     (RegisterWE)
);

ControlUnit Main_ControlBLock(
.I_clk          (clk          ),
.I_reset        (reset        ),
.O_Fetch        (Fetch        ),         
.O_Decoder      (Decoder      ),        
.O_RegisterRead (RegisterRead ),  
.O_RegisterWrite(update       ), 
.O_EnableALU    (EnableALU    ),     
.O_EnableMemory (EnableMemory ) 
);

ALU Main_ALU(                           
.I_clk         (clk         ) ,          
.I_enable      (EnableALU   ) ,          
.I_opcode      (opcode      ) ,   
.I_dataA       (dataA       ) ,    
.I_dataB       (dataB       ) ,    
.I_immediate   (immediate   ) ,           
.O_data        (dataD       ) ,     
.O_shouldbranch(shouldbranch)    
);                        

ProgramCounter Main_ProgramCounter(
.I_clk   (clk     ),
.I_opcode(opcodePC),
.I_pc    (dataD   ), 
.O_pc    (pcO     ) 
);

RegisterHandler Main_HandlerBlock(
.I_clk        (clk        ),
.I_enable     (RegisterRead),
.I_WriteEnable(RegisterWrite),
.I_Ra         (Ra         ),
.I_Rb         (Rb         ),
.I_Rd         (Rd         ),
.I_data       (dataI      ),
.O_dataA      (dataA      ),
.O_dataB      (dataB      ) 
);

RAM Main_RAM(
.I_clk        (clk            ),
.I_WriteEnable(RAM_WriteEnable),
.I_address    (pcO            ),
.I_data       (dataI          ), 
.O_data       (dataO          ) 
);

initial begin
    clk = 0;
    reset = 1;
    #20 
    reset = 0; 
end

always begin
    #5 clk = ~clk;
end

endmodule
