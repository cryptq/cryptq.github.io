#include "ap_fixed.h"
#include "hls_stream.h"

#define NUMFREQSAMPLES 16
#define LOG2_NUMFREQSAMPLES 4
#define NUMFORAVERAGE 32
#define LOG2_NUMFORAVERAGE 5


typedef ap_fixed<18, 4, AP_TRN, AP_WRAP> datain_t;
typedef ap_fixed<18+LOG2_NUMFORAVERAGE, 4+LOG2_NUMFORAVERAGE, AP_TRN, AP_WRAP> datatmp_t;



struct complex_in_t{
	datain_t real;
	datain_t imag;
};

struct complex_tmp_t{
	datatmp_t real;
	datatmp_t imag;
};


void InterFPGA_cali(hls::stream<complex_in_t>& InFromUpFPGA,
					hls::stream<complex_in_t>& InFromLocalFPGA,
					hls::stream<complex_in_t>& OutToDownFPGA,
					complex_in_t ImbalanceOut[NUMFREQSAMPLES]);
