// Modification : include the header file static.h

#include "HalfBandC.h"


void HalfBandC(complex_tmp_t input[HALFBANDC_IN_SIZE], complex_tmp_t output[HALFBANDC_OUT_SIZE])
{
	// Modification : redefine static variable for SV model builder
	static complex_tmp_t reg[HALFBANDC_IN_SIZE*HALFBANDC_REG_BANKS];

	complex_tmp_t outTmp[HALFBANDC_OUT_SIZE];

	for (int i = 0; i < HALFBANDC_OUT_SIZE; i++)
	{
		outTmp[i].real = 0;
		outTmp[i].imag = 0;
	}

	for (int i = 0; i < HALFBANDC_IN_SIZE; i++)
	{
		for (int j = HALFBANDC_REG_BANKS - 2; j >= 0; j--)
		{
			reg[i+HALFBANDC_IN_SIZE*(j+1)] = reg[i+HALFBANDC_IN_SIZE*j];
		}
		reg[i] = input[HALFBANDC_IN_SIZE - 1 - i];
	}


	for (int i = 0; i < HALFBANDC_OUT_SIZE; i++)
	{
		for (int j = 0; j < HALFBANDC_FIR_LEN/4+1; j++)
		{
			outTmp[i].real += (reg[((i+j)<<1)+1].real + reg[HALFBANDC_FIR_LEN+((i-j)<<1)].real) * coefC[j];
			outTmp[i].imag += (reg[((i+j)<<1)+1].imag + reg[HALFBANDC_FIR_LEN+((i-j)<<1)].imag) * coefC[j];
		}
		outTmp[i].real += reg[(i<<1)+HALFBANDC_FIR_LEN/2+1].real * coefC[HALFBANDC_FIR_LEN/4+1];
		outTmp[i].imag += reg[(i<<1)+HALFBANDC_FIR_LEN/2+1].imag * coefC[HALFBANDC_FIR_LEN/4+1];
	}

	for (int i = 0; i < HALFBANDC_OUT_SIZE; i++)
	{
		output[i] = outTmp[HALFBANDC_OUT_SIZE - 1 - i];
	}
}
