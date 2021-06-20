`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Meads
// 
// Create Date: 05/25/2021 08:31:56 PM
// Design Name: 
// Module Name: clk_gen
// Project Name: Emoji_Animation
// Target Devices: 7 Series FPGAs
// Tool Versions: 
// Description: generates 25 MHz pixel clock for VGA from 125 MHz input clock on Arty board
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk_gen(
  input i_clk_125MHz,
  input i_rst,
  output o_clk_25MHz,
  output o_locked
  );
  
  wire w_clk_fb;
  wire w_clk_25MHz;
    
       PLLE2_BASE #(
      .BANDWIDTH("OPTIMIZED"),  // OPTIMIZED, HIGH, LOW
      .CLKFBOUT_MULT(33),        // Multiply value for all CLKOUT, (2-64)
      .CLKFBOUT_PHASE(0.0),     // Phase offset in degrees of CLKFB, (-360.000-360.000).
      .CLKIN1_PERIOD(8.0),      // Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).
      .CLKOUT0_DIVIDE(33),
      .CLKOUT0_DUTY_CYCLE(0.5),
      .CLKOUT0_PHASE(0.0),
      .DIVCLK_DIVIDE(5),        // Master division value, (1-56)
      .REF_JITTER1(0.0),        // Reference input jitter in UI, (0.000-0.999).
      .STARTUP_WAIT("FALSE")    // Delay DONE until PLL Locks, ("TRUE"/"FALSE")
   )
   PLLE2_BASE_inst (
      .CLKOUT0(w_clk_25MHz), 
      .CLKFBOUT(w_clk_fb), 
      .LOCKED(o_locked),    
      .CLKIN1(i_clk_125MHz),     
      .PWRDWN(1'b0),     
      .RST(i_rst),           
      .CLKFBIN(w_clk_fb)    
   );
   
     BUFG clk_out (
      .O(o_clk_25MHz),
      .I(w_clk_25MHz) 
   );

endmodule
