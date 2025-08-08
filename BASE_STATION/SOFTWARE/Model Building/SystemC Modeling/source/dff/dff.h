#pragma once
#include <systemc.h>

template <  int wl = 32, 
            bool bSigned = true, 
            int iStartValue = -1786355 >
class DFF : public sc_module
{
public:
    sc_in   < sc_logic  > clk;
    sc_in   < sc_logic  > en;
    sc_in   < sc_lv< wl > > in1;
    sc_out  < sc_lv< wl > > out1;

    void run();
  
    SC_HAS_PROCESS(DFF);
    DFF(sc_module_name moduleName) :
        sc_module(moduleName)
    {
        out1.initialize( static_cast< sc_lv< wl > >(iStartValue).range( wl - 1, 0 ) );

        SC_METHOD(run);
        sensitive << clk.value_changed() << en.value_changed();
    }
};

template < int wl, 
           bool bSigned, 
           int iStartValue >
void DFF< wl, bSigned, iStartValue >::run()
{  
    if( en.read() == SC_LOGIC_1 )
    {
        if ( clk.event() && ( clk.read() == SC_LOGIC_1 ) )
        {
            out1 = in1.read(); 
        }
    }    
}