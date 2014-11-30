/*
*   Testbench for the Vending Machine
/*

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
    
    //Set initial values ??
    
    
    //Randomize Inputs
    repeat (100) begin
      assert (rb.randomize());
      if (index == 0){ int[5] arr = 10100; }
      if (index == 1){ int[5] arr = 00010; }
      if (index == 2){ int[5] arr = 01110; }
      if (index == 3){ int[5] arr = 01010; }
      if (index == 4){ int[5] arr = 11111; }
      
      
      
      
      
      
      tc.sample();
      cc.sample();
    
    
    
    
    end
    
    
  end


endmodule
