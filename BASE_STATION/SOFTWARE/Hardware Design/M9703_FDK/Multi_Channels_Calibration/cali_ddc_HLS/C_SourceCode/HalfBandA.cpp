// Modification : include the header file static.h

#include "HalfBandA.h"


void HalfBandA(complex_tmp_t input[HALFBANDA_IN_SIZE], complex_tmp_t output[HALFBANDA_OUT_SIZE])
{
	// Modification : redefine static variable for SV model builder
	static complex_tmp_t reg[HALFBANDA_IN_SIZE*HALFBANDA_REG_BANKS];

	complex_tmp_t outTmp[HALFBANDA_OUT_SIZE];

	for (int i = 0; i < HALFBANDA_OUT_SIZE; i++)
	{
		outTmp[i].real = 0;
		outTmp[i].imag = 0;
	}

	for (int i = 0; i < HALFBANDA_IN_SIZE; i++)
	{
		for (int j = HALFBANDA_REG_BANKS - 2; j >= 0; j--)
		{
			reg[i+HALFBANDA_IN_SIZE*(j+1)] = reg[i+HALFBANDA_IN_SIZE*j];
		}
		reg[i] = input[HALFBANDA_IN_SIZE - 1 - i];
	}


	for (int i = 0; i < HALFBANDA_OUT_SIZE; i++)
	{
		for (int j = 0; j < HALFBANDA_FIR_LEN/4+1; j++)
		{
			outTmp[i].real += (reg[((i+j)<<1)+1].real + reg[HALFBANDA_FIR_LEN+((i-j)<<1)].real) * coefA[j];
			outTmp[i].imag += (reg[((i+j)<<1)+1].imag + reg[HALFBANDA_FIR_LEN+((i-j)<<1)].imag) * coefA[j];
		}
		outTmp[i].real += reg[(i<<1)+HALFBANDA_FIR_LEN/2+1].real * coefA[HALFBANDA_FIR_LEN/4+1];
		outTmp[i].imag += reg[(i<<1)+HALFBANDA_FIR_LEN/2+1].imag * coefA[HALFBANDA_FIR_LEN/4+1];
	}

	for (int i = 0; i < HALFBANDA_OUT_SIZE; i++)
	{
		output[i] = outTmp[HALFBANDA_OUT_SIZE - 1 - i];
	}
}
