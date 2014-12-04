/*
*   Testbench for the Vending Machine
*/

class random_buy;
  rand int index;                                     
  rand int buyC;                                          //buyChance - chance to buy a product
  rand int prodSel;                                       //productSelection - which product to be bought.
  constraint c { index >= 0; index <=4;                   //0-4 for 4 coins and a no coin signal
                 buyC >= 0; buyC <=9;                     // 90% no buy, 10% buy
                 prodSel >= 0; prodSel < 4;}              //[00, 01, 10, 11]
endclass

module vmTestBench();
  reg clk, reset, serialIn, buy;
  reg [1:0] product;
  wire [6:0] digit0, digit1;
  VendingMachine VM(clk,reset,serialIn,product,buy, digit0,digit1);
  
//Covergroups
  covergroup Trans_Cov @ (clk);
    PENNY:    coverpoint VM.penny {bins pennyDetected = {1};}    // If the penny signal = 1, then bin is covered
    NICKEL:   coverpoint VM.nickel {bins nickelDetected = {1};}
    DIME:     coverpoint VM.dime {bins dimeDetected = {1};}
    QUARTER:  coverpoint VM.quarter {bins quarterDetected = {1};}
    // Does not ask to cover a no-coin sequence
    
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
  
  // This syntax should work.
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

  initial begin
    random_buy rb = new();
    Trans_Cov tc = new();
    Cross_Cov cc = new();
    
    reg [4:0] arr = 5'b11111;
    reg index = 0;
    reg buySig = 0;
    reg [1:0] prodSig = 2'b00;
    
    //Set initial values
    clk <= 0;
    reset <= 0;
    
    //Randomize Inputs
    repeat (5000) begin
      assert (rb.randomize());
      
      
      if      (rb.index == 0) begin arr = 5'b01001; end
      else if (rb.index == 1) begin arr = 5'b00010; end
      else if (rb.index == 2) begin arr = 5'b01110; end
      else if (rb.index == 3) begin arr = 5'b01010; end
      else if (rb.index == 4) begin arr = 5'b11111; end

      if (rb.buyC == 0) begin buySig = 0; end
      else if (rb.buyC == 1) begin buySig = 0; end
      else if (rb.buyC == 2) begin buySig = 0; end
      else if (rb.buyC == 3) begin buySig = 0; end
      else if (rb.buyC == 4) begin buySig = 0; end
      else if (rb.buyC == 5) begin buySig = 0; end
      else if (rb.buyC == 6) begin buySig = 0; end
      else if (rb.buyC == 7) begin buySig = 0; end
      else if (rb.buyC == 8) begin buySig = 0; end
      else if (rb.buyC == 9) begin buySig = 1; end

      
      if (rb.prodSel == 0) begin prodSig = 2'b00; end
      else if (rb.prodSel == 1) begin prodSig = 2'b01; end
      else if (rb.prodSel == 2) begin prodSig = 2'b10; end
      else if (rb.prodSel == 3) begin prodSig = 2'b11; end
      
      // Input code for inputing serialIn from array
      /*
      #20     reset <= 1;
      #40     buy <= buySig;                 // Signal is constant until next run
      #40     product <= prodSig;            // Signal is constant until next run
      
      #40     serialIn <= arr[4];
      #60     serialIn <= arr[3];
      #80     serialIn <= arr[2];
      #100    serialIn <= arr[1];
      #120    serialIn <= arr[0];
      */
      #10 reset = 1;
      #10 serialIn = arr[4];
      #10 serialIn = arr[3];
      #10 serialIn = arr[2];
      #10 serialIn = arr[1];
      #10 serialIn = arr[0];
          buy = buySig;
          product = prodSig;
    end
  end
  always begin
		#10 clk <= ~clk;
	end
endmodule
