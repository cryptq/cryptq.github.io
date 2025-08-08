#include "SystemC_BitFormatter.h"

namespace SystemVueModelBuilder
{

    SystemC_BitFormatter::SystemC_BitFormatter(sc_module_name mName, EnuFormat Format, double LogicZeroVoltage, double LogicOneVoltage)
        :m_eFormat(Format),
        m_dLogicZeroVoltage(LogicZeroVoltage),
        m_dLogicOneVoltage(LogicOneVoltage)
    {
        SC_HAS_PROCESS(SystemC_BitFormatter);

        SC_METHOD(Encode);
        sensitive << clkIn;
    }

    void SystemC_BitFormatter::Encode()
    {
        sc_logic lCurrentBitValue = signalIn.read();

        if (lCurrentBitValue == SC_LOGIC_X || lCurrentBitValue == SC_LOGIC_Z)
        {
            signalOut.write(0);
            return;
        }


        if (m_eFormat == NRZ)
        {
            if (lCurrentBitValue == SC_LOGIC_1)
                signalOut.write(m_dLogicOneVoltage);
            else
                signalOut.write(m_dLogicZeroVoltage);
            next_trigger(signalIn.value_changed_event());
        }
        else // RZ
        {
            if (clkIn.read())
            {
                if (lCurrentBitValue == SC_LOGIC_1)
                    signalOut.write(m_dLogicOneVoltage);
                else
                    signalOut.write(m_dLogicZeroVoltage);
            }
            else
            {
                signalOut.write(0);
            }
        }
    }
}