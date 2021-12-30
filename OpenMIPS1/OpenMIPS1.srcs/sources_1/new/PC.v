module PC(
    input   wire                clk,
    input   wire                rst,
    output  reg[`InstAddrBus]   PC,
    output  reg                 CE
);
	always @ (posedge clk) begin
		if(rst == `RstEnable)begin
			CE <= `ChipDisable;
		end else begin
			CE <= `ChipEnable;
		end
	end
	
	
	always @ (posedge clk)begin
		if(CE == `ChipDisable)begin
			PC <= `ZeroWord;
		end else begin
			PC <= PC + 4'h4; 		// instrct One word, so PC add 4 each time
		end
	end
	
		
endmodule