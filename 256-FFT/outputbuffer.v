module outputbuffer (
						input clk, reset, start_output, startin,
						input [4:0] cal_cycles,
						input [2:0] stage, //if stage ==7
						input [55:0] out0, out1, out2, out3, out4, out5, out6, out7,
						output reg [19:0] realout, imagout,
						output reg startout
					);

// Shift Registers

reg [19:0] ShiftBits_Real[255:0];
reg [19:0] ShiftBits_Imgr [255:0];
reg [7:0] counter, senddata;
reg push;

always @ (posedge clk or posedge reset) begin
	if (reset) begin
		startout <= #1 0;
	end
	else begin
		case (startout)
			0: if (push && start_output && cal_cycles == 31) startout <= #1 1;
			1: startout <= #1 0;
		endcase
	end
end

always @(posedge clk or posedge reset) begin
	if(reset) begin
		realout <= 0;
		imagout <= 0;
		counter <= 0;
		senddata <= 0;
		push <= 0;
	end
	else begin
		if(stage == 7) begin
			// if(counter == 256) begin
			// 	counter <= 0;
			// end
			// else begin
			ShiftBits_Real[counter]   <= out0[24:2]; //Remove 3 MSB and 2 LSB
			ShiftBits_Real[counter+1] <= out1[24:2];
			ShiftBits_Real[counter+2] <= out2[24:2];
			ShiftBits_Real[counter+3] <= out3[24:2];
			ShiftBits_Real[counter+4] <= out4[24:2];
			ShiftBits_Real[counter+5] <= out5[24:2];
			ShiftBits_Real[counter+6] <= out6[24:2];
			ShiftBits_Real[counter+7] <= out7[24:2];

			ShiftBits_Imgr[counter]   <= out0[52:30];
			ShiftBits_Imgr[counter+1] <= out1[52:30];
			ShiftBits_Imgr[counter+2] <= out2[52:30];
			ShiftBits_Imgr[counter+3] <= out3[52:30];
			ShiftBits_Imgr[counter+4] <= out4[52:30];
			ShiftBits_Imgr[counter+5] <= out5[52:30];
			ShiftBits_Imgr[counter+6] <= out6[52:30];
			ShiftBits_Imgr[counter+7] <= out7[52:30];

			if ((counter + 7) == 255) begin
				counter <= 0;
				push <= 1;
			end
			else counter <= counter + 8; //counter runs from 0, 8, 16, .... to 248
		//end
		end
		else begin
			if (push && start_output) begin
				realout <= #1 ShiftBits_Real[senddata];
				imagout <= #1 ShiftBits_Imgr[senddata];
				senddata <= senddata + 1;
				if (senddata == 255) push <= 0;
			end
		end
		// else begin
		// //recirculation
		// // ShiftBits_Real[senddata] <= ShiftBits_Real[senddata];
		// // senddata <= senddata + 1;
		// end
	end
end
endmodule
