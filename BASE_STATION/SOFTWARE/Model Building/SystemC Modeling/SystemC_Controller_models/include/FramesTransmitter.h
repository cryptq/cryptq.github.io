// Copyright 2011 - 2014 Keysight Technologies, Inc   
#pragma once
#define MAX_MSG_BITS 70 // 11 bits IDENTIFIER + 3 bits DATASIZE + 56 bits MAXDATABITS
#define MAX_FRAME_BITS 114

#include "systemc.h"



namespace SystemVueModelBuilder
{
	class FramesTransmitter: public sc_module 
	{
	public:
		//default constructor
		FramesTransmitter( sc_module_name mName, size_t iBufferSize = 16 );

		//destructor
		~FramesTransmitter();
		
		sc_in_clk	clkIn;
		sc_fifo_in< sc_lv<MAX_MSG_BITS> > msgIn;
		
		sc_out<sc_logic>	SerialOut;
		sc_out<sc_logic>    TxFrames;

		
	private:	
		sc_lv<15> CalculateCRC();
		void SaveMsg();
		void ProcessMsg();
		size_t FindLength();
		void GenerateOutputSignal();
		unsigned int BitStuffing();
		

	private:
		sc_lv<MAX_FRAME_BITS>	m_lvFrame;
		size_t  m_iLength;
		size_t  m_iTxFrames;
		bool m_bPostpone;
		sc_fifo< sc_lv<MAX_MSG_BITS> > m_vlvBuffer;
		
	};
}
