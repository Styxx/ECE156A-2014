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
