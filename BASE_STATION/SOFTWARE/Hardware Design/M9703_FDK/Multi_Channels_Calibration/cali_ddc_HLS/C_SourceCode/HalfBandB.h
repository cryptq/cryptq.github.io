#ifndef _HALFBANDB_
#define _HALFBANDB_

#include "data_type.h"

#define HALFBANDB_COEFNUM 7
const coef_t coefB[HALFBANDB_COEFNUM] = {-0.0008, 0.0041, -0.0135, 0.0351, -0.0861, 0.3111, 0.5000};

#define HALFBANDB_IN_SIZE 4
#define HALFBANDB_FIR_LEN ((HALFBANDB_COEFNUM-2)*4+3)
#define HALFBANDB_OUT_SIZE (HALFBANDB_IN_SIZE/2)
#define HALFBANDB_REG_BANKS ((HALFBANDB_FIR_LEN-1)/HALFBANDB_IN_SIZE+2)

void HalfBandB(complex_tmp_t input[HALFBANDB_IN_SIZE], complex_tmp_t output[HALFBANDB_OUT_SIZE]);

#endif
