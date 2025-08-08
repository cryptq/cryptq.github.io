/*
 * RxAdaptiveCTLE.cpp
 * Created by SystemVue C++ Code Generator
 * Copyright © 2000-2014, Keysight Technologies, Inc.
 */

#include "RxAdaptiveCTLE.h"

#ifndef SV_CODE_GEN
DEFINE_MODEL_INTERFACE(RxAdaptiveCTLE)
{
	ADD_MODEL_INPUT( input );
	ADD_MODEL_OUTPUT( output );
	ADD_MODEL_OUTPUT( clockTimes );
	SystemVueModelBuilder::DFParam BitTime_DFParam = ADD_MODEL_PARAM(BitTime);
	BitTime_DFParam.SetDescription("Bit time");
	BitTime_DFParam.SetUnit(SystemVueModelBuilder::Units::TIME);
	SystemVueModelBuilder::DFParam SamplesPerBit_DFParam = ADD_MODEL_PARAM(SamplesPerBit);
	SamplesPerBit_DFParam.SetDescription("Samples per bit");
	SystemVueModelBuilder::DFParam NumBitsToAvg_DFParam = ADD_MODEL_PARAM(NumBitsToAvg);
	NumBitsToAvg_DFParam.SetDescription("Number of bits to average for detection");
	SystemVueModelBuilder::DFParam TargetV_DFParam = ADD_MODEL_PARAM(TargetV);
	TargetV_DFParam.SetDescription("Target detection voltage");
	SystemVueModelBuilder::DFParam ThresholdV_DFParam = ADD_MODEL_PARAM(ThresholdV);
	ThresholdV_DFParam.SetDescription("Target detection threshold voltage");
	SystemVueModelBuilder::DFParam CTLE_Init_DFParam = ADD_MODEL_PARAM(CTLE_Init);
	CTLE_Init_DFParam.SetDescription("Initial CTLE value");
	SystemVueModelBuilder::DFParam EnableAdaption_DFParam = ADD_MODEL_PARAM(EnableAdaption);
	EnableAdaption_DFParam.SetDescription("Enable the controlling of CTLE taps");
	return true;
}
#endif

RxAdaptiveCTLE::RxAdaptiveCTLE()
{
	m_pBuffer_input_To_VtCTLE_FIR_input_CircularBuffer = NULL;
	m_pBuffer_Delay_output_output_2__To_output = NULL;
	m_pBuffer_ClockTimes_time_To_clockTimes = NULL;
	m_pBuffer_CTLE_Detection_output_CircularBuffer_To_CTLE_Control_DetV_CircularBuffer = NULL;
	m_pBuffer_CTLE_BPF_output_CircularBuffer_To_CTLE_Detection_input_CircularBuffer = NULL;
	m_pBuffer_ClockRecovery_P1_phaseError_To_ClockRecovery_V1_vin = NULL;
	m_pBuffer_ClockRecovery_V1_vout = NULL;
	m_pBuffer_ClockRecovery_V1_clock_To_ClockRecovery_V1_clock_input = NULL;
	m_pBuffer_ClockRecovery_V1_voutq = NULL;
	m_pBuffer_ClockRecovery_V1_clockq = NULL;
	m_pBuffer_ClockRecovery_Int_to_Flt_at_V1_clock_output_2_output_To_ClockRecovery_G1_input = NULL;
	m_pBuffer_ClockRecovery_Flt_to_Int_at_G1_output_output_To_Int_to_Dbl_at_clock_output_1_input = NULL;
	m_pBuffer_ClockRecovery_V1_clock_output_0__To_ClockRecovery_P1_clock = NULL;
	m_pBuffer_ClockRecovery_V1_clock_output_1__To_ClockRecovery_Int_to_Flt_at_V1_clock_output_2_input = NULL;
	m_pBuffer_ClockRecovery_G1_output_To_ClockRecovery_Flt_to_Int_at_G1_output_input = NULL;
	m_pBuffer_VtCTLE_FIR_output_CircularBuffer_To_Delay_output_input = NULL;
	m_pBuffer_CTLE_Control_CTLE_Index_CircularBuffer_To_VtCTLE_FIR_CTLE_control_CircularBuffer = NULL;
	m_pBuffer_Int_to_Dbl_at_clock_output_1_output_To_ClockTimes_clock = NULL;
	m_pBuffer_Delay_output_output_0__To_CTLE_BPF_input_CircularBuffer = NULL;
	m_pBuffer_Delay_output_output_1__To_ClockRecovery_P1_signal = NULL;
	m_pBuffer_C3_output_To_VtCTLE_FIR_gain_control_CircularBuffer = NULL;
	BitTime = 1.000000000000000e-010;
	SamplesPerBit = 64;
	NumBitsToAvg = 200;
	TargetV = 0.1500000000000000;
	ThresholdV = 0.01500000000000000;
	CTLE_Init = 7;
	EnableAdaption = 1;
}

RxAdaptiveCTLE::~RxAdaptiveCTLE()
{
	DeleteBuffers();
}

void RxAdaptiveCTLE::DeleteBuffers()
{
	delete[] m_pBuffer_input_To_VtCTLE_FIR_input_CircularBuffer;
	m_pBuffer_input_To_VtCTLE_FIR_input_CircularBuffer = NULL;
	delete[] m_pBuffer_Delay_output_output_2__To_output;
	m_pBuffer_Delay_output_output_2__To_output = NULL;
	delete[] m_pBuffer_ClockTimes_time_To_clockTimes;
	m_pBuffer_ClockTimes_time_To_clockTimes = NULL;
	delete[] m_pBuffer_CTLE_Detection_output_CircularBuffer_To_CTLE_Control_DetV_CircularBuffer;
	m_pBuffer_CTLE_Detection_output_CircularBuffer_To_CTLE_Control_DetV_CircularBuffer = NULL;
	delete[] m_pBuffer_CTLE_BPF_output_CircularBuffer_To_CTLE_Detection_input_CircularBuffer;
	m_pBuffer_CTLE_BPF_output_CircularBuffer_To_CTLE_Detection_input_CircularBuffer = NULL;
	delete[] m_pBuffer_ClockRecovery_P1_phaseError_To_ClockRecovery_V1_vin;
	m_pBuffer_ClockRecovery_P1_phaseError_To_ClockRecovery_V1_vin = NULL;
	delete[] m_pBuffer_ClockRecovery_V1_vout;
	m_pBuffer_ClockRecovery_V1_vout = NULL;
	delete[] m_pBuffer_ClockRecovery_V1_clock_To_ClockRecovery_V1_clock_input;
	m_pBuffer_ClockRecovery_V1_clock_To_ClockRecovery_V1_clock_input = NULL;
	delete[] m_pBuffer_ClockRecovery_V1_voutq;
	m_pBuffer_ClockRecovery_V1_voutq = NULL;
	delete[] m_pBuffer_ClockRecovery_V1_clockq;
	m_pBuffer_ClockRecovery_V1_clockq = NULL;
	delete[] m_pBuffer_ClockRecovery_Int_to_Flt_at_V1_clock_output_2_output_To_ClockRecovery_G1_input;
	m_pBuffer_ClockRecovery_Int_to_Flt_at_V1_clock_output_2_output_To_ClockRecovery_G1_input = NULL;
	delete[] m_pBuffer_ClockRecovery_Flt_to_Int_at_G1_output_output_To_Int_to_Dbl_at_clock_output_1_input;
	m_pBuffer_ClockRecovery_Flt_to_Int_at_G1_output_output_To_Int_to_Dbl_at_clock_output_1_input = NULL;
	delete[] m_pBuffer_ClockRecovery_V1_clock_output_0__To_ClockRecovery_P1_clock;
	m_pBuffer_ClockRecovery_V1_clock_output_0__To_ClockRecovery_P1_clock = NULL;
	delete[] m_pBuffer_ClockRecovery_V1_clock_output_1__To_ClockRecovery_Int_to_Flt_at_V1_clock_output_2_input;
	m_pBuffer_ClockRecovery_V1_clock_output_1__To_ClockRecovery_Int_to_Flt_at_V1_clock_output_2_input = NULL;
	delete[] m_pBuffer_ClockRecovery_G1_output_To_ClockRecovery_Flt_to_Int_at_G1_output_input;
	m_pBuffer_ClockRecovery_G1_output_To_ClockRecovery_Flt_to_Int_at_G1_output_input = NULL;
	delete[] m_pBuffer_VtCTLE_FIR_output_CircularBuffer_To_Delay_output_input;
	m_pBuffer_VtCTLE_FIR_output_CircularBuffer_To_Delay_output_input = NULL;
	delete[] m_pBuffer_CTLE_Control_CTLE_Index_CircularBuffer_To_VtCTLE_FIR_CTLE_control_CircularBuffer;
	m_pBuffer_CTLE_Control_CTLE_Index_CircularBuffer_To_VtCTLE_FIR_CTLE_control_CircularBuffer = NULL;
	delete[] m_pBuffer_Int_to_Dbl_at_clock_output_1_output_To_ClockTimes_clock;
	m_pBuffer_Int_to_Dbl_at_clock_output_1_output_To_ClockTimes_clock = NULL;
	delete[] m_pBuffer_Delay_output_output_0__To_CTLE_BPF_input_CircularBuffer;
	m_pBuffer_Delay_output_output_0__To_CTLE_BPF_input_CircularBuffer = NULL;
	delete[] m_pBuffer_Delay_output_output_1__To_ClockRecovery_P1_signal;
	m_pBuffer_Delay_output_output_1__To_ClockRecovery_P1_signal = NULL;
	delete[] m_pBuffer_C3_output_To_VtCTLE_FIR_gain_control_CircularBuffer;
	m_pBuffer_C3_output_To_VtCTLE_FIR_gain_control_CircularBuffer = NULL;
}

bool RxAdaptiveCTLE::RunEquations()
{
	SampleInterval = ( BitTime / SamplesPerBit );

	return true;
}

bool RxAdaptiveCTLE::Setup()
{
	bool bStatus = true;

	RunEquations();

	//setup models and their parameters
	ClockRecovery.BitTime = BitTime;
	ClockRecovery.SamplesPerBit = SamplesPerBit;
	ClockRecovery.BitCenter = 1;
	ClockRecovery.Enable_LoopFilter = false;
	ClockRecovery.FilterPole = 20000;
	ClockRecovery.FilterZero = 30000;
	ClockRecovery.FilterGain = 1;
	bStatus &= ClockRecovery.Setup();

	//CTLE_Detection CTLE_Detection
	CTLE_Detection.SamplesPerBit = SamplesPerBit;
	CTLE_Detection.NumBitsToAvg = NumBitsToAvg;
	CTLE_Detection.TargetV = TargetV;
	bStatus &= CTLE_Detection.Setup();

	//CTLE_BPF CTLE_BPF
	CTLE_BPF.SampleInterval = SampleInterval;
	bStatus &= CTLE_BPF.Setup();

	//SystemVueModelBuilder::ClockTimes ClockTimes
	ClockTimes.SampleInterval = SampleInterval;
	ClockTimes.ClockEdge = (SystemVueModelBuilder::ClockTimes::ClockEdgeE)(int)0;
	ClockTimes.Offset = 0;
	ClockTimes.TimingMethod = (SystemVueModelBuilder::ClockTimes::TimingMethodE)(int)0;
	bStatus &= ClockTimes.Setup();

	//VtCTLE_FIR VtCTLE_FIR
	VtCTLE_FIR.SampleInterval = SampleInterval;
	bStatus &= VtCTLE_FIR.Setup();

	//CTLE_Control CTLE_Control
	CTLE_Control.BitRate = 10000000000.00000;
	CTLE_Control.SamplesPerBit = SamplesPerBit;
	CTLE_Control.NumBitsToAvg = NumBitsToAvg;
	CTLE_Control.TargetV = TargetV;
	CTLE_Control.ThresholdV = ThresholdV;
	CTLE_Control.IndexInit = CTLE_Init;
	CTLE_Control.EnableEq = (CTLE_Control::EnableEqE)(int)EnableAdaption;
	bStatus &= CTLE_Control.Setup();

	//SystemVueModelBuilder::ScalarToScalar< SystemVueModelBuilder::CircularBuffer< int >,SystemVueModelBuilder::CircularBuffer< double > > Int_to_Dbl_at_clock_output_1
	bStatus &= Int_to_Dbl_at_clock_output_1.Setup();

	//SystemVueModelBuilder::Fork< SystemVueModelBuilder::CircularBuffer< double > > Delay_output
	Delay_output.output.Initialize(3);
	bStatus &= Delay_output.Setup();

	//SystemVueModelBuilder::ConstUnTimed< double > C3
	C3.m_iInitialDelay = 0;
	C3.Value = 1;
	bStatus &= C3.Setup();

	//setup input and output dataflow rates
	input.SetRate(1);
	output.SetRate(1);
	clockTimes.SetRate(1);

	return bStatus;
}

bool RxAdaptiveCTLE::Initialize()
{
	bool bStatus = true;

	DeleteBuffers();

	//allocate buffer from input to VtCTLE_FIR_input_CircularBuffer
	m_pBuffer_input_To_VtCTLE_FIR_input_CircularBuffer = new double[1];
	input_CirBuf.SetBuffer(m_pBuffer_input_To_VtCTLE_FIR_input_CircularBuffer, 1, 1, 0);
	VtCTLE_FIR_input_CircularBuffer.SetBuffer(m_pBuffer_input_To_VtCTLE_FIR_input_CircularBuffer, 1, 1, 0);

	//allocate buffer from Delay_output.output[2] to output
	m_pBuffer_Delay_output_output_2__To_output = new double[1];
	output_CirBuf.SetBuffer(m_pBuffer_Delay_output_output_2__To_output, 1, 1, 0);
	Delay_output.output[2].SetBuffer(m_pBuffer_Delay_output_output_2__To_output, 1, 1, 0);

	//allocate buffer from ClockTimes.time to clockTimes
	m_pBuffer_ClockTimes_time_To_clockTimes = new double[1];
	clockTimes_CirBuf.SetBuffer(m_pBuffer_ClockTimes_time_To_clockTimes, 1, 1, 0);
	ClockTimes.time.SetBuffer(m_pBuffer_ClockTimes_time_To_clockTimes, 1, 1, 0);

	//allocate buffer from CTLE_Detection_output_CircularBuffer to CTLE_Control_DetV_CircularBuffer
	m_pBuffer_CTLE_Detection_output_CircularBuffer_To_CTLE_Control_DetV_CircularBuffer = new double[1];
	CTLE_Detection_output_CircularBuffer.SetBuffer(m_pBuffer_CTLE_Detection_output_CircularBuffer_To_CTLE_Control_DetV_CircularBuffer, 1, 1, 0);
	CTLE_Control_DetV_CircularBuffer.SetBuffer(m_pBuffer_CTLE_Detection_output_CircularBuffer_To_CTLE_Control_DetV_CircularBuffer, 1, 1, 0);

	//allocate buffer from CTLE_BPF_output_CircularBuffer to CTLE_Detection_input_CircularBuffer
	m_pBuffer_CTLE_BPF_output_CircularBuffer_To_CTLE_Detection_input_CircularBuffer = new double[1];
	CTLE_BPF_output_CircularBuffer.SetBuffer(m_pBuffer_CTLE_BPF_output_CircularBuffer_To_CTLE_Detection_input_CircularBuffer, 1, 1, 0);
	CTLE_Detection_input_CircularBuffer.SetBuffer(m_pBuffer_CTLE_BPF_output_CircularBuffer_To_CTLE_Detection_input_CircularBuffer, 1, 1, 0);

	//allocate buffer from ClockRecovery.P1.phaseError to ClockRecovery.V1.vin
	m_pBuffer_ClockRecovery_P1_phaseError_To_ClockRecovery_V1_vin = new double[1];
	ClockRecovery.P1.phaseError.SetBuffer(m_pBuffer_ClockRecovery_P1_phaseError_To_ClockRecovery_V1_vin, 1, 1, 0);
	ClockRecovery.V1.vin.SetBuffer(m_pBuffer_ClockRecovery_P1_phaseError_To_ClockRecovery_V1_vin, 1, 1, 0);
	ClockRecovery.V1.vin.Zero(0, 1, NULL);

	//allocate buffer for ClockRecovery.V1.vout
	m_pBuffer_ClockRecovery_V1_vout = new double[1];
	ClockRecovery.V1.vout.SetBuffer(m_pBuffer_ClockRecovery_V1_vout, 1, 1, 0);

	//allocate buffer from ClockRecovery.V1.clock to ClockRecovery.V1_clock.input
	m_pBuffer_ClockRecovery_V1_clock_To_ClockRecovery_V1_clock_input = new int[1];
	ClockRecovery.V1.clock.SetBuffer(m_pBuffer_ClockRecovery_V1_clock_To_ClockRecovery_V1_clock_input, 1, 1, 0);
	ClockRecovery.V1_clock.input.SetBuffer(m_pBuffer_ClockRecovery_V1_clock_To_ClockRecovery_V1_clock_input, 1, 1, 0);

	//allocate buffer for ClockRecovery.V1.voutq
	m_pBuffer_ClockRecovery_V1_voutq = new double[1];
	ClockRecovery.V1.voutq.SetBuffer(m_pBuffer_ClockRecovery_V1_voutq, 1, 1, 0);

	//allocate buffer for ClockRecovery.V1.clockq
	m_pBuffer_ClockRecovery_V1_clockq = new int[1];
	ClockRecovery.V1.clockq.SetBuffer(m_pBuffer_ClockRecovery_V1_clockq, 1, 1, 0);

	//allocate buffer from ClockRecovery.Int_to_Flt_at_V1_clock_output_2.output to ClockRecovery.G1.input
	m_pBuffer_ClockRecovery_Int_to_Flt_at_V1_clock_output_2_output_To_ClockRecovery_G1_input = new float[1];
	ClockRecovery.Int_to_Flt_at_V1_clock_output_2.output.SetBuffer(m_pBuffer_ClockRecovery_Int_to_Flt_at_V1_clock_output_2_output_To_ClockRecovery_G1_input, 1, 1, 0);
	ClockRecovery.G1.input.SetBuffer(m_pBuffer_ClockRecovery_Int_to_Flt_at_V1_clock_output_2_output_To_ClockRecovery_G1_input, 1, 1, 0);

	//allocate buffer from ClockRecovery.Flt_to_Int_at_G1_output.output to Int_to_Dbl_at_clock_output_1.input
	m_pBuffer_ClockRecovery_Flt_to_Int_at_G1_output_output_To_Int_to_Dbl_at_clock_output_1_input = new int[1];
	ClockRecovery.Flt_to_Int_at_G1_output.output.SetBuffer(m_pBuffer_ClockRecovery_Flt_to_Int_at_G1_output_output_To_Int_to_Dbl_at_clock_output_1_input, 1, 1, 0);
	Int_to_Dbl_at_clock_output_1.input.SetBuffer(m_pBuffer_ClockRecovery_Flt_to_Int_at_G1_output_output_To_Int_to_Dbl_at_clock_output_1_input, 1, 1, 0);

	//allocate buffer from ClockRecovery.V1_clock.output[0] to ClockRecovery.P1.clock
	m_pBuffer_ClockRecovery_V1_clock_output_0__To_ClockRecovery_P1_clock = new int[1];
	ClockRecovery.V1_clock.output[0].SetBuffer(m_pBuffer_ClockRecovery_V1_clock_output_0__To_ClockRecovery_P1_clock, 1, 1, 0);
	ClockRecovery.P1.clock.SetBuffer(m_pBuffer_ClockRecovery_V1_clock_output_0__To_ClockRecovery_P1_clock, 1, 1, 0);

	//allocate buffer from ClockRecovery.V1_clock.output[1] to ClockRecovery.Int_to_Flt_at_V1_clock_output_2.input
	m_pBuffer_ClockRecovery_V1_clock_output_1__To_ClockRecovery_Int_to_Flt_at_V1_clock_output_2_input = new int[1];
	ClockRecovery.V1_clock.output[1].SetBuffer(m_pBuffer_ClockRecovery_V1_clock_output_1__To_ClockRecovery_Int_to_Flt_at_V1_clock_output_2_input, 1, 1, 0);
	ClockRecovery.Int_to_Flt_at_V1_clock_output_2.input.SetBuffer(m_pBuffer_ClockRecovery_V1_clock_output_1__To_ClockRecovery_Int_to_Flt_at_V1_clock_output_2_input, 1, 1, 0);

	//allocate buffer from ClockRecovery.G1.output to ClockRecovery.Flt_to_Int_at_G1_output.input
	m_pBuffer_ClockRecovery_G1_output_To_ClockRecovery_Flt_to_Int_at_G1_output_input = new float[1];
	ClockRecovery.G1.output.SetBuffer(m_pBuffer_ClockRecovery_G1_output_To_ClockRecovery_Flt_to_Int_at_G1_output_input, 1, 1, 0);
	ClockRecovery.Flt_to_Int_at_G1_output.input.SetBuffer(m_pBuffer_ClockRecovery_G1_output_To_ClockRecovery_Flt_to_Int_at_G1_output_input, 1, 1, 0);

	//allocate buffer from VtCTLE_FIR_output_CircularBuffer to Delay_output.input
	m_pBuffer_VtCTLE_FIR_output_CircularBuffer_To_Delay_output_input = new double[1];
	VtCTLE_FIR_output_CircularBuffer.SetBuffer(m_pBuffer_VtCTLE_FIR_output_CircularBuffer_To_Delay_output_input, 1, 1, 0);
	Delay_output.input.SetBuffer(m_pBuffer_VtCTLE_FIR_output_CircularBuffer_To_Delay_output_input, 1, 1, 0);
	Delay_output.input.Zero(0, 1, NULL);

	//allocate buffer from CTLE_Control_CTLE_Index_CircularBuffer to VtCTLE_FIR_CTLE_control_CircularBuffer
	m_pBuffer_CTLE_Control_CTLE_Index_CircularBuffer_To_VtCTLE_FIR_CTLE_control_CircularBuffer = new int[1];
	CTLE_Control_CTLE_Index_CircularBuffer.SetBuffer(m_pBuffer_CTLE_Control_CTLE_Index_CircularBuffer_To_VtCTLE_FIR_CTLE_control_CircularBuffer, 1, 1, 0);
	VtCTLE_FIR_CTLE_control_CircularBuffer.SetBuffer(m_pBuffer_CTLE_Control_CTLE_Index_CircularBuffer_To_VtCTLE_FIR_CTLE_control_CircularBuffer, 1, 1, 0);

	//allocate buffer from Int_to_Dbl_at_clock_output_1.output to ClockTimes.clock
	m_pBuffer_Int_to_Dbl_at_clock_output_1_output_To_ClockTimes_clock = new double[1];
	Int_to_Dbl_at_clock_output_1.output.SetBuffer(m_pBuffer_Int_to_Dbl_at_clock_output_1_output_To_ClockTimes_clock, 1, 1, 0);
	ClockTimes.clock.SetBuffer(m_pBuffer_Int_to_Dbl_at_clock_output_1_output_To_ClockTimes_clock, 1, 1, 0);

	//allocate buffer from Delay_output.output[0] to CTLE_BPF_input_CircularBuffer
	m_pBuffer_Delay_output_output_0__To_CTLE_BPF_input_CircularBuffer = new double[1];
	Delay_output.output[0].SetBuffer(m_pBuffer_Delay_output_output_0__To_CTLE_BPF_input_CircularBuffer, 1, 1, 0);
	CTLE_BPF_input_CircularBuffer.SetBuffer(m_pBuffer_Delay_output_output_0__To_CTLE_BPF_input_CircularBuffer, 1, 1, 0);

	//allocate buffer from Delay_output.output[1] to ClockRecovery.P1.signal
	m_pBuffer_Delay_output_output_1__To_ClockRecovery_P1_signal = new double[1];
	Delay_output.output[1].SetBuffer(m_pBuffer_Delay_output_output_1__To_ClockRecovery_P1_signal, 1, 1, 0);
	ClockRecovery.P1.signal.SetBuffer(m_pBuffer_Delay_output_output_1__To_ClockRecovery_P1_signal, 1, 1, 0);

	//allocate buffer from C3.output to VtCTLE_FIR_gain_control_CircularBuffer
	m_pBuffer_C3_output_To_VtCTLE_FIR_gain_control_CircularBuffer = new double[1];
	C3.output.SetBuffer(m_pBuffer_C3_output_To_VtCTLE_FIR_gain_control_CircularBuffer, 1, 1, 0);
	VtCTLE_FIR_gain_control_CircularBuffer.SetBuffer(m_pBuffer_C3_output_To_VtCTLE_FIR_gain_control_CircularBuffer, 1, 1, 0);

	//initialize models
	bStatus &= CTLE_Detection.Initialize();
	bStatus &= CTLE_BPF.Initialize();
	bStatus &= ClockRecovery.P1.Initialize();
	bStatus &= ClockRecovery.V1.Initialize();
	bStatus &= ClockRecovery.Int_to_Flt_at_V1_clock_output_2.Initialize();
	bStatus &= ClockRecovery.Flt_to_Int_at_G1_output.Initialize();
	bStatus &= ClockRecovery.V1_clock.Initialize();
	bStatus &= ClockRecovery.G1.Initialize();
	bStatus &= ClockTimes.Initialize();
	bStatus &= VtCTLE_FIR.Initialize();
	bStatus &= CTLE_Control.Initialize();
	bStatus &= Int_to_Dbl_at_clock_output_1.Initialize();
	bStatus &= Delay_output.Initialize();
	bStatus &= C3.Initialize();

	return bStatus;
}

bool RxAdaptiveCTLE::Run()
{
	bool bStatus = true;

	//copy samples from inputs
	input.Copy(0, &input_CirBuf, 0, 1);

	//execute schedule
	//SystemVueModelBuilder::ConstUnTimed< double > C3
	bStatus &= C3.Run();

	//SystemVueModelBuilder::Fork< SystemVueModelBuilder::CircularBuffer< double > > Delay_output
	bStatus &= Delay_output.Run();

	//CTLE_BPF CTLE_BPF
	CTLE_BPF.input = CTLE_BPF_input_CircularBuffer[0];
	bStatus &= CTLE_BPF.Run();
	CTLE_BPF_output_CircularBuffer[0] = CTLE_BPF.output;

	//CTLE_Detection CTLE_Detection
	CTLE_Detection.input = CTLE_Detection_input_CircularBuffer[0];
	bStatus &= CTLE_Detection.Run();
	CTLE_Detection_output_CircularBuffer[0] = CTLE_Detection.output;

	//CTLE_Control CTLE_Control
	CTLE_Control.DetV = CTLE_Control_DetV_CircularBuffer[0];
	bStatus &= CTLE_Control.Run();
	CTLE_Control_CTLE_Index_CircularBuffer[0] = CTLE_Control.CTLE_Index;

	//VtCTLE_FIR VtCTLE_FIR
	VtCTLE_FIR.input = VtCTLE_FIR_input_CircularBuffer[0];
	VtCTLE_FIR.CTLE_control = VtCTLE_FIR_CTLE_control_CircularBuffer[0];
	VtCTLE_FIR.gain_control = VtCTLE_FIR_gain_control_CircularBuffer[0];
	bStatus &= VtCTLE_FIR.Run();
	VtCTLE_FIR_output_CircularBuffer[0] = VtCTLE_FIR.output;

	//SystemVueModelBuilder::VCO ClockRecovery.V1
	bStatus &= ClockRecovery.V1.Run();

	//SystemVueModelBuilder::Fork< SystemVueModelBuilder::CircularBuffer< int > > ClockRecovery.V1_clock
	bStatus &= ClockRecovery.V1_clock.Run();

	//SystemVueModelBuilder::PhaseDetector ClockRecovery.P1
	bStatus &= ClockRecovery.P1.Run();

	//SystemVueModelBuilder::ScalarToScalar< SystemVueModelBuilder::CircularBuffer< int >,SystemVueModelBuilder::CircularBuffer< float > > ClockRecovery.Int_to_Flt_at_V1_clock_output_2
	bStatus &= ClockRecovery.Int_to_Flt_at_V1_clock_output_2.Run();

	//SystemVueModelBuilder::Gain< float > ClockRecovery.G1
	bStatus &= ClockRecovery.G1.Run();

	//SystemVueModelBuilder::ScalarToScalar< SystemVueModelBuilder::CircularBuffer< float >,SystemVueModelBuilder::CircularBuffer< int >, SystemVueModelBuilder::TypeConverterRound > ClockRecovery.Flt_to_Int_at_G1_output
	bStatus &= ClockRecovery.Flt_to_Int_at_G1_output.Run();

	//SystemVueModelBuilder::ScalarToScalar< SystemVueModelBuilder::CircularBuffer< int >,SystemVueModelBuilder::CircularBuffer< double > > Int_to_Dbl_at_clock_output_1
	bStatus &= Int_to_Dbl_at_clock_output_1.Run();

	//SystemVueModelBuilder::ClockTimes ClockTimes
	bStatus &= ClockTimes.Run();


	//copy samples to outputs
	output_CirBuf.Copy(0, &output, 0, 1);
	clockTimes_CirBuf.Copy(0, &clockTimes, 0, 1);

	return bStatus;
}

bool RxAdaptiveCTLE::Finalize()
{
	bool bStatus = true;

	//finalize models
	bStatus &= CTLE_Detection.Finalize();
	bStatus &= CTLE_BPF.Finalize();
	bStatus &= ClockRecovery.P1.Finalize();
	bStatus &= ClockRecovery.V1.Finalize();
	bStatus &= ClockRecovery.Int_to_Flt_at_V1_clock_output_2.Finalize();
	bStatus &= ClockRecovery.Flt_to_Int_at_G1_output.Finalize();
	bStatus &= ClockRecovery.V1_clock.Finalize();
	bStatus &= ClockRecovery.G1.Finalize();
	bStatus &= ClockTimes.Finalize();
	bStatus &= VtCTLE_FIR.Finalize();
	bStatus &= CTLE_Control.Finalize();
	bStatus &= Int_to_Dbl_at_clock_output_1.Finalize();
	bStatus &= Delay_output.Finalize();
	bStatus &= C3.Finalize();

	DeleteBuffers();

	return bStatus;
}

RxAdaptiveCTLE::Subnetwork_ClockRecovery::Subnetwork_ClockRecovery()
{
	BitTime = 1.000000000000000e-010;
	SamplesPerBit = 64;
	BitCenter = 1;
	Enable_LoopFilter = false;
	FilterPole = 20000.00000000000;
	FilterZero = 30000.00000000000;
	FilterGain = 1.000000000000000;
}

bool RxAdaptiveCTLE::Subnetwork_ClockRecovery::RunEquations()
{
	SampleInterval = ( BitTime / SamplesPerBit );

	return true;
}

bool RxAdaptiveCTLE::Subnetwork_ClockRecovery::Setup()
{
	bool bStatus = true;

	RunEquations();

	//setup models and their parameters
	//SystemVueModelBuilder::PhaseDetector ClockRecovery.P1
	P1.BitCenter = (SystemVueModelBuilder::PhaseDetector::ClockEdgeE)(int)BitCenter;
	bStatus &= P1.Setup();

	//SystemVueModelBuilder::VCO ClockRecovery.V1
	V1.SampleInterval = SampleInterval;
	V1.Frequency = ( ( 1 / SampleInterval ) / SamplesPerBit );
	V1.Sensitivity = ( ( ( 1 / SampleInterval ) / ( 2 * 3.1415926535897932 ) ) / 10 );
	V1.InitialPhase = 0;
	V1.Amplitude = 1;
	V1.InvertQuadrature = (SystemVueModelBuilder::QueryEnum)(int)0;
	bStatus &= V1.Setup();

	//SystemVueModelBuilder::ScalarToScalar< SystemVueModelBuilder::CircularBuffer< int >,SystemVueModelBuilder::CircularBuffer< float > > ClockRecovery.Int_to_Flt_at_V1_clock_output_2
	bStatus &= Int_to_Flt_at_V1_clock_output_2.Setup();

	//SystemVueModelBuilder::ScalarToScalar< SystemVueModelBuilder::CircularBuffer< float >,SystemVueModelBuilder::CircularBuffer< int >, SystemVueModelBuilder::TypeConverterRound > ClockRecovery.Flt_to_Int_at_G1_output
	bStatus &= Flt_to_Int_at_G1_output.Setup();

	//SystemVueModelBuilder::Fork< SystemVueModelBuilder::CircularBuffer< int > > ClockRecovery.V1_clock
	V1_clock.output.Initialize(2);
	bStatus &= V1_clock.Setup();

	//SystemVueModelBuilder::Gain< float > ClockRecovery.G1
	G1.m_Gain = 1;
	bStatus &= G1.Setup();

	return bStatus;
}


