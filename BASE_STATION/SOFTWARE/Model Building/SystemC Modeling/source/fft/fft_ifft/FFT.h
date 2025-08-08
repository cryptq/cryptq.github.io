// Copyright 2011 - 2014 Keysight Technologies, Inc
#pragma once
#include <systemc.h>
#include <complex>

const unsigned int c_uiIntBits = 32;
typedef enum {FFT , IFFT} TranformType_t;

class FFTnumeric: public sc_module
{
public:
    FFTnumeric(sc_module_name mName, const unsigned int c_uiFFTLength, const TranformType_t c_bInverse);
    ~FFTnumeric();

    sc_fifo_in<std::complex<double> > complexIn;   
    sc_fifo_out<std::complex<double> > complexOut; 	

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