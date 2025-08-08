#include "InterFPGA_cali.h"

void InterFPGA_cali(hls::stream<complex_in_t>& InFromUpFPGA,
					hls::stream<complex_in_t>& InFromLocalFPGA,
					hls::stream<complex_in_t>& OutToDownFPGA,
					complex_in_t ImbalanceOut[NUMFREQSAMPLES],
					ap_uint<1> IsSourceFPGA,
					ap_uint<1> IsEndFPGA)
{

	//hls::stream<complex_in_t> UpFPGADataFIFO;
	//hls::stream<complex_in_t> LocalFPGADataFIFO;
	complex_in_t UpFPGADataFIFO[NUMFORAVERAGE];
	complex_in_t LocalFPGADataFIFO[NUMFORAVERAGE];

	complex_in_t UpFPGADataTmp;
	complex_in_t LocalFPGADataTmp;
	complex_tmp_t acctmp;
	static ap_uint<LOG2_NUMFREQSAMPLES> FreqSampleIndex = 0;

	for1:for(int i=0; i<NUMFORAVERAGE; i++)
	{
		LocalFPGADataTmp = InFromLocalFPGA.read();
		LocalFPGADataFIFO[i] = LocalFPGADataTmp;
	}

	if(IsSourceFPGA == 0)
	{
		for2:for(int i=0; i<NUMFORAVERAGE; i++)
		{
			UpFPGADataTmp = InFromUpFPGA.read();
			//UpFPGADataFIFO.write(UpFPGADataTmp);
			UpFPGADataFIFO[i] = UpFPGADataTmp;
		}
	}

	if(IsEndFPGA == 0)
	{
		for3:for(int i=0; i<NUMFORAVERAGE; i++)
		{
			if(IsSourceFPGA == 0)
			{
				OutToDownFPGA.write(UpFPGADataFIFO[i]);
			}
			else
			{
				OutToDownFPGA.write(LocalFPGADataFIFO[i]);
			}
		}
	}

	if(IsSourceFPGA == 0)
	{
		acctmp.real = 0;
		acctmp.imag = 0;

		for4:for(int i=0; i<NUMFORAVERAGE; i++)
		{
			LocalFPGADataTmp = LocalFPGADataFIFO[i];
			//UpFPGADataTmp = UpFPGADataFIFO.read();
			UpFPGADataTmp = UpFPGADataFIFO[i];

			//OutToDownFPGA.write(UpFPGADataTmp);

			acctmp.real += (UpFPGADataTmp.real*LocalFPGADataTmp.real + UpFPGADataTmp.imag*LocalFPGADataTmp.imag) / (LocalFPGADataTmp.real*LocalFPGADataTmp.real + LocalFPGADataTmp.imag*LocalFPGADataTmp.imag);
			acctmp.imag += (UpFPGADataTmp.imag*LocalFPGADataTmp.real - UpFPGADataTmp.real*LocalFPGADataTmp.imag) / (LocalFPGADataTmp.real*LocalFPGADataTmp.real + LocalFPGADataTmp.imag*LocalFPGADataTmp.imag);
		}

		ImbalanceOut[FreqSampleIndex].real = (datain_t)(acctmp.real >> LOG2_NUMFORAVERAGE);
		ImbalanceOut[FreqSampleIndex].imag = (datain_t)(acctmp.imag >> LOG2_NUMFORAVERAGE);
	}
	else
	{
		ImbalanceOut[FreqSampleIndex].real = 0.0;
		ImbalanceOut[FreqSampleIndex].imag = 0.0;
	}

	FreqSampleIndex++;
}
