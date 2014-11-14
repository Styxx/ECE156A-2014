/*
*  Pattern Detecting Machine - State Level
*  Checks for the patterns 0100 or 00010
*  Rightmost bit arrives first
*  Requires an initial reset to get set to the correct state.
*/


module machine_a(z, clk, in, reset);
	input clk, in, reset;
	output z;

	reg [3:0] state, next;
	reg z;
	//reg s0, s1, s2, s3, s4, s5, s6, s7, s8;		//Debug signals

	parameter A0 = 4'd0;
	
	//path for 01000
	parameter B01 = 4'd1;
	parameter B010 = 4'd2;
	parameter B0100 = 4'd3;
	parameter B01000 = 4'd4;

	//path for 0010
	parameter C00 = 4'd5;
	parameter C001 = 4'd6;
	parameter C0010 = 4'd7;

	//Extra 1 path;
	parameter D11 = 4'd8;

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
			/*	s0 = 1;
				s1 = 0;
				s2 = 0;
				s3 = 0;
				s4 = 0;
				s5 = 0;
				s6 = 0;
				s7 = 0;
				s8 = 0;		*/
				if(!in) next = C00;
				else next = B01;
			end

			B01:begin
				z = 0;
			/*	s0 = 0;
				s1 = 1;
				s2 = 0;
				s3 = 0;
				s4 = 0;
				s5 = 0;
				s6 = 0;
				s7 = 0;
				s8 = 0;		*/
				if(!in) next = B010;
				else next = D11;
			end
			B010:begin
				z = 0;
			/*	s0 = 0;
				s1 = 0;
				s2 = 1;
				s3 = 0;
				s4 = 0;
				s5 = 0;
				s6 = 0;
				s7 = 0;
				s8 = 0;		*/
				if(!in) next = B0100;
				else next = B01;
			end
			B0100:begin
				z = 0;
			/*	s0 = 0;
				s1 = 0;
				s2 = 0;
				s3 = 1;
				s4 = 0;
				s5 = 0;
				s6 = 0;
				s7 = 0;
				s8 = 0;		*/
				if(!in) next = B01000;
				else next = C001;
			end
			B01000:begin
				z = 1;
			/*	s0 = 0;
				s1 = 0;
				s2 = 0;
				s3 = 0;
				s4 = 1;
				s5 = 0;
				s6 = 0;
				s7 = 0;
				s8 = 0;		*/
				if(!in) next = C00;
				else next = C001;
			end

			C00:begin
				z = 0;
				s0 = 0;
				s1 = 0;
				s2 = 0;
				s3 = 0;
				s4 = 0;
				s5 = 1;
				s6 = 0;
				s7 = 0;
				s8 = 0;		
				if(!in) next = C00;
				else next = C001;
			end
			C001:begin
				z = 0;
			/*	s0 = 0;
				s1 = 0;
				s2 = 0;
				s3 = 0;
				s4 = 0;
				s5 = 0;
				s6 = 1;
				s7 = 0;
				s8 = 0;		*/
				if(!in) next = C0010;
				else next = D11;
			end
			C0010:begin
				z = 1;
			/*	s0 = 0;
				s1 = 0;
				s2 = 0;
				s3 = 0;
				s4 = 0;
				s5 = 0;
				s6 = 0;
				s7 = 1;
				s8 = 0;		*/
				if (!in) next = C00;
				else next = B01;
			end
		
			D11:begin
				z = 0;
			/*	s0 = 0;
				s1 = 0;
				s2 = 0;
				s3 = 0;
				s4 = 0;
				s5 = 0;
				s6 = 0;
				s7 = 0;
				s8 = 1;		*/
				if(!in) next = A0;
				else next = D11;
			end
		endcase
	end
endmodule