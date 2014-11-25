/*
*   Seven Segment Display Manager
*   Shows accumulated credit of user
*   When purchase made, shows code for 6 clock cycles
*/


module sevenSegDispMngr (input clk, reset, apple, banana, carrot, date, error, 
 input [7:0] credit, output [6:0] digit1, digit0);

  input clk, reset, apple, banana, carrot, date, error;
  input [7:0] credit;
  output [6:0] digit1, digit0;
  reg [6:0] digit1, digit0;
  
  
  always @ (posedge clk)      // If making purchase
   begin
    
    
    
    
    
    
    
    
    end
    
 if (!apple && !banana && !carrot && !date && !error)
  begin
   always @ (posedge clk)      // If not making purchase, display credit
   begin
   if (!reset) {
    digit1 = 7'b0000000;
    digit2 = 7'b0000000;
   }
   else{
   
      // Display credit
   
   }
   end
 }
endmodule
