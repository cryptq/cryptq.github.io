#ifndef __FFT_H__
#define __FFT_H__
#include <systemc.h>
#include <complex>

const unsigned int c_uiIntBits = 32;
typedef enum {FFT , IFFT} TranformType_t;

class FFT_param: public sc_module
{
public:
    FFT_param(sc_module_name mName, const unsigned int c_uiFFTLength, const TranformType_t c_bInverse);
    ~FFT_param();

    sc_in<float> realIn;
    sc_in<float> imagIn;

    sc_out<float> realOut;
    sc_out<float> imagOut;    

    sc_in_clk   CLK; 
    sc_in<bool> reset;

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

    unsigned int m_uiFFTLength;
    TranformType_t m_bInverse;

    unsigned int m_uiCurLength;
    unsigned int m_uiIndexOut;       
    
};



#endif //__FFT_H__