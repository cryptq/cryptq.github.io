#pragma once

#include "SystemVue/ModelBuilder.h"

class CTLE_Control :	public SystemVueModelBuilder::DFModel
{
public:

	CTLE_Control(void);
	~CTLE_Control(void);

	bool Initialize();
	bool Run();
	bool Finalize();

	// inputs
	double DetV;
	// outputs
	int CTLE_Index;

	DECLARE_MODEL_INTERFACE(CTLE_Control);

	// parameters
	double BitRate;
	int SamplesPerBit;
	int NumBitsToAvg;
	double TargetV;
	double ThresholdV;
	int IndexInit;
	enum EnableEqE
	{
		eNoEq,
		eYesEq
	};
	EnableEqE EnableEq;

private:

	double sampleInterval;
	int iCount, iWindowSize, pastCTLEIndex;

};



