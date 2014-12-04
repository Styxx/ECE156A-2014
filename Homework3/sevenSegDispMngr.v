/*
*   Seven Segment Display Manager
*   Shows accumulated credit of user
*   When purchase made, shows code for 6 clock cycles
*/


module sevenSegDispMngr (clk, reset, apple, banana, carrot, date, error, credit, digit1, digit0);

	input clk, reset, apple, banana, carrot, date, error;

	reg 	reset1, apple1, banana1, carrot1, date1, error1;   //Inner regs
	input   [7:0] credit;
	output  [6:0] digit0, digit1;
	reg	[6:0] digit0, digit1;

	reg	[3:0] counter = 3'd5;     // Counter to count 6 cycles
	
	//Read inputs on negedge
	always @ (negedge clk) begin
	
		if (!reset) reset1 <= 1;
		else if (apple) apple1 <= 1;
		else if (banana) banana1 <= 1;
		else if (carrot) carrot1 <= 1;
		else if (date) date1 <= 1;
		else if (error) error1 <= 1;
		
	end

	//Assign outputs on posedge
	always @ (posedge clk) begin

		//Active counter
		if (counter < 3'd5) begin
		
			//Reset - Display credit
			if	(reset1) begin
				counter <= 3'd5;
				digit0 <= credit[3:0];
				digit1 <= credit[7:4];
				reset1 <= 0;
			end
			//Apple - "aa"
			else if (apple1) begin
				digit0 <= 7'h4;
				digit1 <= 7'h8;
				apple1 <= 0;
			end
			//Banana - "bb"
			else if (banana1) begin
				digit0 <= 7'h1;
				digit1 <= 7'h83;
				banana1 <= 0;
			end
			//Carrot - "cc"
			else if (carrot1) begin
				digit0 <= 7'h23;
				digit1 <= 7'h45;
				carrot1 <= 0;
			end
			//Date - "dd"
			else if (date1) begin
				digit0 <= 7'h10;
				digit1 <= 7'hA1;
				date1 <= 0;
			end
			//Error - "ee"
			else if (error1) begin
				digit0 <= 7'h3;
				digit1 <= 7'h5;
				error1 <= 0;
			end
			
			counter <= counter + 1'd1;
		
		end
		
		//Inactive counter
		else if (counter == 5) begin
			// Display credit
			digit0 <= credit[3:0];
			digit1 <= credit[7:4];
			//If purchase, set to starting value
			if (apple1 || banana1 || carrot1 || date1 || error1)
				counter <= 3'd0;
		end
	end

endmodule
