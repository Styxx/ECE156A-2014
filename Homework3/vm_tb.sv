/*
*   Testbench for the Vending Machine
*/

class random_buy;
  rand int index;                                     
  rand int buyC;                                          //buyChance - chance to buy a product
  rand int prodSel;                                       //productSelection - which product to be bought.
  constraint c { index > 0; index <=4;                    //0-4 for 4 coins and a no coin signal
                 buyC dist {[0:3] := 0, [4:5] := 1};      //[0, 0, 0, 1, 1]
                 prodSel >= 0; prodSel < 4;}              //[00, 01, 10, 11]
endclass

module vmTestBench();
  reg clk, reset, serialIn, product, buy;
  wire digit0, digit1;
  VendingMachine VM(clk,reset,serialIn,product,buy, digit0,digit1);
  
//Covergroups
  covergroup Trans_Cov @ (clk)
    PENNY:    coverpoint VM.penny {bins pennyDetected = {1};}    // If the penny signal = 1, then bin is covered
    NICKEL:   coverpoint VM.nickel {bins nickelDetected = {1};}
    DIME:     coverpoint VM.dime {bins dimeDetected = {1};}
    QUARTER:  coverpoint VM.quarter {bins quarterDetected = {1};}
    // Does not ask to cover a no-coin sequence
    
    CREDITS: coverpoint VM.credits {    
      bins 1to4 = { [1:4] };                                  // If credits reach value from 1 to 4, bin is covered
      bins 5to9 = { [5:9] };
      bins 10to24 = { [10:24] };
      bins 25to39 = { [25:39] };
      bins 40to49 = { [40:49] };
      bins 50to74 = { [50:74] };
      bins 75tomax = { [75:254] };
      bins maxC = { 255 };
    }
  endgroup
  
  // This syntax should work.
  covergroup Cross_Cov @ (clk)
    PRODUCTS: coverpoint VM.product {
      bins appleDetected = {0};           //00
      bins bananaDetected = {1};          //01
      bins carrotDetected = {2};          //10
      bins dateDetected = {3};            //11
      
    }
    /* UNSURE ABOUT THE ERROR COVERPOINT
    *  There is no error signal or wire in the entire module
    *  But VM.[wire] is how we check for coverpoint signals  
    *  If there's no error wire, how do we check the error coverpoint?
    */
    // Solution
    // Whatever signal sends the "error" signal to the display, use that signal to
    // measrue the error coverpoint
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
    
    reg arr = 5'b11111;
    reg buySig = 2'b00;
    reg prodSig = 0;
    
    //Set initial values ?? Is that what I did just above?
    
    
    //Randomize Inputs
    repeat (100) begin
      assert (rb.randomize());
      
      //Unsure about all code from this line and below
      if (index == 0){ arr = 5'b01001; }
      else if (index == 1){ arr = 5'b00010; }
      else if (index == 2){ arr = 5'b01110; }
      else if (index == 3){ arr = 5'b01010; }
      else if (index == 4){ arr = 5'b11111; }
      else { int[5] arr = 5'b11111; }

      if (buyC == 0) { buySig = 0; }
      else { buySig = 1; }
      
      if (prodSel == 0) { prodSig == 2'b00; }
      else if (prodSel == 1) { prodSig == 2'b01; }
      else if (prodSel == 2) { prodSig == 2'b10; }
      else if (prodSel == 3) { prodSig == 2'b11; }
      
      // Input code for inputing serialIn from array
      #10     VM.buy <= buySig;                 // Signal is constant until next run
      #10     VM.product <= prodSig;            // Signal is constant until next run
      #10     VM.serialIn <= arr[4];
      #20     VM.serialIn <= arr[3];
      #30     VM.serialIn <= arr[2];
      #40     VM.serialIn <= arr[1];
      #50     VM.serialIn <= arr[0];
      
      tc.sample();        //Gathers coverage
      cc.sample();        //Gathers coverage
      
    end
  end
endmodule
