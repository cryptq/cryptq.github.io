// Copyright 2011 - 2014 Keysight Technologies, Inc   

#pragma once
#define MAX_MSG_BITS 70 // 11 bits IDENTIFIER + 3 bits DATASIZE + 56 bits MAXDATABITS
#define MAX_FRAME_BITS 114

#include "systemc.h"
namespace SystemVueModelBuilder
{
	class FramesReceiver: public sc_module 
	{
	public:
		//default constructor
		FramesReceiver( sc_module_name mName );

		//destructor
		~FramesReceiver();
		
		sc_in_clk	clkIn;
		sc_in< sc_logic > SerialIn;
		
		sc_out<sc_logic>	ErrorFrames;
		sc_out<sc_logic>	CorrectFrames;
		sc_out<sc_logic>	ReceivedFrames;

		
	private:	
		sc_lv<15> CalculateCRC();
		void ReadInput();
		void SaveInput( sc_logic valueIn );
		void ProcessInput( sc_logic valueIn );
		size_t FindLength();
		bool CheckCRC();    
		

	private:
		sc_lv<MAX_FRAME_BITS>	m_lvFrame;
		sc_lv<15> m_lvCRC;
		size_t  m_iRxBits;  
		size_t  m_iRxFrames;
		size_t  m_iRxErrorFrames;
		size_t  m_iRxCorrectFrames;
		size_t m_iSeqBits;
		size_t m_iLength;
		sc_logic m_lLastBitValue;
		bool m_bIdle;
		bool m_bNextBitStuff;
		bool m_bExpectEOF;
		bool m_bContError;
		bool m_bPendingCorrect;
	};
}
