#include "FFT_param.h"
#include "math.h"

SC_HAS_PROCESS(FFT_param);

FFT_param::FFT_param(sc_module_name mName, const unsigned int c_uiFFTLength, const TranformType_t c_bInverse):
    sc_module(mName), 
    m_uiFFTLength(c_uiFFTLength),
    m_bInverse(c_bInverse),
    m_uiCurLength(0),    
    m_sampleRealrd(NULL),
    m_sampleImagrd(NULL),
    m_sampleRealwr(NULL),
    m_sampleImagwr(NULL),    
    m_uiIndexOut(0)
{     
    
    SC_CTHREAD( ReadSamples, CLK.pos() );
    reset_signal_is( reset, true );

    SC_THREAD( OutputResults );
    sensitive << CLK.pos();  
    dont_initialize();

    m_sampleRealrd = new float[size_t(m_uiFFTLength)];
    m_sampleImagrd = new float[size_t(m_uiFFTLength)];
    m_sampleRealwr = new float[size_t(m_uiFFTLength)];
    m_sampleImagwr = new float[size_t(m_uiFFTLength)];
}


FFT_param::~FFT_param()
{
    if(m_sampleRealrd)
        delete[] m_sampleRealrd;
    if(m_sampleImagrd)
        delete[] m_sampleImagrd;
    if(m_sampleRealwr)
        delete[] m_sampleRealwr;
    if(m_sampleImagwr)
        delete[] m_sampleImagwr;
}


void FFT_param::calculate()
{   
    unsigned int index = 0;            
    unsigned int uiN = m_uiFFTLength;
    double* dWreal = new double[size_t( m_uiFFTLength / 2)];
    double* dWimag = new double[size_t( m_uiFFTLength / 2)];

    do{
        uiN = uiN / 2;            

        for (unsigned int i = 0; i < uiN; i++)
        {
            dWreal[i] = cos( i * 4.0 * atan(1.0) / uiN );
            dWimag[i] = -sin( i * 4.0 * atan(1.0) / uiN );
        }

        while( index < m_uiFFTLength )
        {
            float tempReal;
            float tempImag;

            m_sampleRealwr[index] = m_sampleRealrd[index] + m_sampleRealrd[index + uiN];
            m_sampleImagwr[index] = m_sampleImagrd[index] + m_sampleImagrd[index + uiN];

            tempReal = m_sampleRealrd[index] - m_sampleRealrd[index + uiN];
            tempImag = m_sampleImagrd[index] - m_sampleImagrd[index + uiN];                

            m_sampleRealwr[index + uiN] = ( tempReal * dWreal[index%uiN] ) - ( tempImag * dWimag[index%uiN] );
            m_sampleImagwr[index + uiN] = ( tempReal * dWimag[index%uiN] ) + ( tempImag * dWreal[index%uiN] );

            m_sampleRealrd[index] = m_sampleRealwr[index];
            m_sampleImagrd[index] = m_sampleImagwr[index];
            m_sampleRealrd[index + uiN] = m_sampleRealwr[index + uiN];
            m_sampleImagrd[index + uiN] = m_sampleImagwr[index + uiN];
                
            index++;
            if( index%uiN == 0 )
                index += uiN;
        }
        
        index = 0;
            
    }while( uiN != 1 );

    m_uiCurLength = 0;  
    m_uiIndexOut = 0;
    eDataReady.notify(SC_ZERO_TIME);    
}


void FFT_param::ReadSamples()
{
    if( reset )
    {     
        memset( m_sampleRealrd, 0, size_t(m_uiFFTLength) );
        memset( m_sampleImagrd, 0, size_t(m_uiFFTLength) );
        memset( m_sampleRealwr, 0, size_t(m_uiFFTLength) );
        memset( m_sampleImagwr, 0, size_t(m_uiFFTLength) );
        m_uiCurLength = 0;
        m_uiIndexOut = 0;               
        wait();
    }

    while(true)
    {
        m_sampleRealrd[m_uiCurLength] = realIn.read();

        if(m_bInverse)
            m_sampleImagrd[m_uiCurLength] = -imagIn.read();
        else
            m_sampleImagrd[m_uiCurLength] = imagIn.read();

        m_uiCurLength++;

        if( m_uiCurLength == m_uiFFTLength )
            calculate();

        wait();
    }
}


void FFT_param::OutputResults()
{
    int uiBits = BitLength( m_uiFFTLength );
    unsigned int index = 0;

    wait( eDataReady );

    while(true)
    {        
        index = BitReverse( m_uiIndexOut, uiBits );  

        if(m_bInverse)
        {
            m_sampleRealwr[index] = m_sampleRealwr[index] / m_uiFFTLength;
            m_sampleImagwr[index] = -m_sampleImagwr[index] / m_uiFFTLength;
        }

        realOut.write( m_sampleRealwr[index] );
        imagOut.write( m_sampleImagwr[index] ); 

        m_uiIndexOut++;  

        if( m_uiIndexOut != m_uiFFTLength )
            wait();       
        else
            wait( eDataReady );
    }
}


int FFT_param::BitLength( unsigned int uiValue )
{
    int iCounter = 0;

    while ( (uiValue % 2) == 0 )
    {
        uiValue = uiValue / 2;
        iCounter++;
    }
   
    if( uiValue != 1)
    {
        //uiValue is not a power of 2
        iCounter = -1;
    }

    return iCounter;
}


sc_uint<32> FFT_param::BitReverse( const unsigned int uiValue, const int iBitLength )
{
    sc_uint< c_uiIntBits > bits_i = 0;
    sc_uint< c_uiIntBits > bits_index = 0;

    bits_i = uiValue;         

    for(int k = 0; k < iBitLength; k++)
    {
        bits_index[iBitLength - 1 - k] = bits_i[k];
    }

    return bits_index;
}
