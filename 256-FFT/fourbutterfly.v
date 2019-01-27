//combination of 4 butterfly modules

module fourbutterfly(clk, reset,WR_bt1,WR_bt3,WR_bt5,WR_bt7,WI_bt1,WI_bt3,WI_bt5,WI_bt7, outputscrambler_Real_bt0,
outputscrambler_Imgr_bt0, outputscrambler_Real_bt1, outputscrambler_Imgr_bt1, outputscrambler_Real_bt2, outputscrambler_Imgr_bt2,
outputscrambler_Real_bt3, outputscrambler_Imgr_bt3, outputscrambler_Real_bt4, outputscrambler_Imgr_bt4, outputscrambler_Real_bt5,
outputscrambler_Imgr_bt5, outputscrambler_Real_bt6, outputscrambler_Imgr_bt6,outputscrambler_Real_bt7, outputscrambler_Imgr_bt7,
outputbutterfly_Real_bt0, outputbutterfly_Imgr_bt0, outputbutterfly_Real_bt1, outputbutterfly_Imgr_bt1, outputbutterfly_Real_bt2,
outputbutterfly_Imgr_bt2,outputbutterfly_Real_bt3, outputbutterfly_Imgr_bt3, outputbutterfly_Real_bt4, outputbutterfly_Imgr_bt4,
outputbutterfly_Real_bt5, outputbutterfly_Imgr_bt5, outputbutterfly_Real_bt6, outputbutterfly_Imgr_bt6,outputbutterfly_Real_bt7,
outputbutterfly_Imgr_bt7);

input clk, reset;
input [21:0] WR_bt1,WR_bt3,WR_bt5,WR_bt7,WI_bt1,WI_bt3,WI_bt5,WI_bt7; //Four pairs of twiddle factors
input [27:0] outputscrambler_Real_bt0, outputscrambler_Imgr_bt0, outputscrambler_Real_bt1, outputscrambler_Imgr_bt1, //bt is butterfly number
outputscrambler_Real_bt2, outputscrambler_Imgr_bt2,outputscrambler_Real_bt3, outputscrambler_Imgr_bt3,
outputscrambler_Real_bt4, outputscrambler_Imgr_bt4, outputscrambler_Real_bt5, outputscrambler_Imgr_bt5, //bt is butterfly number
outputscrambler_Real_bt6, outputscrambler_Imgr_bt6,outputscrambler_Real_bt7, outputscrambler_Imgr_bt7;
output [27:0] outputbutterfly_Real_bt0, outputbutterfly_Imgr_bt0, outputbutterfly_Real_bt1, outputbutterfly_Imgr_bt1, //bt is butterfly number
outputbutterfly_Real_bt2, outputbutterfly_Imgr_bt2,outputbutterfly_Real_bt3, outputbutterfly_Imgr_bt3,
outputbutterfly_Real_bt4, outputbutterfly_Imgr_bt4, outputbutterfly_Real_bt5, outputbutterfly_Imgr_bt5, //bt is butterfly number
outputbutterfly_Real_bt6, outputbutterfly_Imgr_bt6,outputbutterfly_Real_bt7, outputbutterfly_Imgr_bt7;



//Butterfly pairs - 01, 23, 45, 67
butterfly bt0(clk, reset, WR_bt1, WI_bt1, outputscrambler_Real_bt0, outputscrambler_Imgr_bt0, outputscrambler_Real_bt1, outputscrambler_Imgr_bt1,
 outputbutterfly_Real_bt0, outputbutterfly_Imgr_bt0, outputbutterfly_Real_bt1, outputbutterfly_Imgr_bt1);

butterfly bt1(clk, reset, WR_bt3, WI_bt3, outputscrambler_Real_bt2, outputscrambler_Imgr_bt2, outputscrambler_Real_bt3, outputscrambler_Imgr_bt3,
 outputbutterfly_Real_bt2, outputbutterfly_Imgr_bt2, outputbutterfly_Real_bt3, outputbutterfly_Imgr_bt3);

butterfly bt2(clk, reset, WR_bt5, WI_bt5, outputscrambler_Real_bt4, outputscrambler_Imgr_bt4, outputscrambler_Real_bt5, outputscrambler_Imgr_bt5,
 outputbutterfly_Real_bt4, outputbutterfly_Imgr_bt4, outputbutterfly_Real_bt5, outputbutterfly_Imgr_bt5);

butterfly bt3(clk, reset, WR_bt7, WI_bt7, outputscrambler_Real_bt6, outputscrambler_Imgr_bt6, outputscrambler_Real_bt7, outputscrambler_Imgr_bt7,
 outputbutterfly_Real_bt6, outputbutterfly_Imgr_bt6, outputbutterfly_Real_bt7, outputbutterfly_Imgr_bt7);
 endmodule




//******************** TB ****************
/*
module fourbutterflyTB();

reg clk, reset;
reg [27:0] WR_bt1,WR_bt3,WR_bt5,WR_bt7,WI_bt1,WI_bt3,WI_bt5,WI_bt7; //Four pairs of twiddle factors
reg [27:0] outputscrambler_Real_bt0, outputscrambler_Imgr_bt0, outputscrambler_Real_bt1, outputscrambler_Imgr_bt1, //bt is butterfly number
outputscrambler_Real_bt2, outputscrambler_Imgr_bt2,outputscrambler_Real_bt3, outputscrambler_Imgr_bt3,
outputscrambler_Real_bt4, outputscrambler_Imgr_bt4, outputscrambler_Real_bt5, outputscrambler_Imgr_bt5, //bt is butterfly number
outputscrambler_Real_bt6, outputscrambler_Imgr_bt6,outputscrambler_Real_bt7, outputscrambler_Imgr_bt7;

wire [27:0] outputbutterfly_Real_bt0, outputbutterfly_Imgr_bt0, outputbutterfly_Real_bt1, outputbutterfly_Imgr_bt1, //bt is butterfly number
outputbutterfly_Real_bt2, outputbutterfly_Imgr_bt2,outputbutterfly_Real_bt3, outputbutterfly_Imgr_bt3,
outputbutterfly_Real_bt4, outputbutterfly_Imgr_bt4, outputbutterfly_Real_bt5, outputbutterfly_Imgr_bt5, //bt is butterfly number
outputbutterfly_Real_bt6, outputbutterfly_Imgr_bt6,outputbutterfly_Real_bt7, outputbutterfly_Imgr_bt7;



fourbutterfly instbutterflyfour(clk, reset,WR_bt1,WR_bt3,WR_bt5,WR_bt7,WI_bt1,WI_bt3,WI_bt5,WI_bt7, outputscrambler_Real_bt0,
outputscrambler_Imgr_bt0, outputscrambler_Real_bt1, outputscrambler_Imgr_bt1, outputscrambler_Real_bt2, outputscrambler_Imgr_bt2,
outputscrambler_Real_bt3, outputscrambler_Imgr_bt3, outputscrambler_Real_bt4, outputscrambler_Imgr_bt4, outputscrambler_Real_bt5,
outputscrambler_Imgr_bt5, outputscrambler_Real_bt6, outputscrambler_Imgr_bt6,outputscrambler_Real_bt7, outputscrambler_Imgr_bt7,
outputbutterfly_Real_bt0, outputbutterfly_Imgr_bt0, outputbutterfly_Real_bt1, outputbutterfly_Imgr_bt1, outputbutterfly_Real_bt2,
outputbutterfly_Imgr_bt2,outputbutterfly_Real_bt3, outputbutterfly_Imgr_bt3, outputbutterfly_Real_bt4, outputbutterfly_Imgr_bt4,
outputbutterfly_Real_bt5, outputbutterfly_Imgr_bt5, outputbutterfly_Real_bt6, outputbutterfly_Imgr_bt6,outputbutterfly_Real_bt7,
outputbutterfly_Imgr_bt7);

initial begin
   $dumpfile ("FFTFourButterfly.vcd");
   $dumpvars (0);

	clk = 1'b0;
	reset = 1'b0;

	//counter = 1'b0;
	forever	#1 clk = ~clk;
 $finish;
end

initial
	begin

		$display("STATEMENT 1 :: time is %0t",$time);

		repeat(10)@(posedge clk)
		begin
			reset = 1'b1;

			outputscrambler_Real_bt0 = 	28'b0000_0011_0000_0000_0000_0000_0000;  // Input  1.5 ; 7.21 format
			outputscrambler_Imgr_bt0 = 	28'b0000_0011_0000_0000_0000_0000_0000; //Input  j1.5

			outputscrambler_Real_bt1 = 	28'b0000_0011_0000_0000_0000_0000_0000;  // Input  1.5 ; 7.21 format
			outputscrambler_Imgr_bt1 = 	28'b0000_0011_0000_0000_0000_0000_0000; //Input  j1.5

			outputscrambler_Real_bt2 = 	28'b0000_0010_0000_0000_0000_0000_0000; //Input  1
			outputscrambler_Imgr_bt2 = 	28'b0000_0010_0000_0000_0000_0000_0000; //Input  j1

			outputscrambler_Real_bt3 = 	28'b0000_0010_0000_0000_0000_0000_0000; //Input  1
			outputscrambler_Imgr_bt3 = 	28'b0000_0010_0000_0000_0000_0000_0000; //Input  j1

			outputscrambler_Real_bt4 = 	28'b0000_0011_0000_0000_0000_0000_0000;  // Input  1.5 ; 7.21 format
			outputscrambler_Imgr_bt4 = 	28'b0000_0011_0000_0000_0000_0000_0000; //Input  j1.5

			outputscrambler_Real_bt5 = 	28'b0000_0011_0000_0000_0000_0000_0000;  // Input  1.5 ; 7.21 format
			outputscrambler_Imgr_bt5 = 	28'b0000_0011_0000_0000_0000_0000_0000; //Input  j1.5

			outputscrambler_Real_bt6 = 	28'b0000_0010_0000_0000_0000_0000_0000; //Input  1
			outputscrambler_Imgr_bt6 = 	28'b0000_0010_0000_0000_0000_0000_0000; //Input  j1

			outputscrambler_Real_bt7 = 	28'b0000_0010_0000_0000_0000_0000_0000; //Input  1
			outputscrambler_Imgr_bt7 = 	28'b0000_0010_0000_0000_0000_0000_0000; //Input  j1


			WR_bt1 = 28'b0000_000_0_0100_0000_0000_0000_0000; //Twiddle is 0.5
			WI_bt1 = 28'b0000_000_1_0000_0000_0000_0000_0000; //Twiddle is 0.5
			WR_bt3 = 28'b0000_000_0_0100_0000_0000_0000_0000; //Twiddle is 0.5
			WI_bt3 = 28'b0000_000_1_0000_0000_0000_0000_0000; //Twiddle is 0.5
			WR_bt5 = 28'b0000_000_0_0100_0000_0000_0000_0000; //Twiddle is 0.5
			WI_bt5 = 28'b0000_000_1_0000_0000_0000_0000_0000; //Twiddle is 0.5
			WR_bt7 = 28'b0000_000_0_0100_0000_0000_0000_0000; //Twiddle is 0.5
			WI_bt7 = 28'b0000_000_1_0000_0000_0000_0000_0000; //Twiddle is 0.5

		end
	$finish;
end



endmodule
*/
