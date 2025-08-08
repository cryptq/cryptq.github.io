#pragma once
#include "SystemVue/ModelBuilder.h"
#include "SystemVue/TimedDFModel.h"
#include "SystemVue/TimedCircularBuffer.h"

class RemezLPF : public SystemVueModelBuilder::TimedDFModel
{
public:
	// This Macro is required for all classes derived from DFModel
	DECLARE_MODEL_INTERFACE( RemezLPF );

	RemezLPF();
	~RemezLPF();

	//-------- Function Overloads --------
	virtual bool	Setup();
	virtual bool	Initialize();
	virtual bool	Run();

	// Ports
	SystemVueModelBuilder::TimedCircularBuffer< double > input, output;
	
	// Parameter
	int Order;
	double PassFreq;
	double StopFreq;

private:
	// filter coefficients
	int numtaps;
	double *h;
};
