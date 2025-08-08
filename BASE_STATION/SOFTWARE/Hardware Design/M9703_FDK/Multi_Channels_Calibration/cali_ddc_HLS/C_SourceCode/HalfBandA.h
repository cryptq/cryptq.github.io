#ifndef _HALFBANDA_
#define _HALFBANDA_

#include "data_type.h"


#define HALFBANDA_COEFNUM 4
const coef_t coefA[HALFBANDA_COEFNUM] = {0.0078, -0.0539, 0.2962, 0.5};

#define HALFBANDA_IN_SIZE 8
#define HALFBANDA_FIR_LEN ((HALFBANDA_COEFNUM-2)*4+3)
#define HALFBANDA_OUT_SIZE (HALFBANDA_IN_SIZE/2)
#define HALFBANDA_REG_BANKS ((HALFBANDA_FIR_LEN-1)/HALFBANDA_IN_SIZE+2)

void HalfBandA(complex_tmp_t input[HALFBANDA_IN_SIZE], complex_tmp_t output[HALFBANDA_OUT_SIZE]);

#endif
