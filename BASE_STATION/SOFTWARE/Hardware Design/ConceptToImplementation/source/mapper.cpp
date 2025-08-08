// Copyright 2011 - 2014 Keysight Technologies, Inc   
#include "mapper.h"
#include <complex>

const std::complex<int> QAM_64[64] = 
{
	std::complex<int>(1, 1),	std::complex<int>(3, 1),	std::complex<int>(1, 3),	std::complex<int>(3, 3),	std::complex<int>(7, 1),	std::complex<int>(5, 1),	std::complex<int>(7, 3),	std::complex<int>(5, 3),
 //s5s4s3s2s1s0=000000				=000001						=000010					=000011						=000100						=000101						=000110								=000111
	std::complex<int>(1, 7),	std::complex<int>(3, 7),	std::complex<int>(1, 5),	std::complex<int>(3, 5),	std::complex<int>(7, 7),	std::complex<int>(5, 7),	std::complex<int>(7, 5),	std::complex<int>(5, 5),
 //s5s4s3s2s1s0=001000			=001001						=001010						=001011							=001100						=001101					=001110						=001111
	std::complex<int>(15, 1),	std::complex<int>(13, 1),	std::complex<int>(15, 3),	std::complex<int>(13, 3),	std::complex<int>(9, 1),	std::complex<int>(11, 1),	std::complex<int>(9, 3),	std::complex<int>(11, 3),
 //s5s4s3s2s1s0=010000		=010001							=010010						=010011						=010100					=010101							=010110						=010111
	std::complex<int>(15, 7),	std::complex<int>(13, 7),	std::complex<int>(15, 5),	std::complex<int>(13, 5),	std::complex<int>(9, 7),	std::complex<int>(11, 7),	std::complex<int>(9, 5),	std::complex<int>(11, 5),
 //s5s4s3s2s1s0=011000				=011001					=011010						=011011						=011100						=011101						=011110						=011111
	std::complex<int>(1, 15),	std::complex<int>(3, 15),	std::complex<int>(1, 13),	std::complex<int>(3, 13),	std::complex<int>(7, 15),	std::complex<int>(5, 15),	std::complex<int>(7, 13),	std::complex<int>(5, 13),
 //s5s4s3s2s1s0=100000				=100001					=100010						=100011						=100100						=100101						=100110						=100111
	std::complex<int>(1, 9),	std::complex<int>(3, 9),	std::complex<int>(1, 11),	std::complex<int>(3, 11),	std::complex<int>(7, 9),	std::complex<int>(5, 9),	std::complex<int>(7, 11),	std::complex<int>(5, 11),
 //s5s4s3s2s1s0=101000			=101001						=101010						=101011						=101100						=101101						=101110						=101111
	std::complex<int>(15, 15),	std::complex<int>(13, 15),	std::complex<int>(15, 13),	std::complex<int>(13, 13),	std::complex<int>(9, 15),	std::complex<int>(11, 15),	std::complex<int>(9, 13),	std::complex<int>(11, 13),
 //s5s4s3s2s1s0=110000			=110001						=110010						=110011						=110100						=110101						=110110							=110111
	std::complex<int>(15, 9),	std::complex<int>(13, 9),	std::complex<int>(15, 11),	std::complex<int>(13, 11),	std::complex<int>(9, 9),	std::complex<int>(11, 9),	std::complex<int>(9, 11),	std::complex<int>(11, 11)
 //s5s4s3s2s1s0=111000			=111001						=111010						=111011						=111100						=111101						=111110						=111111
};

#pragma design top
void Mapper(ac_int<6,false> *dataIn, ac_int<4,false> *realOut, ac_int<4,false> * imagOut)
{

    unsigned short index = *dataIn;
	*realOut = QAM_64[index].real();
	*imagOut = QAM_64[index].imag();
}
