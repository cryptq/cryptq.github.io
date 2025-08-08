//-----------------------------------------------------------------------------------
//	Copyright (c) Keysight Technologies 2010.  All rights reserved.
//-----------------------------------------------------------------------------------

#include "CTLE_Control.h"

CTLE_Control::CTLE_Control(void)
{
}

CTLE_Control::~CTLE_Control(void)
{
}

#ifndef SV_CODE_GEN
DEFINE_MODEL_INTERFACE(CTLE_Control)
{
	SET_MODEL_NAME( "CTLE_Control" );
	SET_MODEL_DESCRIPTION( "Adaptive CTLE control algorithm" );

	ADD_MODEL_INPUT( DetV );
	ADD_MODEL_OUTPUT( CTLE_Index );

	SystemVueModelBuilder::DFParam param = ADD_MODEL_PARAM( BitRate );
	param.SetDefaultValue( "10e9" );
	param.SetUnit( SystemVueModelBuilder::Units::FREQUENCY );
	param.SetDescription( "Bit rate" );

	param = ADD_MODEL_PARAM( SamplesPerBit );
	param.SetDefaultValue( "64" );
	param.SetDescription( "Samples per bit" );

	param = ADD_MODEL_PARAM( NumBitsToAvg );
	param.SetDefaultValue( "200" );
	param.SetDescription( "Number of bits to average" );

	param = ADD_MODEL_PARAM( TargetV );
	param.SetDefaultValue( "0.15" );
	param.SetDescription( "Target control voltage" );

	param = ADD_MODEL_PARAM( ThresholdV );
	param.SetDefaultValue( "0.015" );
	param.SetDescription( "Target control voltage threshold" );

	param = ADD_MODEL_PARAM( IndexInit );
	param.SetDefaultValue( "7" );
	param.SetDescription( "Initial CTLE index" );

	EnableEq = eYesEq;
	param = ADD_MODEL_ENUM_PARAM(EnableEq, CTLE_Control::EnableEqE );
	param.AddEnumeration("No", eNoEq);
	param.AddEnumeration("Yes", eYesEq);
	param.SetDescription("Enable CTLE control");
	param.SetSchematicDisplay( false);

	return true;
}
#endif 

bool CTLE_Control::Initialize()
{
	bool bStatus = true;

	if ( BitRate <= 0 ) 
	{
		std::stringstream msg;
		msg << "BitRate value must be > 0.";
		POST_ERROR( msg.str().c_str() );
		bStatus = false;
	}
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
	if ( IndexInit < 1 || IndexInit > 13 ) 
	{
		std::stringstream msg;
		msg << "IndexInit value must be aninteger in the range [1,13].";
		POST_ERROR( msg.str().c_str() );
		bStatus = false;
	}

	if ( bStatus )
		sampleInterval = 1./BitRate/SamplesPerBit;
	iWindowSize = NumBitsToAvg*SamplesPerBit;

	pastCTLEIndex = IndexInit;
	iCount = 0;

	return bStatus;
}

bool CTLE_Control::Run()
{
	bool bStatus = true;

	if ( EnableEq == eNoEq )
	{
		CTLE_Index = IndexInit;
	}
	else
	{
		if ( iCount == iWindowSize )
		{
			if ( DetV < TargetV-ThresholdV )
				CTLE_Index++;
			if ( DetV > TargetV+ThresholdV )
				CTLE_Index--;

			if ( CTLE_Index < 1 )
				CTLE_Index = 1;
			if ( CTLE_Index > 13 )
				CTLE_Index = 13;

			pastCTLEIndex = CTLE_Index;

			iCount = 0;
		}
		else
		{
			CTLE_Index = pastCTLEIndex;
			iCount++;
		}
	}

	return bStatus;
}

bool CTLE_Control::Finalize()
{
	bool bStatus = true;
	return bStatus;
}

