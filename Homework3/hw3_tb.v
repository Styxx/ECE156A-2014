module hw3_tb();
  
	/* For coinSensor
	reg  clk, reset, serialIn;
	wire penny, nickel, dime, quarter;*/

	/* For piggyBank
	reg clk, reset, penny, nickel, dime, quarter, apple, banana, carrot, date;
	wire [7:0] credit;*/

	/* For purchaseMngr
	reg clk, buy;
	reg [1:0] product;
	reg [7:0] credit;
	wire apple, banana, carrot, date, error; */

	/* For sevenSegDispMngr
	reg clk, reset, apple, banana, carrot, date, error;
	reg [7:0] credit;
	wire [6:0] digit0, digit1;*/
  
	/* For complete testing */
	reg clk, reset, serialIn, buy;
	reg [1:0] product;
	wire penny, nickel, dime, quarter,
		apple, banana, carrot, date,
		error;
	wire [7:0] credit;
	wire [6:0] digit0, digit1;

	coinSensor coinSenstor(clk, reset, serialIn, penny, nickel, dime, quarter);
	piggyBank piggyBank(clk, reset, penny, nickel, dime, quarter, apple, banana, carrot, date, credit);
	purchaseMngr purchaseMngr(clk, buy, product, credit, apple, banana, carrot, date, error);
	sevenSegDispMngr sevenSegDispMngr(clk, reset, apple, banana, carrot, date, error, credit, digit1, digit0);

	initial begin
    
	/* For coinSensor testing
	clk <= 0;
	reset <= 1;
	serialIn <= 0;
    
	#15 reset <= 0;
	#10 reset <= 1;
	#70 serialIn <= 1;
	#10 serialIn <= 0;*/

	/* For piggyBank testing
	clk <= 0;
	reset <= 0;
	penny <= 0;
	nickel <= 0;
	dime <= 0;
	quarter <= 0;
	apple <= 0;
	banana <= 0;
	carrot <= 0;
	date <= 0;

	#1 reset <= 1;
	#14 quarter <= 1;
	#10 quarter <= 0;
	#10 quarter <= 1;
	#10 quarter <= 0;
	#10 quarter <= 1;
	#10 quarter <= 0;
	#10 quarter <= 1;
	#10 quarter <= 0;
	#10 quarter <= 1;
	#10 quarter <= 0;
	#10 quarter <= 1;
	#10 quarter <= 0;
	#10 quarter <= 1;
	#10 quarter <= 0;
	#10 quarter <= 1;
	#10 quarter <= 0;
	#10 quarter <= 1;
	#10 quarter <= 0;
	#10 quarter <= 1;
	#10 quarter <= 0;
	#10 quarter <= 1;
	#10 quarter <= 0;
	#10 date <= 1;
	#10 date <= 0;
	#10 date <= 1;
	#10 date <= 0;
	#10 date <= 1;
	#10 date <= 0;
	#10 date <= 1;
	#10 date <= 0;
	#10 date <= 1;
	#10 date <= 0;
	#10 date <= 1;
	#10 date <= 0;
	#10 date <= 1;
	#10 date <= 0;*/
    
	/* For purchaseMngr testing
	clk <= 0;
	buy <= 0;
	product <= 2'b01;
	credit <= 8'b00000000;

	#15 buy <= 1;
	#10 buy <= 0;*/

	/* For sevenSegDispMngr testing
	clk <= 0;
	reset <= 1;
	apple <= 0;
	banana <= 0;
	carrot <= 0;
	date <= 0;
	error <= 0;
	credit <= 8'b00000000;

	#15 reset <= 0;
	#10 reset <= 1;
	#15 apple <= 1;
	#10 apple <= 0; */

	/* For complete testing */
	clk <= 0;
	reset <= 1;
	serialIn <= 0;
	buy <= 0;
	product <= 2'b00;

	#15 reset <= 0;
	#10 reset <= 1;
	#70 serialIn <= 1;
	#10 serialIn <= 0;
	#70 serialIn <= 1;
	#10 serialIn <= 0;
	#130 buy <= 1;
	#10 buy <= 0;
	
	end
  
	always begin
		#10 clk <= ~clk;
	end

endmodule
