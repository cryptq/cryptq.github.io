/*
 * CTLE_FIR.cpp
 * Created by SystemVue C++ Code Generator
 * Copyright © 2000-2010, Keysight Technologies, Inc.
 */

#include "CTLE_FIR.h"
#include <string>

#define NUMRESPONSES 13
#define DATA_SAMPLERATE 64.0*10e9;
static double CTLE_impulse_file[][NUMRESPONSES+1] = {
#include "CTLE_FIR_taps_data.txt"
};

static double CTLE_gain_file[][NUMRESPONSES] = {
#include "CTLE_FIR_gain_file.txt"
};

double CTLE_FIR::get_CTLE_impulse_file( int i, int j)
{
	return( CTLE_impulse_file[i][j]);
}
double CTLE_FIR::get_CTLE_gain_file( int j)
{
	return( CTLE_gain_file[0][j]);
}

#ifndef SV_CODE_GEN
DEFINE_MODEL_INTERFACE(CTLE_FIR)
{
	SET_MODEL_NAME( "CTLE_FIR" );
	SET_MODEL_DESCRIPTION( "CTLE FIR model for one from multiple transient single-ended impulse response waveforms" );

	ADD_MODEL_INPUT( input );
	ADD_MODEL_INPUT( gain_control );
	ADD_MODEL_OUTPUT( output );

	SystemVueModelBuilder::DFParam cSampleInterval = ADD_MODEL_PARAM( SampleInterval );
	cSampleInterval.SetName( "SampleInterval" );
	cSampleInterval.SetDefaultValue( "5e-12" );
	cSampleInterval.SetDescription( "Sample interval to be used in the extracted data" );

	SystemVueModelBuilder::DFParam cSelectedResponse = ADD_MODEL_PARAM( SelectedResponse );
	cSelectedResponse.SetName( "SelectedResponse" );
	cSelectedResponse.SetDefaultValue( "1" );
	cSelectedResponse.SetDescription( "Select response in range [1, 13]" );

	return true;
}
#endif

CTLE_FIR::CTLE_FIR()
{
	SampleInterval = 5e-012;
	SelectedResponse = 1;

	NumResponses = NUMRESPONSES;  
	size_CTLE_impulse_file = sizeof( CTLE_impulse_file)/sizeof( CTLE_impulse_file[0][0]);
	size_CTLE_impulse_file /= NumResponses+1;
	size_CTLE_gain_file = sizeof( CTLE_gain_file)/sizeof( CTLE_gain_file[0][0]);
	size_CTLE_gain_file /= NumResponses;

	ResponseType = 0;  //0 = impulse; 
	//PulseScalingType = eRefVoltage; // 1 = eRefVoltage;
	//PulseRefV = 1.0;
	//FIR_TruncRatio = 0;
	//WindowFIR = eNoWindow;

	S1.m_pdResponse = NULL;
	S1.m_pdTimeStamps = NULL;

	d_taps = NULL;
	d_xbuffer = NULL;
	i_numtaps = 0;
	ll_xcount = 0;

}

CTLE_FIR::~CTLE_FIR()
{
	DeleteArrayParameters();
}

void CTLE_FIR::DeleteArrayParameters()
{
	delete[] S1.m_pdResponse; S1.m_pdResponse = NULL;
	delete[] S1.m_pdTimeStamps; S1.m_pdTimeStamps = NULL;

	delete [] d_taps; d_taps = NULL;
	delete [] d_xbuffer; d_xbuffer = NULL;
	i_numtaps = 0;
	ll_xcount = 0;
}

bool CTLE_FIR::Setup()
{
	bool bStatus = true;
	DeleteArrayParameters();

	if ( NumResponses < 1 ) 
	{
		std::stringstream msg;
		msg << "NumResponses value should be greater than or equal to 1.";
		POST_ERROR( msg.str().c_str() );
		bStatus = false;
	}
	if ( SelectedResponse < 1 || SelectedResponse > NumResponses )
	{
		std::stringstream msg;
		msg << "SelectedResponse value should be in the range [1, " << NumResponses << "].";
		POST_ERROR( msg.str().c_str() );
		bStatus = false;
	}
	if ( bStatus )
	{
		double dcgain;
		double *tdata, *vdata;
		tdata = vdata = NULL;
		tdata = new double[ size_CTLE_impulse_file];
		vdata = new double[ size_CTLE_impulse_file];

		int datacnt; 
		datacnt = 0; 
		if ( SelectedResponse>=1 && SelectedResponse<=NumResponses )
		{
			if ( size_CTLE_impulse_file > 100000 )
			{
				std::stringstream msg;
				msg << "CTLE_impulse_file must have less than 100,000 lines.";
				POST_ERROR( msg.str().c_str() );
				bStatus = false;
			}
			if ( size_CTLE_gain_file != 1 )
			{
				std::stringstream msg;
				msg << "CTLE_gain_file must have only 1 line.";
				POST_ERROR( msg.str().c_str() );
				bStatus = false;
			}
			if ( bStatus )
			{
				int i;
				for (i=0; i<size_CTLE_impulse_file; i++ )
				{
					tdata[i] = CTLE_impulse_file[i][0];
					vdata[i] = CTLE_impulse_file[i][SelectedResponse];
				}
				datacnt = size_CTLE_impulse_file;
				int tmpdatacnt = datacnt;
				for (i=datacnt-1; i>0; i-- )
				{
					if ( vdata[i] == 0 )
						tmpdatacnt--;
					else
						break;
				}
				datacnt = tmpdatacnt;
				dcgain = CTLE_gain_file[0][SelectedResponse-1];
			}
		}
		else
		{
			std::stringstream msg;
			msg << "SelectedResponse out of range.  Must be an integer in the range [1, " << NumResponses << "].";
			POST_ERROR( msg.str().c_str() );
			bStatus = false;
		}

		if ( bStatus )
		{
			if ( datacnt < 4 )
			{
				std::stringstream msg;
				msg << "Selected FileData dataset has less than lower limit of 4 rows. Please check and correct the CTLE_impulse_file.";
				POST_ERROR( msg.str().c_str() );
				bStatus = false;
			}
			else
			{
				int i;
				double reft;
				reft = tdata[ 0];
				for (i=0; i<datacnt; i++)
				{
					tdata[ i] -= reft;
				}

				//setup models and their parameters
				S1.m_eResponseType = (SystemVueModelBuilder::TimeResponseFIR::ResponseTypeE)(int)ResponseType;
				//S1.m_ePulseScalingType = (SystemVueModelBuilder::TimeRespFIR::PulseScalingTypeE)(int)PulseScalingType;
				//PulseRefV = 1./dcgain;
				//S1.m_dPulseRefV = PulseRefV;
				//S1.m_dFIR_TruncRatio = FIR_TruncRatio;
				//S1.m_eWindowFIR = (SystemVueModelBuilder::TimeRespFIR::WindowFIR_E)(int)WindowFIR;
				S1.m_pdResponse = new double[ datacnt ];
				memcpy( S1.m_pdResponse, vdata, sizeof(double)*datacnt );
				S1.m_iResponseSize = datacnt;
				S1.m_pdTimeStamps = new double[ datacnt ];
				memcpy( S1.m_pdTimeStamps, tdata, sizeof(double)*datacnt );
				S1.m_iTimeStampSize = datacnt;
				S1.m_dSampleRate = ( 1 / SampleInterval );
				bStatus &= S1.Setup();

				if ( bStatus )
				{
					//initialize models
					bStatus &= S1.Initialize();
				}
				if ( bStatus )
				{
					i_numtaps = S1.m_iTapsSize;
					d_taps = new double[ i_numtaps ];

					for (i=0; i<i_numtaps; i++)
					{
						d_taps[i] = S1.m_Taps[i]/dcgain*DATA_SAMPLERATE;
					}

					d_xbuffer = new double[ i_numtaps];
					int i;
					for (i=0; i<i_numtaps; i++)
						d_xbuffer[i] = 0;

				}
			}
		}
		delete [] tdata;
		delete [] vdata;
	}

	return bStatus;
}

bool CTLE_FIR::Initialize()
{
	bool bStatus = true;
	return bStatus;
}

bool CTLE_FIR::Run()
{
	bool bStatus = true;

	int i;
	int n = i_numtaps;
	d_xbuffer[ ll_xcount%n] = input;
	d_xbuffer[ ll_xcount%n] *= gain_control;

	double y = 0.;
	for (i=0; i<n; i++)
	{
		y += d_taps[i]*d_xbuffer[(ll_xcount-i+n)%n];
		if ( i>=ll_xcount )
			break;
	}
	output = y;

	ll_xcount++;
	return bStatus;
}

bool CTLE_FIR::Finalize()
{
	bool bStatus = true;
	DeleteArrayParameters();
	return bStatus;
}

