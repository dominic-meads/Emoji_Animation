`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Meads
// 
// Create Date: 05/22/2021 09:53:03 PM
// Design Name: 
// Module Name: h_v_counter
// Project Name: Emoji_Animation
// Target Devices: 
// Tool Versions: 
// Description: generates the horizontal and vertical counters needed to keep track of pixels and v_sync/h_sync
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module h_v_counter(
  input clk,               // 25 MHz
  output [9:0] o_hcounter, // horizontal pixel counter
  output [9:0] o_vcounter  // verticle pixel counter
  );
    
  reg [9:0] r_hcounter = 0;  // horizontal counter reg
	reg [9:0] r_vcounter = 0;  // vertical counter reg'
  
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// counter and sync generation
	always @(posedge clk)  // horizontal counter
		begin 
			if (r_hcounter < 799)
				r_hcounter <= r_hcounter + 1;  // horizontal counter (including off-screen horizontal 160 pixels) total of 800 pixels 
			else
				r_hcounter <= 0;              
		end  // always 
	
	always @ (posedge clk)  // vertical counter
		begin 
			if (r_hcounter == 799)  // only counts up 1 count after horizontal finishes 800 counts
				begin
					if (r_vcounter < 525)  // vertical counter (including off-screen vertical 45 pixels) total of 525 pixels
						r_vcounter <= r_vcounter + 1;
					else
						r_vcounter <= 0;              
				end  // if (r_hcounter...
		end  // always
	
  // counter output assignments
	assign o_hcounter = r_hcounter;
	assign o_vcounter = r_vcounter;
	// end counter and sync generation  
  
endmodule
