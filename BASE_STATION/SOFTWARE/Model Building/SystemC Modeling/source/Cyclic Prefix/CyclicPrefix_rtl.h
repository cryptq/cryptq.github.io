//**************************************************************************//
//** Class CyclicPrefix_rtl - calculates the Cyclic Prefix of an input packet **//
//**************************************************************************//

class CyclicPrefix_rtl: public sc_module
{
public:

    CyclicPrefix_rtl(sc_module_name mName);
    ~CyclicPrefix_rtl();

	sc_in_clk       clk;
    sc_in<bool>     reset;
	sc_in<bool>		valid;
    sc_in<float>    samples_imag;
	sc_in<float>    samples_real;
    sc_out<float>   result_imag;
	sc_out<float>   result_real;
	sc_out<bool>	out_valid;
	sc_out<bool>	ack;
    
    
private:

    void CalculateCP();
    void IOHandler();     

    sc_event eRun;

    float*  fSamples_imag;
	float*  fSamples_real;

    static const unsigned int uiCPLength = 4;
    static const unsigned int uiInSamples = 16;

    unsigned int uiCurrentSample;
    bool bStartOutput;

};