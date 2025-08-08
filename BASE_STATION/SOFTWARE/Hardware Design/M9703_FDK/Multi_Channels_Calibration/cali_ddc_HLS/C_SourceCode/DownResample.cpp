#include "DownResample.h"

void DownResample(data_t input[DOWN_RESAMPLE_IN_SIZE], 
	complex_out_t output[DOWN_RESAMPLE_OUT_SIZE],
	phase_t DDC_freq_norm[DDC_IN_SIZE],
	complex_reconfig_coef_t reconfigcoef[RECONFIG_FIR_LEN])
{
#pragma HLS data_pack variable=output
	complex_tmp_t DDC_dout[DDC_IN_SIZE];

#if (HALFBANDSTAGENUM==1)
	complex_tmp_t HalfBandA_dout[HALFBANDA_OUT_SIZE];

	DDC(input, DDC_dout, DDC_freq_norm);
	HalfBandA(DDC_dout, HalfBandA_dout);
	ReconfigFIR(HalfBandA_dout, output, reconfigcoef);
#endif

#if (HALFBANDSTAGENUM==2)
	complex_tmp_t HalfBandA_dout[HALFBANDA_OUT_SIZE];
	complex_tmp_t HalfBandB_dout[HALFBANDB_OUT_SIZE];

	DDC(input, DDC_dout, DDC_freq_norm);
	HalfBandA(DDC_dout, HalfBandA_dout);
	HalfBandB(HalfBandA_dout, HalfBandB_dout);
	ReconfigFIR(HalfBandB_dout, output, reconfigcoef);
#endif

#if (HALFBANDSTAGENUM==3)
	complex_tmp_t HalfBandA_dout[HALFBANDA_OUT_SIZE];
	complex_tmp_t HalfBandB_dout[HALFBANDB_OUT_SIZE];
	complex_tmp_t HalfBandC_dout[HALFBANDC_OUT_SIZE];

	DDC(input, DDC_dout, DDC_freq_norm);
	HalfBandA(DDC_dout, HalfBandA_dout);
	HalfBandB(HalfBandA_dout, HalfBandB_dout);
	HalfBandC(HalfBandB_dout, HalfBandC_dout);
	ReconfigFIR(HalfBandC_dout, output, reconfigcoef);
#endif
}

// ----------------------------------- DDC --------------------------------------------------------------
const coef_t sinT[TABLE_SIZE] = {
	#include "sin1024T.h"
};

const coef_t cosT[TABLE_SIZE] = {
	#include "cos1024T.h"
};

void DDC(data_t input[DDC_IN_SIZE], complex_tmp_t output[DDC_IN_SIZE], phase_t freq_norm[DDC_IN_SIZE])
{
	// Modification : redefine static variable for SV model builder
	static phase_t phaseAcc = 0;

	phase_t phaseCur[DDC_IN_SIZE];

	for (int i = 0; i < DDC_IN_SIZE; i++)
	{
		phaseCur[i] = phaseAcc + freq_norm[i];
	}


	for (int i = 0; i < DDC_IN_SIZE; i++)
	{
		ap_uint<TABLE_WIDTH> phaseIndex;
		phaseIndex = phaseCur[i].range(PHASE_ACC_WIDTH-1, PHASE_ACC_WIDTH-TABLE_WIDTH);

		output[i].real = input[i] * cosT[phaseIndex];
		output[i].imag = input[i] * sinT[phaseIndex];
	}

	phaseAcc += freq_norm[1] << DDC_IN_SIZE_WIDTH;
};
// --------------------------------------------------------------------------------------------------------------

// ----------------------------------- ReconfigFIR --------------------------------------------------------------
void ReconfigFIR(complex_tmp_t input[RECONFIG_IN_SIZE], complex_out_t output[RECONFIG_IN_SIZE], complex_reconfig_coef_t coef[RECONFIG_FIR_LEN])
{
	// Modification : redefine static variable for SV model builder
	//static complex_reconfig_coef_t coef_reg[RECONFIG_FIR_LEN];
	//static logic_bit coef_done = 0;
	static complex_tmp_t reg[RECONFIG_FIR_LEN+RECONFIG_IN_SIZE-1];

		complex_out_t outtmp[RECONFIG_IN_SIZE];
		for (int i = 0; i < RECONFIG_IN_SIZE; i++)
		{
			outtmp[i].real = 0;
			outtmp[i].imag = 0;
		}

		for(int i=1; i<RECONFIG_FIR_LEN; i++)
		{
			reg[RECONFIG_FIR_LEN+RECONFIG_IN_SIZE-1-i] = reg[RECONFIG_FIR_LEN-1-i];
		}

		for(int i=0; i<RECONFIG_IN_SIZE; i++)
		{
			reg[RECONFIG_IN_SIZE-1-i] = input[i];
		}

		for(int j=0; j< RECONFIG_IN_SIZE; j++)
		{
			for(int i=0; i<RECONFIG_FIR_LEN; i++)
			{
				outtmp[j].real += coef[i].real * reg[RECONFIG_FIR_LEN+RECONFIG_IN_SIZE-2-i-j].real - coef[i].imag * reg[RECONFIG_FIR_LEN+RECONFIG_IN_SIZE-2-i-j].imag;
				outtmp[j].imag += coef[i].real * reg[RECONFIG_FIR_LEN+RECONFIG_IN_SIZE-2-i-j].imag + coef[i].imag * reg[RECONFIG_FIR_LEN+RECONFIG_IN_SIZE-2-i-j].real;
			}
		}

		for(int i=0; i<RECONFIG_IN_SIZE; i++)
		{
			output[i] = outtmp[i];
		}

}
// --------------------------------------------------------------------------------------------------------------



