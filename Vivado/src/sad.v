`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2021 08:16:27 PM
// Design Name: 
// Module Name: sad
// Project Name: Emoji_Animation
// Target Devices: 
// Tool Versions: 
// Description: sad face animation
// 
// Dependencies: 25 MHz input clk
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sad(
	input clk,                  // 25MHz
	input [9:0] i_hcounter,     // horizontal pixel counter
	input [9:0] i_vcounter,     // vertical pixel counter
	output [11:0] o_color_data  // color data bus
	);
	
	reg [31:0] clk_counter = 0;    // for keeping track of how long the frame is active
	reg [2:0] FRAME = 0;           // State
	reg [11:0] r_color = 12'h000;  // color of pixel (4 bits red, 4 bits green, 4 bits blue -- in that order)
	
	assign o_color_data = r_color;
	
  // each emoji animation has a number of frames (different from fps frames)
	localparam FRAME_1 = 3'b000;
	localparam FRAME_2 = 3'b001;
	localparam FRAME_3 = 3'b010;
	localparam FRAME_4 = 3'b011;
  localparam FRAME_5 = 3'b100;
  localparam FRAME_6 = 3'b101;
  localparam FRAME_7 = 3'b110;
  localparam FRAME_8 = 3'b111;
  
  // time in clock cycles to hold each frame still
  localparam FRAME_1_time = 37500000; // 0.5 sec
  localparam FRAME_2_time = 2500000; // 100 ms
  localparam FRAME_3_time = 2500000; // 100 ms
  localparam FRAME_4_time = 2500000; // 100 ms
  localparam FRAME_5_time = 3000000; 
  localparam FRAME_6_time = 3500000; 
  localparam FRAME_7_time = 4000000;
  localparam FRAME_8_time = 37500000; // 0.5 sec
  
  // total time in clock cycles of animation 
  localparam FRAME_total_time = FRAME_1_time + FRAME_2_time + FRAME_3_time + FRAME_4_time + FRAME_5_time + FRAME_6_time + FRAME_7_time + FRAME_8_time;
  
  // basic colors used in the animation
  localparam yellow = 12'hFF0;
  localparam black = 12'h000;
  localparam white = 12'hFFF;
  localparam blue = 12'h8AF;
	
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
			else if (clk_counter >= (FRAME_1_time + FRAME_2_time + FRAME_3_time) && clk_counter < (FRAME_1_time + FRAME_2_time + FRAME_3_time + FRAME_4_time))
				FRAME <= FRAME_4;
      else if (clk_counter >= (FRAME_1_time + FRAME_2_time + FRAME_3_time + FRAME_4_time) && clk_counter < (FRAME_1_time + FRAME_2_time + FRAME_3_time + FRAME_4_time + FRAME_5_time))
				FRAME <= FRAME_5;
      else if (clk_counter >= (FRAME_1_time + FRAME_2_time + FRAME_3_time + FRAME_4_time + FRAME_5_time) && clk_counter < (FRAME_1_time + FRAME_2_time + FRAME_3_time + FRAME_4_time + FRAME_5_time + FRAME_6_time))
				FRAME <= FRAME_6;
      else if (clk_counter >= (FRAME_1_time + FRAME_2_time + FRAME_3_time + FRAME_4_time + FRAME_5_time + FRAME_6_time) && clk_counter < (FRAME_1_time + FRAME_2_time + FRAME_3_time + FRAME_4_time + FRAME_5_time + FRAME_6_time + FRAME_7_time))
				FRAME <= FRAME_7;
      else if (clk_counter >= (FRAME_1_time + FRAME_2_time + FRAME_3_time + FRAME_4_time + FRAME_5_time + FRAME_6_time + FRAME_7_time) && clk_counter <= (FRAME_total_time))
				FRAME <= FRAME_8;
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
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white; 
							end  
						// END SECTION 2.2 (FOREHEAD)
						
						// SECTION 2.3 (EYES)
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
						// END SECTION 2.3 (EYES)
						
						// SECTION 2.4 (MIDDLE OF FACE)
						else if (i_vcounter >= 217 && i_vcounter < 305)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
						// END SECTION 2.4 (MIDDLE OF FACE)
						
						// SECTION 2.5 (MOUTH)
						else if (i_vcounter >= 305 && i_vcounter < 310)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 391)
									r_color <= yellow;
								else if (i_hcounter >= 391 && i_hcounter < 537)
									r_color <= black;
								else if (i_hcounter >= 537 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 2.5 (MOUTH)
						
						// SECTION 2.6 (CHIN)
						else if (i_vcounter >= 305 && i_vcounter < 414)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
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
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white; 
							end  
						// END SECTION 3.2 (FOREHEAD)
						
						// SECTION 3.3 (EYES)
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
						// END SECTION 3.3 (EYES)
            
            // SECTION 3.4 (TEAR)
            else if (i_vcounter >= 217 && i_vcounter < 229)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 545)
                  r_color <= yellow;
                else if (i_hcounter >= 545 && i_hcounter < 557)
                  r_color <= blue;
                else if (i_hcounter >= 557 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            // END SECTION 3.4 (TEAR)
						
						// SECTION 3.5 (MIDDLE OF FACE)
						else if (i_vcounter >= 229 && i_vcounter < 305)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
						// END SECTION 3.5 (MIDDLE OF FACE)
						
						// SECTION 3.6 (MOUTH)
						else if (i_vcounter >= 305 && i_vcounter < 310)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 411)
									r_color <= yellow;
								else if (i_hcounter >= 411 && i_hcounter < 517)
									r_color <= black;
								else if (i_hcounter >= 517 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 3.6 (MOUTH)
						
						// SECTION 3.7 (CHIN)
						else if (i_vcounter >= 305 && i_vcounter < 414)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 3.7 (CHIN)
						
						// SECTION 3.8 (BOTTOM OF SCREEN)
						else if (i_vcounter <= 414)
							r_color <= white;
						// END SECTION 3.8 (BOTTOM OF SCREEN)
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
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white; 
							end  
						// END SECTION 4.2 (FOREHEAD)
						
						// SECTION 4.3 (EYES)
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
						// END SECTION 4.3 (EYES)
            
            // SECTION 4.4 (PART OF FACE ABOVE TEAR)
            else if (i_vcounter >= 217 && i_vcounter < 229)
              begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
            // END SECTION 4.4 (PART OF FACE ABOVE TEAR)  
            
            // SECTION 4.5 (TEAR)
            else if (i_vcounter >= 229 && i_vcounter < 241)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 545)
                  r_color <= yellow;
                else if (i_hcounter >= 545 && i_hcounter < 557)
                  r_color <= blue;
                else if (i_hcounter >= 557 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            // END SECTION 4.5 (TEAR)
						
						// SECTION 4.6 (MIDDLE OF FACE)
						else if (i_vcounter >= 241 && i_vcounter < 305)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
						// END SECTION 4.6 (MIDDLE OF FACE)
						
						// SECTION 4.7 (MOUTH)
						else if (i_vcounter >= 305 && i_vcounter < 310)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 431)
									r_color <= yellow;
								else if (i_hcounter >= 431 && i_hcounter < 497)
									r_color <= black;
								else if (i_hcounter >= 497 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 4.7 (MOUTH)
						
						// SECTION 4.8 (CHIN)
						else if (i_vcounter >= 305 && i_vcounter < 414)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 4.8 (CHIN)
						
						// SECTION 4.9 (BOTTOM OF SCREEN)
						else if (i_vcounter <= 414)
							r_color <= white;
						// END SECTION 4.9 (BOTTOM OF SCREEN)
					end  // FRAME_4
          
          FRAME_5 : 
					begin 
						// SECTION 5.1 (TOP OF SCREEN)
						if (i_vcounter < 135)             
								r_color <= white;
						// END SECTION 5.1 (TOP OF SCREEN)
						
						// SECTION 5.2 (FOREHEAD)
						else if (i_vcounter >= 135 && i_vcounter < 205)
							begin 
								if (i_hcounter < 324) 
									r_color <= white;  
								else if (i_hcounter >= 324 && i_hcounter < 604) 
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white; 
							end  
						// END SECTION 5.2 (FOREHEAD)
						
						// SECTION 5.3 (EYES)
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
						// END SECTION 5.3 (EYES)
            
            // SECTION 5.4 (PART OF FACE ABOVE TEAR)
            else if (i_vcounter >= 217 && i_vcounter < 241)
              begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
            // END SECTION 5.4 (PART OF FACE ABOVE TEAR)  
            
            // SECTION 5.5 (TEAR)
            else if (i_vcounter >= 241 && i_vcounter < 253)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 545)
                  r_color <= yellow;
                else if (i_hcounter >= 545 && i_hcounter < 557)
                  r_color <= blue;
                else if (i_hcounter >= 557 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            // END SECTION 5.5 (TEAR)
						
						// SECTION 5.6 (MIDDLE OF FACE)
						else if (i_vcounter >= 253 && i_vcounter < 305)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
						// END SECTION 5.6 (MIDDLE OF FACE)
						
						// SECTION 5.7 (MOUTH)
						else if (i_vcounter >= 305 && i_vcounter < 310)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 441)
									r_color <= yellow;
								else if (i_hcounter >= 441 && i_hcounter < 487)
									r_color <= black;
								else if (i_hcounter >= 487 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 5.7 (MOUTH)
						
						// SECTION 5.8 (CHIN)
						else if (i_vcounter >= 305 && i_vcounter < 414)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 5.8 (CHIN)
						
						// SECTION 5.9 (BOTTOM OF SCREEN)
						else if (i_vcounter <= 414)
							r_color <= white;
						// END SECTION 5.9 (BOTTOM OF SCREEN)
					end  // FRAME_5
          
          FRAME_6 : 
					begin 
						// SECTION 6.1 (TOP OF SCREEN)
						if (i_vcounter < 135)             
								r_color <= white;
						// END SECTION 6.1 (TOP OF SCREEN)
						
						// SECTION 6.2 (FOREHEAD)
						else if (i_vcounter >= 135 && i_vcounter < 205)
							begin 
								if (i_hcounter < 324) 
									r_color <= white;  
								else if (i_hcounter >= 324 && i_hcounter < 604) 
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white; 
							end  
						// END SECTION 6.2 (FOREHEAD)
						
						// SECTION 6.3 (EYES)
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
						// END SECTION 6.3 (EYES)
            
            // SECTION 6.4 (PART OF FACE ABOVE TEAR)
            else if (i_vcounter >= 217 && i_vcounter < 253)
              begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
            // END SECTION 6.4 (PART OF FACE ABOVE TEAR)  
            
            // SECTION 6.5 (TEAR)
            else if (i_vcounter >= 253 && i_vcounter < 265)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 545)
                  r_color <= yellow;
                else if (i_hcounter >= 545 && i_hcounter < 557)
                  r_color <= blue;
                else if (i_hcounter >= 557 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            // END SECTION 6.5 (TEAR)
						
						// SECTION 6.6 (MIDDLE OF FACE)
						else if (i_vcounter >= 265 && i_vcounter < 305)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
						// END SECTION 6.6 (MIDDLE OF FACE)
						
						// SECTION 6.7 (MOUTH)
						else if (i_vcounter >= 305 && i_vcounter < 310)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 441)
									r_color <= yellow;
								else if (i_hcounter >= 441 && i_hcounter < 487)
									r_color <= black;
								else if (i_hcounter >= 487 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 6.7 (MOUTH)
						
						// SECTION 6.8 (CHIN)
						else if (i_vcounter >= 305 && i_vcounter < 414)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 6.8 (CHIN)
						
						// SECTION 6.9 (BOTTOM OF SCREEN)
						else if (i_vcounter <= 414)
							r_color <= white;
						// END SECTION 6.9 (BOTTOM OF SCREEN)
					end  // FRAME_6
          
          FRAME_7 : 
					begin 
						// SECTION 7.1 (TOP OF SCREEN)
						if (i_vcounter < 135)             
								r_color <= white;
						// END SECTION 7.1 (TOP OF SCREEN)
						
						// SECTION 7.2 (FOREHEAD)
						else if (i_vcounter >= 135 && i_vcounter < 205)
							begin 
								if (i_hcounter < 324) 
									r_color <= white;  
								else if (i_hcounter >= 324 && i_hcounter < 604) 
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white; 
							end  
						// END SECTION 7.2 (FOREHEAD)
						
						// SECTION 7.3 (EYES)
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
						// END SECTION 7.3 (EYES)
            
            // SECTION 7.4 (PART OF FACE ABOVE TEAR)
            else if (i_vcounter >= 217 && i_vcounter < 265)
              begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
            // END SECTION 7.4 (PART OF FACE ABOVE TEAR)  
            
            // SECTION 7.5 (TEAR)
            else if (i_vcounter >= 265 && i_vcounter < 277)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 545)
                  r_color <= yellow;
                else if (i_hcounter >= 545 && i_hcounter < 557)
                  r_color <= blue;
                else if (i_hcounter >= 557 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            // END SECTION 7.5 (TEAR)
						
						// SECTION 7.6 (MIDDLE OF FACE)
						else if (i_vcounter >= 277 && i_vcounter < 305)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
						// END SECTION 7.6 (MIDDLE OF FACE)
						
						// SECTION 7.7 (MOUTH)
						else if (i_vcounter >= 305 && i_vcounter < 310)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 441)
									r_color <= yellow;
								else if (i_hcounter >= 441 && i_hcounter < 487)
									r_color <= black;
								else if (i_hcounter >= 487 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 7.7 (MOUTH)
						
						// SECTION 7.8 (CHIN)
						else if (i_vcounter >= 305 && i_vcounter < 414)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 7.8 (CHIN)
						
						// SECTION 7.9 (BOTTOM OF SCREEN)
						else if (i_vcounter <= 414)
							r_color <= white;
						// END SECTION 7.9 (BOTTOM OF SCREEN)
					end  // FRAME_7
          
          FRAME_8 : 
					begin 
						// SECTION 8.1 (TOP OF SCREEN)
						if (i_vcounter < 135)             
								r_color <= white;
						// END SECTION 8.1 (TOP OF SCREEN)
						
						// SECTION 8.2 (FOREHEAD)
						else if (i_vcounter >= 135 && i_vcounter < 205)
							begin 
								if (i_hcounter < 324) 
									r_color <= white;  
								else if (i_hcounter >= 324 && i_hcounter < 604) 
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white; 
							end  
						// END SECTION 8.2 (FOREHEAD)
						
						// SECTION 8.3 (EYES)
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
						// END SECTION 8.3 (EYES)
            
            // SECTION 8.4 (PART OF FACE ABOVE TEAR)
            else if (i_vcounter >= 217 && i_vcounter < 277)
              begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
            // END SECTION 8.4 (PART OF FACE ABOVE TEAR)  
            
            // SECTION 8.5 (TEAR)
            else if (i_vcounter >= 277 && i_vcounter < 289)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 545)
                  r_color <= yellow;
                else if (i_hcounter >= 545 && i_hcounter < 557)
                  r_color <= blue;
                else if (i_hcounter >= 557 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            // END SECTION 8.5 (TEAR)
						
						// SECTION 8.6 (MIDDLE OF FACE)
						else if (i_vcounter >= 289 && i_vcounter < 305)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
						// END SECTION 8.6 (MIDDLE OF FACE)
						
						// SECTION 8.7 (MOUTH)
						else if (i_vcounter >= 305 && i_vcounter < 310)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 441)
									r_color <= yellow;
								else if (i_hcounter >= 441 && i_hcounter < 487)
									r_color <= black;
								else if (i_hcounter >= 487 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 8.7 (MOUTH)
						
						// SECTION 8.8 (CHIN)
						else if (i_vcounter >= 305 && i_vcounter < 414)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 8.8 (CHIN)
						
						// SECTION 8.9 (BOTTOM OF SCREEN)
						else if (i_vcounter <= 414)
							r_color <= white;
						// END SECTION 8.9 (BOTTOM OF SCREEN)
					end  // FRAME_8
        
          default :
					begin 
						r_color <= white;
					end  // default 
			endcase
		end  // always
endmodule
