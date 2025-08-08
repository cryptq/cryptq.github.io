#pragma once

#include "SystemVue/ModelBuilder.h"
#include "SystemVue/Models/SlidWinAvg.h"

class CTLE_Detection :	public SystemVueModelBuilder::DFModel
{
public:

	CTLE_Detection(void);
	~CTLE_Detection(void);

	bool Setup();
	bool Initialize();
	bool Run();
	bool Finalize();

	// inputs
	double input;
	// outputs
	double output;

	DECLARE_MODEL_INTERFACE(CTLE_Detection);

	// parameters
	int SamplesPerBit;
	int NumBitsToAvg;
	double TargetV;

private:

	void DeleteBuffers();

	// SystemVueModelBuilder::SlidWinAvg Sliding-Window Averager
	SystemVueModelBuilder::SlidWinAvg S6;

	// buffer from S6.output to S1.input
	double* m_pBuffer_S6_output;

	// buffer from M1.m_dOutput to S6.input
	double* m_pBuffer_To_S6_input;

	double pastOutput;

	int iCount;

};



