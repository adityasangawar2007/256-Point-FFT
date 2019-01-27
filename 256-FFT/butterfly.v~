//combination of 1 butterfly module


module butterfly(clk, reset,WR128,WI128, outputscrambler_Real0, outputscrambler_Imgr0, outputscrambler_Real128, outputscrambler_Imgr128, outputbutterfly_Real0, outputbutterfly_Imgr0, outputbutterfly_Real128, outputbutterfly_Imgr128);

input clk, reset;
input [21:0] WR128,WI128;
input [27:0] outputscrambler_Real0, outputscrambler_Imgr0, outputscrambler_Real128, outputscrambler_Imgr128;
output reg [27:0] outputbutterfly_Real0, outputbutterfly_Imgr0, outputbutterfly_Real128, outputbutterfly_Imgr128;

reg [27:0] outputbutterfly_combo_Real0,
outputbutterfly_combo_Imgr0,
outputbutterfly_combo_Real128,
outputbutterfly_combo_Imgr128,
outputscrambler_Real0_temp1,
outputscrambler_Real0_temp2,
outputscrambler_Real0_temp3,

outputscrambler_Imgr0_temp1,
outputscrambler_Imgr0_temp2,
outputscrambler_Imgr0_temp3,

outputscrambler_Imgr128_temp1,
outputscrambler_Imgr128_temp2,
outputscrambler_Imgr128_temp3,

outputscrambler_Real128_temp1,
outputscrambler_Real128_temp2,
outputscrambler_Real128_temp3;

wire [49:0] DWout_BR_WR_128, DWout_BR_WI_128, DWout_BI_WR_128, DWout_BI_WI_128; //Twiddle factor WI - Twiddle Imaginary, WR Twiddle Real

DW02_mult_3_stage#(28,22) instr1(outputscrambler_Real128,WR128,1'b1,clk,DWout_BR_WR_128);//Butterfly Real and Twiddle Real
DW02_mult_3_stage#(28,22) instr2(outputscrambler_Real128,WI128,1'b1,clk,DWout_BR_WI_128);//Butterfly Real and Twiddle Imgr
DW02_mult_3_stage#(28,22) instr3(outputscrambler_Imgr128,WR128,1'b1,clk,DWout_BI_WR_128);//Butterfly Imgr and Twiddle Real
DW02_mult_3_stage#(28,22) instr4(outputscrambler_Imgr128,WI128,1'b1,clk,DWout_BI_WI_128);//Butterfly Imgr and Twiddle Imgr


always @(*) begin

	outputbutterfly_combo_Real0 = outputscrambler_Real0_temp2 + DWout_BR_WR_128[49:20] - DWout_BI_WI_128[49:20];
	outputbutterfly_combo_Imgr0 = outputscrambler_Imgr0_temp2 + DWout_BR_WI_128[49:20] + DWout_BI_WR_128[49:20];
	outputbutterfly_combo_Real128 = outputscrambler_Real128_temp2 - DWout_BR_WR_128[49:20] + DWout_BI_WI_128[49:20];
	outputbutterfly_combo_Imgr128 = outputscrambler_Imgr128_temp2 - DWout_BR_WI_128[49:20] - DWout_BI_WR_128[49:20];


end

always @(posedge clk or posedge reset) begin
		if(reset)  begin
			outputbutterfly_combo_Real0 <= 0;
			outputbutterfly_combo_Imgr0 <= 0;
			outputbutterfly_combo_Real128 <= 0;
			outputbutterfly_combo_Imgr128 <= 0;
			outputscrambler_Real0_temp1 <= 0;
			outputscrambler_Real0_temp2 <= 0;
			outputscrambler_Real0_temp3 <= 0;

			outputscrambler_Imgr0_temp1 <= 0;
			outputscrambler_Imgr0_temp2 <= 0;
			outputscrambler_Imgr0_temp3 <= 0;

			outputscrambler_Imgr128_temp1 <= 0;
			outputscrambler_Imgr128_temp2 <= 0;
			outputscrambler_Imgr128_temp3 <= 0;

			outputscrambler_Real128_temp1 <= 0;
			outputscrambler_Real128_temp2 <= 0;
			outputscrambler_Real128_temp3 <= 0;
		end

		else
		outputscrambler_Real0_temp1 <= outputscrambler_Real0;
		outputscrambler_Real0_temp2 <= outputscrambler_Real0_temp1;

		outputscrambler_Imgr0_temp1 <= outputscrambler_Imgr0;
		outputscrambler_Imgr0_temp2 <= outputscrambler_Imgr0_temp1;

		outputscrambler_Imgr128_temp1 <= outputscrambler_Imgr128;
		outputscrambler_Imgr128_temp2 <= outputscrambler_Imgr128_temp1;

		outputscrambler_Real128_temp1 <= outputscrambler_Real128;
		outputscrambler_Real128_temp2 <= outputscrambler_Real128_temp1;

		outputbutterfly_Real0 <= outputbutterfly_combo_Real0;
		outputbutterfly_Imgr0 <= outputbutterfly_combo_Imgr0;
		outputbutterfly_Real128 <= outputbutterfly_combo_Real128;
		outputbutterfly_Imgr128 <= outputbutterfly_combo_Imgr128;

		end

endmodule
