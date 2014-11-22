/*
* Piggy Bank
* Adds credit for penny(1), nickel(5), dime(10), and quarter(25)
* Subtracts credit for apple(75), banana(20), carrot(30), and date(40)
* Max credit is $2.55, displayed in hex
* Active low, asynchronous reset
*/

module piggyBank (input clk, reset, penny, nickel, dime, quarter, apple, banana, carrot, date, output [7:0] credit);
  input clk, reset, penny, nickel, dime, quarter, apple, banana, carrot, date;
  output [7:0] credit;
  
  always @ (posedge clk or reset)
    begin
      if (!reset)
        credit = 7'b0000000;
      else begin
        if (penny == 1)
          credit = credit + 1;
        else if (nickel == 1)
          credit = credit + 5;
        else if (dime == 1)
          credit = credit + 10;
        else if (quarter == 1)
          credit = credit + 25;
        if (apple == 1)
          credit = credit - 75;
        else if (banana == 1)
          credit = credit - 20;
        else if (carrot == 1)
          credit = credit - 30;
        else if (date == 1)
          credit = credit - 40;
      end
    end
endmodule
