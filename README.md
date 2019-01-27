# 256-Point-Complex-FFT

The inputs are 20 bits of real, and 20 bits imaginary data. 
The binary point is 18 bits from the right. The inputs are ranged between -1 and +1.
The interface has a start signal, with the first input data point. This is followed by 255 samples of complex data.
An FFT and IFFT require a scaling factor. This is traditionally placed on the IFFT. This project places
the scaling (/256) on the FFT output. This implies that the range of the output will also be between -1 and +

The design calculation completes in 256 clocks to complete one FFT. 
The FFT has 8 layers of 128 butterfly operations. This is 1024 butterfly operations. 
To complete in time, there are 4 butterfly operations happening concurrently.
Each butterfly operation requires a complex multiply. The complex multiply requires 4 actual multiplies.

Design Limit - 
4 butterfly operations of 4 multipliers each.
The total design (outer level, and all included hierarchies) does not have more than 16 multiplies.
The design synthesizes and runs at the gate level at 300 MHz. (3.3ns cycle time)
