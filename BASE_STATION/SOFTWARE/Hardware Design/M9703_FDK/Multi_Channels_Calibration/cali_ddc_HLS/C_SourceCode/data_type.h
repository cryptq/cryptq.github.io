#ifndef _DATA_TYPE_
#define _DATA_TYPE_

#include "ap_fixed.h"

typedef ap_fixed<16, 1, AP_RND, AP_WRAP> data_t;
typedef ap_fixed<25, 2, AP_TRN, AP_WRAP> coef_t;
typedef ap_fixed<20, 4, AP_RND, AP_WRAP> accReg_t;
typedef ap_fixed<19, 3, AP_RND, AP_WRAP> data_tmp_t;
typedef ap_fixed<18, 4, AP_RND, AP_WRAP> data_out_t;
typedef ap_fixed<16, 2, AP_TRN, AP_WRAP> reconfig_coef_t;
typedef ap_uint<1> logic_bit;

#define PHASE_ACC_WIDTH 32
typedef ap_ufixed<PHASE_ACC_WIDTH, 0, AP_TRN, AP_WRAP> phase_t;

struct complex_t{
	data_t real;
	data_t imag;
};

struct complex_tmp_t{
	data_tmp_t real;
	data_tmp_t imag;
};

struct complex_acc_t{
	accReg_t real;
	accReg_t imag;
};

struct complex_reconfig_coef_t{
	reconfig_coef_t real;
	reconfig_coef_t imag;
};

struct complex_out_t{
	data_out_t real;
	data_out_t imag;
};

#endif
