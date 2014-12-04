/*
*   Testbench for the Vending Machine
*/

class random_buy;
  rand int index;                                     
  rand int buyC;                                          //buyChance - chance to buy a product
  rand int prodSel;                                       //productSelection - which product to be bought.
  constraint c { index >= 0; index <=4;                   //0-4 for 4 coins and a no coin signal
                 buyC >= 0; buyC <=9;                     //90% no buy, 10% buy
                 prodSel >= 0; prodSel < 4;}              //[00, 01, 10, 11]
endclass

module vmTestBench();
/* VENDING MACHINE INSTANTIATION */
  reg clk, reset, serialIn, buy;
  reg [1:0] product;
  wire [6:0] digit0, digit1;
  VendingMachine VM(clk,reset,serialIn,product,buy, digit0,digit1); 
/* ~~~~~ */
  
/* COVERGROUPS */
  covergroup Trans_Cov @ (clk);
    PENNY:    coverpoint VM.penny {bins pennyDetected = {1};}    // If the penny signal = 1, then bin is covered
    NICKEL:   coverpoint VM.nickel {bins nickelDetected = {1};}
    DIME:     coverpoint VM.dime {bins dimeDetected = {1};}
    QUARTER:  coverpoint VM.quarter {bins quarterDetected = {1};}
    // Does not ask to cover a no-coin sequence, so no no-coin coverpoint
    
    CREDITS: coverpoint VM.credit {    
      bins a1to4 = { [1:4] };                                  // If credits reach value from 1 to 4, bin is covered
      bins a5to9 = { [5:9] };
      bins a10to24 = { [10:24] };
      bins a25to39 = { [25:39] };
      bins a40to49 = { [40:49] };
      bins a50to74 = { [50:74] };
      bins a75tomax = { [75:254] };
      bins maxC = { 255 };
    }
    
    // Credit coverpoint expanded (for testing / debugging)
    // I used this section to expand out the credit coverpoint to view which bins were hit
    /*
    A1TO4: coverpoint VM.credit {bins a1to4 = {[1:4]};}
    A5TO9: coverpoint VM.credit {bins a5to9 = {[5:9]};}
    A10TO24: coverpoint VM.credit {bins a10to24 = {[10:24]};}
    A25TO39: coverpoint VM.credit {bins a25to39 = {[25:39]};}
    A40TO49: coverpoint VM.credit {bins a40to49 = {[40:49]};}
    A50TO74: coverpoint VM.credit {bins a50to74 = {[50:74]};}
    A75TOMAX: coverpoint VM.credit {bins a75toMax = {[75:254]};}
    MAX: coverpoint VM.credit {bins maxC = {255};}
    */
  endgroup

  covergroup Cross_Cov @ (clk);
    PRODUCTS: coverpoint VM.product {
      bins appleDetected = {0};           //00
      bins bananaDetected = {1};          //01
      bins carrotDetected = {2};          //10
      bins dateDetected = {3};            //11
      
    }
    ERROR: coverpoint VM.error { 
      bins noError = {0};
      bins error = {1};
    }
    CROSS_COV: cross PRODUCTS, ERROR;
  endgroup
/* ~~~~~ */

/* TESTBENCH */
  initial begin
    // Initialize your rand class and your covergroups
    random_buy rb = new();
    Trans_Cov tc = new();
    Cross_Cov cc = new();
    
    // Set initial values
    reg [4:0] arr = 5'b11111;					// Used for coin input.
    reg index = 0;						// Used to pick which coin input
    reg buySig = 0;						// Used to pick if buying or not
    reg [1:0] prodSig = 2'b00;					// Used to pick which product to buy that cycle
    
    clk <= 0;
    reset <= 0;							// Guaranteed to start off with a system reset.
    
    
    //Randomize Inputs
    repeat (5000) begin						// Maximum amount of test cycles you want to run
      assert (rb.randomize());
      
      //Chooses which coin input to select
      if      (rb.index == 0) begin arr = 5'b01001; end		// Penny	
      else if (rb.index == 1) begin arr = 5'b00010; end		// Nickel
      else if (rb.index == 2) begin arr = 5'b01110; end		// Dime
      else if (rb.index == 3) begin arr = 5'b01010; end		// Quarter
      else if (rb.index == 4) begin arr = 5'b11111; end		// No coin

      //Chooses whether to buy or not
      if (rb.buyC == 0) begin buySig = 0; end			// Similar to a rand dist, but more fleshed out.
      else if (rb.buyC == 1) begin buySig = 0; end		// buyC dist {[0:8] := 0, 9 := 1};}
      else if (rb.buyC == 2) begin buySig = 0; end
      else if (rb.buyC == 3) begin buySig = 0; end
      else if (rb.buyC == 4) begin buySig = 0; end
      else if (rb.buyC == 5) begin buySig = 0; end
      else if (rb.buyC == 6) begin buySig = 0; end
      else if (rb.buyC == 7) begin buySig = 0; end
      else if (rb.buyC == 8) begin buySig = 0; end
      else if (rb.buyC == 9) begin buySig = 1; end

      //Chooses which product to buy
      if (rb.prodSel == 0) begin prodSig = 2'b00; end
      else if (rb.prodSel == 1) begin prodSig = 2'b01; end
      else if (rb.prodSel == 2) begin prodSig = 2'b10; end
      else if (rb.prodSel == 3) begin prodSig = 2'b11; end
      
      // Input code for inputing serialIn from array

      #10 reset = 1;					//@10
      #10 serialIn = arr[4];				//@20
      #10 serialIn = arr[3];				//@30
      #10 serialIn = arr[2];				//@40
      #10 serialIn = arr[1];				//@50
      #10 serialIn = arr[0];				//@60		Parallel
          buy = buySig;					//@60		Parallel
          product = prodSig;				//@60		Parallel
    end
  end
  always begin
		#10 clk <= ~clk;
	end
endmodule
