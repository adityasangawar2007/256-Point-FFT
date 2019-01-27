module input_mux(
                    input [2:0] stg_cnt,
                    input [55:0] scr_in0, scr_in1, scr_in2, scr_in3, scr_in4, scr_in5, scr_in6, scr_in7, //input from scrambler
                    input [55:0] db_in0, db_in1, db_in2, db_in3, db_in4, db_in5, db_in6, db_in7, // input from databuffer
                    output [55:0] out_0, out_1, out_2, out_3, out_4, out_5, out_6, out_7
                );

assign out_0 = (stg_cnt == 3'b0) ? scr_in0 : db_in0;
assign out_1 = (stg_cnt == 3'b0) ? scr_in1 : db_in1;
assign out_2 = (stg_cnt == 3'b0) ? scr_in2 : db_in2;
assign out_3 = (stg_cnt == 3'b0) ? scr_in3 : db_in3;
assign out_4 = (stg_cnt == 3'b0) ? scr_in4 : db_in4;
assign out_5 = (stg_cnt == 3'b0) ? scr_in5 : db_in5;
assign out_6 = (stg_cnt == 3'b0) ? scr_in6 : db_in6;
assign out_7 = (stg_cnt == 3'b0) ? scr_in7 : db_in7;

endmodule