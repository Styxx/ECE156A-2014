/*
*  Pattern Detecting Machine - Register Level
*  Checks for the patterns 0100 or 00010
*  Rightmost bit arrives first
*/



module machine_b(z, clk, in, reset);
	input clk, in, reset;
	output z;

	reg [4:0] state_reg;
	reg z;

	always @ (negedge clk)
		if (!reset) begin
			state_reg[4:0] = 5'b00000;
		end
		else begin
			state_reg[4] = state_reg[3];
			state_reg[3] = state_reg[2];
			state_reg[2] = state_reg[1];
			state_reg[1] = state_reg[0];
			state_reg[0] = in;

			if ((state_reg[4:0] == 5'b01000) || 
			   (state_reg[4:0] == 5'b00010) ||
			   (state_reg[4:0] == 5'b10010) ||
			   (state_reg[4:0] == 5'b00101) ||
			   (state_reg[4:0] == 5'b00100))
				z = 1;
			else
				z = 0;
		end
endmodule