/*
 * CTLE_BPF.h
 * Created by SystemVue C++ Code Generator
 * Copyright © 2000-2010, Keysight Technologies, Inc.
 */

#pragma once

#include "SystemVue/ModelBuilder.h"
#include "SystemVue/Models/AMI/TimeResponseFIR.h"
//#include "TimeRespFIR.h"

class CTLE_BPF : public SystemVueModelBuilder::DFModel
{
public:
	DECLARE_MODEL_INTERFACE(CTLE_BPF)
	CTLE_BPF();
	~CTLE_BPF();

	bool Setup();
	bool Initialize();
	bool Run();
	bool Finalize();

	// input, rate=1
	double input;
	// output, rate=1
	double output;

	// Input signal sampling time interval
	double SampleInterval;

	// Type of data (0=Single ended, 1=Differential)
	int DataType;

	// Response type (0=impulse, 1=step)
	int ResponseType;

	// Number of repsonses in the DataArray
	int NumResponses;

	// Selected response in the DataArray
	int SelectedResponse;

	//enum PulseScalingTypeE
	//{
	//	eAuto,
	//	eRefVoltage
	//};
	//PulseScalingTypeE PulseScalingType;
	//double PulseRefV;
	//double FIR_TruncRatio;
	//enum WindowFIR_E
	//{
	//	eNoWindow,
	//	eYesWindow
	//};
	//WindowFIR_E WindowFIR;

	int size_BPF_impulse_file;

protected:
	// delete array parameters
	void DeleteArrayParameters();

	// SystemVueModelBuilder::TimeResponseFIR
	SystemVueModelBuilder::TimeResponseFIR S1;

	double *d_taps, *d_xbuffer;
	int i_numtaps;
	long long ll_xcount;
};

