#ifndef __FFT_H__
#define __FFT_H__
#include <systemc.h>

const unsigned int c_uiIntBits = 32;
const unsigned int c_uiFFTLength = 16; 

class FFT_DIF_rtl: public sc_module
{
public:
    FFT_DIF_rtl(sc_module_name mName);
    ~FFT_DIF_rtl();

    sc_in<float> realIn;
    sc_in<float> imagIn;

    sc_out<float> realOut;
    sc_out<float> imagOut;
    
    sc_in<bool> inverse;
	sc_in<bool> data_valid;
	sc_in<bool> data_ack;
	sc_in<bool> reset;
	sc_in_clk   CLK; 
	
	sc_out<bool> data_ready;
	sc_out<bool> data_req;	
    

private:

    void calculate();

    void ReadSamples();

    void OutputResults();

    int BitLength( unsigned int uiValue );  

    sc_uint< c_uiIntBits > BitReverse( const unsigned int uiValue, const int iBitLength );  
    
    sc_event eDataReady;

    float* m_sampleRealrd;
    float* m_sampleImagrd;
    float* m_sampleRealwr;
    float* m_sampleImagwr;      

    unsigned int m_uiCurLength;
    unsigned int m_uiIndexOut;
    bool m_bInverse; 
	bool m_bOutPending;  	
    
};

#endif //__FFT_H__