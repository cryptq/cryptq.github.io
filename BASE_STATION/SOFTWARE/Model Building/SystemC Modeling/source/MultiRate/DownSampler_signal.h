//**************************************************************************//
//** Class DownSampler - 
//**************************************************************************//
#pragma once
#include "systemc.h"

template< typename T >
class DownSampler: public sc_module
{
public:

    DownSampler(sc_module_name mName, size_t iFactor, size_t iPhase);
    ~DownSampler();
	
    sc_in< T >     input;		
    sc_out< T >    output;
	
    
private:

    void DownSampling();    
	
	size_t	m_iFactor;
    size_t	m_iPhase;
	size_t  m_iSamplesRead;

};

template<typename T>
DownSampler<T>::DownSampler(sc_module_name mName, size_t iFactor, size_t iPhase):
    sc_module( mName ),
	m_iFactor(iFactor),
    m_iPhase(iPhase),
	m_iSamplesRead(0)	
{	
    m_iPhase =  m_iPhase % m_iFactor;   // phase should be in the range [ 0, Factor - 1 ]

	SC_HAS_PROCESS(DownSampler);
    SC_METHOD( DownSampling );
    sensitive << input;	
    //dont_initialize();
}

template<typename T>
DownSampler<T>::~DownSampler()
{
    
}

template<typename T>
void DownSampler<T>::DownSampling()
{
    T tempInput = input.read();
	m_iSamplesRead++;

	if( m_iSamplesRead == (m_iPhase + 1) ) 	
		output.write( tempInput );	
	
    if( m_iSamplesRead == m_iFactor )
            m_iSamplesRead = 0;
}
