// Copyright 2011 - 2014 Keysight Technologies, Inc   

#pragma once
#include "systemc.h"

namespace SystemVueModelBuilder
{
    template< typename DT >
    class SystemC_NoiseChannel: public sc_module 
    {
    public:
	    //default constructor
	    SystemC_NoiseChannel( sc_module_name mName, unsigned Deviation, double Offset )
            :m_dOffset(Offset),
            m_uDeviation(Deviation)
        {    
	        SC_HAS_PROCESS(SystemC_NoiseChannel);
                        
            m_precPower = InitializeSeed( m_uDeviation );

            SC_METHOD(AddNoise);
            sensitive << clkIn.pos();
            dont_initialize();
        }

	    //destructor
        ~SystemC_NoiseChannel(){};
	
		sc_in_clk	clkIn;
	    sc_in< DT >	signalIn;
	    sc_out< DT > signalOut;	

	
    private:	
	
        void AddNoise()
        {     
            double dValue = RandomValue( m_uDeviation, m_precPower, m_dOffset );
            double dOutValue = signalIn.read() + dValue;
            signalOut.write( dOutValue );
        }

    private:	
        unsigned m_uDeviation; 
        int m_precPower;
        double m_dOffset;
    };


    extern int InitializeSeed( unsigned iDeviation );
    extern double RandomValue( unsigned uDeviation, int iPrecPower, double dOffset );
}