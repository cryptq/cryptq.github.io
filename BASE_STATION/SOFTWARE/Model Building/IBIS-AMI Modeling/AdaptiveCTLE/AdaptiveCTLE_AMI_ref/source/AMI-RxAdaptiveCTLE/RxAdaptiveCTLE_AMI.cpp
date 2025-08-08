/*
 * RxAdaptiveCTLE_AMI.cpp"
 * Created by SystemVue C++ Code Generator
 * Copyright © 2000-2014, Keysight Technologies, Inc.
 */

#include "RxAdaptiveCTLE_AMI.h"
#include "RxAdaptiveCTLE.h"
#include "SystemVue/Models/AMI/AmiParamParser.h"
#include <string>
#include <math.h>

class AMIContainer
{
public:
	RxAdaptiveCTLE cSystemVueModel;
	std::string sMessage;
	std::vector<double> vClockTimes;
	int iSamplesPerBit;
};

long AMI_Init( double *impulse_matrix, long row_size, long aggressors, double sample_interval, double bit_time, char *AMI_parameters_in, char **AMI_parameters_out, void **AMI_memory_handle, char **msg )
{
	//Instantiate AMIContainer that manages AMI memory
	AMIContainer* pContainer = new AMIContainer;

	//SystemVue code generation model
	RxAdaptiveCTLE* pSystemVueModel = &pContainer->cSystemVueModel;

	//AMI parameter parser
	SystemVueModelBuilder::AMI::ParamParser parser( AMI_parameters_in );

	//samples per bit = bit_time / sample_interval, assume divisible
	int iSamplesPerBit = (int)(bit_time / sample_interval + 0.5);
	pContainer->iSamplesPerBit = iSamplesPerBit;

	//set model parameters
	pSystemVueModel->BitTime = bit_time;
	pSystemVueModel->SamplesPerBit = iSamplesPerBit;
	if ( !parser.GetValue( pSystemVueModel->NumBitsToAvg, "RxAdaptiveCTLE.NumBitsToAvg" ) )
		pContainer->sMessage += "The IBIS-AMI model, RxAdaptiveCTLE, is unable to initialize the parameter NumBitsToAvg from the AMI_Init arguments.  The model will use the default setting. ";
	if ( !parser.GetValue( pSystemVueModel->TargetV, "RxAdaptiveCTLE.TargetV" ) )
		pContainer->sMessage += "The IBIS-AMI model, RxAdaptiveCTLE, is unable to initialize the parameter TargetV from the AMI_Init arguments.  The model will use the default setting. ";
	if ( !parser.GetValue( pSystemVueModel->ThresholdV, "RxAdaptiveCTLE.ThresholdV" ) )
		pContainer->sMessage += "The IBIS-AMI model, RxAdaptiveCTLE, is unable to initialize the parameter ThresholdV from the AMI_Init arguments.  The model will use the default setting. ";
	if ( !parser.GetValue( pSystemVueModel->CTLE_Init, "RxAdaptiveCTLE.CTLE_Init" ) )
		pContainer->sMessage += "The IBIS-AMI model, RxAdaptiveCTLE, is unable to initialize the parameter CTLE_Init from the AMI_Init arguments.  The model will use the default setting. ";
	if ( !parser.GetValue( pSystemVueModel->EnableAdaption, "RxAdaptiveCTLE.EnableAdaption" ) )
		pContainer->sMessage += "The IBIS-AMI model, RxAdaptiveCTLE, is unable to initialize the parameter EnableAdaption from the AMI_Init arguments.  The model will use the default setting. ";

	//allocate I/O buffers
	double* p_input_buffer = new double[ 1 ];
	pSystemVueModel->input.SetBuffer( p_input_buffer, 1, 1, 0 );
	double* p_output_buffer = new double[ 1 ];
	pSystemVueModel->output.SetBuffer( p_output_buffer, 1, 1, 0 );
	double* p_clockTimes_buffer = new double[ 1 ];
	pSystemVueModel->clockTimes.SetBuffer( p_clockTimes_buffer, 1, 1, 0 );

	bool bStatus = true;

	//Setup
	if ( !pSystemVueModel->Setup() )
	{
		pContainer->sMessage += "Error occurred in RxAdaptiveCTLE::Setup(). ";
		bStatus = false;
	}

	//Initialize
	if ( bStatus )
	{
		if ( !pSystemVueModel->Initialize() )
		{
			pContainer->sMessage += "Error occurred in RxAdaptiveCTLE::Initialize(). ";
			bStatus = false;
		}
	}

	//set AMI_memory_handle
	*AMI_memory_handle = (void*)pContainer;

	//set msg
	if ( !pContainer->sMessage.empty() )
		*msg = (char*)pContainer->sMessage.c_str();

	return bStatus;
}

long AMI_GetWave( double *wave, long wave_size, double *clock_times, char **AMI_parameters_out, void *AMI_memory )
{
	AMIContainer* pContainer = (AMIContainer*)AMI_memory;
	RxAdaptiveCTLE* pSystemVueModel = &pContainer->cSystemVueModel;
	bool bStatus = true;
	long i, k = 0;

	//the upper bound for the possible number of clock times is wave_size + 1
	pContainer->vClockTimes.resize( wave_size + 1 );

	//filter wave and get clock times
	for ( i=0; i<wave_size; i++ )
	{
		//input wave sample
		pSystemVueModel->input[0] = wave[i];
		//Run
		if ( ! pSystemVueModel->Run() )
		{
			pContainer->sMessage += "Error occurred in RxAdaptiveCTLE::Run(). ";
			bStatus = false;
			break;
		}
		//output wave sample
		wave[i] = pSystemVueModel->output[0];
		//clock time
		if ( pSystemVueModel->clockTimes[0] >= 0 )
		{
			pContainer->vClockTimes[k++] = pSystemVueModel->clockTimes[0];
		}
	}

	//end clock_times
	pContainer->vClockTimes[k++] = -1;

	//From IBIS version 5.0 section 10, "The clock_time vector is allocated by the EDA platform and is guaranteed to be greater than the number of clocks expected during the AMI_GetWave call."
	//However, the standard does not specify the size of clock_times array nor provide an argument in AMI_GetWave for the size of clock_times array.
	//To prevent accessing clock_times array out of bounds, SystemVue AMI generator imposes a limit, wave_size / samples_per_bit + 101 (including up to 100 extra clock times and the last -1 element).
	//Users are free to modify this limit based on the EDA platform they use.
	long iClockTimesLimit = (long)floor((double)wave_size / (double)pContainer->iSamplesPerBit) + 101;
	if (iClockTimesLimit > wave_size)
		iClockTimesLimit = wave_size;
	if ( k <= iClockTimesLimit ) //k is the number of clock times
	{
		memcpy( clock_times, &pContainer->vClockTimes[0], sizeof(double)*k );
	}
	else
	{
		//if the number of clock times is larger than the limit, only return the last iClockTimesLimit elements
		memcpy( clock_times, &pContainer->vClockTimes[ k - iClockTimesLimit ], sizeof(double)*iClockTimesLimit );
	}

	return bStatus;
}

long AMI_Close( void *AMI_memory )
{
	AMIContainer* pContainer = (AMIContainer*)AMI_memory;
	RxAdaptiveCTLE* pSystemVueModel = &pContainer->cSystemVueModel;
	bool bStatus = true;

	//Finalize
	if ( !pSystemVueModel->Finalize() )
	{
		pContainer->sMessage += "Error occurred in RxAdaptiveCTLE::Finalize(). ";
		bStatus = false;
	}

	//delete I/O buffers
	delete[] &pSystemVueModel->input[0];
	delete[] &pSystemVueModel->output[0];
	delete[] &pSystemVueModel->clockTimes[0];

	//delete AMIContainer
	delete pContainer;

	return bStatus;
}
