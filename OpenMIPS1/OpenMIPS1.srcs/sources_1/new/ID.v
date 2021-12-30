module ID(
    input wire      rst,
    input wire[`InstAddrBus]    PC_i,
    input wire[`InstBus]        Inst_i,


    // read the value of regfile
    input wire[`RegBus]         reg1_data_i,
    input wire[`RegBus]         reg2_data_i,

    // output to Regfile
    output reg                  reg1_read_o,
    output reg                  reg2_read_o,
    output reg[`RegAddrBus]     reg1_addr_o,
    output reg[`RegAddrBus]     reg2_addr_o,

    // sent to Exe
    output reg[`AluOpBus]       ALUOp_o,
    output reg[`AluSelBus]      ALUSel_o,
    output reg[`RegBus]         reg1_o,
    output reg[`RegBus]         reg2_o,
    output reg[`RegAddrBus]     wd_o,
    output reg                  wreg_o
);
    //generate opcode
    wire[5:0] op = Inst_i[31:26];
    wire[4:0] op2 = Inst_i[10:6];
    wire[5:0] op3 = Inst_i[5:0];
    wire[4:0] op4 = Inst_i[20:16];

    reg[`RegBus]    imm;
    reg instvalid;

    // translate
    always @(*) begin
        if(rst == `RstEnable)begin
            ALUOp_o     <= `EXE_NOP_OP;
            ALUSel_o    <= `EXE_RES_NOP;
            wd_o        <= `NOPRegAddr;
            rwreg_o     <= `WriteDisable;
            instvalid   <= `InstValid;
            reg1_read_o <= 1'b0;
            reg2_read_o <= 1'b0;
            reg1_addr_o <= `NOPRegAddr;
            reg2_addr_o <= `NOPRegAddr;
            imm         <= `ZeroWord;
        end else begin
            ALUOp_o     <= `EXE_NOP_OP;
            ALUSel_o    <= `EXE_RES_NOP;
            wd_o        <= Inst_i[15:11];   // destniation
            rwreg_o     <= `WriteDisable;
            instvalid   <= `InstValid;
            reg1_read_o <= 1'b0;
            reg2_read_o <= 1'b0;
            reg1_addr_o <= Inst_i[25:21];   // read port 1
            reg2_addr_o <= Inst_i[20:16];   // read port 2
            imm         <= `ZeroWord;
            // judge Opcode
            case (op)
                `EXE_ORI: begin
                    wreg_o      <= `WriteEnable;
                    ALUOp_o     <= `EXE_OR_OP;
                    ALUSel_o    <= `EXE_RES_LOGIC;

                    reg1_read_o <= 1'b1;
                    reg2_read_o <= 1'b0;

                    imm         <= {16'h0, Inst_i[15:0]};   // unsigned extend
                    
                    wd_o        <= Inst_i[20:16];

                    instvalid   <= `InstValid;
                end
                default:begin
                    
                end
            endcase
        end // if
    end // always

    // operator 1
    always @(*) begin
        if(rst == `RstEnable)begin
            reg1_o  <= `ZeroWord;
        end else if(reg1_read_o == 1'b1)begin
            reg1_o  <= reg1_data_i;     // read port 1
        end else if(reg1_read_o == 1'b0)begin
            reg1_o  <= imm;
        end else begin
            reg1_o <= `ZeroWord;
        end
    end

    // operator 2
    always @(*) begin
        if(rst == `RstEnable)begin
            reg2_o  <= `ZeroWord;
        end else if(reg2_read_o == 1'b1)begin
            reg2_o  <= reg2_data_i;     // read port 2
        end else if(reg1_read_o == 1'b0)begin
            reg2_o  <= imm;
        end else begin
            reg2_o <= `ZeroWord;
        end
    end


endmodule