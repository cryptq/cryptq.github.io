//-----------------------------------------------------------------------------------
//	Copyright (c) Keysight Technologies 2010.  All rights reserved.
//-----------------------------------------------------------------------------------

#include "CTLE_Detection.h"

CTLE_Detection::CTLE_Detection(void)
{
	m_pBuffer_S6_output = NULL;
	m_pBuffer_To_S6_input = NULL;
}

CTLE_Detection::~CTLE_Detection(void)
{
	DeleteBuffers();
}

void CTLE_Detection::DeleteBuffers()
{
	delete[] m_pBuffer_S6_output;  	m_pBuffer_S6_output = NULL;
	delete[] m_pBuffer_To_S6_input;  m_pBuffer_To_S6_input = NULL;
}

#ifndef SV_CODE_GEN
DEFINE_MODEL_INTERFACE(CTLE_Detection)
{
	SET_MODEL_NAME( "CTLE_Detection" );
	SET_MODEL_DESCRIPTION( "Adaptive CTLE control detection algorithm" );

	ADD_MODEL_INPUT( input );
	ADD_MODEL_OUTPUT( output );

	SystemVueModelBuilder::DFParam param = ADD_MODEL_PARAM( SamplesPerBit );
	param.SetDefaultValue( "64" );
	param.SetDescription( "Samples per bit" );

	param = ADD_MODEL_PARAM( NumBitsToAvg );
	param.SetDefaultValue( "200" );
	param.SetDescription( "Number of bits to average" );

	param = ADD_MODEL_PARAM( TargetV );
	param.SetDefaultValue( "0.15" );
	param.SetDescription( "Target control voltage" );

	return true;
}
#endif 

bool CTLE_Detection::Setup()
{
	bool bStatus = true;

	//setup models and their parameters
	//SystemVueModelBuilder::SlidWinAvg S6
	S6.WindowSize = ( NumBitsToAvg * SamplesPerBit );
	bStatus &= S6.Setup();

	return bStatus;
}

bool CTLE_Detection::Initialize()
{
	bool bStatus = true;

	if ( SamplesPerBit <= 0 ) 
	{
		std::stringstream msg;
		msg << "SamplesPerBit value must be > 0.";
		POST_ERROR( msg.str().c_str() );
		bStatus = false;
	}
	if ( TargetV <= 0 ) 
	{
		std::stringstream msg;
		msg << "TargetV value must be > 0.";
		POST_ERROR( msg.str().c_str() );
		bStatus = false;
	}

	if ( bStatus )
	{
		//allocate buffer from S6.output to S1.input
		m_pBuffer_S6_output = new double[1];
		S6.output.SetBuffer(m_pBuffer_S6_output, 1, 1, 0);

		//allocate buffer from M1.m_dOutput to S6.input
		m_pBuffer_To_S6_input = new double[SamplesPerBit*NumBitsToAvg+1];
		S6.input.SetBuffer(m_pBuffer_To_S6_input, SamplesPerBit*NumBitsToAvg+1, 1, 1);
		S6.input.Zero(0, SamplesPerBit*NumBitsToAvg+1, NULL);

		//initialize models
		bStatus &= S6.Initialize();
	}

	iCount = 0;
	output = TargetV;
	pastOutput = TargetV;

	return bStatus;
}

bool CTLE_Detection::Run()
{
	bool bStatus = true;

	m_pBuffer_To_S6_input[ iCount%(SamplesPerBit*NumBitsToAvg+1) ] = fabs(input);
	bStatus &= S6.Run();
	S6.input.Advance();

	if ( iCount < 3*NumBitsToAvg*SamplesPerBit )
		output = TargetV;
	else
	{
		if ( iCount%(SamplesPerBit*NumBitsToAvg) == 0 )
			output = m_pBuffer_S6_output[0];
		else
			output = pastOutput;
		pastOutput = output;
	}

	iCount++;
	return bStatus;
}

bool CTLE_Detection::Finalize()
{
	bool bStatus = true;

	bStatus &= S6.Finalize();
	DeleteBuffers();

	return bStatus;
}

