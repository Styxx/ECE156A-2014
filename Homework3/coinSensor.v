/*
* Coin Sensor Machine - Shift Register
* Checks for designated patterns for each coin
* Shifts to the left
*/


module coinSensor(penny,nickel,dime,quarter, clk,reset,serialIn);
  output penny, nickel, dime, quarter;
  input clk, reset, serialIn;
  
  reg [4:0] shift_reg;
  reg penny, nickel, dime, quarter;
  
  always @ (negedge clk)
    begin
      if (!reset) begin
        shift_reg[4:0] = 5'b00000;
      end
      else begin
        shift_reg[0] = in;
        shift_reg[1] = shift_reg[0];
        shift_reg[2] = shift_reg[1];
        shift_reg[3] = shift_reg[2];
        shift_reg[4] = shift_reg[3];
        
        if ((shift_reg[4:0] == 5'b00100) ||
          (shift_reg[4:0] == 5'b10100) ||
          (shift_reg[4:0] == 5'b01000) ||
          (shift_reg[4:0] == 5'b01001)) {
            penny = 1;
            nickel = 0;
            dime = 0;
            quarter = 0;
            shift_reg[4:0] = 5'b00000;
        } else if (shift_reg[4:0] == 5'b00010){
            penny = 0;
            nickel = 1;
            dime = 0;
            quarter = 0;
            shift_reg[4:0] = 5'b00000;
        } else if (shift_reg[4:0] == 5'b01110){
            penny = 0;
            nickel = 0;
            dime = 1;
            quarter = 0;
            shift_reg[4:0] = 5'b00000;
        } else if (shift_reg[4:0] == 5'b01010){
            penny = 0;
            nickel = 0;
            dime = 0;
            quarter = 1;
            shift_reg[4:0] = 5'b00000;
        } else
            penny = 0; nickel = 0;, dime = 0; quarter = 0;
      end
    end
endmodule
