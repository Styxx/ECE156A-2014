module VendingMachine (clk,reset,serialIn,product,buy, digit0,digit1);

	input clk, reset, serialIn, buy;
	input [1:0] product;
	output [6:0] digit0, digit1;

	wire penny, nickel, dime, quarter, apple, banana, carrot, date, error;
	wire [7:0] credit;

	coinSensor CS(clk, reset, serialIn, penny, nickel, dime, quarter);
	purchaseMngr PM(clk, buy, product, credit, apple, banana, carrot, date, error);
	piggyBank PB(clk, reset, penny, nickel, dime, quarter, apple, banana, carrot, date, credit);
	sevenSegDispMngr SSDM(clk, reset, apple, banana, carrot, date, error, credit,digit1, digit0);
	
endmodule
