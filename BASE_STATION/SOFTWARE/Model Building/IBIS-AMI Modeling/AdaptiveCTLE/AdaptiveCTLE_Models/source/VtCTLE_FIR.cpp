/*
 * VtCTLE_FIR.cpp
 * Created by SystemVue C++ Code Generator
 * Copyright © 2000-2010, Keysight Technologies, Inc.
 */

#include "VtCTLE_FIR.h"
#include <string>

#define DATA_SAMPLERATE 64.0*10e9;

#ifndef SV_CODE_GEN
DEFINE_MODEL_INTERFACE(VtCTLE_FIR)
{
	SET_MODEL_NAME( "VtCTLE_FIR" );
	SET_MODEL_DESCRIPTION( "Voltage tuned CTLE FIR model for one from multiple transient single-ended impulse response waveforms" );

	ADD_MODEL_INPUT( input );
	ADD_MODEL_INPUT( CTLE_control );
	ADD_MODEL_INPUT( gain_control );
	ADD_MODEL_OUTPUT( output );

	SystemVueModelBuilder::DFParam cSampleInterval = ADD_MODEL_PARAM( SampleInterval );
	cSampleInterval.SetName( "SampleInterval" );
	cSampleInterval.SetDefaultValue( "5e-12" );
	cSampleInterval.SetDescription( "Sample interval to be used in the extracted data" );

	//SystemVueModelBuilder::DFParam cFIR_TruncRatio = ADD_MODEL_PARAM(FIR_TruncRatio);
	//cFIR_TruncRatio.SetName("FIR_TruncRatio");
	//cFIR_TruncRatio.SetDefaultValue("0.0");
	//cFIR_TruncRatio.SetDescription("FIR tap value truncation ratio to limit FIR length");
	//cFIR_TruncRatio.SetSchematicDisplay( false);

	//SystemVueModelBuilder::DFParam param = ADD_MODEL_ENUM_PARAM(WindowFIR, VtCTLE_FIR::WindowFIR_E );
	//param.AddEnumeration("No", eNoWindow);
	//param.AddEnumeration("Yes", eYesWindow);
	//param.SetName("WindowFIR");
	//param.SetDescription("Window truncated FIR taps");
	//param.SetSchematicDisplay( false);

	return true;
}
#endif

VtCTLE_FIR::VtCTLE_FIR()
{
	d_taps = NULL;
	d_tapsscale = NULL;
	i_numtaps = NULL;
	d_xbuffer = NULL;
	i_maxtaps = 0;
}

VtCTLE_FIR::~VtCTLE_FIR()
{
	//DeleteVtArrayParameters();
}

void VtCTLE_FIR::DeleteVtArrayParameters()
{
	int i;
	if ( d_taps != NULL )
	{
		for (i=0; i<NumResponses; i++)
		{
			delete [] d_taps[i];
		}
	}
	delete [] d_taps; d_taps = NULL;
	delete [] d_tapsscale; d_tapsscale = NULL;
	delete [] i_numtaps; i_numtaps = NULL;
	delete [] d_xbuffer; d_xbuffer = NULL;
	i_maxtaps = 0;
}

bool VtCTLE_FIR::Setup()
{
	bool bStatus = true;
	DeleteVtArrayParameters();
	DeleteArrayParameters();

	double *tdata, *vdata;
	tdata = vdata = NULL;
	tdata = new double[ size_CTLE_impulse_file];
	vdata = new double[ size_CTLE_impulse_file];

	i_numtaps = new int[NumResponses];
	d_taps = new double*[NumResponses];
	d_tapsscale = new double[NumResponses];

	int resp = 0;
	for (resp=0; resp<NumResponses; resp++)
	{
		double dcgain;
		int datacnt; 
		datacnt = 0; 
		int i;
		for (i=0; i<size_CTLE_impulse_file; i++ )
		{
			tdata[i] = get_CTLE_impulse_file(i, 0);
			vdata[i] = get_CTLE_impulse_file(i, resp+1);
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
		dcgain = get_CTLE_gain_file(resp);

		if ( bStatus )
		{
			if ( datacnt < 4 )
			{
				std::stringstream msg;
				msg << "Selected FileData dataset has less than lower limit of 4 rows. Please check and correct the FileData.";
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

				if ( bStatus )
				{
					delete[] S1.m_pdResponse; S1.m_pdResponse = NULL;
					delete[] S1.m_pdTimeStamps; S1.m_pdTimeStamps = NULL;
				}
				if ( bStatus )
				{
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
				}
				if ( bStatus )
				{
					//initialize models
					bStatus &= S1.Initialize();
				}
				if ( bStatus )
				{
					i_numtaps[resp] = S1.m_iTapsSize;
					d_taps[resp] = new double[ i_numtaps[resp] ];

					for (i=0; i<i_numtaps[resp]; i++)
					{
						d_taps[resp][i] = S1.m_Taps[i]/dcgain*DATA_SAMPLERATE;
					}
				}
			}
		}
	}

	delete [] tdata;
	delete [] vdata;

	if ( bStatus )
	{
		i_maxtaps = 0;
		int i;
		for (i=0; i<NumResponses; i++)
		{
			if ( i_numtaps[i] > i_maxtaps )
				i_maxtaps = i_numtaps[i];
		}
		d_xbuffer = new double[ i_maxtaps];
		for (i=0; i<i_maxtaps; i++)
			d_xbuffer[i] = 0;

		std::stringstream msg;
		msg << "Number of FIR taps = " << i_maxtaps << ".\n";
		POST_INFO( msg.str().c_str() );

	}
	return bStatus;
}

bool VtCTLE_FIR::Initialize()
{
	bool bStatus = true;
	b_ctrlErrFlag = false;
	return bStatus;
}

bool VtCTLE_FIR::Run()
{
	bool bStatus = true;
	int ctrl;

	ctrl = CTLE_control;
	if ( ll_xcount>10 && b_ctrlErrFlag==false && (ctrl < 1 || ctrl > NumResponses ) )
	{  // ignore the first 10 samples to account for start up transient
		std::stringstream msg;
		msg << "Control input at time = " << ll_xcount*SampleInterval << " is " << ctrl << " and is out of range.  It will be limited to an integer in the range [1, " << NumResponses << "].";
		POST_WARNING( msg.str().c_str() );
		b_ctrlErrFlag = true;
	}

	if ( ctrl < 1 )
		ctrl = 1;
	if (ctrl > NumResponses )
		ctrl = NumResponses;

	int i;
	int s = ctrl-1;
	int n = i_numtaps[s];
	d_xbuffer[ ll_xcount%i_maxtaps] = gain_control * input;
	double y = 0.;
	for (i=0; i<n; i++)
	{
		y += d_taps[s][i]*d_xbuffer[(ll_xcount-i+i_maxtaps)%i_maxtaps];
		if ( i>=ll_xcount )
			break;
	}

	output = y;

	ll_xcount++;
	return bStatus;
}

bool VtCTLE_FIR::Finalize()
{
	bool bStatus = true;
	DeleteArrayParameters();
	DeleteVtArrayParameters();
	return bStatus;
}

