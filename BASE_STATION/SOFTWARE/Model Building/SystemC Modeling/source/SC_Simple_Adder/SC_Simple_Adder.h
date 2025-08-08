#ifndef __ADDER_H__
#define __ADDER_H__

#include "systemc.h"

class SC_Simple_Adder: 
	public sc_module
{
public:

	SC_Simple_Adder(sc_module_name name);
	~SC_Simple_Adder();	
	
	double 	aaa;
	
	sc_in<double>	inputA;
	sc_in<double>	inputB;
	sc_out<double>	outputA;

private:

	void	add();	
	
};

#endif //__ADDER_H__