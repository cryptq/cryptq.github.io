#include "RemezLPF.h"

// Third party header
// It happens to be in C, if it were in C++ we wouldn't need "extern C" line
extern "C"
{
#include "remez.h"
}


#ifndef SV_CODE_GEN
DEFINE_MODEL_INTERFACE(RemezLPF)
{	
	ADD_MODEL_INPUT(input);
	ADD_MODEL_OUTPUT(output);
	SystemVueModelBuilder::DFParam paramOrder = ADD_MODEL_PARAMETER(Order);
	paramOrder.SetDefaultValue("3");
	SystemVueModelBuilder::DFParam paramPassFreq = ADD_MODEL_PARAMETER(PassFreq);
	paramPassFreq.SetDefaultValue("100e3");
	paramPassFreq.SetUnit(SystemVueModelBuilder::Units::FREQUENCY);
	SystemVueModelBuilder::DFParam paramStopFreq = ADD_MODEL_PARAMETER(StopFreq);
	paramStopFreq.SetDefaultValue("150e3");
	paramStopFreq.SetUnit(SystemVueModelBuilder::Units::FREQUENCY);
	return true;
}
#endif

RemezLPF::RemezLPF()
{
	h = nullptr;
}

RemezLPF::~RemezLPF()
{
	delete[] h;
}

bool RemezLPF::Setup()
{
	numtaps = Order + 1;

	if (numtaps > 1)
	{
		input.SetHistoryDepth(numtaps);
	}
	else
	{
		POST_ERROR("LPF Order must be a positive number.");
		return false;
	}

	return true;
}

bool RemezLPF::Initialize()
{
	double sr = input.GetSampleRate();

	delete[] h;

	h = new double[numtaps];

	const int numband = 2;
	double bands[numband * 2] = { 0.0, PassFreq / sr, StopFreq / sr, 0.5 };
	double des[numband] = { 1.0, 0.0 };
	double weight[numband] = { 1.0, 4.0 };

	// Call third party API
	if (!remez(h, numtaps, numband, bands, des, weight, BANDPASS))
	{
		POST_ERROR("Remez did not converge. Increasing the filter order may improve convergence.");
		return false;
	}

	return true;
}

bool RemezLPF::Run()
{
	double res = 0.0;

	for (int i = 0; i < numtaps; i++)
	{
		res += h[i] * input[i];
	}

	output[0] = res;

	return true;
}
