`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Meads
// 
// Create Date: 06/19/2021 12:54:25 PM
// Design Name: 
// Module Name: mux4to1_12bit
// Project Name: Emoji_Animation
// Target Devices: 
// Tool Versions: 
// Description: multiplexes all the different emotions and outputs one depending on the select value
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux4to1_12bit(
  input [11:0] i_happy_data,
  input [11:0] i_sad_data,
  input [11:0] i_mad_data,
  input [11:0] i_crazy_data,
  input [1:0] i_sel,          // from processor
  output [11:0] o_color_data  // output data to VGA driver module
  );
  
  assign o_color_data = (i_sel == 2'b00) ? i_happy_data : 
                        (i_sel == 2'b01) ? i_sad_data : 
                        (i_sel == 2'b10) ? i_mad_data : 
                        (i_sel == 2'b11) ? i_crazy_data :
                        12'h000;
  
endmodule
