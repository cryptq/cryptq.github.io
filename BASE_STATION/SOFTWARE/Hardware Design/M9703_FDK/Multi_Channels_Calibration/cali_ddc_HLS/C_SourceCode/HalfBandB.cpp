// Modification : include the header file static.h

#include "HalfBandB.h"


void HalfBandB(complex_tmp_t input[HALFBANDB_IN_SIZE], complex_tmp_t output[HALFBANDB_OUT_SIZE])
{
	// Modification : redefine static variable for SV model builder

	static complex_tmp_t reg[HALFBANDB_IN_SIZE*HALFBANDB_REG_BANKS];

	complex_tmp_t outTmp[HALFBANDB_OUT_SIZE];

	for (int i = 0; i < HALFBANDB_OUT_SIZE; i++)
	{
		outTmp[i].real = 0;
		outTmp[i].imag = 0;
	}

	for (int i = 0; i < HALFBANDB_IN_SIZE; i++)
	{
		for (int j = HALFBANDB_REG_BANKS - 2; j >= 0; j--)
		{
			reg[i+HALFBANDB_IN_SIZE*(j+1)] = reg[i+HALFBANDB_IN_SIZE*j];
		}
		reg[i] = input[HALFBANDB_IN_SIZE - 1 - i];
	}

	for (int i = 0; i < HALFBANDB_OUT_SIZE; i++)
	{
		for (int j = 0; j < HALFBANDB_FIR_LEN/4+1; j++)
		{
			outTmp[i].real += (reg[((i+j)<<1)+1].real + reg[HALFBANDB_FIR_LEN+((i-j)<<1)].real) * coefB[j];
			outTmp[i].imag += (reg[((i+j)<<1)+1].imag + reg[HALFBANDB_FIR_LEN+((i-j)<<1)].imag) * coefB[j];
		}
		outTmp[i].real += reg[(i<<1)+HALFBANDB_FIR_LEN/2+1].real * coefB[HALFBANDB_FIR_LEN/4+1];
		outTmp[i].imag += reg[(i<<1)+HALFBANDB_FIR_LEN/2+1].imag * coefB[HALFBANDB_FIR_LEN/4+1];
	}

	for (int i = 0; i < HALFBANDB_OUT_SIZE; i++)
	{
		output[i] = outTmp[HALFBANDB_OUT_SIZE - 1 - i];
	}
}
