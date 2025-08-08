/*
 * CTLE_BPF.cpp
 * Created by SystemVue C++ Code Generator
 * Copyright © 2000-2010, Keysight Technologies, Inc.
 */

#include "CTLE_BPF.h"
#include <string>

#define NUMRESPONSES 1
#define DATA_SAMPLERATE 64.0*10e9;
static double BPF_impulse_file[][NUMRESPONSES+1] = {
#include "BPF_taps_data.txt"
};

#ifndef SV_CODE_GEN
DEFINE_MODEL_INTERFACE(CTLE_BPF)
{
	SET_MODEL_NAME( "CTLE_BPF" );
	SET_MODEL_DESCRIPTION( "BPF model for transient single-ended impulse response waveform" );

	ADD_MODEL_INPUT( input );
	ADD_MODEL_OUTPUT( output );

	SystemVueModelBuilder::DFParam cSampleInterval = ADD_MODEL_PARAM( SampleInterval );
	cSampleInterval.SetName( "SampleInterval" );
	cSampleInterval.SetDefaultValue( "5e-12" );
	cSampleInterval.SetDescription( "Sample interval to be used in the extracted data" );

	// Activate if NUMRESPONSES > 1
	//SystemVueModelBuilder::DFParam cSelectedResponse = ADD_MODEL_PARAM( SelectedResponse );
	//cSelectedResponse.SetName( "SelectedResponse" );
	//cSelectedResponse.SetDefaultValue( "1" );
	//cSelectedResponse.SetDescription( "Select response in range [1, 1]" );

	return true;
}
#endif

CTLE_BPF::CTLE_BPF()
{
	SampleInterval = 5e-012;
	SelectedResponse = 1;

	NumResponses = NUMRESPONSES;  
	size_BPF_impulse_file = sizeof( BPF_impulse_file)/sizeof( BPF_impulse_file[0][0]);
	size_BPF_impulse_file /= NumResponses+1;

	ResponseType = 0;  //0 = impulse; 
	//PulseScalingType = eAuto; // 0 = eAuto;
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

CTLE_BPF::~CTLE_BPF()
{
	DeleteArrayParameters();
}

void CTLE_BPF::DeleteArrayParameters()
{
	delete[] S1.m_pdResponse; S1.m_pdResponse = NULL;
	delete[] S1.m_pdTimeStamps; S1.m_pdTimeStamps = NULL;

	delete [] d_taps; d_taps = NULL;
	delete [] d_xbuffer; d_xbuffer = NULL;
	i_numtaps = 0;
	ll_xcount = 0;
}

bool CTLE_BPF::Setup()
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
		double *tdata, *vdata;
		tdata = vdata = NULL;
		tdata = new double[ size_BPF_impulse_file];
		vdata = new double[ size_BPF_impulse_file];

		int datacnt; 
		datacnt = 0; 
		if ( SelectedResponse>=1 && SelectedResponse<=NumResponses )
		{
			if ( size_BPF_impulse_file > 100000 )
			{
				std::stringstream msg;
				msg << "BPF_impulse_file must have less than 100,000 lines.";
				POST_ERROR( msg.str().c_str() );
				bStatus = false;
			}
			if ( bStatus )
			{
				int i;
				for (i=0; i<size_BPF_impulse_file; i++ )
				{
					tdata[i] = BPF_impulse_file[i][0];
					vdata[i] = BPF_impulse_file[i][SelectedResponse];
				}
				datacnt = size_BPF_impulse_file;
				int tmpdatacnt = datacnt;
				for (i=datacnt-1; i>0; i-- )
				{
					if ( vdata[i] == 0 )
						tmpdatacnt--;
					else
						break;
				}
				datacnt = tmpdatacnt;
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
				msg << "Selected FileData dataset has less than lower limit of 4 rows. Please check and correct the BPF_impulse_file.";
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
				//S1.m_ePulseScalingType = (SystemVueModelBuilder::TimeResponseFIR::PulseScalingTypeE)(int)PulseScalingType;
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
						d_taps[i] = S1.m_Taps[i]*DATA_SAMPLERATE;
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

bool CTLE_BPF::Initialize()
{
	bool bStatus = true;
	return bStatus;
}

bool CTLE_BPF::Run()
{
	bool bStatus = true;

	int i;
	int n = i_numtaps;
	d_xbuffer[ ll_xcount%n] = input;

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

bool CTLE_BPF::Finalize()
{
	bool bStatus = true;
	DeleteArrayParameters();
	return bStatus;
}

