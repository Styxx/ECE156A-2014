/*
* Coin Sensor Machine - Shift Register
* Checks for designated patterns for each coin
* Shifts to the left
*/
module coinSensor(clk,reset,serialIn, penny,nickel,dime,quarter);

	input clk, reset, serialIn;
	output penny, nickel, dime, quarter;
	reg penny, nickel, dime, quarter;                 
  reg [4:0] shift_reg;

  //Reads inputs on negedge
	always @ (negedge clk) begin
	
		if ( penny || nickel || dime || quarter )
			shift_reg[4:0] = 5'b11111;                  		// Prevents accidental sequences
	
		if (!reset) begin
			shift_reg[4:0] = 5'b11111;
			penny 	= 0;
			nickel 	= 0;
			dime 	= 0;
			quarter = 0;
		end
		
		else begin																				// Shifts left
			shift_reg[4] = shift_reg[3];
			shift_reg[3] = shift_reg[2];
			shift_reg[2] = shift_reg[1];
			shift_reg[1] = shift_reg[0];
			shift_reg[0] = serialIn;
		end
	end
	
	//Assign outputs on posedge
	always @ (posedge clk) begin

		//Sets outputs back to zero at next clkedge
		if ( penny || nickel || dime || quarter ) begin
			penny 	= 0;
			nickel 	= 0;
			dime 	= 0;
			quarter = 0;
		end

		// Check for sequences
		if (shift_reg[3:0] == 4'b0100) begin penny = 1; end
		else if (shift_reg[4:0] == 5'b00010) begin nickel = 1; end
		else if (shift_reg[4:0] == 5'b01110) begin dime = 1; end
		else if (shift_reg[4:0] == 5'b01010) begin quarter = 1; end

	end
	
endmodule
