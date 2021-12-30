module EX (
    input wire                  rst,

    input wire[`AluOpBus]       ALUOp_i,        // sub type
    input wire[`AluSelBus]      ALUSel_i,       // cac type
    input wire[`RegBus]         reg1_i,
    input wire[`RegBus]         reg2_i,
    input wire[`RegAddrBus]     wd_i,           // write reg address
    input wire                  wreg_i,         // whether write reg

    output reg[`RegAddrBus]     wd_o,           // write reg address
    output reg                  wreg_o,         // whether write reg
    output reg[`RegBus]         wdata_o
);
    // save result
    reg[`RegBus] logicout;
    
    // cac and save to logicout
    always @(*) begin
        if(rst == `RstEnable)begin
            logicout <= `ZeroWord;
        end else begin
            case (ALUOp_i)
                `EXE_OR_OP: begin
                    logicout <= reg1_i | reg2_i;
                end
                default: begin
                    logicout <= `ZeroWord;
                end
        end // if
    end // always


    // output result
    always @(*) begin
        wd_o    <= wd_i;        // pass
        wreg_o  <= wreg_i;      // pass
        case (ALUSel_i)
            `EXE_RES_LOGIC: begin
                wdata_o <= logicout;
            end
            default: begin
                wdata_o <= `ZeroWord;
            end
        endcase
    end

endmodule