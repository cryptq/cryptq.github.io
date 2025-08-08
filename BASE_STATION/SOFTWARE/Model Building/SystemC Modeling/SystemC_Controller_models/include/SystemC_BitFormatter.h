// Copyright 2011 - 2014 Keysight Technologies, Inc   
#pragma once
#include "systemc.h"

namespace SystemVueModelBuilder
{    
    class SystemC_BitFormatter: public sc_module 
    {
    public:
        enum EnuFormat{ NRZ, RZ };
    public:
	    //default constructor
	    SystemC_BitFormatter( sc_module_name mName, EnuFormat Format = NRZ, double LogicZeroVoltage = -1., double LogicOneVoltage = 1. );

	    //destructor
        ~SystemC_BitFormatter(){};
	    
        sc_in_clk           clkIn;
	    sc_in< sc_logic >	signalIn;
	    sc_out< double >    signalOut;	

	
    private:	
	
        void Encode();

    private:	        
        double m_dLogicOneVoltage;
        double m_dLogicZeroVoltage;
        EnuFormat m_eFormat;
    };

}