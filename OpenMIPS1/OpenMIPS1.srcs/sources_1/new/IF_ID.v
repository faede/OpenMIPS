module IF_ID(
	input  wire					clk,
	input  wire					rst,
	input  wire[`InstAddrBus]	IF_PC,
	input  wire[`InstBus]		IF_Inst,
	output reg[`InstAddrBus]	ID_PC,
	output reg[`InstBus]		ID_Inst
);

	always @(posedge clk) begin
		if(rst == `RstEnable) begin
			// Set Nop
			ID_PC	<= `ZeroWord;
			ID_Inst <= `ZeroWord;
		end else begin
			// Just Pass Instruction
			ID_PC <= IF_PC;
			ID_Inst <= IF_Inst;
		end
	end

endmodule