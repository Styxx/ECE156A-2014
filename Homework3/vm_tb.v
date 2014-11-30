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
      bins appleDetected = {00};
      bins bananaDetected = {01};
      bins carrotDetected = {10};
      bins dateDetected = {11};
    }
    ERROR: coverpoint VM.error {                // UNSURE ABOUT THIS COVERPOINT
      bins noError = {0};
      bins error = {1};
    }
    CROSS_COV: cross PRODUCTS, ERROR;
  endgroup



endmodule
