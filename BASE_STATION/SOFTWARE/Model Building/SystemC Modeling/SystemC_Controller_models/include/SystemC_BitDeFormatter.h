// Copyright 2011 - 2014 Keysight Technologies, Inc   
#pragma once
#include "systemc.h"

namespace SystemVueModelBuilder
{    
    class SystemC_BitDeFormatter: public sc_module 
    {
    public:
        enum EnuFormat{ NRZ, RZ };
    public:
	    //default constructor
	    SystemC_BitDeFormatter( sc_module_name mName, EnuFormat Format = NRZ, double LogicZeroVoltage = -1.0, double LogicOneVoltage = 1.0 );

	    //destructor
        ~SystemC_BitDeFormatter(){};
	    
        sc_in_clk           clkIn;
	    sc_in< double >	signalIn;
	    sc_out< sc_logic >    signalOut;	

	
    private:	
	
        void Decode();

    private:	       
        sc_logic m_OverThresholdBit;
        sc_logic m_UnderThresholdBit;
        sc_logic m_LastValidBit;
        double m_dThresholdValue; // for NRZ
        double m_dThresholdHignValue; // for RZ
        double m_dThresholdLowValue; // for RZ
        EnuFormat m_eFormat;
    };

}