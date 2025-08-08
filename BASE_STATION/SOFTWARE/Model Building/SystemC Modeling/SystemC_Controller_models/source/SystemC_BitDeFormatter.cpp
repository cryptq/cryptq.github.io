#include "SystemC_BitDeFormatter.h"

namespace SystemVueModelBuilder
{

    SystemC_BitDeFormatter::SystemC_BitDeFormatter( sc_module_name mName, EnuFormat Format, double LogicZeroVoltage, double LogicOneVoltage )
        :m_eFormat(Format),
        m_LastValidBit(SC_LOGIC_1) // SC_LOGIC_1 in this case is the idle bus value
    {    
	    SC_HAS_PROCESS(SystemC_BitDeFormatter);

        m_dThresholdValue = (LogicOneVoltage - LogicZeroVoltage)/2.0 + LogicZeroVoltage;        

        if( LogicOneVoltage > LogicZeroVoltage )
        {
            m_dThresholdHignValue = (LogicOneVoltage - 0)/2.0;
            m_dThresholdLowValue = (LogicZeroVoltage - 0)/2.0;
            m_OverThresholdBit = SC_LOGIC_1;
            m_UnderThresholdBit = SC_LOGIC_0;
        }
        else
        {
            m_dThresholdHignValue = (LogicZeroVoltage - 0)/2.0;
            m_dThresholdLowValue = (LogicOneVoltage - 0)/2.0;
            m_OverThresholdBit = SC_LOGIC_0;
            m_UnderThresholdBit = SC_LOGIC_1;
        }

        SC_METHOD(Decode);            
        sensitive << clkIn;            
    }

    void SystemC_BitDeFormatter::Decode()
    {   
        double dCurrentBusValue = signalIn.read();

        if( m_eFormat == NRZ )
        {
            if( clkIn.read() )
            {
                if( dCurrentBusValue >= m_dThresholdValue )
                    signalOut.write( m_OverThresholdBit );
                else
                    signalOut.write( m_UnderThresholdBit );
            }      
        }
        else // RZ
        {
            next_trigger( signalIn.value_changed_event() );
            if( dCurrentBusValue >= m_dThresholdHignValue )
            {
                signalOut.write( m_OverThresholdBit );    
                m_LastValidBit = m_OverThresholdBit;
            }
            else if( dCurrentBusValue <= m_dThresholdLowValue )
            {
                signalOut.write( m_UnderThresholdBit );
                m_LastValidBit = m_UnderThresholdBit;
            }
            else
            {
                signalOut.write( m_LastValidBit );                
            }
        }
    }
}