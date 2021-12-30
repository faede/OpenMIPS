module  ID_EX(
    input wire          clk,
    input wire          rst,

    input wire[`AluOpBus]           ID_ALUOp,
    input wire[`ALUSelBus]          ID_ALUSel,
    input wire[`RegBus]             id_reg1,
    input wire[`RegBus]             id_reg2,
    input wire[`RegAddrBus]         id_wd,
    input wire                      id_wreg,


    output reg[`AluOpBus]           EX_ALUOp,
    output reg[`AluSelBus]          EX_ALUSel,
    output reg[`RegBus]             ex_reg1,
    output reg[`RegBus]             ex_reg2,
    output reg[`RegAddrBus]         ex_wd,
    output reg                      ex_wreg
);
    always @(posedge clk) begin
        if(rst == `RstEnable)begin
            EX_ALUOp    <= `EXE_NOP_OP;
            EX_ALUSel   <= `EXE_RES_NOP;
            ex_reg1     <= `ZeroWord;
            ex_reg2     <= `ZeroWord;
            ex_wd       <= `NOPRegAddr;
            ex_wreg     <= `WriteDisable;
        end else begin
            EX_ALUOp    <= ID_ALUOp;
            EX_ALUSel   <= ID_ALUSel;
            ex_reg1     <= id_reg1;
            ex_reg2     <= id_reg2;
            ex_wd       <= id_wd;
            ex_wreg     <= id_wreg;
        end
    end
    
endmodule