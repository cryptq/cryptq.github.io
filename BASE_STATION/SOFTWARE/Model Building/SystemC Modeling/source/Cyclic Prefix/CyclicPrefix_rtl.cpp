#include "systemc.h"
#include "CyclicPrefix_rtl.h"

SC_HAS_PROCESS(CyclicPrefix_rtl);

CyclicPrefix_rtl::CyclicPrefix_rtl(sc_module_name mName):
    sc_module( mName ),    
    uiCurrentSample( 0 ),
    bStartOutput( false )
{
    SC_METHOD( CalculateCP );
    sensitive << eRun;
    dont_initialize();

    SC_CTHREAD( IOHandler, clk.pos() );
    reset_signal_is(reset, true);  
	
	out_valid.initialize( false );
	ack.initialize( false );

    fSamples_imag = new float[ size_t( uiInSamples + uiCPLength ) ];
	fSamples_real = new float[ size_t( uiInSamples + uiCPLength ) ];
	memset( fSamples_imag, 0, size_t( uiInSamples + uiCPLength ) );
	memset( fSamples_real, 0, size_t( uiInSamples + uiCPLength ) );
}

CyclicPrefix_rtl::~CyclicPrefix_rtl()
{
    delete[] fSamples_imag;
    fSamples_imag = NULL;
	delete[] fSamples_real;
    fSamples_real = NULL;
}

void CyclicPrefix_rtl::CalculateCP()
{
    for(int i = 0; i < uiCPLength; i++)
    {
        fSamples_imag[i] = fSamples_imag[uiInSamples + i];
		fSamples_real[i] = fSamples_real[uiInSamples + i];
    }
}

void CyclicPrefix_rtl::IOHandler()
{
    if(reset)
    {
        memset( fSamples_imag, 0, size_t(uiInSamples + uiCPLength) );
		memset( fSamples_real, 0, size_t(uiInSamples + uiCPLength) );
        uiCurrentSample = 0;
        bStartOutput = false;
		out_valid.write( false );
		ack.write( false );  
        wait();
    }

    while(true)
    {
		out_valid.write( bStartOutput );
	
        if( !bStartOutput && valid.read() == true )
        {
            fSamples_imag[uiCurrentSample + uiCPLength] = samples_imag.read();
			fSamples_real[uiCurrentSample + uiCPLength] = samples_real.read();
			uiCurrentSample++;
			ack.write( true );
			do {wait();} while ( valid.read() == true );
			ack.write( false );           

            if( uiCurrentSample == uiInSamples )
            {   
                eRun.notify( SC_ZERO_TIME );
                uiCurrentSample = 0;
                bStartOutput = true;
            }
        }
        else if( bStartOutput )
        {
            result_imag.write( fSamples_imag[uiCurrentSample] );
			result_real.write( fSamples_real[uiCurrentSample] );
            uiCurrentSample++;			

            if( uiCurrentSample == ( uiInSamples + uiCPLength ) )
            {
                uiCurrentSample = 0;
                bStartOutput = false;				
            }
        }
		
        wait();		
    }
}

