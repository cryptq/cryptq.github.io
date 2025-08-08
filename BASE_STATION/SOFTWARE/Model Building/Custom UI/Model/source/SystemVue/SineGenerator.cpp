// Copyright 2011 - 2014 Keysight Technologies, Inc   
#include "SineGenerator.h"

#define TWOPI 6.28318530717958647692528676655900576839433879875021

#ifndef SV_CODE_GEN
DEFINE_MODEL_INTERFACE( SineGenerator )
{
	SET_CUSTOM_UI( "Sine_UI" );

	ADD_MODEL_OUTPUT( output );

	SystemVueModelBuilder::DFParam paramAmp = ADD_MODEL_PARAM( Amplitude );
	paramAmp.SetDefaultValue( "1.0" );
	paramAmp.SetDescription( "Amplitude" );
	paramAmp.SetUnit( SystemVueModelBuilder::Units::VOLTAGE );

	SystemVueModelBuilder::DFParam paramOff = ADD_MODEL_PARAM( Offset );
	paramOff.SetDefaultValue( "0" );
	paramOff.SetDescription( "DC offset" );
	paramOff.SetUnit( SystemVueModelBuilder::Units::VOLTAGE );

	SystemVueModelBuilder::DFParam paramFreq = ADD_MODEL_PARAM( Frequency );
	paramFreq.SetDefaultValue( "5e3" );
	paramFreq.SetDescription( "Frequency" );
	paramFreq.SetUnit( SystemVueModelBuilder::Units::FREQUENCY );

	SystemVueModelBuilder::DFParam paramPhase = ADD_MODEL_PARAM( Phase );
	paramPhase.SetDefaultValue( "0" );
	paramPhase.SetDescription( "Phase" );
	paramPhase.SetUnit( SystemVueModelBuilder::Units::ANGLE );

	SystemVueModelBuilder::DFParam paramSR = ADD_MODEL_PARAM( SampleRate );
	paramSR.SetDefaultValue( "1e6" );
	paramSR.SetDescription( "Sample rate" );
	paramSR.SetUnit( SystemVueModelBuilder::Units::FREQUENCY );

	return true;
}
#endif


bool SineGenerator::Setup()
{
	bool bStatus = true;
	
	if ( SampleRate > 0 )
	{
		output.SetSampleRate( SampleRate );
	}
	else
	{
		POST_ERROR( "SampleRate must be greater than 0." );
		bStatus = false;
	}

	if ( Frequency <= 0 )
	{
		POST_ERROR( "Frequency must be greater than 0." );
		bStatus = false;
	}
	
	return bStatus;
}

bool SineGenerator::Run()
{
	bool bStatus = true;
	//assume Phase is in radian
	output[0] = Amplitude * sin( TWOPI * Frequency * output.GetTime( 0, m_iFiringCount ) + Phase ) + Offset;
	return bStatus;
}
