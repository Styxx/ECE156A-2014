/*
*   TestBench for Homework 3
*/


module hw3tb();

//-----Coin Sensor TestBench-----//
// module coinSensor(penny,nickel,dime,quarter, clk,reset,serialIn);
reg clk, reset, serialIn;
wire penny, nickel, dime, quarter;

coinSensor coinS (penny,nickel,dime,quarter, clk,reset,serialIn);

initial begin
  clk <= 0;
  reset <= 1;
  serialIn <= 0;

  #15 reset <= 0;
  #10 reset <= 1;
  #70 serialIn <= 1;
  #10 serialIn <= 0;

  end

  always begin
  #10 clk <= ~clk;
  end

//-----End coinSensor TB-----//


endmodule
