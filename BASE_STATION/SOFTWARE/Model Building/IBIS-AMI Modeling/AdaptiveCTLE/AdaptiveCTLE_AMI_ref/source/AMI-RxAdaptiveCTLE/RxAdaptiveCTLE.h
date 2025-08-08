/*
 * RxAdaptiveCTLE.h
 * Created by SystemVue C++ Code Generator
 * Copyright © 2000-2014, Keysight Technologies, Inc.
 */

#pragma once

#include "SystemVue/ModelBuilder.h"
#include "../../../AdaptiveCTLE_Models/source/CTLE_Detection.h"
#include "../../../AdaptiveCTLE_Models/source/CTLE_BPF.h"
#include "SystemVue/Models/AMI/PhaseDetector.h"
#include "SystemVue/Models/AMI/VCO.h"
#include "SystemVue/Models/TypeConverter.h"
#include "SystemVue/Models/Fork.h"
#include "SystemVue/Models/Gain.h"
#include "SystemVue/Models/AMI/ClockTimes.h"
#include "../../../AdaptiveCTLE_Models/source/VtCTLE_FIR.h"
#include "../../../AdaptiveCTLE_Models/source/CTLE_Control.h"
#include "SystemVue/Models/ConstUnTimed.h"

class RxAdaptiveCTLE : public SystemVueModelBuilder::DFModel
{
public:
	DECLARE_MODEL_INTERFACE(RxAdaptiveCTLE)

	RxAdaptiveCTLE();

	~RxAdaptiveCTLE();

	bool RunEquations();

	bool Setup();

	bool Initialize();

	bool Run();

	bool Finalize();

	// input, rate=1
	SystemVueModelBuilder::CircularBuffer<double > input;

	// output, rate=1
	SystemVueModelBuilder::CircularBuffer<double > output;

	// output, rate=1
	SystemVueModelBuilder::CircularBuffer<double > clockTimes;

	// Bit time
	double BitTime;

	// Samples per bit
	int SamplesPerBit;

	// Number of bits to average for detection
	int NumBitsToAvg;

	// Target detection voltage
	double TargetV;

	// Target detection threshold voltage
	double ThresholdV;

	// Initial CTLE value
	int CTLE_Init;

	// Enable the controlling of CTLE taps
	int EnableAdaption;


private:
	// subnetwork ClockRecovery
	class Subnetwork_ClockRecovery
	{
	public:
		Subnetwork_ClockRecovery();

		bool RunEquations();

		bool Setup();

		// SystemVueModelBuilder::PhaseDetector Phase Detector
		SystemVueModelBuilder::PhaseDetector P1;

		// SystemVueModelBuilder::VCO Voltage Controlled Oscillator
		SystemVueModelBuilder::VCO V1;

		// SystemVueModelBuilder::ScalarToScalar< SystemVueModelBuilder::CircularBuffer< int >,SystemVueModelBuilder::CircularBuffer< float > > Convert from int to float
		SystemVueModelBuilder::ScalarToScalar< SystemVueModelBuilder::CircularBuffer< int >,SystemVueModelBuilder::CircularBuffer< float > > Int_to_Flt_at_V1_clock_output_2;

		// SystemVueModelBuilder::ScalarToScalar< SystemVueModelBuilder::CircularBuffer< float >,SystemVueModelBuilder::CircularBuffer< int >, SystemVueModelBuilder::TypeConverterRound > Convert from float to int
		SystemVueModelBuilder::ScalarToScalar< SystemVueModelBuilder::CircularBuffer< float >,SystemVueModelBuilder::CircularBuffer< int >, SystemVueModelBuilder::TypeConverterRound > Flt_to_Int_at_G1_output;

		// SystemVueModelBuilder::Fork< SystemVueModelBuilder::CircularBuffer< int > > int Fork
		SystemVueModelBuilder::Fork< SystemVueModelBuilder::CircularBuffer< int > > V1_clock;

		// SystemVueModelBuilder::Gain< float > float Gain
		SystemVueModelBuilder::Gain< float > G1;

		// Bit time
		double BitTime;

		// Samples per bit
		int SamplesPerBit;

		// Bit center and clock edge alignment
		int BitCenter;

		// Use to enable loop filter
		bool Enable_LoopFilter;

		// Real filter pole
		double FilterPole;

		// Real filter zero
		double FilterZero;

		// Real filter gain
		double FilterGain;


	private:
		// variable defined in Equations
		double SampleInterval;


	} ClockRecovery;

	// delete buffer memory
	void DeleteBuffers();

	// CTLE_Detection Adaptive CTLE control detection algorithm
	CTLE_Detection CTLE_Detection;

	// circular buffer for CTLE_Detection.input
	SystemVueModelBuilder::CircularBuffer<double > CTLE_Detection_input_CircularBuffer;

	// circular buffer for CTLE_Detection.output
	SystemVueModelBuilder::CircularBuffer<double > CTLE_Detection_output_CircularBuffer;

	// CTLE_BPF BPF model for transient single-ended impulse response waveform
	CTLE_BPF CTLE_BPF;

	// circular buffer for CTLE_BPF.input
	SystemVueModelBuilder::CircularBuffer<double > CTLE_BPF_input_CircularBuffer;

	// circular buffer for CTLE_BPF.output
	SystemVueModelBuilder::CircularBuffer<double > CTLE_BPF_output_CircularBuffer;

	// SystemVueModelBuilder::ClockTimes Clock Signal to Clock Times Converter
	SystemVueModelBuilder::ClockTimes ClockTimes;

	// VtCTLE_FIR Voltage tuned CTLE FIR model for one from multiple transient single-ended impulse response waveforms
	VtCTLE_FIR VtCTLE_FIR;

	// circular buffer for VtCTLE_FIR.input
	SystemVueModelBuilder::CircularBuffer<double > VtCTLE_FIR_input_CircularBuffer;

	// circular buffer for VtCTLE_FIR.CTLE_control
	SystemVueModelBuilder::CircularBuffer<int > VtCTLE_FIR_CTLE_control_CircularBuffer;

	// circular buffer for VtCTLE_FIR.gain_control
	SystemVueModelBuilder::CircularBuffer<double > VtCTLE_FIR_gain_control_CircularBuffer;

	// circular buffer for VtCTLE_FIR.output
	SystemVueModelBuilder::CircularBuffer<double > VtCTLE_FIR_output_CircularBuffer;

	// CTLE_Control Adaptive CTLE control algorithm
	CTLE_Control CTLE_Control;

	// circular buffer for CTLE_Control.DetV
	SystemVueModelBuilder::CircularBuffer<double > CTLE_Control_DetV_CircularBuffer;

	// circular buffer for CTLE_Control.CTLE_Index
	SystemVueModelBuilder::CircularBuffer<int > CTLE_Control_CTLE_Index_CircularBuffer;

	// SystemVueModelBuilder::ScalarToScalar< SystemVueModelBuilder::CircularBuffer< int >,SystemVueModelBuilder::CircularBuffer< double > > Convert from int to double
	SystemVueModelBuilder::ScalarToScalar< SystemVueModelBuilder::CircularBuffer< int >,SystemVueModelBuilder::CircularBuffer< double > > Int_to_Dbl_at_clock_output_1;

	// SystemVueModelBuilder::Fork< SystemVueModelBuilder::CircularBuffer< double > > double Fork
	SystemVueModelBuilder::Fork< SystemVueModelBuilder::CircularBuffer< double > > Delay_output;

	// SystemVueModelBuilder::ConstUnTimed< double > double ConstUnTimed
	SystemVueModelBuilder::ConstUnTimed< double > C3;

	// buffer from input to VtCTLE_FIR_input_CircularBuffer
	double* m_pBuffer_input_To_VtCTLE_FIR_input_CircularBuffer;

	// circular buffer for input
	SystemVueModelBuilder::CircularBuffer<double > input_CirBuf;

	// buffer from Delay_output.output[2] to output
	double* m_pBuffer_Delay_output_output_2__To_output;

	// circular buffer for output
	SystemVueModelBuilder::CircularBuffer<double > output_CirBuf;

	// buffer from ClockTimes.time to clockTimes
	double* m_pBuffer_ClockTimes_time_To_clockTimes;

	// circular buffer for clockTimes
	SystemVueModelBuilder::CircularBuffer<double > clockTimes_CirBuf;

	// buffer from CTLE_Detection_output_CircularBuffer to CTLE_Control_DetV_CircularBuffer
	double* m_pBuffer_CTLE_Detection_output_CircularBuffer_To_CTLE_Control_DetV_CircularBuffer;

	// buffer from CTLE_BPF_output_CircularBuffer to CTLE_Detection_input_CircularBuffer
	double* m_pBuffer_CTLE_BPF_output_CircularBuffer_To_CTLE_Detection_input_CircularBuffer;

	// buffer from ClockRecovery.P1.phaseError to ClockRecovery.V1.vin
	double* m_pBuffer_ClockRecovery_P1_phaseError_To_ClockRecovery_V1_vin;

	// buffer for ClockRecovery.V1.vout
	double* m_pBuffer_ClockRecovery_V1_vout;

	// buffer from ClockRecovery.V1.clock to ClockRecovery.V1_clock.input
	int* m_pBuffer_ClockRecovery_V1_clock_To_ClockRecovery_V1_clock_input;

	// buffer for ClockRecovery.V1.voutq
	double* m_pBuffer_ClockRecovery_V1_voutq;

	// buffer for ClockRecovery.V1.clockq
	int* m_pBuffer_ClockRecovery_V1_clockq;

	// buffer from ClockRecovery.Int_to_Flt_at_V1_clock_output_2.output to ClockRecovery.G1.input
	float* m_pBuffer_ClockRecovery_Int_to_Flt_at_V1_clock_output_2_output_To_ClockRecovery_G1_input;

	// buffer from ClockRecovery.Flt_to_Int_at_G1_output.output to Int_to_Dbl_at_clock_output_1.input
	int* m_pBuffer_ClockRecovery_Flt_to_Int_at_G1_output_output_To_Int_to_Dbl_at_clock_output_1_input;

	// buffer from ClockRecovery.V1_clock.output[0] to ClockRecovery.P1.clock
	int* m_pBuffer_ClockRecovery_V1_clock_output_0__To_ClockRecovery_P1_clock;

	// buffer from ClockRecovery.V1_clock.output[1] to ClockRecovery.Int_to_Flt_at_V1_clock_output_2.input
	int* m_pBuffer_ClockRecovery_V1_clock_output_1__To_ClockRecovery_Int_to_Flt_at_V1_clock_output_2_input;

	// buffer from ClockRecovery.G1.output to ClockRecovery.Flt_to_Int_at_G1_output.input
	float* m_pBuffer_ClockRecovery_G1_output_To_ClockRecovery_Flt_to_Int_at_G1_output_input;

	// buffer from VtCTLE_FIR_output_CircularBuffer to Delay_output.input
	double* m_pBuffer_VtCTLE_FIR_output_CircularBuffer_To_Delay_output_input;

	// buffer from CTLE_Control_CTLE_Index_CircularBuffer to VtCTLE_FIR_CTLE_control_CircularBuffer
	int* m_pBuffer_CTLE_Control_CTLE_Index_CircularBuffer_To_VtCTLE_FIR_CTLE_control_CircularBuffer;

	// buffer from Int_to_Dbl_at_clock_output_1.output to ClockTimes.clock
	double* m_pBuffer_Int_to_Dbl_at_clock_output_1_output_To_ClockTimes_clock;

	// buffer from Delay_output.output[0] to CTLE_BPF_input_CircularBuffer
	double* m_pBuffer_Delay_output_output_0__To_CTLE_BPF_input_CircularBuffer;

	// buffer from Delay_output.output[1] to ClockRecovery.P1.signal
	double* m_pBuffer_Delay_output_output_1__To_ClockRecovery_P1_signal;

	// buffer from C3.output to VtCTLE_FIR_gain_control_CircularBuffer
	double* m_pBuffer_C3_output_To_VtCTLE_FIR_gain_control_CircularBuffer;

	// variable defined in Equations
	double SampleInterval;


};

