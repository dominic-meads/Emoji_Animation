`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Dominic Meads
// 
// Create Date: 06/06/2021 02:06:21 PM
// Design Name: 
// Module Name: crazy
// Project Name: Emoji_Animation
// Target Devices: 
// Tool Versions: 
// Description: crazy face animation
// 
// Dependencies: 25 MHz input clk
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module crazy(
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
  localparam FRAME_4_time = 3500000; // 200 ms
  localparam FRAME_5_time = 3500000; 
  localparam FRAME_6_time = 3500000; 
  localparam FRAME_7_time = 3500000;
  localparam FRAME_8_time = 37500000; // 0.5 sec
  
  // total time in clock cycles of animation 
  localparam FRAME_total_time = FRAME_1_time + FRAME_2_time + FRAME_3_time + FRAME_4_time + FRAME_5_time + FRAME_6_time + FRAME_7_time + FRAME_8_time;
  
  // basic colors used in the animation
  localparam yellow = 12'hFF0;
  localparam black = 12'h000;
  localparam white = 12'hFFF;
  localparam pink = 12'hF7E;
  	
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
						else if (i_vcounter >= 135 && i_vcounter < 180)
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
						else if (i_vcounter >= 180 && i_vcounter < 207)
							begin 
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 404)
									r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 584)
									r_color <= white; 
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end
            else if (i_vcounter >= 207 && i_vcounter < 213)
              begin 
                if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 361)
									r_color <= white;
                else if (i_hcounter >= 361 && i_hcounter < 367)
                  r_color <= black;
                else if (i_hcounter >= 367 && i_hcounter < 404)
                  r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 541)
									r_color <= white; 
                else if (i_hcounter >= 541 && i_hcounter < 547)
                  r_color <= black;
                else if (i_hcounter >= 547 && i_hcounter < 584)
                  r_color <= white;
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            else if (i_vcounter >= 213 && i_vcounter < 240)
              begin 
                if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 404)
									r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 584)
									r_color <= white; 
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end   
						// END SECTION 1.3 (EYES)
						
						// SECTION 1.4 (MIDDLE OF FACE)
						else if (i_vcounter >= 240 && i_vcounter < 305)
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
						else if (i_vcounter >= 135 && i_vcounter < 180)
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
						else if (i_vcounter >= 180 && i_vcounter < 207)
							begin 
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 404)
									r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 584)
									r_color <= white; 
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end
            else if (i_vcounter >= 207 && i_vcounter < 213)
              begin 
                if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 361)
									r_color <= white;
                else if (i_hcounter >= 361 && i_hcounter < 367)
                  r_color <= black;
                else if (i_hcounter >= 367 && i_hcounter < 404)
                  r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 541)
									r_color <= white; 
                else if (i_hcounter >= 541 && i_hcounter < 547)
                  r_color <= black;
                else if (i_hcounter >= 547 && i_hcounter < 584)
                  r_color <= white;
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            else if (i_vcounter >= 213 && i_vcounter < 240)
              begin 
                if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 404)
									r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 584)
									r_color <= white; 
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end    
						// END SECTION 2.3 (EYES)
						
						// SECTION 2.4 (MIDDLE OF FACE)
						else if (i_vcounter >= 240 && i_vcounter < 300)
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
						else if (i_vcounter >= 300 && i_vcounter < 315)
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
						// END SECTION 2.5 (MOUTH)
            
            // SECTION 2.6 (TONUGE)
            else if (i_vcounter >= 315 && i_vcounter < 317)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            else if (i_vcounter >= 317 && i_vcounter < 319)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 449)
                  r_color <= pink;
                else if (i_hcounter >= 449 && i_hcounter < 451)
                  r_color <= black;
                else if (i_hcounter >= 451 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            else if (i_vcounter >= 319 && i_vcounter < 321)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end
            // END SECTION 2.6 (TONUGE)
						
						// SECTION 2.7 (CHIN)
						else if (i_vcounter >= 321 && i_vcounter < 414)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 2.7 (CHIN)
						
						// SECTION 2.8 (BOTTOM OF SCREEN)
						else if (i_vcounter <= 414)
							r_color <= white;
						// END SECTION 2.8 (BOTTOM OF SCREEN)
					end  // FRAME_2
          
          FRAME_3 : 
					begin 
						// SECTION 3.1 (TOP OF SCREEN)
						if (i_vcounter < 135)             
								r_color <= white;
						// END SECTION 3.1 (TOP OF SCREEN)
						
						// SECTION 3.2 (FOREHEAD)
						else if (i_vcounter >= 135 && i_vcounter < 180)
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
						else if (i_vcounter >= 180 && i_vcounter < 207)
							begin 
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 404)
									r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 584)
									r_color <= white; 
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end
            else if (i_vcounter >= 207 && i_vcounter < 213)
              begin 
                if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 361)
									r_color <= white;
                else if (i_hcounter >= 361 && i_hcounter < 367)
                  r_color <= black;
                else if (i_hcounter >= 367 && i_hcounter < 404)
                  r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 541)
									r_color <= white; 
                else if (i_hcounter >= 541 && i_hcounter < 547)
                  r_color <= black;
                else if (i_hcounter >= 547 && i_hcounter < 584)
                  r_color <= white;
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            else if (i_vcounter >= 213 && i_vcounter < 240)
              begin 
                if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 404)
									r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 584)
									r_color <= white; 
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
						// END SECTION 3.3 (EYES)
            
						// SECTION 3.4 (MIDDLE OF FACE)
						else if (i_vcounter >= 240 && i_vcounter < 300)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
						// END SECTION 3.4 (MIDDLE OF FACE)
						
						// SECTION 3.5 (MOUTH)
            else if (i_vcounter >= 300 && i_vcounter < 315)
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
						// END SECTION 3.5 (MOUTH)
						
						// SECTION 3.6 (TONUGE)
            else if (i_vcounter >= 315 && i_vcounter < 320)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end
            else if (i_vcounter >= 320 && i_vcounter < 330)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 449)
                  r_color <= pink;
                else if (i_hcounter >= 449 && i_hcounter < 451)
                  r_color <= black;
                else if (i_hcounter >= 451 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            else if (i_vcounter >= 330 && i_vcounter < 340)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end
            // END SECTION 3.6 (TONUGE)
						
						// SECTION 3.7 (CHIN)
						else if (i_vcounter >= 340 && i_vcounter < 414)
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
						else if (i_vcounter >= 135 && i_vcounter < 180)
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
						else if (i_vcounter >= 180 && i_vcounter < 207)
							begin 
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 404)
									r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 584)
									r_color <= white; 
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end
            else if (i_vcounter >= 207 && i_vcounter < 213)
              begin 
                if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 361)
									r_color <= white;
                else if (i_hcounter >= 361 && i_hcounter < 367)
                  r_color <= black;
                else if (i_hcounter >= 367 && i_hcounter < 404)
                  r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 541)
									r_color <= white; 
                else if (i_hcounter >= 541 && i_hcounter < 547)
                  r_color <= black;
                else if (i_hcounter >= 547 && i_hcounter < 584)
                  r_color <= white;
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            else if (i_vcounter >= 213 && i_vcounter < 240)
              begin 
                if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 404)
									r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 584)
									r_color <= white; 
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end  
						// END SECTION 4.3 (EYES)
            
						// SECTION 4.4 (MIDDLE OF FACE)
						else if (i_vcounter >= 240 && i_vcounter < 300)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
						// END SECTION 4.4 (MIDDLE OF FACE)
						
						// SECTION 4.5 (MOUTH)
						else if (i_vcounter >= 300 && i_vcounter < 315)
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
						// END SECTION 4.5 (MOUTH)
						
						// SECTION 4.6 (TONUGE)
            else if (i_vcounter >= 315 && i_vcounter < 330)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end
            else if (i_vcounter >= 330 && i_vcounter < 350)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 449)
                  r_color <= pink;
                else if (i_hcounter >= 449 && i_hcounter < 451)
                  r_color <= black;
                else if (i_hcounter >= 451 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end  
            else if (i_vcounter >= 350 && i_vcounter < 370)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end
            // END SECTION 4.6 (TONUGE)
						
						// SECTION 4.7 (CHIN)
						else if (i_vcounter >= 370 && i_vcounter < 414)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 4.7 (CHIN)
						
						// SECTION 4.8 (BOTTOM OF SCREEN)
						else if (i_vcounter <= 414)
							r_color <= white;
						// END SECTION 4.8 (BOTTOM OF SCREEN)
					end  // FRAME_4
          
          FRAME_5 : 
					begin 
						// SECTION 5.1 (TOP OF SCREEN)
						if (i_vcounter < 135)             
								r_color <= white;
						// END SECTION 5.1 (TOP OF SCREEN)
						
						// SECTION 5.2 (FOREHEAD)
						else if (i_vcounter >= 135 && i_vcounter < 180)
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
						else if (i_vcounter >= 180 && i_vcounter < 217)
							begin 
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 404)
									r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 584)
									r_color <= white; 
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end
            else if (i_vcounter >= 217 && i_vcounter < 223)
              begin 
                if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 361)
									r_color <= white;
                else if (i_hcounter >= 361 && i_hcounter < 367)
                  r_color <= black;
                else if (i_hcounter >= 367 && i_hcounter < 404)
                  r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 541)
									r_color <= white; 
                else if (i_hcounter >= 541 && i_hcounter < 547)
                  r_color <= black;
                else if (i_hcounter >= 547 && i_hcounter < 584)
                  r_color <= white;
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            else if (i_vcounter >= 223 && i_vcounter < 240)
              begin 
                if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 404)
									r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 584)
									r_color <= white; 
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end  
						// END SECTION 5.3 (EYES)
            
						// SECTION 5.4 (MIDDLE OF FACE)
						else if (i_vcounter >= 240 && i_vcounter < 300)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
						// END SECTION 5.4 (MIDDLE OF FACE)
						
						// SECTION 5.5 (MOUTH)
						else if (i_vcounter >= 300 && i_vcounter < 315)
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
						// END SECTION 5.5 (MOUTH)
						
						// SECTION 5.6 (TONUGE)
            else if (i_vcounter >= 315 && i_vcounter < 330)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end
            else if (i_vcounter >= 330 && i_vcounter < 350)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 449)
                  r_color <= pink;
                else if (i_hcounter >= 449 && i_hcounter < 451)
                  r_color <= black;
                else if (i_hcounter >= 451 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            else if (i_vcounter >= 350 && i_vcounter < 370)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            // END SECTION 5.6 (TONUGE)
						
						// SECTION 5.7 (CHIN)
						else if (i_vcounter >= 370 && i_vcounter < 414)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 5.7 (CHIN)
						
						// SECTION 5.8 (BOTTOM OF SCREEN)
						else if (i_vcounter <= 414)
							r_color <= white;
						// END SECTION 5.8 (BOTTOM OF SCREEN)
					end  // FRAME_5
          
          FRAME_6 : 
					begin 
						// SECTION 6.1 (TOP OF SCREEN)
						if (i_vcounter < 135)             
								r_color <= white;
						// END SECTION 6.1 (TOP OF SCREEN)
						
						// SECTION 6.2 (FOREHEAD)
						else if (i_vcounter >= 135 && i_vcounter < 180)
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
						else if (i_vcounter >= 180 && i_vcounter < 217)
							begin 
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 404)
									r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 584)
									r_color <= white; 
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end
            else if (i_vcounter >= 217 && i_vcounter < 223)
              begin 
                if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 371)
									r_color <= white;
                else if (i_hcounter >= 371 && i_hcounter < 377)
                  r_color <= black;
                else if (i_hcounter >= 377 && i_hcounter < 404)
                  r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 551)
									r_color <= white; 
                else if (i_hcounter >= 551 && i_hcounter < 557)
                  r_color <= black;
                else if (i_hcounter >= 557 && i_hcounter < 584)
                  r_color <= white;
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            else if (i_vcounter >= 223 && i_vcounter < 240)
              begin 
                if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 404)
									r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 584)
									r_color <= white; 
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end
						// END SECTION 6.3 (EYES)
            
						// SECTION 6.4 (MIDDLE OF FACE)
						else if (i_vcounter >= 240 && i_vcounter < 300)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
						// END SECTION 6.4 (MIDDLE OF FACE)
						
						// SECTION 6.5 (MOUTH)
						else if (i_vcounter >= 300 && i_vcounter < 315)
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
						// END SECTION 6.5 (MOUTH)
						
						// SECTION 6.6 (TONUGE)
            else if (i_vcounter >= 315 && i_vcounter < 330)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end
            else if (i_vcounter >= 330 && i_vcounter < 350)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 449)
                  r_color <= pink;
                else if (i_hcounter >= 449 && i_hcounter < 451)
                  r_color <= black;
                else if (i_hcounter >= 451 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            else if (i_vcounter >= 350 && i_vcounter < 370)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            // END SECTION 6.6 (TONUGE)
						
						// SECTION 6.7 (CHIN)
						else if (i_vcounter >= 370 && i_vcounter < 414)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 6.7 (CHIN)
						
						// SECTION 6.8 (BOTTOM OF SCREEN)
						else if (i_vcounter <= 414)
							r_color <= white;
						// END SECTION 6.8 (BOTTOM OF SCREEN)
					end  // FRAME_6
          
          FRAME_7 : 
					begin 
						// SECTION 7.1 (TOP OF SCREEN)
						if (i_vcounter < 135)             
								r_color <= white;
						// END SECTION 7.1 (TOP OF SCREEN)
						
						// SECTION 7.2 (FOREHEAD)
						else if (i_vcounter >= 135 && i_vcounter < 180)
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
						else if (i_vcounter >= 180 && i_vcounter < 207)
							begin 
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 404)
									r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 584)
									r_color <= white; 
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end
            else if (i_vcounter >= 207 && i_vcounter < 213)
              begin 
                if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 371)
									r_color <= white;
                else if (i_hcounter >= 371 && i_hcounter < 377)
                  r_color <= black;
                else if (i_hcounter >= 377 && i_hcounter < 404)
                  r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 551)
									r_color <= white; 
                else if (i_hcounter >= 551 && i_hcounter < 557)
                  r_color <= black;
                else if (i_hcounter >= 557 && i_hcounter < 584)
                  r_color <= white;
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            else if (i_vcounter >= 213 && i_vcounter < 240)
              begin 
                if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 404)
									r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 584)
									r_color <= white; 
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
						// END SECTION 7.3 (EYES)
            
					// SECTION 7.4 (MIDDLE OF FACE)
						else if (i_vcounter >= 240 && i_vcounter < 300)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
						// END SECTION 7.4 (MIDDLE OF FACE)
						
						// SECTION 7.5 (MOUTH)
						else if (i_vcounter >= 300 && i_vcounter < 315)
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
						// END SECTION 7.5 (MOUTH)
						
						// SECTION 7.6 (TONUGE)
            else if (i_vcounter >= 315 && i_vcounter < 330)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end
            else if (i_vcounter >= 330 && i_vcounter < 350)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 449)
                  r_color <= pink;
                else if (i_hcounter >= 449 && i_hcounter < 451)
                  r_color <= black;
                else if (i_hcounter >= 451 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            else if (i_vcounter >= 350 && i_vcounter < 370)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            // END SECTION 7.6 (TONUGE)
						
						// SECTION 7.7 (CHIN)
						else if (i_vcounter >= 370 && i_vcounter < 414)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 7.7 (CHIN)
						
						// SECTION 7.8 (BOTTOM OF SCREEN)
						else if (i_vcounter <= 414)
							r_color <= white;
						// END SECTION 7.8 (BOTTOM OF SCREEN)
					end  // FRAME_7
          
          FRAME_8 : 
					begin 
						// SECTION 8.1 (TOP OF SCREEN)
						if (i_vcounter < 135)             
								r_color <= white;
						// END SECTION 8.1 (TOP OF SCREEN)
						
						// SECTION 8.2 (FOREHEAD)
						else if (i_vcounter >= 135 && i_vcounter < 180)
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
						else if (i_vcounter >= 180 && i_vcounter < 207)
							begin 
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 404)
									r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 584)
									r_color <= white; 
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end
            else if (i_vcounter >= 207 && i_vcounter < 213)
              begin 
                if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 361)
									r_color <= white;
                else if (i_hcounter >= 361 && i_hcounter < 367)
                  r_color <= black;
                else if (i_hcounter >= 367 && i_hcounter < 404)
                  r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 541)
									r_color <= white; 
                else if (i_hcounter >= 541 && i_hcounter < 547)
                  r_color <= black;
                else if (i_hcounter >= 547 && i_hcounter < 584)
                  r_color <= white;
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end 
            else if (i_vcounter >= 213 && i_vcounter < 240)
              begin 
                if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 344)
									r_color <= yellow;
								else if (i_hcounter >= 344 && i_hcounter < 404)
									r_color <= white;
								else if (i_hcounter >= 404 && i_hcounter < 524)
									r_color <= yellow;
								else if (i_hcounter >= 524 && i_hcounter < 584)
									r_color <= white; 
								else if (i_hcounter >= 584 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end  
						// END SECTION 8.3 (EYES) 
						
						// SECTION 8.4 (MIDDLE OF FACE)
						else if (i_vcounter >= 240 && i_vcounter < 300)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end 
						// END SECTION 8.4 (MIDDLE OF FACE)
						
						// SECTION 8.5 (MOUTH)
						else if (i_vcounter >= 300 && i_vcounter < 315)
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
						// END SECTION 8.5 (MOUTH)
						
						// SECTION 8.6 (TONUGE)
            else if (i_vcounter >= 315 && i_vcounter < 330)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end
            else if (i_vcounter >= 330 && i_vcounter < 350)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 449)
                  r_color <= pink;
                else if (i_hcounter >= 449 && i_hcounter < 451)
                  r_color <= black;
                else if (i_hcounter >= 451 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end
            else if (i_vcounter >= 350 && i_vcounter < 370)
              begin 
                if (i_hcounter < 324)
                  r_color <= white;
                else if (i_hcounter >= 324 && i_hcounter < 435)
                  r_color <= yellow;
                else if (i_hcounter >= 435 && i_hcounter < 465)
                  r_color <= pink;
                else if (i_hcounter >= 465 && i_hcounter < 604)
                  r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
              end
            // END SECTION 8.6 (TONUGE)
						
						// SECTION 8.7 (CHIN)
						else if (i_vcounter >= 370 && i_vcounter < 414)
							begin
								if (i_hcounter < 324)
									r_color <= white;
								else if (i_hcounter >= 324 && i_hcounter < 604)
									r_color <= yellow;
								else if (i_hcounter >= 604)
									r_color <= white;
							end  
						// END SECTION 8.7 (CHIN)
						
						// SECTION 8.8 (BOTTOM OF SCREEN)
						else if (i_vcounter <= 414)
							r_color <= white;
						// END SECTION 8.8 (BOTTOM OF SCREEN)
					end  // FRAME_8
					
          default :
          begin
						r_color <= white;
					end  // default 
			endcase
		end  // always
endmodule // crazy

