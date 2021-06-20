`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: DOminic Meads
// 
// Create Date: 06/06/2021 01:28:47 PM
// Design Name: 
// Module Name: mad
// Project Name: Emoji_Animation
// Target Devices: 
// Tool Versions: 
// Description: mad face animation
// 
// Dependencies: 25 MHz input clk
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mad (
	input clk,                  // 25MHz
	input [9:0] i_hcounter,     // horizontal pixel counter
	input [9:0] i_vcounter,     // vertical pixel counter
	output [11:0] o_color_data  // color data bus
	);
	
	reg [31:0] clk_counter = 0;    // for keeping track of how long the frame is active
	reg [1:0] FRAME = 0;           // State
	reg [11:0] r_color = 12'h000;  // color of pixel (4 bits red, 4 bits green, 4 bits blue -- in that order)
	
	assign o_color_data = r_color;
	
  // each emoji animation has a number of frames (different from fps frames)
	localparam FRAME_1 = 2'b00;
	localparam FRAME_2 = 2'b01;
	localparam FRAME_3 = 2'b10;
	localparam FRAME_4 = 2'b11;
  
  // time in clock cycles to hold each frame still
  localparam FRAME_1_time = 37500000; // 0.5 sec
  localparam FRAME_2_time = 2500000; // 100 ms
  localparam FRAME_3_time = 2500000; // 100 ms
  localparam FRAME_4_time = 37500000; // 1.5 sec
  // total time in clock cycles of animation before looping around
  localparam FRAME_total_time = FRAME_1_time + FRAME_2_time + FRAME_3_time + FRAME_4_time;
  
  // basic colors used in the animation
  localparam yellow = 12'hFF0;
  localparam black = 12'h000;
  localparam white = 12'hFFF;
  localparam yellow_orange = 12'hFD0;
  localparam orange = 12'hF80;
  localparam red_orange = 12'hF40;
	
  //////////////////////////////////////////////////////////////////////////////
  // frame timing
	always @ (posedge clk)
		begin 
			if (clk_counter < FRAME_total_time)
				clk_counter <= clk_counter + 1;
			else 
				clk_counter <= 0;
		end 
		
	always @ (posedge clk) 
		begin 
			if (clk_counter < FRAME_1_time)  
				FRAME <= FRAME_1;
			else if (clk_counter >= FRAME_1_time && clk_counter < (FRAME_1_time + FRAME_2_time)) 
				FRAME <= FRAME_2;
			else if (clk_counter >= (FRAME_1_time + FRAME_2_time) && clk_counter < (FRAME_1_time + FRAME_2_time + FRAME_3_time))  
				FRAME <= FRAME_3;
			else if (clk_counter >= (FRAME_1_time + FRAME_2_time + FRAME_3_time) && clk_counter <= FRAME_total_time)
				FRAME <= FRAME_4;
		end 
  // end frame timing
  
  ///////////////////////////////////////////////////////////////////////////////
  // Frame state machine
	always @ (posedge clk)
		begin 
			case (FRAME)
				FRAME_1 : 
					begin 
						// SECTION 1.1 (TOP OF SCREEN)
						if (i_vcounter < 135)             
								r_color <= white;
						// END SECTION 1.1 (TOP OF SCREEN)
						
						// SECTION 1.2 (FOREHEAD)
						else if (i_vcounter >= 135 && i_vcounter < 205)
							begin 
								if (i_hcounter < 324) 
									r_color <= white;  
								else if (i_hcounter >= 324 && i_hcounter < 604) 
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white; 
							end  
						// END SECTION 1.2 (FOREHEAD)
						
						// SECTION 1.3 (EYES)
						else if (i_vcounter >= 205 && i_vcounter < 217)
							begin 
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 371)
									r_color <= yellow;
								else if (i_hcounter >= 371 && i_hcounter < 383)
									r_color <= black;
								else if (i_hcounter >= 383 && i_hcounter < 545)
									r_color <= yellow;
								else if (i_hcounter >= 545 && i_hcounter < 557)
									r_color <= black; 
								else if (i_hcounter >= 557 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 1.3 (EYES)
						
						// SECTION 1.4 (MIDDLE OF FACE)
						else if (i_vcounter >= 217 && i_vcounter < 305)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
						// END SECTION 1.4 (MIDDLE OF FACE)
						
						// SECTION 1.5 (MOUTH)
						else if (i_vcounter >= 305 && i_vcounter < 310)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 371)
									r_color <= yellow;
								else if (i_hcounter >= 371 && i_hcounter < 557)
									r_color <= black;
								else if (i_hcounter >= 557 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 1.5 (MOUTH)
						
						// SECTION 1.6 (CHIN)
						else if (i_vcounter >= 305 && i_vcounter < 414)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 1.6 (CHIN)
						
						// SECTION 1.7 (BOTTOM OF SCREEN)
						else if (i_vcounter <= 414)
							r_color <= white;
						// END SECTION 1.7 (BOTTOM OF SCREEN)
					end  // FRAME_1
				
				FRAME_2 :
					begin 
						// SECTION 2.1 (TOP OF SCREEN)
						if (i_vcounter < 135)             
								r_color <= white;
						// END SECTION 2.1 (TOP OF SCREEN)
						
						// SECTION 2.2 (FOREHEAD)
						else if (i_vcounter >= 135 && i_vcounter < 205)
							begin 
								if (i_hcounter < 324) 
									r_color <= white;  
								else if (i_hcounter >= 324 && i_hcounter < 604) 
									r_color <= yellow_orange;
								else if (i_hcounter >= 604)
									r_color <= white; 
							end  
						// END SECTION 2.2 (FOREHEAD)
						
						// SECTION 2.3 (EYES)
						else if (i_vcounter >= 205 && i_vcounter < 217)
							begin 
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 366)
									r_color <= yellow_orange;
								else if (i_hcounter >= 366 && i_hcounter < 388)
									r_color <= black;
								else if (i_hcounter >= 388 && i_hcounter < 540)
									r_color <= yellow_orange;
								else if (i_hcounter >= 540 && i_hcounter < 562)
									r_color <= black; 
								else if (i_hcounter >= 562 && i_hcounter < 604)
									r_color <= yellow_orange;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 2.3 (EYES)
						
						// SECTION 2.4 (MIDDLE OF FACE)
						else if (i_vcounter >= 217 && i_vcounter < 300)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow_orange;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
						// END SECTION 2.4 (MIDDLE OF FACE)
						
						// SECTION 2.5 (MOUTH)
						else if (i_vcounter >= 300 && i_vcounter < 331)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 361)
									r_color <= yellow_orange;
								else if (i_hcounter >= 361 && i_hcounter < 567)
									r_color <= black;
								else if (i_hcounter >= 567 && i_hcounter < 604)
									r_color <= yellow_orange;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 2.5 (MOUTH)
						
						// SECTION 2.6 (CHIN)
						else if (i_vcounter >= 331 && i_vcounter < 414)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow_orange;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 2.6 (CHIN)
						
						// SECTION 2.7 (BOTTOM OF SCREEN)
						else if (i_vcounter <= 414)
							r_color <= white;
						// END SECTION 2.7 (BOTTOM OF SCREEN)
					end  // FRAME_2
					
				FRAME_3 :
					begin 
						// SECTION 3.1 (TOP OF SCREEN)
						if (i_vcounter < 135)             
								r_color <= white;
						// END SECTION 3.1 (TOP OF SCREEN)
						
						// SECTION 3.2 (FOREHEAD)
						else if (i_vcounter >= 135 && i_vcounter < 205)
							begin 
								if (i_hcounter < 324) 
									r_color <= white;  
								else if (i_hcounter >= 324 && i_hcounter < 604) 
									r_color <= orange;
								else if (i_hcounter >= 604)
									r_color <= white; 
							end  
						// END SECTION 3.2 (FOREHEAD)
						
						// SECTION 3.3 (EYES)
						else if (i_vcounter >= 205 && i_vcounter < 217)
							begin 
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 361)
									r_color <= orange;
								else if (i_hcounter >= 361 && i_hcounter < 393)
									r_color <= black;
								else if (i_hcounter >= 393 && i_hcounter < 535)
									r_color <= orange;
								else if (i_hcounter >= 535 && i_hcounter < 567)
									r_color <= black; 
								else if (i_hcounter >= 567 && i_hcounter < 604)
									r_color <= orange;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 3.3 (EYES)
						
						// SECTION 3.4 (MIDDLE OF FACE)
						else if (i_vcounter >= 217 && i_vcounter < 295)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= orange;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
						// END SECTION 3.4 (MIDDLE OF FACE)
						
						// SECTION 3.5 (MOUTH)
						else if (i_vcounter >= 295 && i_vcounter < 336)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 351)
									r_color <= orange;
								else if (i_hcounter >= 351 && i_hcounter < 577)
									r_color <= black;
								else if (i_hcounter >= 577 && i_hcounter < 604)
									r_color <= orange;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 3.5 (MOUTH)
						
						// SECTION 3.6 (CHIN)
						else if (i_vcounter >= 336 && i_vcounter < 414)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= orange;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 3.6 (CHIN)
						
						// SECTION 3.7 (BOTTOM OF SCREEN)
						else if (i_vcounter <= 414)
							r_color <= white;
						// END SECTION 3.7 (BOTTOM OF SCREEN)
					end  // FRAME_3
					
				FRAME_4 :
					begin 
						// SECTION 4.1 (TOP OF SCREEN)
						if (i_vcounter < 135)             
								r_color <= white;
						// END SECTION 4.1 (TOP OF SCREEN)
						
						// SECTION 4.2 (FOREHEAD)
						else if (i_vcounter >= 135 && i_vcounter < 205)
							begin 
								if (i_hcounter < 324) 
									r_color <= white;  
								else if (i_hcounter >= 324 && i_hcounter < 604) 
									r_color <= red_orange;
								else if (i_hcounter >= 604)
									r_color <= white; 
							end  
						// END SECTION 4.2 (FOREHEAD)
						
						// SECTION 4.3 (EYES)
						else if (i_vcounter >= 205 && i_vcounter < 217)
							begin 
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 358)
									r_color <= red_orange;
								else if (i_hcounter >= 358 && i_hcounter < 396)
									r_color <= black;
								else if (i_hcounter >= 396 && i_hcounter < 532)
									r_color <= red_orange;
								else if (i_hcounter >= 532 && i_hcounter < 570)
									r_color <= black; 
								else if (i_hcounter >= 570 && i_hcounter < 604)
									r_color <= red_orange;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 4.3 (EYES)
						
						// SECTION 4.4 (MIDDLE OF FACE)
						else if (i_vcounter >= 217 && i_vcounter < 290)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= red_orange;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
						// END SECTION 4.4 (MIDDLE OF FACE)
						
						// SECTION 4.5 (MOUTH)
						else if (i_vcounter >= 290 && i_vcounter < 341)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 341)
									r_color <= red_orange;
								else if (i_hcounter >= 341 && i_hcounter < 587)
									r_color <= black;
								else if (i_hcounter >= 587 && i_hcounter < 604)
									r_color <= red_orange;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 4.5 (MOUTH)
						
						// SECTION 4.6 (CHIN)
						else if (i_vcounter >= 341 && i_vcounter < 414)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= red_orange;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 4.6 (CHIN)
						
						// SECTION 4.7 (BOTTOM OF SCREEN)
						else if (i_vcounter <= 414)
							r_color <= white;
						// END SECTION 4.7 (BOTTOM OF SCREEN)
					end  // FRAME_4
				
				default :
					begin 
						r_color <= white;
					end  // default  
			endcase
		end  // always 
endmodule  // mad

  

