/*
*  Pattern Detecting Machine - State Level
*  Checks for the patterns 0100 or 00010
*  Rightmost bit arrives firsts
*/


module machine_x(z, clk, in, reset);
	input clk, in, reset;
	output z;

	reg [3:0] state, next;
	reg z;

	parameter A0 = 5'd0;
	
	//path for 01000
	parameter B01 = 5'd1;
	parameter B010 = 5'd2;
	parameter B0100 = 5'd3;
	parameter B01000 = 5'd4;

	//path for 0010
	parameter C00 = 5'd5;
	parameter C001 = 5'd6;
	parameter C0010 = 5'd7;

	//Extra 1 path;
	parameter D11 = 5'd8;

	always @ (negedge clk) begin
		if(!reset)
			state <= A0;
		else
			state <= next;
	end
	
	always @ (state or in or next) begin
		//Default start
		next = state;
		z = 0;

		case (state)
			A0:begin
				z = 0;
				if(!in) next = C00;
				else next = B01;
			end

			B01:begin
				z = 0;
				if(!in) next = B010;
				else next = D11;
			end
			B010:begin
				z = 0;
				if(!in) next = B0100;
				else next = B01;
			end
			B0100:begin
				z = 0;
				if(!in) next = B01000;
				else next = C001;
			end
			B01000:begin
				z = 1;
			end

			C00:begin
				z = 0;
				if(!in) next = C00;
				else next = C001;
			end
			C001:begin
				z = 0;
				if(!in) next = C0010;
				else next = D11;
			end
			C0010:begin
				z = 1;
			end
		
			D11:begin
				z = 0;
				if(!in) next = A0;
				else next = D11;
			end
		endcase
	end
endmodule