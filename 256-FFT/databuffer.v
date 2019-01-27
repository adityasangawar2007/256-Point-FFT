module databuffer	(
						input clk, reset, data_valid, bank,
						input [7:0] rd_pt0, rd_pt1, rd_pt2, rd_pt3, rd_pt4, rd_pt5, rd_pt6, rd_pt7,
						input [55:0] in0, in1, in2, in3, in4, in5, in6, in7,
						output reg [55:0] out0, out1, out2, out3, out4, out5, out6, out7
					);

//reg [4:0] casecounter;
reg [55:0] datamem0 [0:255]; //56x256 mem
reg [55:0] datamem1 [0:255]; //56x256 mem
reg [7:0] wr_pointer;
reg [5:0] counter;
//reg data_out, data_in;
reg [2:0] stg_counter;

always @ (posedge clk or posedge reset) begin
	if(reset) begin
		counter <= 5'b0;
		// data_in <= 1'b0;
		// data_out <= 1'b0;
		wr_pointer <= 9'b0;
		//stg_counter <= 3'b0;
	end
	else begin
		if(data_valid) begin
			//counter <= counter + 1'b1;
			wr_pointer <= wr_pointer + 8;
		end
	end
end

// always @ (*) begin
// 	//if (data_valid) data_in = 1'b1;
// 	if (counter == 31) begin
// 		data_out = 1'b1;
// 	end
// 	if (counter == 32) begin
// 		stg_counter = stg_counter + 1'b1;
// 		counter = 0;
// 	end
// end

//write block
always @ (posedge clk) begin
	if (data_valid) begin
		case (bank)
		0: begin
			datamem0[wr_pointer] <= in0; datamem0[wr_pointer+1] <= in1; datamem0[wr_pointer+2] <= in2; datamem0[wr_pointer+3] <= in3;
			datamem0[wr_pointer+4] <= in4; datamem0[wr_pointer+5] <= in5; datamem0[wr_pointer+6] <= in6; datamem0[wr_pointer+7] <= in7;
		end
		1: begin
			datamem1[wr_pointer] <= in0; datamem1[wr_pointer+1] <= in1; datamem1[wr_pointer+2] <= in2; datamem1[wr_pointer+3] <= in3;
			datamem1[wr_pointer+4] <= in4; datamem1[wr_pointer+5] <= in5; datamem1[wr_pointer+6] <= in6; datamem1[wr_pointer+7] <= in7;
		end
		// datamem[wr_pointer+8] <= in8; datamem[wr_pointer+9] <= in9; datamem[wr_pointer+10] <= in10; datamem[wr_pointer+11] <= in11;
		// datamem[wr_pointer+12] <= in12; datamem[wr_pointer+13] <= in13; datamem[wr_pointer+14] <= in14; datamem[wr_pointer+15] <= in15;
		endcase
	end
end

//Read block
always @ (posedge clk) begin
	if (data_valid) begin
		case (bank)
		0: begin
			out0 <= datamem1[rd_pt0]; out1 <= datamem1[rd_pt1]; out2 <= datamem1[rd_pt2]; out3 <= datamem1[rd_pt3];
			out4 <= datamem1[rd_pt4]; out5 <= datamem1[rd_pt5]; out6 <= datamem1[rd_pt6]; out7 <= datamem1[rd_pt7];
		end
		1: begin
			out0 <= datamem0[rd_pt0]; out1 <= datamem0[rd_pt1]; out2 <= datamem0[rd_pt2]; out3 <= datamem0[rd_pt3];
			out4 <= datamem0[rd_pt4]; out5 <= datamem0[rd_pt5]; out6 <= datamem0[rd_pt6]; out7 <= datamem0[rd_pt7];
		end
		// datamem[wr_pointer+8] <= in8; datamem[wr_pointer+9] <= in9; datamem[wr_pointer+10] <= in10; datamem[wr_pointer+11] <= in11;
		// datamem[wr_pointer+12] <= in12; datamem[wr_pointer+13] <= in13; datamem[wr_pointer+14] <= in14; datamem[wr_pointer+15] <= in15;
		endcase
	end
end

//Use the 4 stage buffer in such a way that every 256 cycles we get output. SO stage 1 should take 32 cycles

// fourbutterfly FBs (clk, reset,WR_bt0,WR_bt3,WR_bt5,WR_bt7,WI_bt1,WI_bt3,WI_bt5,WI_bt7, outputscrambler_Real_bt[ ],
// outputscrambler_Imgr_bt0, outputscrambler_Real_bt1, outputscrambler_Imgr_bt1, outputscrambler_Real_bt2, outputscrambler_Imgr_bt2,
// outputscrambler_Real_bt3, outputscrambler_Imgr_bt3, outputscrambler_Real_bt4, outputscrambler_Imgr_bt4, outputscrambler_Real_bt5,
// outputscrambler_Imgr_bt5, outputscrambler_Real_bt6, outputscrambler_Imgr_bt6,outputscrambler_Real_bt7, outputscrambler_Imgr_bt7,
// outputbutterfly_Real_bt0, outputbutterfly_Imgr_bt0, outputbutterfly_Real_bt1, outputbutterfly_Imgr_bt1, outputbutterfly_Real_bt2,
// outputbutterfly_Imgr_bt2,outputbutterfly_Real_bt3, outputbutterfly_Imgr_bt3, outputbutterfly_Real_bt4, outputbutterfly_Imgr_bt4,
// outputbutterfly_Real_bt5, outputbutterfly_Imgr_bt5, outputbutterfly_Real_bt6, outputbutterfly_Imgr_bt6,outputbutterfly_Real_bt7,
// outputbutterfly_Imgr_bt7);


// always @ (posedge clk or negedge rst)
// 		if(!reset) begin

// 		end

// 		//01, 23, 45, 67

// 		// Thinh to work from here ............

// 		else begin

// 		case(casecounter)



// 		end

endmodule


module fifo # (parameter ADDR_WIDTH = 5, DATA_WIDTH = 40)(
    input clk,
    input reset,
    input wr_en,
    input rd_en,
	input [DATA_WIDTH-1:0] din,
    //output empty,
    //output full,
	output [DATA_WIDTH-1:0] dout
	//output [ADDR_WIDTH:0] fifo_stat_out
    );

parameter FIFO_DEPTH = (1 << ADDR_WIDTH);

reg [DATA_WIDTH-1:0] out;
reg [DATA_WIDTH-1:0] dmem[0:FIFO_DEPTH-1]; //number of entries in fifo = 2^(address width) defaut is 2^5 = 32 entries
reg [ADDR_WIDTH-1:0] wr_reg; //points to the register that needs to be written to
reg [ADDR_WIDTH-1:0] rd_reg; //points to the register that needs to be read from
reg [ADDR_WIDTH:0] fifo_stat; //keep track of the fifo status

//assign full = (fifo_stat == FIFO_DEPTH-1); //fifo is full when the counter is at the max depth of the fifo
//assign empty = (fifo_stat == 0); //fifo is empty when the counter is at 0
assign dout = out;
//assign fifo_stat_out = fifo_stat;

//Write logic
always @ (posedge clk) begin
	if(wr_en) begin
		dmem[wr_reg] <= din;  //at wr_reg location of data_reg store what is given at din
		wr_reg <= #1 wr_reg + 1; //increase wr pointer after a read
	end
end

//Read logic
always @ (posedge clk) begin
	if(rd_en) begin
		out <= #1 dmem[rd_reg];
		rd_reg <= #1 rd_reg + 1; //increase rd pointer after a read
	end
end

always @ (posedge clk or posedge reset) begin
	if (reset) begin
		wr_reg <= #1 0;
		rd_reg <= #1 0;
		out <= #1 0;
		fifo_stat <= #1 0;
	end
	else begin
		case({wr_en,rd_en})
		2'b01: begin //read
			if (fifo_stat != 0) begin
				fifo_stat <= #1 fifo_stat - 1; //fifo is now one less element after a read
			end
		end
		2'b10: begin //write
			if (fifo_stat != FIFO_DEPTH) begin
				fifo_stat <= #1 fifo_stat + 1; //fifo is now one more element after a write
			end
		end
		endcase
	end
end

endmodule


// module databuffer_tb();

// reg data_valid_tb;
// reg clk_tb, reset_tb;
// reg [55:0] i;
// reg [55:0] in_tb;
// reg [7:0] rd_pt0_tb, rd_pt1_tb, rd_pt2_tb, rd_pt3_tb, rd_pt4_tb, rd_pt5_tb, rd_pt6_tb, rd_pt7_tb;
// wire [55:0] out_tb0, out_tb1, out_tb2, out_tb3, out_tb4, out_tb5, out_tb6, out_tb7;
// //out_tb8, out_tb9, out_tb10, out_tb11, out_tb12, out_tb13, out_tb14, out_tb15;

// databuffer DB	(
// 					.clk(clk_tb), .reset(reset_tb), .data_valid(data_valid_tb),
// 					.in0(in_tb), .in1(in_tb), .in2(in_tb), .in3(in_tb), .in4(in_tb), .in5(in_tb), .in6(in_tb), .in7(in_tb),
// 					// .in8(in_tb), .in9(in_tb), .in10(in_tb), .in11(in_tb), .in12(in_tb), .in13(in_tb), .in14(in_tb), .in15(in_tb),
// 					.rd_pt0(rd_pt0_tb), .rd_pt1(rd_pt1_tb), .rd_pt2(rd_pt2_tb), .rd_pt3(rd_pt3_tb), .rd_pt4(rd_pt4_tb), .rd_pt5(rd_pt5_tb), .rd_pt6(rd_pt6_tb), .rd_pt7(rd_pt7_tb),
// 					.out0(out_tb0), .out1(out_tb1), .out2(out_tb2), .out3(out_tb3), .out4(out_tb4), .out5(out_tb5), .out6(out_tb6), .out7(out_tb7)
// 					// .out8(out_tb8), .out9(out_tb9), .out10(out_tb10), .out11(out_tb11), .out12(out_tb12), .out13(out_tb13), .out14(out_tb14), .out15(out_tb15)
// 				);

// initial begin
// 	clk_tb = 1'b0;
// 	reset_tb = 1'b1;
// 	forever #5 clk_tb = ~clk_tb;
// end

// initial begin
// 	#10 reset_tb = 1'b0;
// 	#2	data_valid_tb = 1'b1;
// 	for (i = 0; i < 32; i = i + 1'b1) begin
// 		in_tb = i;
// 		$display("@ %t in_tb = %d", $time, in_tb);
// 		#10;
// 	end
// 	for (i = 0; i < 32; i = i + 1'b1) begin
// 		rd_pt0_tb = i*8; rd_pt1_tb = i*8+1; rd_pt2_tb = i*8+2; rd_pt3_tb = i*8+3;
// 		rd_pt4_tb = i*8+4; rd_pt5_tb = i*8+5; rd_pt6_tb = i*8+6; rd_pt7_tb = i*8+7;
// 		$display("@ %t cycle %d Out4: %d", $time, i, out_tb4); $display("@ %t cycle %d Out5: %d", $time, i, out_tb5); $display("@ %t cycle %d Out6: %d", $time, i, out_tb6); $display("@ %t cycle %d Out7: %d", $time, i, out_tb7);
// 		$display("@ %t tcycle %d Out0: %d", $time, i, out_tb0); $display("@ %t cycle %d Out1: %d", $time, i, out_tb1); $display("@%t cycle %d Out2: %d", $time, i, out_tb2); $display("@ %t cycle %d Out3: %d", $time, i, out_tb3);
// 		//$display("@ %t cycle %d Out8: %d", $time, i, out_tb8); $display("@ %t cycle %d Out9: %d", $time, i, out_tb9); $display("@ %t cycle %d Out10: %d", $time, i, out_tb10); $display("@ %t cycle %d Out11: %d", $time, i, out_tb11);
// 		//$display("@ %t cycle %d Out12: %d", $time, i, out_tb12); $display("@ %t cycle %d Out13: %d", $time, i, out_tb13); $display("@ %t cycle %d Out14: %d", $time, i, out_tb14); $display("@ %t cycle %d Out15: %d", $time, i, out_tb15);
// 		in_tb = i + 32;
// 		$display("@ %t in_tb = %d", $time, in_tb);
// 		#10;
// 	end
// 	for (i = 0; i < 32; i = i + 1'b1) begin
// 		rd_pt0_tb = i*8; rd_pt1_tb = i*8+1; rd_pt2_tb = i*8+2; rd_pt3_tb = i*8+3;
// 		rd_pt4_tb = i*8+4; rd_pt5_tb = i*8+5; rd_pt6_tb = i*8+6; rd_pt7_tb = i*8+7;
// 		$display("@ %t cycle %d Out4: %d", $time, i, out_tb4); $display("@ %t cycle %d Out5: %d", $time, i, out_tb5); $display("@ %t cycle %d Out6: %d", $time, i, out_tb6); $display("@ %t cycle %d Out7: %d", $time, i, out_tb7);
// 		$display("@ %t tcycle %d Out0: %d", $time, i, out_tb0); $display("@ %t cycle %d Out1: %d", $time, i, out_tb1); $display("@%t cycle %d Out2: %d", $time, i, out_tb2); $display("@ %t cycle %d Out3: %d", $time, i, out_tb3);
// 		//$display("@ %t cycle %d Out8: %d", $time, i, out_tb8); $display("@ %t cycle %d Out9: %d", $time, i, out_tb9); $display("@ %t cycle %d Out10: %d", $time, i, out_tb10); $display("@ %t cycle %d Out11: %d", $time, i, out_tb11);
// 		//$display("@ %t cycle %d Out12: %d", $time, i, out_tb12); $display("@ %t cycle %d Out13: %d", $time, i, out_tb13); $display("@ %t cycle %d Out14: %d", $time, i, out_tb14); $display("@ %t cycle %d Out15: %d", $time, i, out_tb15);
// 		in_tb = i + 32;
// 		$display("@ %t in_tb = %d", $time, in_tb);
// 		#10;
// 	end
// 	#50 $finish();
// end

// endmodule
