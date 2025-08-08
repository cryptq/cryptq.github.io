// Copyright 2011 - 2014 Keysight Technologies, Inc   
#pragma once
#include "SystemVue/ModelBuilder.h"
#include "SystemVue/TimedDFModel.h"
#include "SystemVue/TimedCircularBuffer.h"


class SineGenerator : public SystemVueModelBuilder::TimedDFModel
{
public:
	DECLARE_MODEL_INTERFACE( SineGenerator )

	virtual bool	Run();
	virtual bool	Setup();

	SystemVueModelBuilder::TimedCircularBuffer<double> output;

	double Amplitude;
	double Frequency;
	double Phase;
	double Offset;
	double SampleRate;
};