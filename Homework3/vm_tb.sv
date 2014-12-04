/*
*   Testbench for the Vending Machine
*/

class random_buy;
  rand int index;                                     
  rand int buyC;                                          //buyChance - chance to buy a product
  rand int prodSel;                                       //productSelection - which product to be bought.
  constraint c { index >= 0; index <=4;                   //0-4 for 4 coins and a no coin signal
                 buyC dist {[0:2] := 0, [3:4] := 1};      //[0, 0, 0, 1, 1]
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
    repeat (100) begin
      assert (rb.randomize());
      
      
      if (rb.index == 0) begin arr = 5'b01001; end
      else if (rb.index == 1) begin arr = 5'b00010; end
      else if (rb.index == 2) begin arr = 5'b01110; end
      else if (rb.index == 3) begin arr = 5'b01010; end
      else if (rb.index == 4) begin arr = 5'b11111; end

      if (rb.buyC == 0) begin buySig = 0; end
      else begin buySig = 1; end
      
      if (rb.prodSel == 0) begin prodSig = 2'b00; end
      else if (rb.prodSel == 1) begin prodSig = 2'b01; end
      else if (rb.prodSel == 2) begin prodSig = 2'b10; end
      else if (rb.prodSel == 3) begin prodSig = 2'b11; end
      
      // Input code for inputing serialIn from array
      #20     reset <= 1;
      #40     buy <= buySig;                 // Signal is constant until next run
      #40     product <= prodSig;            // Signal is constant until next run
      
      #40     serialIn <= arr[4];
      #60     serialIn <= arr[3];
      #80     serialIn <= arr[2];
      #100    serialIn <= arr[1];
      #120    serialIn <= arr[0];
      #140    serialIn <= 1;
      #160    serialIn <= 1;
      #180    serialIn <= 1;
      #200    serialIn <= 1;
      #220    serialIn <= 1;
    end
  end
  always begin
		#60 clk <= ~clk;
	end
endmodule
