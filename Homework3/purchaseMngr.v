/*
*   Purchase Manager
*   Inputs buy signal, 2-bit product code, and credit
*   Checks if user has enough credit. Output signal for 1 clk cyc to piggyBank
/*

module purchaseMngr(input clk, buy, input [1:0] product, input [7:0] credit, output apple, banana, carrot, date, error);
  input clk, buy;
  input [1:0] product;
  input [7:0] credit;
  output apple, banana, carrot, date, error;
  reg apple, banana, carrot, date, error;
  
  always @ (posedge clk or buy)
    begin
      if (!buy)
        // Do nothing
      else
        begin
          if (product == 2'b00) {         // Apple
            if (credit >= 8'b01001011) {
              apple = 1;
              banana = 0; carrot = 0; date = 0; error = 0;
            }
            else {
              apple = 0; banana = 0; carrot = 0; date = 0;
              error = 1;
            }
          else if (product == 2'b01) {    // Banana
            if (credit >= 8'b00010100) {
              apple = 0;
              banana = 1;
              carrot = 0; date = 0; error = 0;
            } else {
              apple = 0; banana = 0; carrot = 0; date = 0;
              error = 1;
            }
          else if (product = 2'b10) {     // Carrot
            if (credit >= 8'b00011110) {
              apple = 0; banana = 0;
              carrot = 1;
              date = 0; error = 0;
            } else {
              apple = 0; banana = 0; carrot = 0; date = 0;
              error = 1;
            }
          else if (product = 2'b11) {     // Date
            if (credit >= 8'b00101000) {
              apple = 0; banana = 0; carrot = 0;
              date = 1;
              error = 0;
            } else {
              apple = 0; banana = 0; carrot = 0; date = 0;
              error = 1;
            }
          
          #1 apple = 0; banana = 0; carrot = 0; date = 0; error = 0;
        end
  end
endmodule
