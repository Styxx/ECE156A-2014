//module sevenSegDispMngr (clk, reset, apple, banana, carrot, date, error, credit, digit1, digit0);
//module purchaseMngr(clk, buy, product, credit, apple, banana, carrot, date, error);
//module piggyBank(clk, reset, penny, nickel, dime, quarter, apple, banana, carrot, date, credit);
//module coinSensor(clk, reset, serialIn, penny, nickel, dime, quarter);

module VendingMachine (clk,reset,serialIn,product,buy, digit0,digit1);

	input clk, reset, serialIn, product, buy;
	output digit0, digit1;

	wire penny, nickel, dime, quarter, apple, banana, carrot, date, error;
	wire [7:0] credit;

	coinSensor CS(clk, reset, serialIn, penny, nickel, dime, quarter);
	purchaseMngr PM(clk, buy, product, credit, apple, banana, carrot, date, error);
	piggyBank PB(clk, reset, penny, nickel, dime, quarter, apple, banana, carrot, date, credit);
	sevenSegDispMngr SSDM(clk, reset, apple, banana, carrot, date, error, credit,digit1, digit0);
endmodule







module coinSensor(clk, reset, serialIn, penny, nickel, dime, quarter);

	input  clk, reset, serialIn;
	output penny, nickel, dime, quarter;
	reg    penny, nickel, dime, quarter;                 
  
	reg [4:0] shift_reg;

	// Reading inputs on the negative clock edge
	always @ (negedge clk) begin
	
		// This if statement sets the shift register to all
		// 	ones in order to prevent accidental sequences!
		if ( penny || nickel || dime || quarter )
			shift_reg[4:0] = 5'b11111;
	
		if (!reset) begin
		  	
			// Our reset values
			shift_reg[4:0] = 5'b11111;
			penny 	= 0;
			nickel 	= 0;
			dime 	= 0;
			quarter = 0;
			
		end
		else begin
		  
			// Shifting of registers
			shift_reg[4] = shift_reg[3];
			shift_reg[3] = shift_reg[2];
			shift_reg[2] = shift_reg[1];
			shift_reg[1] = shift_reg[0];
			shift_reg[0] = serialIn;
		
		end
		
	end
	
	// Assigning outputs on the positive clock edge
	always @ (posedge clk) begin

		// This if statement sets the outputs back to zero on the next clock
		if ( penny || nickel || dime || quarter ) begin

			// Our reset values
			penny 	= 0;
			nickel 	= 0;
			dime 	= 0;
			quarter = 0;

		end

		// Check for sequences
		if      (shift_reg[3:0] == 4'b0100)
			penny   = 1;
		else if (shift_reg[4:0] == 5'b00010)
			nickel  = 1;
		else if (shift_reg[4:0] == 5'b01110)
			dime    = 1;
		else if (shift_reg[4:0] == 5'b01010)
			quarter = 1;

	end

endmodule

module piggyBank(clk, reset, penny, nickel, dime, quarter, apple, banana, carrot, date, credit);

	input 	clk, reset, penny, nickel, dime, quarter, apple, banana, carrot, date;
	// The following enable us to set credit on the positive clock edge
	reg 	reset1, penny1, nickel1, dime1, quarter1, apple1, banana1, carrot1, date1;
	output 	[7:0] credit;
	reg 	[7:0] credit;

	// Reading inputs on the negative clock edge
	always @ (negedge clk) begin

		// This if statement sets the outputs back to zero on the next clock
		reset1	 = 0;
		penny1	 = 0;
		nickel1  = 0;
		dime1 	 = 0;
		quarter1 = 0;
		apple1	 = 0;
		banana1  = 0;
		carrot1  = 0;
		date1 	 = 0;

		// Set out output flags accordingly
		if 	(!reset)  reset1   = 1;
		if 	(penny)	  penny1   = 1;
		else if (nickel)  nickel1  = 1;
		else if (dime) 	  dime1    = 1;
		else if (quarter) quarter1 = 1;
		else if (apple)   apple1   = 1;
		else if (banana)  banana1  = 1;
		else if (carrot)  carrot1  = 1;
		else if (date)    date1    = 1;
	
	end

	// Assigning outputs on the positive clock edge
	always @ (posedge clk) begin

		if (reset1)
			credit[7:0] = 8'b00000000;

		if 	(penny1) begin
			// Make sure credit doesn't exceed 255
			if (credit > 8'b11111110)
				credit <= 8'b11111111;
			else
				credit <= credit + 1'b1;
		end
		else if (nickel1) begin
			// Make sure credit doesn't exceed 255
			if (credit > 8'b11111010)
				credit <= 8'b11111111;
			else
				credit <= credit + 3'b101;
		end
		else if (dime1) begin
			// Make sure credit doesn't exceed 255
			if (credit > 8'b11110101)
				credit <= 8'b11111111;
			else
				credit <= credit + 4'b1010;
		end
		else if (quarter1) begin
			// Make sure credit doesn't exceed 255
			if (credit > 8'b11100110)
				credit <= 8'b11111111;
			else
				credit <= credit + 5'b11001;
		end
		else if (apple1) begin
			// Make sure credit doesn't go negative
			if (credit < 7'b1001011)
				credit <= 8'b00000000;
			else
				credit <= credit - 7'b1001011;
		end
		else if (banana1) begin
			// Make sure credit doesn't go negative
			if (credit < 5'b10100)
				credit <= 8'b00000000;
			else
				credit <= credit - 5'b10100;
		end
		else if (carrot1) begin
			// Make sure credit doesn't go negative
			if (credit < 5'b11110)
				credit <= 8'b00000000;
			else
				credit <= credit - 5'b11110;
		end
		else if (date1) begin
			// Make sure credit doesn't go negative
			if (credit < 6'b101000)
				credit <= 8'b00000000;
			else
				credit <= credit - 6'b101000;
		end

	end

endmodule

module purchaseMngr(clk, buy, product, credit, apple, banana, carrot, date, error);

	input clk, buy;
	input [1:0] product;
	input [7:0] credit;
	output 	apple, banana, carrot, date, error;
	reg	apple, banana, carrot, date, error;
	// The following enable us to set the reg's above on the pos clock edge
	reg	apple1, banana1, carrot1, date1, error1;

	// Reading inputs on the negative clock edge
	always @ (negedge clk) begin

		if (buy) begin
		
			case( product )
				
			// Apple
			2'b00:
				if (credit >= 7'b1001011)
					apple1 <= 1;
				else
					error1 <= 1;
			// Banana
			2'b01:
				if (credit >= 5'b10100)
					banana1 <= 1;
				else
					error1 <= 1;
			// Carrot
			2'b10:
				if (credit >= 5'b11110)
					carrot1 <= 1;
				else
					error1 <= 1;
			// Date
			2'b11:
				if (credit >= 6'b101000)
					date1 <= 1;
				else
					error1 <= 1;

			endcase

		end

	end

	// Assigning outputs on the positive clock edge
	always @ (posedge clk) begin
	
		// Set the outputs back down to zero after one clock cycle
		if (apple || banana || carrot || date || error) begin
			
			apple 	= 0; apple1 	= 0;
			banana 	= 0; banana1 	= 0;
			carrot 	= 0; carrot1 	= 0;
			date 	= 0; date1 	= 0;
			error 	= 0; error1 	= 0;

		end

		// Set outputs accordingly
		if 	(apple1)
			apple 	= 1;
		else if (banana1)
			banana 	= 1;
		else if (carrot1)
			carrot1 = 1;
		else if (date1)
			date 	= 1;
		else if (error1)
			error	= 1;

	end

endmodule

module sevenSegDispMngr (clk, reset, apple, banana, carrot, date, error, credit, digit1, digit0);

	input clk, reset, apple, banana, carrot, date, error;
	// The following enable us to set credit on the positive clock edge
	reg 	reset1, apple1, banana1, carrot1, date1, error1;
	input   [7:0] credit;
	output  [6:0] digit0, digit1;
	reg	[6:0] digit0, digit1;
	// The following reg is used to count to 6 clock cycles
	reg	[3:0] counter = 3'd5;
	
	// Reading inputs on the negative clock edge
	always @ (negedge clk) begin

		// Set out output flags accordingly
		if 	(!reset)  reset1   <= 1;
		else if (apple)   apple1   <= 1;
		else if (banana)  banana1  <= 1;
		else if (carrot)  carrot1  <= 1;
		else if (date)    date1    <= 1;
		else if (error)   error1   <= 1;
			
	end

	// Assigning outputs on the positive clock edge
	always @ (posedge clk) begin

		// If the counter is active
		
		if (counter < 3'd5) begin
			
			// Upon reset, display the user's credit
			if	(reset1) begin
				counter <= 3'd5;
				digit0 <= credit[3:0];
				digit1 <= credit[7:4];
				reset1 <= 0;
			end
			// Upon apple, display "aa"
			else if (apple1) begin
				digit0 <= 7'h4;
				digit1 <= 7'h8;
				apple1 <= 0;
			end
			// Upon banana, display "bb"
			else if (banana1) begin
				digit0 <= 7'h1;
				digit1 <= 7'h83;
				banana1 <= 0;
			end
			// Upon carrot, display "cc"
			else if (carrot1) begin
				digit0 <= 7'h23;
				digit1 <= 7'h45;
				carrot1 <= 0;
			end
			// Upon date, display "dd"
			else if (date1) begin
				digit0 <= 7'h10;
				digit1 <= 7'hA1;
				date1 <= 0;
			end
			// Upon error, display "ee"
			else if (error1) begin
				digit0 <= 7'h3;
				digit1 <= 7'h5;
				error1 <= 0;
			end
			
			counter <= counter + 1'd1;
		
		end
		// If the counter is inactive
		else if (counter == 5) begin

			// Display credit
			digit0 <= credit[3:0];
			digit1 <= credit[7:4];
			// Set counter to starting value if purchase is called
			if (apple1 || banana1 || carrot1 || date1 || error1)
				counter <= 3'd0;
		
		end
		
	end

endmodule
