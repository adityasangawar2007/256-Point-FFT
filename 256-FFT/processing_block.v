// Code your design here
module processing_block(
                        input clk, reset, start_process, startin,
                        output [2:0] stg_counter_out,
                        output [4:0] in_cycles_out, cal_cycles_out,
                        input [55:0] input_0, input_1, input_2, input_3, input_4, input_5, input_6, input_7,
                        output [55:0] output0, output1, output2, output3, output4, output5, output6, output7
                        );

wire [27:0] real_0, real_1, real_2, real_3, real_4, real_5, real_6, real_7;
wire [27:0] imag_0, imag_1, imag_2, imag_3, imag_4, imag_5, imag_6, imag_7;
wire [27:0] bt2db_real0, bt2db_real1, bt2db_real2, bt2db_real3, bt2db_real4, bt2db_real5, bt2db_real6, bt2db_real7;
wire [27:0] bt2db_imag0, bt2db_imag1, bt2db_imag2, bt2db_imag3, bt2db_imag4, bt2db_imag5, bt2db_imag6, bt2db_imag7;
wire [55:0] db_out0, db_out1, db_out2, db_out3, db_out4, db_out5, db_out6, db_out7;

reg [7:0] rd_pt0, rd_pt1, rd_pt2, rd_pt3, rd_pt4, rd_pt5, rd_pt6, rd_pt7;
// reg [4:0] cycles;
reg [4:0] in_cycles, cal_cycles;
reg [2:0] stg_counter;
//reg [7:0] twiddle_real_pt1, twiddle_real_pt3, twiddle_real_pt5, twiddle_real_pt7;
//reg [7:0] twiddle_imag_pt1, twiddle_imag_pt3, twiddle_imag_pt5, twiddle_imag_pt7;
// reg [21:0] twiddle_mem [0:255]; // memory to hold al twiddles
//reg [21:0] tw_r1, twr3, tw_r5, tw_r7, tw_i1, tw_i3, tw_i5, tw_i7;
reg [21:0] TW_Real1, TW_Imag1, TW_Real3, TW_Imag3, TW_Real5, TW_Imag5, TW_Real7, TW_Imag7;

reg bank; // to select which bank to read and write from the databuffer

assign in_cycles_out = in_cycles;
assign cal_cycles_out = cal_cycles;
assign stg_counter_out = stg_counter;
assign real_0 = output0[55:28];
assign imag_0 = output0[27:0];
assign real_1 = output1[55:28];
assign imag_1 = output1[27:0];
assign real_2 = output2[55:28];
assign imag_2 = output2[27:0];
assign real_3 = output3[55:28];
assign imag_3 = output3[27:0];
assign real_4 = output4[55:28];
assign imag_4 = output4[27:0];
assign real_5 = output5[55:28];
assign imag_5 = output5[27:0];
assign real_6 = output6[55:28];
assign imag_6 = output6[27:0];
assign real_7 = output7[55:28];
assign imag_7 = output7[27:0];

// initial begin
//   $readmemh("twiddle.dat",twiddle_mem);
// end

databuffer DB (
                  .clk(clk), .reset(reset), .data_valid(start_process), .bank(bank),
						      .rd_pt0(rd_pt0), .rd_pt1(rd_pt1), .rd_pt2(rd_pt2), .rd_pt3(rd_pt3), .rd_pt4(rd_pt4), .rd_pt5(rd_pt5), .rd_pt6(rd_pt6), .rd_pt7(rd_pt7),
						      .in0({bt2db_real0,bt2db_imag0}), .in1({bt2db_real1,bt2db_imag1}), .in2({bt2db_real2,bt2db_imag2}), .in3({bt2db_real3,bt2db_imag3}),
                  .in4({bt2db_real4,bt2db_imag4}), .in5({bt2db_real5,bt2db_imag5}), .in6({bt2db_real6,bt2db_imag6}), .in7({bt2db_real7,bt2db_imag7}),
						      .out0(db_out0), .out1(db_out1), .out2(db_out2), .out3(db_out3), .out4(db_out4), .out5(db_out5), .out6(db_out6), .out7(db_out7)
              );


              // .WR_bt1(twiddle_mem[twiddle_real_pt1]), .WR_bt3(twiddle_mem[twiddle_real_pt3]), .WR_bt5(twiddle_mem[twiddle_real_pt5]), .WR_bt7(twiddle_mem[twiddle_real_pt7]),
              // .WI_bt1(twiddle_mem[twiddle_imag_pt5]), .WI_bt3(twiddle_mem[twiddle_imag_pt3]), .WI_bt5(twiddle_mem[twiddle_imag_pt5]), .WI_bt7(twiddle_mem[twiddle_imag_pt7]),
fourbutterfly FBT (
                    .clk(clk), .reset(reset),
                    .WR_bt1(TW_Real1), .WR_bt3(TW_Real3), .WR_bt5(TW_Real5), .WR_bt7(TW_Real7),
                    .WI_bt1(TW_Imag1), .WI_bt3(TW_Imag3), .WI_bt5(TW_Imag5), .WI_bt7(TW_Imag7),
                    .outputscrambler_Real_bt0(real_0),
                    .outputscrambler_Imgr_bt0(imag_0), .outputscrambler_Real_bt1(real_1), .outputscrambler_Imgr_bt1(imag_1), .outputscrambler_Real_bt2(real_2), .outputscrambler_Imgr_bt2(imag_2),
                    .outputscrambler_Real_bt3(real_3), .outputscrambler_Imgr_bt3(imag_3), .outputscrambler_Real_bt4(real_4), .outputscrambler_Imgr_bt4(imag_4), .outputscrambler_Real_bt5(real_5),
                    .outputscrambler_Imgr_bt5(imag_5), .outputscrambler_Real_bt6(real_6), .outputscrambler_Imgr_bt6(imag_6), .outputscrambler_Real_bt7(real_7), .outputscrambler_Imgr_bt7(imag_7),
                    .outputbutterfly_Real_bt0(bt2db_real0), .outputbutterfly_Imgr_bt0(bt2db_imag0), .outputbutterfly_Real_bt1(bt2db_real1), .outputbutterfly_Imgr_bt1(bt2db_imag1),
                    .outputbutterfly_Real_bt2(bt2db_real2), .outputbutterfly_Imgr_bt2(bt2db_imag2), .outputbutterfly_Real_bt3(bt2db_real3), .outputbutterfly_Imgr_bt3(bt2db_imag3),
                    .outputbutterfly_Real_bt4(bt2db_real4), .outputbutterfly_Imgr_bt4(bt2db_imag4), .outputbutterfly_Real_bt5(bt2db_real5), .outputbutterfly_Imgr_bt5(bt2db_imag5),
                    .outputbutterfly_Real_bt6(bt2db_real6), .outputbutterfly_Imgr_bt6(bt2db_imag6), .outputbutterfly_Real_bt7(bt2db_real7), .outputbutterfly_Imgr_bt7(bt2db_imag7)
                  );

input_mux INX   (
                  .stg_cnt(stg_counter),
                  .scr_in0(input_0), .scr_in1(input_1), .scr_in2(input_2), .scr_in3(input_3), .scr_in4(input_4), .scr_in5(input_5), .scr_in6(input_6), .scr_in7(input_7), //input from scrambler
                  .db_in0(db_out0), .db_in1(db_out1), .db_in2(db_out2), .db_in3(db_out3), .db_in4(db_out4), .db_in5(db_out5), .db_in6(db_out6), .db_in7(db_out7), // input from databuffer
                  .out_0(output0), .out_1(output1), .out_2(output2), .out_3(output3),
                  .out_4(output4), .out_5(output5), .out_6(output6), .out_7(output7)
                );

// Control signal block
always @ (posedge clk or posedge reset) begin
	if (reset) begin
	//cycles <= 0;
  in_cycles <= 0;
  cal_cycles <= 0;
  stg_counter <= 0;
	end
	else begin
		if (start_process) begin
			if (cal_cycles == 31) begin
			  stg_counter <= stg_counter + 1;
        in_cycles <= in_cycles + 1;
        cal_cycles <= cal_cycles + 1;
			// cycles = 0;
			end
      if (in_cycles >= 3) begin
        cal_cycles <= cal_cycles + 1;
      end
		// end
		// else begin
		// case (stg_counter)
		// endcase
		  if (in_cycles < 31) begin
        in_cycles <= in_cycles + 1;
      end
		end
	/*
	else begin No startin signal --> stall handling

	end */
	end
end

always @ (stg_counter) begin
  case (stg_counter % 2)
    0: bank <= 0;
    1: bank <= 1;
  endcase
end

// Read pointer block
// always @ (posedge clk or posedge reset) begin
//   if (reset) begin
//     rd_pt0 <= 0; rd_pt1 <= 0; rd_pt2 <= 0; rd_pt3 <= 0;
//     rd_pt4 <= 0; rd_pt5 <= 0; rd_pt6 <= 0; rd_pt7 <= 0;
//   end
//   else begin
always @ (in_cycles) begin
  // case (stg_counter % 2)
  //   0: bank <= 0;
  //   1: bank <= 1;
  // endcase
  case (stg_counter)
    0: begin
      rd_pt0 <= 0; rd_pt1 <= 0; rd_pt2 <= 0; rd_pt3 <= 0;
      rd_pt4 <= 0; rd_pt5 <= 0; rd_pt6 <= 0; rd_pt7 <= 0;
    end
    1: begin
      rd_pt0 <= in_cycles*8; rd_pt1 <= in_cycles*8+1; rd_pt2 <= in_cycles*8+2; rd_pt3 <= in_cycles*8+3;
      rd_pt4 <= in_cycles*8+4; rd_pt5 <= in_cycles*8+5; rd_pt6 <= in_cycles*8+6; rd_pt7 <= in_cycles*8+7;
    end
    2: begin
      rd_pt0 <= in_cycles*4; rd_pt1 <= in_cycles*4+4; rd_pt2 <= in_cycles*4+1; rd_pt3 <= in_cycles*4+5;
      rd_pt4 <= in_cycles*4+2; rd_pt5 <= in_cycles*4+6; rd_pt6 <= in_cycles*4+3; rd_pt7 <= in_cycles*4+7;
    end
    3: begin
      rd_pt0 <= in_cycles*4; rd_pt1 <= in_cycles*4+8; rd_pt2 <= in_cycles*4+1; rd_pt3 <= in_cycles*4+9;
      rd_pt4 <= in_cycles*4+2; rd_pt5 <= in_cycles*4+10; rd_pt6 <= in_cycles*4+3; rd_pt7 <= in_cycles*4+11;
    end
    4: begin
      rd_pt0 <= in_cycles*4; rd_pt1 <= in_cycles*4+16; rd_pt2 <= in_cycles*4+1; rd_pt3 <= in_cycles*4+17;
      rd_pt4 <= in_cycles*4+2; rd_pt5 <= in_cycles*4+18; rd_pt6 <= in_cycles*4+5; rd_pt7 <= in_cycles*4+19;
    end
    5: begin
      rd_pt0 <= in_cycles*4; rd_pt1 <= in_cycles*4+32; rd_pt2 <= in_cycles*4+1; rd_pt3 <= in_cycles*4+33;
      rd_pt4 <= in_cycles*4+2; rd_pt5 <= in_cycles*4+34; rd_pt6 <= in_cycles*4+3; rd_pt7 <= in_cycles*4+35;
    end
    6: begin
      rd_pt0 <= in_cycles*4; rd_pt1 <= in_cycles*4+64; rd_pt2 <= in_cycles*4+1; rd_pt3 <= in_cycles*4+65;
      rd_pt4 <= in_cycles*4+2; rd_pt5 <= in_cycles*4+66; rd_pt6 <= in_cycles*4+3; rd_pt7 <= in_cycles*4+67;
    end
    7: begin
      rd_pt0 <= in_cycles*4; rd_pt1 <= in_cycles*4+128; rd_pt2 <= in_cycles*4+1; rd_pt3 <= in_cycles*4+129;
      rd_pt4 <= in_cycles*4+2; rd_pt5 <= in_cycles*4+130; rd_pt6 <= in_cycles*4+3; rd_pt7 <= in_cycles*4+131;
    end
    default: begin
      rd_pt0 <= 0; rd_pt1 <= 0; rd_pt2 <= 0; rd_pt3 <= 0;
      rd_pt4 <= 0; rd_pt5 <= 0; rd_pt6 <= 0; rd_pt7 <= 0;
    end
  endcase
  // end
end

// always @ (*) begin
//   case (stg_counter)
//     0: begin
//       twiddle_real_pt1 = 0; twiddle_real_pt3 = 0; twiddle_real_pt5 = 0; twiddle_real_pt7 = 0;
//       twiddle_imag_pt1 = 1; twiddle_imag_pt3 = 1; twiddle_imag_pt5 = 1; twiddle_imag_pt7 = 1;
//     end
//     1: begin
//       twiddle_real_pt1 = 0; twiddle_real_pt3 = 128; twiddle_real_pt5 = 0; twiddle_real_pt7 = 128;
//       twiddle_imag_pt1 = 1; twiddle_imag_pt3 = 129; twiddle_imag_pt5 = 1; twiddle_imag_pt7 = 129;
//     end
//     2: begin
//       twiddle_real_pt1 = 0; twiddle_real_pt3 = 64; twiddle_real_pt5 = 128; twiddle_real_pt7 = 192;
//       twiddle_imag_pt1 = 1; twiddle_imag_pt3 = 65; twiddle_imag_pt5 = 129; twiddle_imag_pt7 = 193;
//     end
//     3: begin
//       case (in_cycles)
//         0: begin
//           twiddle_real_pt1 = 0; twiddle_real_pt3 = 32; twiddle_real_pt5 = 64; twiddle_real_pt7 = 96;
//           twiddle_imag_pt1 = 1; twiddle_imag_pt3 = 33; twiddle_imag_pt5 = 65; twiddle_imag_pt7 = 97;
//         end
//         1: begin
//           twiddle_real_pt1 = 128; twiddle_real_pt3 = 160; twiddle_real_pt5 = 192; twiddle_real_pt7 = 224;
//           twiddle_imag_pt1 = 129; twiddle_imag_pt3 = 161; twiddle_imag_pt5 = 193; twiddle_imag_pt7 = 225;
//         end
//         2: begin
//           twiddle_real_pt1 = 0; twiddle_real_pt3 = 32; twiddle_real_pt5 = 64; twiddle_real_pt7 = 96;
//           twiddle_imag_pt1 = 1; twiddle_imag_pt3 = 33; twiddle_imag_pt5 = 65; twiddle_imag_pt7 = 97;
//         end
// 	      3: begin
//           twiddle_real_pt1 = 128; twiddle_real_pt3 = 160; twiddle_real_pt5 = 192; twiddle_real_pt7 = 224;
//           twiddle_imag_pt1 = 129; twiddle_imag_pt3 = 161; twiddle_imag_pt5 = 193; twiddle_imag_pt7 = 225;
//         end
// 	      4: begin
//           twiddle_real_pt1 = 0; twiddle_real_pt3 = 32; twiddle_real_pt5 = 64; twiddle_real_pt7 = 96;
//           twiddle_imag_pt1 = 1; twiddle_imag_pt3 = 33; twiddle_imag_pt5 = 65; twiddle_imag_pt7 = 97;
//         end
// 	      5: begin
//           twiddle_real_pt1 = 128; twiddle_real_pt3 = 160; twiddle_real_pt5 = 192; twiddle_real_pt7 = 224;
//           twiddle_imag_pt1 = 129; twiddle_imag_pt3 = 161; twiddle_imag_pt5 = 193; twiddle_imag_pt7 = 225;
//         end
// 	      6: begin
//           twiddle_real_pt1 = 0; twiddle_real_pt3 = 32; twiddle_real_pt5 = 64; twiddle_real_pt7 = 96;
//           twiddle_imag_pt1 = 1; twiddle_imag_pt3 = 33; twiddle_imag_pt5 = 65; twiddle_imag_pt7 = 97;
// 		    end
// 	      7: begin
//           twiddle_real_pt1 = 128; twiddle_real_pt3 = 160; twiddle_real_pt5 = 192; twiddle_real_pt7 = 224;
//           twiddle_imag_pt1 = 129; twiddle_imag_pt3 = 161; twiddle_imag_pt5 = 193; twiddle_imag_pt7 = 225;
//         end
//         8: begin
//           twiddle_real_pt1 = 0; twiddle_real_pt3 = 32; twiddle_real_pt5 = 64; twiddle_real_pt7 = 96;
//           twiddle_imag_pt1 = 1; twiddle_imag_pt3 = 33; twiddle_imag_pt5 = 65; twiddle_imag_pt7 = 97;
// 		    end
// 	      9: begin
//           twiddle_real_pt1 = 128; twiddle_real_pt3 = 160; twiddle_real_pt5 = 192; twiddle_real_pt7 = 224;
//           twiddle_imag_pt1 = 129; twiddle_imag_pt3 = 161; twiddle_imag_pt5 = 193; twiddle_imag_pt7 = 225;
//         end
//         10: begin
//           twiddle_real_pt1 = 0; twiddle_real_pt3 = 32; twiddle_real_pt5 = 64; twiddle_real_pt7 = 96;
//           twiddle_imag_pt1 = 1; twiddle_imag_pt3 = 33; twiddle_imag_pt5 = 65; twiddle_imag_pt7 = 97;
// 	      end
// 	      11: begin
//           twiddle_real_pt1 = 128; twiddle_real_pt3 = 160; twiddle_real_pt5 = 192; twiddle_real_pt7 = 224;
//           twiddle_imag_pt1 = 129; twiddle_imag_pt3 = 161; twiddle_imag_pt5 = 193; twiddle_imag_pt7 = 225;
//         end
//         12: begin
//           twiddle_real_pt1 = 0; twiddle_real_pt3 = 32; twiddle_real_pt5 = 64; twiddle_real_pt7 = 96;
//           twiddle_imag_pt1 = 1; twiddle_imag_pt3 = 33; twiddle_imag_pt5 = 65; twiddle_imag_pt7 = 97;
// 	      end
// 	      13: begin
//           twiddle_real_pt1 = 128; twiddle_real_pt3 = 160; twiddle_real_pt5 = 192; twiddle_real_pt7 = 224;
//           twiddle_imag_pt1 = 129; twiddle_imag_pt3 = 161; twiddle_imag_pt5 = 193; twiddle_imag_pt7 = 225;
//         end
//         14: begin
//           twiddle_real_pt1 = 0; twiddle_real_pt3 = 32; twiddle_real_pt5 = 64; twiddle_real_pt7 = 96;
//           twiddle_imag_pt1 = 1; twiddle_imag_pt3 = 33; twiddle_imag_pt5 = 65; twiddle_imag_pt7 = 97;
// 	      end
// 	      15: begin
//           twiddle_real_pt1 = 128; twiddle_real_pt3 = 160; twiddle_real_pt5 = 192; twiddle_real_pt7 = 224;
//           twiddle_imag_pt1 = 129; twiddle_imag_pt3 = 161; twiddle_imag_pt5 = 193; twiddle_imag_pt7 = 225;
//         end
// 	      16: begin
//           twiddle_real_pt1 = 0; twiddle_real_pt3 = 32; twiddle_real_pt5 = 64; twiddle_real_pt7 = 96;
//           twiddle_imag_pt1 = 1; twiddle_imag_pt3 = 33; twiddle_imag_pt5 = 65; twiddle_imag_pt7 = 97;
// 	      end
//         17: begin
//           twiddle_real_pt1 = 128; twiddle_real_pt3 = 160; twiddle_real_pt5 = 192; twiddle_real_pt7 = 224;
//           twiddle_imag_pt1 = 129; twiddle_imag_pt3 = 161; twiddle_imag_pt5 = 193; twiddle_imag_pt7 = 225;
//         end
//         18: begin
//           twiddle_real_pt1 = 0; twiddle_real_pt3 = 32; twiddle_real_pt5 = 64; twiddle_real_pt7 = 96;
//           twiddle_imag_pt1 = 1; twiddle_imag_pt3 = 33; twiddle_imag_pt5 = 65; twiddle_imag_pt7 = 97;
// 	      end
// 	      19: begin
//           twiddle_real_pt1 = 128; twiddle_real_pt3 = 160; twiddle_real_pt5 = 192; twiddle_real_pt7 = 224;
//           twiddle_imag_pt1 = 129; twiddle_imag_pt3 = 161; twiddle_imag_pt5 = 193; twiddle_imag_pt7 = 225;
//         end
//         20: begin
//           twiddle_real_pt1 = 0; twiddle_real_pt3 = 32; twiddle_real_pt5 = 64; twiddle_real_pt7 = 96;
//           twiddle_imag_pt1 = 1; twiddle_imag_pt3 = 33; twiddle_imag_pt5 = 65; twiddle_imag_pt7 = 97;
// 	      end
// 	      21: begin
//           twiddle_real_pt1 = 128; twiddle_real_pt3 = 160; twiddle_real_pt5 = 192; twiddle_real_pt7 = 224;
//           twiddle_imag_pt1 = 129; twiddle_imag_pt3 = 161; twiddle_imag_pt5 = 193; twiddle_imag_pt7 = 225;
//         end
//         22: begin
//           twiddle_real_pt1 = 0; twiddle_real_pt3 = 32; twiddle_real_pt5 = 64; twiddle_real_pt7 = 96;
//           twiddle_imag_pt1 = 1; twiddle_imag_pt3 = 33; twiddle_imag_pt5 = 65; twiddle_imag_pt7 = 97;
// 	      end
// 	      23: begin
//           twiddle_real_pt1 = 128; twiddle_real_pt3 = 160; twiddle_real_pt5 = 192; twiddle_real_pt7 = 224;
//           twiddle_imag_pt1 = 129; twiddle_imag_pt3 = 161; twiddle_imag_pt5 = 193; twiddle_imag_pt7 = 225;
//         end
//         24: begin
//           twiddle_real_pt1 = 0; twiddle_real_pt3 = 32; twiddle_real_pt5 = 64; twiddle_real_pt7 = 96;
//           twiddle_imag_pt1 = 1; twiddle_imag_pt3 = 33; twiddle_imag_pt5 = 65; twiddle_imag_pt7 = 97;
// 	      end
//         25: begin
//           twiddle_real_pt1 = 128; twiddle_real_pt3 = 160; twiddle_real_pt5 = 192; twiddle_real_pt7 = 224;
//           twiddle_imag_pt1 = 129; twiddle_imag_pt3 = 161; twiddle_imag_pt5 = 193; twiddle_imag_pt7 = 225;
//         end
//         26: begin
//           twiddle_real_pt1 = 0; twiddle_real_pt3 = 32; twiddle_real_pt5 = 64; twiddle_real_pt7 = 96;
//           twiddle_imag_pt1 = 1; twiddle_imag_pt3 = 33; twiddle_imag_pt5 = 65; twiddle_imag_pt7 = 97;
// 	      end
// 	      27: begin
//           twiddle_real_pt1 = 128; twiddle_real_pt3 = 160; twiddle_real_pt5 = 192; twiddle_real_pt7 = 224;
//           twiddle_imag_pt1 = 129; twiddle_imag_pt3 = 161; twiddle_imag_pt5 = 193; twiddle_imag_pt7 = 225;
//         end
//         28: begin
//           twiddle_real_pt1 = 0; twiddle_real_pt3 = 32; twiddle_real_pt5 = 64; twiddle_real_pt7 = 96;
//           twiddle_imag_pt1 = 1; twiddle_imag_pt3 = 33; twiddle_imag_pt5 = 65; twiddle_imag_pt7 = 97;
// 	      end
// 	      29: begin
//           twiddle_real_pt1 = 128; twiddle_real_pt3 = 160; twiddle_real_pt5 = 192; twiddle_real_pt7 = 224;
//           twiddle_imag_pt1 = 129; twiddle_imag_pt3 = 161; twiddle_imag_pt5 = 193; twiddle_imag_pt7 = 225;
//         end
//         30: begin
//           twiddle_real_pt1 = 0; twiddle_real_pt3 = 32; twiddle_real_pt5 = 64; twiddle_real_pt7 = 96;
//           twiddle_imag_pt1 = 1; twiddle_imag_pt3 = 33; twiddle_imag_pt5 = 65; twiddle_imag_pt7 = 97;
// 	      end
// 	      31: begin
//           twiddle_real_pt1 = 128; twiddle_real_pt3 = 160; twiddle_real_pt5 = 192; twiddle_real_pt7 = 224;
//           twiddle_imag_pt1 = 129; twiddle_imag_pt3 = 161; twiddle_imag_pt5 = 193; twiddle_imag_pt7 = 225;
//         end
//       endcase
//     end
//     4: begin
//       case (in_cycles % 4)
//         0: begin
//           twiddle_real_pt1 = 0; twiddle_real_pt3 = 16; twiddle_real_pt5 = 32; twiddle_real_pt7 = 48;
//           twiddle_imag_pt1 = 1; twiddle_imag_pt3 = 17; twiddle_imag_pt5 = 33; twiddle_imag_pt7 = 49;
//         end
//         1: begin
//           twiddle_real_pt1 = 64; twiddle_real_pt3 = 80; twiddle_real_pt5 = 96; twiddle_real_pt7 = 112;
//           twiddle_imag_pt1 = 65; twiddle_imag_pt3 = 81; twiddle_imag_pt5 = 97; twiddle_imag_pt7 = 113;
//         end
//         2: begin
//           twiddle_real_pt1 = 128; twiddle_real_pt3 = 144; twiddle_real_pt5 = 160; twiddle_real_pt7 = 176;
//           twiddle_imag_pt1 = 129; twiddle_imag_pt3 = 145; twiddle_imag_pt5 = 161; twiddle_imag_pt7 = 177;
//         end
//         3: begin
//           twiddle_real_pt1 = 192; twiddle_real_pt3 = 208; twiddle_real_pt5 = 224; twiddle_real_pt7 = 240;
//           twiddle_imag_pt1 = 193; twiddle_imag_pt3 = 209; twiddle_imag_pt5 = 225; twiddle_imag_pt7 = 241;
//         end
//       endcase
//     end
//     5: begin
//       case (in_cycles % 8)
//         0: begin
//           twiddle_real_pt1 = 0; twiddle_real_pt3 = 8; twiddle_real_pt5 = 16; twiddle_real_pt7 = 24;
//           twiddle_imag_pt1 = 1; twiddle_imag_pt3 = 9; twiddle_imag_pt5 = 17; twiddle_imag_pt7 = 25;
//         end
//         1: begin
//           twiddle_real_pt1 = 32; twiddle_real_pt3 = 40; twiddle_real_pt5 = 48; twiddle_real_pt7 = 56;
//           twiddle_imag_pt1 = 33; twiddle_imag_pt3 = 41; twiddle_imag_pt5 = 49; twiddle_imag_pt7 = 57;
//         end
//         2: begin
//           twiddle_real_pt1 = 64; twiddle_real_pt3 = 72; twiddle_real_pt5 = 80; twiddle_real_pt7 = 88;
//           twiddle_imag_pt1 = 65; twiddle_imag_pt3 = 73; twiddle_imag_pt5 = 81; twiddle_imag_pt7 = 89;
//         end
//         3: begin
//           twiddle_real_pt1 = 96; twiddle_real_pt3 = 104; twiddle_real_pt5 = 112; twiddle_real_pt7 = 120;
//           twiddle_imag_pt1 = 97; twiddle_imag_pt3 = 105; twiddle_imag_pt5 = 113; twiddle_imag_pt7 = 121;
//         end
//         4: begin
//           twiddle_real_pt1 = 128; twiddle_real_pt3 = 136; twiddle_real_pt5 = 144; twiddle_real_pt7 = 152;
//           twiddle_imag_pt1 = 129; twiddle_imag_pt3 = 137; twiddle_imag_pt5 = 145; twiddle_imag_pt7 = 153;
//         end
//         5: begin
//           twiddle_real_pt1 = 160; twiddle_real_pt3 = 168; twiddle_real_pt5 = 176; twiddle_real_pt7 = 184;
//           twiddle_imag_pt1 = 161; twiddle_imag_pt3 = 169; twiddle_imag_pt5 = 177; twiddle_imag_pt7 = 185;
//         end
//         6: begin
//           twiddle_real_pt1 = 192; twiddle_real_pt3 = 200; twiddle_real_pt5 = 208; twiddle_real_pt7 = 216;
//           twiddle_imag_pt1 = 193; twiddle_imag_pt3 = 201; twiddle_imag_pt5 = 209; twiddle_imag_pt7 = 217;
//         end
//         7: begin
//           twiddle_real_pt1 = 224; twiddle_real_pt3 = 232; twiddle_real_pt5 = 240; twiddle_real_pt7 = 248;
//           twiddle_imag_pt1 = 225; twiddle_imag_pt3 = 233; twiddle_imag_pt5 = 241; twiddle_imag_pt7 = 249;
//         end
//       endcase
//     end
//     6: begin
//       case (in_cycles % 16)
//         0: begin
//           twiddle_real_pt1 = 0; twiddle_real_pt3 = 4; twiddle_real_pt5 = 8; twiddle_real_pt7 = 12;
//           twiddle_imag_pt1 = 1; twiddle_imag_pt3 = 5; twiddle_imag_pt5 = 9; twiddle_imag_pt7 = 13;
//         end
//         1: begin
//           twiddle_real_pt1 = 16; twiddle_real_pt3 = 20; twiddle_real_pt5 = 24; twiddle_real_pt7 = 28;
//           twiddle_imag_pt1 = 17; twiddle_imag_pt3 = 21; twiddle_imag_pt5 = 25; twiddle_imag_pt7 = 29;
//         end
//         2: begin
//           twiddle_real_pt1 = 32; twiddle_real_pt3 = 36; twiddle_real_pt5 = 40; twiddle_real_pt7 = 44;
//           twiddle_imag_pt1 = 33; twiddle_imag_pt3 = 37; twiddle_imag_pt5 = 41; twiddle_imag_pt7 = 45;
//         end
//         3: begin
//           twiddle_real_pt1 = 48; twiddle_real_pt3 = 52; twiddle_real_pt5 = 56; twiddle_real_pt7 = 60;
//           twiddle_imag_pt1 = 49; twiddle_imag_pt3 = 53; twiddle_imag_pt5 = 57; twiddle_imag_pt7 = 61;
//         end
//         4: begin
//           twiddle_real_pt1 = 64; twiddle_real_pt3 = 68; twiddle_real_pt5 = 72; twiddle_real_pt7 = 76;
//           twiddle_imag_pt1 = 65; twiddle_imag_pt3 = 69; twiddle_imag_pt5 = 73; twiddle_imag_pt7 = 77;
//         end
//         5: begin
//           twiddle_real_pt1 = 80; twiddle_real_pt3 = 84; twiddle_real_pt5 = 88; twiddle_real_pt7 = 92;
//           twiddle_imag_pt1 = 81; twiddle_imag_pt3 = 85; twiddle_imag_pt5 = 89; twiddle_imag_pt7 = 93;
//         end
//         6: begin
//           twiddle_real_pt1 = 96; twiddle_real_pt3 = 100; twiddle_real_pt5 = 104; twiddle_real_pt7 = 108;
//           twiddle_imag_pt1 = 97; twiddle_imag_pt3 = 101; twiddle_imag_pt5 = 105; twiddle_imag_pt7 = 109;
//         end
//         7: begin
//           twiddle_real_pt1 = 112; twiddle_real_pt3 = 116; twiddle_real_pt5 = 120; twiddle_real_pt7 = 124;
//           twiddle_imag_pt1 = 113; twiddle_imag_pt3 = 117; twiddle_imag_pt5 = 121; twiddle_imag_pt7 = 125;
//         end
//         8: begin
//           twiddle_real_pt1 = 128; twiddle_real_pt3 = 132; twiddle_real_pt5 = 136; twiddle_real_pt7 = 140;
//           twiddle_imag_pt1 = 129; twiddle_imag_pt3 = 133; twiddle_imag_pt5 = 137; twiddle_imag_pt7 = 141;
//         end
//         9: begin
//           twiddle_real_pt1 = 144; twiddle_real_pt3 = 148; twiddle_real_pt5 = 152; twiddle_real_pt7 = 156;
//           twiddle_imag_pt1 = 145; twiddle_imag_pt3 = 149; twiddle_imag_pt5 = 153; twiddle_imag_pt7 = 157;
//         end
//         10: begin
//           twiddle_real_pt1 = 160; twiddle_real_pt3 = 164; twiddle_real_pt5 = 168; twiddle_real_pt7 = 172;
//           twiddle_imag_pt1 = 161; twiddle_imag_pt3 = 165; twiddle_imag_pt5 = 169; twiddle_imag_pt7 = 173;
//         end
//         11: begin
//           twiddle_real_pt1 = 176; twiddle_real_pt3 = 180; twiddle_real_pt5 = 184; twiddle_real_pt7 = 188;
//           twiddle_imag_pt1 = 177; twiddle_imag_pt3 = 181; twiddle_imag_pt5 = 185; twiddle_imag_pt7 = 189;
//         end
//         12: begin
//           twiddle_real_pt1 = 192; twiddle_real_pt3 = 196; twiddle_real_pt5 = 200; twiddle_real_pt7 = 204;
//           twiddle_imag_pt1 = 193; twiddle_imag_pt3 = 197; twiddle_imag_pt5 = 201; twiddle_imag_pt7 = 205;
//         end
//         13: begin
//           twiddle_real_pt1 = 208; twiddle_real_pt3 = 212; twiddle_real_pt5 = 216; twiddle_real_pt7 = 220;
//           twiddle_imag_pt1 = 209; twiddle_imag_pt3 = 213; twiddle_imag_pt5 = 217; twiddle_imag_pt7 = 221;
//         end
//         14: begin
//           twiddle_real_pt1 = 224; twiddle_real_pt3 = 228; twiddle_real_pt5 = 232; twiddle_real_pt7 = 236;
//           twiddle_imag_pt1 = 225; twiddle_imag_pt3 = 229; twiddle_imag_pt5 = 233; twiddle_imag_pt7 = 237;
//         end
//         15: begin
//           twiddle_real_pt1 = 240; twiddle_real_pt3 = 244; twiddle_real_pt5 = 248; twiddle_real_pt7 = 252;
//           twiddle_imag_pt1 = 241; twiddle_imag_pt3 = 245; twiddle_imag_pt5 = 249; twiddle_imag_pt7 = 253;
//         end
//       endcase
//     end
//     7: begin
//       twiddle_real_pt1 = in_cycles * 8; twiddle_real_pt3 = in_cycles * 8 + 2; twiddle_real_pt5 = in_cycles * 8 + 4; twiddle_real_pt7 = in_cycles * 8 + 6;
//       twiddle_imag_pt1 = in_cycles * 8 + 1; twiddle_imag_pt3 = in_cycles * 8 + 3; twiddle_imag_pt5 = in_cycles * 8 + 5; twiddle_imag_pt7 = in_cycles * 8 + 7;
//     end
//     default: begin
//       twiddle_real_pt1 = 0; twiddle_real_pt3 = 0; twiddle_real_pt5 = 0; twiddle_real_pt7 = 0;
//       twiddle_imag_pt1 = 0; twiddle_imag_pt3 = 0; twiddle_imag_pt5 = 0; twiddle_imag_pt7 = 0;
//     end
//   endcase
// end

always @ (*) begin
  case (stg_counter)
    0: begin
      TW_Real1 = 0; TW_Real3 = 0; TW_Real5 = 0; TW_Real7 = 0;
      TW_Imag1 = 1048576; TW_Imag3 = 1048576; TW_Imag5 = 1048576; TW_Imag7 = 1048576;
    end
    1: begin
      TW_Real1 = 1048576; TW_Real3 = 0; TW_Real5 = 1048576; TW_Real7 = 0;
      TW_Imag1 = 0; TW_Imag3 = -1048576; TW_Imag5 = 0; TW_Imag7 = -1048576;
    end
    2: begin
      TW_Real1 = 0; TW_Real3 = 741455; TW_Real5 = 0; TW_Real7 = -741455;
      TW_Imag1 = 1048576; TW_Imag3 = -741455; TW_Imag5 = -1048576; TW_Imag7 = -741455;
    end
    3: begin
      case (in_cycles)
        0: begin
          TW_Real1 = 1048576; TW_Real3 = 968757; TW_Real5 = 741455; TW_Real7 = 401272;
          TW_Imag1 = 0; TW_Imag3 = -401272; TW_Imag5 = -741455; TW_Imag7 = -968757;
        end
        1: begin
          TW_Real1 = 1048576; TW_Real3 = -401272; TW_Real5 = -741455; TW_Real7 = -968757;
          TW_Imag1 = 0; TW_Imag3 = -968757; TW_Imag5 = -741455; TW_Imag7 = -401272;
        end
        2: begin
          TW_Real1 = 1048576; TW_Real3 = 968757; TW_Real5 = 741455; TW_Real7 = 401272;
          TW_Imag1 = 0; TW_Imag3 = -401272; TW_Imag5 = -741455; TW_Imag7 = -968757;
        end
	      3: begin
          TW_Real1 = 0; TW_Real3 = -401272; TW_Real5 = -741455; TW_Real7 = -968757;
          TW_Imag1 = -1048576; TW_Imag3 = -968757; TW_Imag5 = -741455; TW_Imag7 = -401272;
        end
	      4: begin
          TW_Real1 = 1048576; TW_Real3 = 968757; TW_Real5 = 741455; TW_Real7 = 401272;
          TW_Imag1 = 0; TW_Imag3 = -401272; TW_Imag5 = -741455; TW_Imag7 = -968757;
        end
	      5: begin
          TW_Real1 = 0; TW_Real3 = -401272; TW_Real5 = -741455; TW_Real7 = -968757;
          TW_Imag1 = -1048576; TW_Imag3 = -968757; TW_Imag5 = -741455; TW_Imag7 = -401272;
        end
	      6: begin
          TW_Real1 = 1048576; TW_Real3 = 968757; TW_Real5 = 741455; TW_Real7 = 401272;
          TW_Imag1 = 0; TW_Imag3 = -401272; TW_Imag5 = -741455; TW_Imag7 = -968757;
		    end
	      7: begin
          TW_Real1 = 0; TW_Real3 = -401272; TW_Real5 = -741455; TW_Real7 = -968757;
          TW_Imag1 = -1048576; TW_Imag3 = -968757; TW_Imag5 = -741455; TW_Imag7 = -401272;
        end
        8: begin
          TW_Real1 = 1048576; TW_Real3 = 968757; TW_Real5 = 741455; TW_Real7 = 401272;
          TW_Imag1 = 0; TW_Imag3 = -401272; TW_Imag5 = -741455; TW_Imag7 = -968757;
		    end
	      9: begin
          TW_Real1 = 0; TW_Real3 = -401272; TW_Real5 = -741455; TW_Real7 = -968757;
          TW_Imag1 = -1048576; TW_Imag3 = -968757; TW_Imag5 = -741455; TW_Imag7 = -401272;
        end
        10: begin
          TW_Real1 = 1048576; TW_Real3 = 968757; TW_Real5 = 741455; TW_Real7 = 401272;
          TW_Imag1 = 0; TW_Imag3 = -401272; TW_Imag5 = -741455; TW_Imag7 = -968757;
	      end
	      11: begin
          TW_Real1 = 0; TW_Real3 = -401272; TW_Real5 = -741455; TW_Real7 = -968757;
          TW_Imag1 = -1048576; TW_Imag3 = -968757; TW_Imag5 = -741455; TW_Imag7 = -401272;
        end
        12: begin
          TW_Real1 = 1048576; TW_Real3 = 968757; TW_Real5 = 741455; TW_Real7 = 401272;
          TW_Imag1 = 0; TW_Imag3 = -401272; TW_Imag5 = -741455; TW_Imag7 = -968757;
	      end
	      13: begin
          TW_Real1 = 0; TW_Real3 = -401272; TW_Real5 = -741455; TW_Real7 = -968757;
          TW_Imag1 = -1048576; TW_Imag3 = -968757; TW_Imag5 = -741455; TW_Imag7 = -401272;
        end
        14: begin
          TW_Real1 = 1048576; TW_Real3 = 968757; TW_Real5 = 741455; TW_Real7 = 401272;
          TW_Imag1 = 0; TW_Imag3 = -401272; TW_Imag5 = -741455; TW_Imag7 = -968757;
	      end
	      15: begin
          TW_Real1 = 0; TW_Real3 = -401272; TW_Real5 = -741455; TW_Real7 = -968757;
          TW_Imag1 = -1048576; TW_Imag3 = -968757; TW_Imag5 = -741455; TW_Imag7 = -401272;
        end
	      16: begin
          TW_Real1 = 1048576; TW_Real3 = 968757; TW_Real5 = 741455; TW_Real7 = 401272;
          TW_Imag1 = 0; TW_Imag3 = -401272; TW_Imag5 = -741455; TW_Imag7 = -968757;
	      end
        17: begin
          TW_Real1 = 0; TW_Real3 = -401272; TW_Real5 = -741455; TW_Real7 = -968757;
          TW_Imag1 = -1048576; TW_Imag3 = -968757; TW_Imag5 = -741455; TW_Imag7 = -401272;
        end
        18: begin
          TW_Real1 = 1048576; TW_Real3 = 968757; TW_Real5 = 741455; TW_Real7 = 401272;
          TW_Imag1 = 0; TW_Imag3 = -401272; TW_Imag5 = -741455; TW_Imag7 = -968757;
	      end
	      19: begin
          TW_Real1 = 0; TW_Real3 = -401272; TW_Real5 = -741455; TW_Real7 = -968757;
          TW_Imag1 = -1048576; TW_Imag3 = -968757; TW_Imag5 = -741455; TW_Imag7 = -401272;
        end
        20: begin
          TW_Real1 = 1048576; TW_Real3 = 968757; TW_Real5 = 741455; TW_Real7 = 401272;
          TW_Imag1 = 0; TW_Imag3 = -401272; TW_Imag5 = -741455; TW_Imag7 = -968757;
	      end
	      21: begin
          TW_Real1 = 0; TW_Real3 = -401272; TW_Real5 = -741455; TW_Real7 = -968757;
          TW_Imag1 = -1048576; TW_Imag3 = -968757; TW_Imag5 = -741455; TW_Imag7 = -401272;
        end
        22: begin
          TW_Real1 = 1048576; TW_Real3 = 968757; TW_Real5 = 741455; TW_Real7 = 401272;
          TW_Imag1 = 0; TW_Imag3 = -401272; TW_Imag5 = -741455; TW_Imag7 = -968757;
	      end
	      23: begin
          TW_Real1 = 0; TW_Real3 = -401272; TW_Real5 = -741455; TW_Real7 = -968757;
          TW_Imag1 = -1048576; TW_Imag3 = -968757; TW_Imag5 = -741455; TW_Imag7 = -401272;
        end
        24: begin
          TW_Real1 = 1048576; TW_Real3 = 968757; TW_Real5 = 741455; TW_Real7 = 401272;
          TW_Imag1 = 0; TW_Imag3 = -401272; TW_Imag5 = -741455; TW_Imag7 = -968757;
	      end
        25: begin
          TW_Real1 = 0; TW_Real3 = -401272; TW_Real5 = -741455; TW_Real7 = -968757;
          TW_Imag1 = -1048576; TW_Imag3 = -968757; TW_Imag5 = -741455; TW_Imag7 = -401272;
        end
        26: begin
          TW_Real1 = 1048576; TW_Real3 = 968757; TW_Real5 = 741455; TW_Real7 = 401272;
          TW_Imag1 = 0; TW_Imag3 = -401272; TW_Imag5 = -741455; TW_Imag7 = -968757;
	      end
	      27: begin
          TW_Real1 = 0; TW_Real3 = -401272; TW_Real5 = -741455; TW_Real7 = -968757;
          TW_Imag1 = -1048576; TW_Imag3 = -968757; TW_Imag5 = -741455; TW_Imag7 = -401272;
        end
        28: begin
          TW_Real1 = 1048576; TW_Real3 = 968757; TW_Real5 = 741455; TW_Real7 = 401272;
          TW_Imag1 = 0; TW_Imag3 = -401272; TW_Imag5 = -741455; TW_Imag7 = -968757;
	      end
	      29: begin
          TW_Real1 = 0; TW_Real3 = -401272; TW_Real5 = -741455; TW_Real7 = -968757;
          TW_Imag1 = -1048576; TW_Imag3 = -968757; TW_Imag5 = -741455; TW_Imag7 = -401272;
        end
        30: begin
          TW_Real1 = 1048576; TW_Real3 = 968757; TW_Real5 = 741455; TW_Real7 = 401272;
          TW_Imag1 = 0; TW_Imag3 = -401272; TW_Imag5 = -741455; TW_Imag7 = -968757;
	      end
	      31: begin
          TW_Real1 = 0; TW_Real3 = -401272; TW_Real5 = -741455; TW_Real7 = -968757;
          TW_Imag1 = -1048576; TW_Imag3 = -968757; TW_Imag5 = -741455; TW_Imag7 = -401272;
        end
      endcase
    end
    4: begin
      case (in_cycles % 4)
        0: begin
          TW_Real1 = 1048576; TW_Real3 = 1028427; TW_Real5 = 968757; TW_Real7 = 871859;
          TW_Imag1 = 0; TW_Imag3 = -204567; TW_Imag5 = -401272; TW_Imag7 = -582557;
        end
        1: begin
          TW_Real1 = 741455; TW_Real3 = 582557; TW_Real5 = 401272; TW_Real7 = 204567;
          TW_Imag1 = -741455; TW_Imag3 = -871859; TW_Imag5 = -968757; TW_Imag7 = -1028427;
        end
        2: begin
          TW_Real1 = 1048576; TW_Real3 = -204567; TW_Real5 = -401272; TW_Real7 = -582557;
          TW_Imag1 = 0; TW_Imag3 = -1028427; TW_Imag5 = -968757; TW_Imag7 = -871859;
        end
        3: begin
          TW_Real1 = -741455; TW_Real3 = -871859; TW_Real5 = -968757; TW_Real7 = -1028427;
          TW_Imag1 = -741455; TW_Imag3 = -582557; TW_Imag5 = -401272; TW_Imag7 = -204567;
        end
      endcase
    end
    5: begin
      case (in_cycles % 8)
        0: begin
          TW_Real1 = 1048576; TW_Real3 = 1043526; TW_Real5 = 1028427; TW_Real7 = 1003424;
          TW_Imag1 = 0; TW_Imag3 = -102778; TW_Imag5 = -204567; TW_Imag7 = -304385;
        end
        1: begin
          TW_Real1 = 968757; TW_Real3 = 924761; TW_Real5 = 871859; TW_Real7 = 810560;
          TW_Imag1 = -401272; TW_Imag3 = -494295; TW_Imag5 = -582557; TW_Imag7 = -665209;
        end
        2: begin
          TW_Real1 = 741455; TW_Real3 = 665209; TW_Real5 = 582557; TW_Real7 = 494295;
          TW_Imag1 = -741455; TW_Imag3 = -810560; TW_Imag5 = -871859; TW_Imag7 = -924761;
        end
        3: begin
          TW_Real1 = 401272; TW_Real3 = 304385; TW_Real5 = 204567; TW_Real7 = 102778;
          TW_Imag1 = -968757; TW_Imag3 = -1003424; TW_Imag5 = -1028427; TW_Imag7 = -1043526;
        end
        4: begin
          TW_Real1 = 0; TW_Real3 = -102778; TW_Real5 = -204567; TW_Real7 = -304385;
          TW_Imag1 = -1048576; TW_Imag3 = -1043526; TW_Imag5 = -1028427; TW_Imag7 = -1003424;
        end
        5: begin
          TW_Real1 = -401272; TW_Real3 = -494295; TW_Real5 = -582557; TW_Real7 = -665209;
          TW_Imag1 = -968757; TW_Imag3 = -924761; TW_Imag5 = -871859; TW_Imag7 = -810560;
        end
        6: begin
          TW_Real1 = -741455; TW_Real3 = -810560; TW_Real5 = -871859; TW_Real7 = -924761;;
          TW_Imag1 = -741455; TW_Imag3 = -665209; TW_Imag5 = -582557; TW_Imag7 = -494295;
        end
        7: begin
          TW_Real1 = -968757; TW_Real3 = -1003424; TW_Real5 = -1028427; TW_Real7 = -1043526;
          TW_Imag1 = -401272; TW_Imag3 = -304385; TW_Imag5 = -204567; TW_Imag7 = -102778;
        end
      endcase
    end
    6: begin
      case (in_cycles % 16)
        0: begin
          TW_Real1 = 1048576; TW_Real3 = 1047312; TW_Real5 = 1043526; TW_Real7 = 1037226;
          TW_Imag1 = 0; TW_Imag3 = -51451; TW_Imag5 = -102778; TW_Imag7 = -153858;
        end
        1: begin
          TW_Real1 = 1028427; TW_Real3 = 1017151; TW_Real5 = 1003424; TW_Real7 = 987280;
          TW_Imag1 = -204567; TW_Imag3 = -254783; TW_Imag5 = -304385; TW_Imag7 = -353254;
        end
        2: begin
          TW_Real1 = 968757; TW_Real3 = 947901; TW_Real5 = 924761; TW_Real7 = 899393;
          TW_Imag1 = -401272; TW_Imag3 = -448324; TW_Imag5 = -494295; TW_Imag7 = -539075;
        end
        3: begin
          TW_Real1 = 871859; TW_Real3 = 842224; TW_Real5 = 810560; TW_Real7 = 776943;
          TW_Imag1 = -582557; TW_Imag3 = -624635; TW_Imag5 = -665209; TW_Imag7 = -704180;
        end
        4: begin
          TW_Real1 = 741455; TW_Real3 = 704180; TW_Real5 = 665209; TW_Real7 = 624635;
          TW_Imag1 = -741455; TW_Imag3 = -776943; TW_Imag5 = -810560; TW_Imag7 = -842224;
        end
        5: begin
          TW_Real1 = 582557; TW_Real3 = 539075; TW_Real5 = 494295; TW_Real7 = 448324;
          TW_Imag1 = -871859; TW_Imag3 = -899393; TW_Imag5 = -924761; TW_Imag7 = -947901;
        end
        6: begin
          TW_Real1 = 401272; TW_Real3 = 353254; TW_Real5 = 304385; TW_Real7 = 254783;
          TW_Imag1 = -968757; TW_Imag3 = -987280; TW_Imag5 = -1003424; TW_Imag7 = -1017151;
        end
        7: begin
          TW_Real1 = 204567; TW_Real3 = 153858; TW_Real5 = 102778; TW_Real7 = 51451;
          TW_Imag1 = -1028427; TW_Imag3 = -1037226; TW_Imag5 = -1043526; TW_Imag7 = -1047312;
        end
        8: begin
          TW_Real1 = 0; TW_Real3 = -51451; TW_Real5 = -102778; TW_Real7 = -153858;
          TW_Imag1 = -1048576; TW_Imag3 = -1047312; TW_Imag5 = -1043526; TW_Imag7 = -1037226;
        end
        9: begin
          TW_Real1 = -204567; TW_Real3 = -254783; TW_Real5 = -304385; TW_Real7 = -353254;
          TW_Imag1 = -1028427; TW_Imag3 = -1017151; TW_Imag5 = -1003424; TW_Imag7 = -987280;
        end
        10: begin
          TW_Real1 = -401272; TW_Real3 = -448324; TW_Real5 = -494295; TW_Real7 = -539075;
          TW_Imag1 = -968757; TW_Imag3 = -947901; TW_Imag5 = -924761; TW_Imag7 = -899393;
        end
        11: begin
          TW_Real1 = -582557; TW_Real3 = -624635; TW_Real5 = -665209; TW_Real7 = -704180;
          TW_Imag1 = -871859; TW_Imag3 = -842224; TW_Imag5 = -810560; TW_Imag7 = -776943;
        end
        12: begin
          TW_Real1 = -741455; TW_Real3 = -776943; TW_Real5 = -810560; TW_Real7 = -842224;
          TW_Imag1 = -741455; TW_Imag3 = -704180; TW_Imag5 = -665209; TW_Imag7 = -624635;
        end
        13: begin
          TW_Real1 = -871859; TW_Real3 = -899393; TW_Real5 = -924761;; TW_Real7 = -947901;
          TW_Imag1 = -582557; TW_Imag3 = -539075; TW_Imag5 = -494295; TW_Imag7 = -448324;
        end
        14: begin
          TW_Real1 = -968757; TW_Real3 = -987280; TW_Real5 = -1003424; TW_Real7 = -1017151;
          TW_Imag1 = -401272; TW_Imag3 = -353254; TW_Imag5 = -304385; TW_Imag7 = -254783;
        end
        15: begin
          TW_Real1 = -1028427; TW_Real3 = -1037226; TW_Real5 = -1043526; TW_Real7 = -1047312;
          TW_Imag1 = -204567; TW_Imag3 = -153858; TW_Imag5 = -102778; TW_Imag7 = -51451;
        end
      endcase
    end
    7: begin // *TODO Need to modify
      //*****************
        case (in_cycles % 32)
        	
			0: begin
			TW_Real1 = 1048576; TW_Imag1 = 0;
			TW_Real3 = 1048260;	TW_Imag3 = -25733;
			TW_Real5 = 1047312;
			TW_Imag5 = -51451;
			TW_Real7 = 1045734;
			TW_Imag7 = -77138;
			end

			1: begin
			TW_Real1 = 1043526;
			TW_Imag1 = -102778;
			TW_Real3 = 1040690;
			TW_Imag3 = -128356;
			TW_Real5 = 1037226;
			TW_Imag5 = -153858;
			TW_Real7 = 1033138;
			TW_Imag7 = -179266;
			end

			2: begin	
			TW_Real1 = 1028427;
			TW_Imag1 = -204567;
			TW_Real3 = 1023097;
			TW_Imag3 = -229744;
			TW_Real5 = 1017151;
			TW_Imag5 = -254783;
			TW_Real7 = 1010592;
			TW_Imag7 = -279668;
			end

			3: begin	
			TW_Real1 = 1003424;
			TW_Imag1 = -304385;
			TW_Real3 = 995652;
			TW_Imag3 = -328919;
			TW_Real5 = 987280;
			TW_Imag5 = -353254;
			TW_Real7 = 978313;
			TW_Imag7 = -377377;
			end

			4: begin	
			TW_Real1 = 968757;
			TW_Imag1 = -401272;
			TW_Real3 = 958618;
			TW_Imag3 = -424926;
			TW_Real5 = 947901;
			TW_Imag5 = -448324;
			TW_Real7 = 936613;
			TW_Imag7 = -471451;
			end

			5: begin	
			TW_Real1 = 924761;
			TW_Imag1 = -494295;
			TW_Real3 = 912352;
			TW_Imag3 = -516841;
			TW_Real5 = 899393;
			TW_Imag5 = -539075;
			TW_Real7 = 885893;
			TW_Imag7 = -560985;
			end

			6: begin	
			TW_Real1 = 871859;
			TW_Imag1 = -582557;
			TW_Real3 = 857299;
			TW_Imag3 = -603778;
			TW_Real5 = 842224;
			TW_Imag5 = -624635;
			TW_Real7 = 826641;
			TW_Imag7 = -645117;
			end

			7: begin	
			TW_Real1 = 810560;
			TW_Imag1 = -665209;
			TW_Real3 = 793991;
			TW_Imag3 = -684901;
			TW_Real5 = 776943;
			TW_Imag5 = -704180;
			TW_Real7 = 759428;
			TW_Imag7 = -723035;
			end

			8: begin	
			TW_Real1 = 741455;
			TW_Imag1 = -741455;
			TW_Real3 = 723035;
			TW_Imag3 = -759428;
			TW_Real5 = 704180;
			TW_Imag5 = -776943;
			TW_Real7 = 684901;
			TW_Imag7 = -793991;
			end

			9: begin	
			TW_Real1 = 665209;
			TW_Imag1 = -810560;
			TW_Real3 = 645117;
			TW_Imag3 = -826641;
			TW_Real5 = 624635;
			TW_Imag5 = -842224;
			TW_Real7 = 603778;
			TW_Imag7 = -857299;
			end

			10: begin	
			TW_Real1 = 582557;
			TW_Imag1 = -871859;
			TW_Real3 = 560985;
			TW_Imag3 = -885893;
			TW_Real5 = 539075;
			TW_Imag5 = -899393;
			TW_Real7 = 516841;
			TW_Imag7 = -912352;
			end

			11: begin	
			TW_Real1 = 494295;
			TW_Imag1 = -924761;
			TW_Real3 = 471451;
			TW_Imag3 = -936613;
			TW_Real5 = 448324;
			TW_Imag5 = -947901;
			TW_Real7 = 424926;
			TW_Imag7 = -958618;
			end

			12: begin
			TW_Real1 = 401272;
			TW_Imag1 = -968757;
			TW_Real3 = 377377;
			TW_Imag3 = -978313;
			TW_Real5 = 353254;
			TW_Imag5 = -987280;
			TW_Real7 = 328919;
			TW_Imag7 = -995652;
			end

			13: begin	
			TW_Real1 = 304385;
			TW_Imag1 = -1003424;
			TW_Real3 = 279668;
			TW_Imag3 = -1010592;
			TW_Real5 = 254783;
			TW_Imag5 = -1017151;
			TW_Real7 = 229744;
			TW_Imag7 = -1023097;
			end

			14: begin	
			TW_Real1 = 204567;
			TW_Imag1 = -1028427;
			TW_Real3 = 179266;
			TW_Imag3 = -1033138;
			TW_Real5 = 153858;
			TW_Imag5 = -1037226;
			TW_Real7 = 128356;
			TW_Imag7 = -1040690;
			end

			15: begin	
			TW_Real1 = 102778;
			TW_Imag1 = -1043526;
			TW_Real3 = 77138;
			TW_Imag3 = -1045734;
			TW_Real5 = 51451;
			TW_Imag5 = -1047312;
			TW_Real7 = 25733;
			TW_Imag7= -1048260;
			end

			16: begin	
			TW_Real1 = 0;
			TW_Imag1 = -1048576;
			TW_Real3 = -25733;
			TW_Imag3 = -1048260;
			TW_Real5 = -51451;
			TW_Imag5 = -1047312;
			TW_Real7 = -77138;
			TW_Imag7 = -1045734;
			end

			17: begin
			TW_Real1 = -102778;
			TW_Imag1 = -1043526;
			TW_Real3 = -128356;
			TW_Imag3 = -1040690;
			TW_Real5 = -153858;
			TW_Imag5 = -1037226;
			TW_Real7 = -179266;
			TW_Imag7 = -1033138;
			end

			18: begin	
			TW_Real1 = -204567;
			TW_Imag1 = -1028427;
			TW_Real3 = -229744;
			TW_Imag3 = -1023097;
			TW_Real5 = -254783;
			TW_Imag5 = -1017151;
			TW_Real7 = -279668;
			TW_Imag7 = -1010592;
			end

			19: begin	
			TW_Real1 = -304385;
			TW_Imag1 = -1003424;
			TW_Real3 = -328919;
			TW_Imag3 = -995652;
			TW_Real5 = -353254;
			TW_Imag5 = -987280;
			TW_Real7 = -377377;
			TW_Imag7 = -978313;
			end

			20: begin
			TW_Real1 = -401272;
			TW_Imag1 = -968757;
			TW_Real3 = -424926;
			TW_Imag3 = -958618;
			TW_Real5 = -448324;
			TW_Imag5 = -947901;
			TW_Real7 = -471451;
			TW_Imag7 = -936613;
			end

			21: begin
			TW_Real1 = -494295;
			TW_Imag1 = -924761;
			TW_Real3 = -516841;
			TW_Imag3 = -912352;
			TW_Real5 = -539075;
			TW_Imag5 = -899393;
			TW_Real7 = -560985;
			TW_Imag7 = -885893;
			end

			22: begin
			TW_Real1 = -582557;
			TW_Imag1 = -871859;
			TW_Real3 = -603778;
			TW_Imag3 = -857299;
			TW_Real5 = -624635;
			TW_Imag5 = -842224;
			TW_Real7 = -645117;
			TW_Imag7 = -826641;
			end

			23: begin
			TW_Real1 = -665209;
			TW_Imag1 = -810560;
			TW_Real3 = -684901;
			TW_Imag3 = -793991;
			TW_Real5 = -704180;
			TW_Imag5 = -776943;
			TW_Real7 = -723035;
			TW_Imag7 = -759428;
			end

			24: begin
			TW_Real1 = -741455;
			TW_Imag1 = -741455;
			TW_Real3 = -759428;
			TW_Imag3 = -723035;
			TW_Real5 = -776943;
			TW_Imag5 = -704180;
			TW_Real7 = -793991;
			TW_Imag7 = -684901;
			end

			25: begin	
			TW_Real1 = -810560;
			TW_Imag1 = -665209;
			TW_Real3 = -826641;
			TW_Imag3 = -645117;
			TW_Real5 = -842224;
			TW_Imag5 = -624635;
			TW_Real7 = -857299;
			TW_Imag7 = -603778;
			end

			26: begin	
			TW_Real1 = -871859;
			TW_Imag1 = -582557;
			TW_Real3 = -885893;
			TW_Imag3 = -560985;
			TW_Real5 = -899393;
			TW_Imag5 = -539075;
			TW_Real7 = -912352;
			TW_Imag7 = -516841;
			end

			27: begin	
			TW_Real1 = -924761;
			TW_Imag1 = -494295;
			TW_Real3 = -936613;
			TW_Imag3 = -471451;
			TW_Real5 = -947901;
			TW_Imag5 = -448324;
			TW_Real7 = -958618;
			TW_Imag7 = -424926;
			end

			28: begin	
			TW_Real1 = -968757;
			TW_Imag1 = -401272;
			TW_Real3 = -978313;
			TW_Imag3 = -377377;
			TW_Real5 = -987280;
			TW_Imag5 = -353254;
			TW_Real7 = -995652;
			TW_Imag7 = -328919;
			end

			29: begin	
			TW_Real1 = -1003424;
			TW_Imag1 = -304385;
			TW_Real3 = -1010592;
			TW_Imag3 = -279668;
			TW_Real5 = -1017151;
			TW_Imag5 = -254783;
			TW_Real7 = -1023097;
			TW_Imag7 = -229744;
			end

			30: begin	
			TW_Real1 = -1028427;
			TW_Imag1 = -204567;
			TW_Real3 = -1033138;
			TW_Imag3 = -179266;
			TW_Real5 = -1037226;
			TW_Imag5 = -153858;
			TW_Real7 = -1040690;
			TW_Imag7 = -128356;
			end

			31: begin
			TW_Real1 = -1043526;
			TW_Imag1 = -102778;
			TW_Real3 = -1045734;
			TW_Imag3 = -77138;
			TW_Real5 = -1047312;
			TW_Imag5 = -51451;
			TW_Real7 = -1048260;
			TW_Imag7 = -25733;
			end

			default: begin
			TW_Real1 = 0; TW_Real3 = 0; TW_Real5 = 0; TW_Real7 = 0;
			TW_Imag1 = 0; TW_Imag3 = 0; TW_Imag5 = 0; TW_Imag7 = 0;
			end
        endcase
	end
	
	//**************
	
 endcase
end
endmodule
