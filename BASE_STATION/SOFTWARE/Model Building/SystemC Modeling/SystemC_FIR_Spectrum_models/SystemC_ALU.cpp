// Copyright 2011 - 2014 Keysight Technologies, Inc   
#include "SystemC_ALU.h"

namespace SystemVueModelBuilder
{
	SC_HAS_PROCESS(SystemC_ALU);

	SystemC_ALU::SystemC_ALU(sc_module_name name, EnuALUMode Mode):
	sc_module(name),
	m_eMode(Mode)
	{
		SC_METHOD(Calculate);	
		sensitive<<inputA<<inputB;
	}

	SystemC_ALU::~SystemC_ALU()
	{
	}

	void SystemC_ALU::Calculate()
	{	
		switch(m_eMode)
		{
		case ADD:
			outputA.write(inputA.read() + inputB.read());	 
			break;
		case SUBSTRACT:
			outputA.write(inputA.read() - inputB.read());	 
			break;
		case MULTIPLY:
			outputA.write(inputA.read() * inputB.read());	 
			break;
		case DIVIDE:
			outputA.write(inputA.read() / inputB.read());	 
			break;
		default:
			;//error
		}
		   
	};
}