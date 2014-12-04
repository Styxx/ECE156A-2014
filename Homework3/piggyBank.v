/*
* Piggy Bank
* Adds credit for penny(1), nickel(5), dime(10), and quarter(25)
* Subtracts credit for apple(75), banana(20), carrot(30), and date(40)
* Max credit is $2.55, displayed in hex
* Active low, asynchronous reset
*/

module piggyBank(clk, reset, penny, nickel, dime, quarter, apple, banana, carrot, date, credit);
	input 	clk, reset, penny, nickel, dime, quarter, apple, banana, carrot, date;

	reg 	reset1, penny1, nickel1, dime1, quarter1, apple1, banana1, carrot1, date1;    //Inner regs
	output 	[7:0] credit;
	reg 	[7:0] credit;

	//Reading inputs on negedge
	always @ (negedge clk) begin

		//Sets outputs to zero on next clkedge
		reset1 = 0; penny1 = 0; nickel1 = 0; dime1 = 0; quarter1 = 0;
		apple1 = 0; banana1 = 0; carrot1  = 0; date1 = 0;

		//Set output flags
		if (!reset) reset1 = 1;
		if (penny) penny1 = 1;
		else if (nickel) nickel1 = 1;
		else if (dime) dime1 = 1;
		else if (quarter) quarter1 = 1;
		else if (apple) apple1 = 1;
		else if (banana) banana1 = 1;
		else if (carrot) carrot1 = 1;
		else if (date) date1 = 1;
		
	end

	//Assign outputs on posedge
	always @ (posedge clk) begin

		if (reset1)
			credit[7:0] = 8'b00000000;

		if 	(penny1) begin
			if (credit > 8'b11111110) begin	credit <= 8'b11111111; end        //Make sure credit doesn't go over max
			else begin credit <= credit + 1'b1; end
		end
		else if (nickel1) begin
			if (credit > 8'b11111010) begin credit <= 8'b11111111; end
			else begin credit <= credit + 3'b101; end
		end
		else if (dime1) begin
			if (credit > 8'b11110101) begin	credit <= 8'b11111111; end
			else begin credit <= credit + 4'b1010; end
		end
		else if (quarter1) begin
		  if (credit > 8'b11100110) begin	credit <= 8'b11111111; end
			else begin credit <= credit + 5'b11001; end
		end
		else if (apple1) begin
			if (credit < 7'b1001011) begin credit <= 8'b00000000; end         // Make sure credit doesn't go neg
			else begin credit <= credit - 7'b1001011; end
		end
		else if (banana1) begin
			if (credit < 5'b10100) begin credit <= 8'b00000000; end
			else begin credit <= credit - 5'b10100; end
		end
		else if (carrot1) begin
			if (credit < 5'b11110) begin credit <= 8'b00000000; end
			else begin credit <= credit - 5'b11110; end
		end
		else if (date1) begin
			if (credit < 6'b101000) begin credit <= 8'b00000000; end
			else begin credit <= credit - 6'b101000; end
		end

	end

endmodule
