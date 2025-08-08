/*
 * CTLE_FIR.h
 * Created by SystemVue C++ Code Generator
 * Copyright © 2000-2010, Keysight Technologies, Inc.
 */

#pragma once

#include "SystemVue/ModelBuilder.h"
#include "SystemVue/Models/AMI/TimeResponseFIR.h"
//#include "TimeRespFIR.h"

class CTLE_FIR : public SystemVueModelBuilder::DFModel
{
public:
	DECLARE_MODEL_INTERFACE(CTLE_FIR)
	CTLE_FIR();
	~CTLE_FIR();

	bool Setup();
	bool Initialize();
	bool Run();
	bool Finalize();

	// input, rate=1
	double input;
	// input, rate=1
	double gain_control;
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

	int size_CTLE_impulse_file, size_CTLE_gain_file;

	double get_CTLE_impulse_file( int i, int j);
	double get_CTLE_gain_file( int j);

protected:
	// delete array parameters
	void DeleteArrayParameters();

	// SystemVueModelBuilder::TimeResponseFIR
	SystemVueModelBuilder::TimeResponseFIR S1;

	double *d_taps, *d_xbuffer;
	int i_numtaps;
	long long ll_xcount;
};

