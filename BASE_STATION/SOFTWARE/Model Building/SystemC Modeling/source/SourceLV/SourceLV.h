//**************************************************************************//
//** SourceLV 
//**************************************************************************//
#include "systemc.h"

template< size_t SIZE >
class SourceLV: public sc_module
{
public:

    SourceLV(sc_module_name mName, std::string sLogicVector, double dTimeStep);
    ~SourceLV();	
    
    sc_out<sc_lv<SIZE> >            dataOut;
	
    
private:

    void ToLogic();     

    sc_lv<SIZE>	lvDataOut;	    
    std::string m_sLogicVector;
    sc_time tTimeStep;
    sc_event    evRun;
};


template< size_t SIZE >
SourceLV<SIZE>::SourceLV(sc_module_name mName, std::string sLogicVector, double dTimeStep):
    sc_module( mName ),    
    m_sLogicVector( sLogicVector ),
    tTimeStep( sc_time(dTimeStep,SC_SEC) )
{	
	
	lvDataOut = sLogicVector.data();
	
    SC_HAS_PROCESS(SourceLV);
    SC_METHOD( ToLogic );
	sensitive << evRun;  
	
}

template< size_t SIZE >
SourceLV<SIZE>::~SourceLV()
{
    	
}

template< size_t SIZE >
void SourceLV<SIZE>::ToLogic()
{        
    lvDataOut = lvDataOut.lrotate(1);     
    dataOut = lvDataOut;    
    evRun.notify( tTimeStep );
}