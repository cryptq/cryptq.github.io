// Copyright 2011 - 2014 Keysight Technologies, Inc   
#pragma once
#include "systemc.h"

namespace SystemVueModelBuilder
{
	class SystemC_ALU: 
		public sc_module
	{
	public:
		enum EnuALUMode{ ADD, SUBSTRACT, MULTIPLY, DIVIDE };
		SystemC_ALU(sc_module_name name, EnuALUMode Mode );
		~SystemC_ALU();	
			
		sc_in<double>	inputA;
		sc_in<double>	inputB;
		sc_out<double>	outputA;

	private:

		void	Calculate();	
		EnuALUMode m_eMode;
	};
}

