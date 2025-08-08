// Copyright 2011 - 2014 Keysight Technologies, Inc   

#pragma once
#define MAX_MSG_BITS 70 // 11 bits IDENTIFIER + 3 bits DATASIZE + 56 bits MAXDATABITS

#include "systemc.h"
namespace SystemVueModelBuilder
{
	class FramesCreator: public sc_module 
	{
	public:
		//default constructor
		FramesCreator( sc_module_name mName );

		//destructor
		~FramesCreator();
		
		sc_in_clk	clkIn;
		sc_out< sc_lv<MAX_MSG_BITS> > msgOut;	

		
	private:	
		
		void GenerateOutput();    

	private:
		size_t uiClockTicks; // after uiClockTicks generate a msg
		
	};
}