#ifndef _DOWN_RESAMPLE_
#define _DOWN_RESAMPLE_

#include "data_type.h"
#include "HalfBandA.h"
#include "HalfBandB.h"
#include "HalfBandC.h"

// ********************************* Tunable parameters *************************************
// define how many stages of halfband filters are used in DDC filter chain. Valid Num: 1~3
#define HALFBANDSTAGENUM 3
// define the tap number of compensation FIR filter
#define RECONFIG_FIR_LEN 32
// ******************************************************************************************


#if (HALFBANDSTAGENUM==1)
	#define RECONFIG_IN_SIZE HALFBANDA_OUT_SIZE
	#define DOWN_RESAMPLE_OUT_SIZE HALFBANDA_OUT_SIZE
#endif

#if (HALFBANDSTAGENUM==2)
	#define RECONFIG_IN_SIZE HALFBANDB_OUT_SIZE
	#define DOWN_RESAMPLE_OUT_SIZE HALFBANDB_OUT_SIZE
#endif

#if (HALFBANDSTAGENUM==3)
	#define RECONFIG_IN_SIZE HALFBANDC_OUT_SIZE
	#define DOWN_RESAMPLE_OUT_SIZE HALFBANDC_OUT_SIZE
#endif


#define DDC_IN_SIZE 8
#define TABLE_SIZE 1024
#define DDC_IN_SIZE_WIDTH 3
#define TABLE_WIDTH 10
#define DOWN_RESAMPLE_IN_SIZE DDC_IN_SIZE

void DDC(data_t input[DDC_IN_SIZE], complex_tmp_t output[DDC_IN_SIZE], phase_t freq_norm[DDC_IN_SIZE]);
void ReconfigFIR(complex_tmp_t input[RECONFIG_IN_SIZE], complex_out_t output[RECONFIG_IN_SIZE], complex_reconfig_coef_t coef[RECONFIG_FIR_LEN]);
void DownResample(data_t input[DOWN_RESAMPLE_IN_SIZE], 
	complex_out_t output[DOWN_RESAMPLE_OUT_SIZE],
	phase_t DDC_freq_norm[DDC_IN_SIZE],
	complex_reconfig_coef_t reconfigcoef[RECONFIG_FIR_LEN]);

#endif
