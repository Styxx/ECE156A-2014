/*
*   Purchase Manager
*   Inputs buy signal, 2-bit product code, and credit
*   Checks if user has enough credit. Output signal for 1 clk cyc to piggyBank
*/
module purchaseMngr(clk,buy,product,credit, apple, banana, carrot, date, error);

	input clk, buy;
	input [1:0] product;
	input [7:0] credit;
	output 	apple, banana, carrot, date, error;
	reg	apple, banana, carrot, date, error;

	reg	apple1, banana1, carrot1, date1, error1;        //Inner regs

	//Read inputs on negedge
	always @ (negedge clk) begin

		if (buy) begin
			case( product )
			2'b00: //Apple
				if (credit >= 7'b1001011) begin	apple1 <= 1; end
				else begin error1 <= 1; end
			2'b01: //Banana
				if (credit >= 5'b10100) begin banana1 <= 1; end
				else begin error1 <= 1; end
			2'b10: //Carrot
				if (credit >= 5'b11110) begin	carrot1 <= 1; end
				else begin error1 <= 1; end
			2'b11: //Date
				if (credit >= 6'b101000) begin date1 <= 1; end
				else begin	error1 <= 1; end
			endcase
		end
	end

	//Assign outputs on posedge
	always @ (posedge clk) begin
	
		//Reset values to 0 at next clkedge
		if (apple || banana || carrot || date || error) begin
			apple = 0; apple1 = 0;
			banana = 0; banana1 = 0;
			carrot = 0; carrot1 = 0;
			date = 0; date1 = 0;
			error	= 0; error1	= 0;
		end
    
    //Set outputs
		if 	(apple1) begin apple = 1; end
		else if (banana1) begin banana = 1; end
		else if (carrot1) begin carrot1 = 1; end
		else if (date1) begin date = 1; end
		else if (error1) begin error = 1; end
	end

endmodule
