import math
import os

def cosFunc(n):
    pi = math.pi
    c = math.cos(2*pi*n/256)
    ans = int(c*(2**20))
    ansStr = str(ans)
    if ansStr == "6.42067621031e-11":
        return "0"
    else:
        return ansStr

def sinFunc(n):
    pi = math.pi
    c = -(math.sin(2*pi*n/256))
    ans = int(c*(2**20))
    ansStr = str(ans)
    if ansStr == "6.42067621031e-11":
        return "0"
    else:
        return ansStr

def twiddle():
    # twiddleReal = []
    # twiddleImag = []
    twiddles = []
    for i in range(0, 128):
        twiddles.append(cosFunc(i))
        twiddles.append(sinFunc(i))
        # twiddleReal.append(cosFunc(i))
        # twiddleImag.append(sinFunc(i))
    # return twiddleReal, twiddleImag
    return twiddles


def main():
    # twiddleReal, twiddleImag = twiddle()
    twiddles = twiddle()
    # print twiddleReal
    f = open("twiddle.dat", "w")
    for i in twiddles:
        f.write(hex(int(i) & (2**32-1)) + "\n")
        #f.write(hex(int(i) & (2**31))[2:] + '\n') #convert hex to binary then select lower 22 bits
    f.close()
#     f = open("twiddle.v", "w+")
#     f.write("""
# // This is the Twiddle factor lookup table file
#
# module twiddle(tw_re, tw_imag, stage, level);
#
# input [2:0] stage ;
# input [6:0] level;
# output reg [19:0] tw_re, tw_imag;
#
# always @(*)
# begin
#     case (stage) \n""")
#     for i in range(0,8):
#         j = 0
#         f.write("\t")
#         f.write(str(i)+": begin\n\t\tcase(level)")
#         while(j < 128):
#             f.write("\n\t\t"+str(j)+": begin\n\t\t\t")
#             f.write("tw_re = "+twiddleReal[j]+";")
#             f.write("\n\t\t\t")
#             f.write("tw_imag = "+twiddleImag[j]+";")
#             offset = 128/2**i
#             j = j + offset
#             f.write("\n\t\t\tend")
#         f.write("\n\t\tendcase")
#         f.write("\n\tend\n")
#     f.write("\tendcase\n")
#
#     f.write("""
# end
#
# endmodule""")
#
#     f.close()


if __name__ == "__main__":
    main()




##def write_design():
##    moduleName = "twiddle"
##    f = open("/home/012428767@SJSUAD.SJSU.EDU/Desktop/omkar/python/twiddle/twiddle.v", "w+")
##    f.write("""
##// This is the Twiddle factor lookup table file
##
##module """+moduleName)
##    f.write("""(clock, reset, );
##input [:] ;
##output [:] ;
##input clock, reset;
##
##always @(posedge(clock) or posedge(reset))
##begin
##    if(reset)
##    begin
##        case (twiddle_pstate) \n""")
##
##    f.write("""end
##    else
##    begin
##
##    end
##end
##
##endmodule""")
##    f.close()
