`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Meads
// 
// Create Date: 05/22/2021 09:05:25 PM
// Design Name: 
// Module Name: VGA_driver
// Project Name: Emoji_Animation
// Target Devices: 
// Tool Versions: 
// Description: generic VGA driver 640x480 @ 60 FPS
// 
// Dependencies: Input clk frequency of 25 MHz
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module VGA_driver (
	input clk,                 // 25 MHz     
	input [11:0] i_color_data, // color input data (4 bits red, 4 bits green, 4 bits blue)
  input [9:0] i_hcounter,    // horizontal counter 0-799 (include blanking)
	input [9:0] i_vcounter,    // vertical counter 0-524 (include blanking)
	output o_hsync,            // horizontal sync
	output o_vsync,            // vertical sync
	output [3:0] o_red,        // output color red
	output [3:0] o_green,      // output color green
	output [3:0] o_blue        // output color blue
	);
	
	// separate the i_color_data input into its separate RGB colors
	wire [3:0] w_red = i_color_data[11:8];
	wire [3:0] w_green = i_color_data[7:4];
	wire [3:0] w_blue = i_color_data[3:0];
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// hsync and vsync output assignments
	assign o_hsync = (i_hcounter >= 0 && i_hcounter < 96) ? 1:0;  // hsync high for 96 counts                                                 
	assign o_vsync = (i_vcounter >= 0 && i_vcounter < 2) ? 1:0;   // vsync high for 2 counts
	// end hsync and vsync output assignments

	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// color output assignments
		// only output the colors if the counters are within the adressable video time constraints
	assign o_red = (i_hcounter > 144 && i_hcounter <= 783 && i_vcounter > 35 && i_vcounter <= 514) ? w_red : 4'h0;
	assign o_green = (i_hcounter > 144 && i_hcounter <= 783 && i_vcounter > 35 && i_vcounter <= 514) ? w_green : 4'h0;
	assign o_blue = (i_hcounter > 144 && i_hcounter <= 783 && i_vcounter > 35 && i_vcounter <= 514) ? w_blue : 4'h0;
	// end color output assignments
	
endmodule  // VGA_driver
