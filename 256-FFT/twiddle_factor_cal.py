from __future__ import division
import math
import time
import struct
import os

def fft_CT_twiddles(x, inverse = False, verbose = False, twiddles = None) :
    """
    Computes the DFT of x using Cooley-Tukey's FFT algorithm. Twiddle factors
    are precalculated in the first function call, then passed down recursively.
    """
    t = time.clock()
    N = x
    #N = len(x)
    inv = -1 if not inverse else 1
    if N % 2 :
        return dft(x, inverse, False)
    M = N // 2
    if not twiddles :
        #twiddles = [math.e**(inv*2j*math.pi*k/N) for k in xrange(M)]+[N]
        #twiddles = [math.e**(inv*2j*math.pi*k/N) for k in xrange(M)]
        twiddles = [(math.cos(2*math.pi*k/N)+1j*math.sin(2*math.pi*k/N)) for k in xrange(M)]
	return twiddles

def binary(num):
    return ''.join(bin(ord(c)).replace('0b', '').rjust(8, '0') for c in struct.pack('!f', num))

x = 256
twiddles = fft_CT_twiddles(x)
print len(twiddles)
file = open("twiddle.dat","w")
for e in twiddles:
	#print (e, e.real, e.imag)
	#print (e, binary(e.real), binary(e.imag))
	if e.real == -1.0 or e.real == 1.0:
		realbit = '1'
	else:
		realbit = '0'
	if e.imag == 1.0 or e.imag == -1.0:
		imagbit = '1'
	else:
		imagbit = '0'

	bin_real = binary(e.real)[0] + realbit + binary(e.real)[9:29]
	bin_imag = binary(e.imag)[0] + imagbit + binary(e.imag)[9:29]

	print (e, bin_real, bin_imag, len(bin_imag))
	#print (e, , bin_imag, len(bin_imag))
	file.write(bin_real + '\n')
	file.write(bin_imag + '\n')

file.close()
