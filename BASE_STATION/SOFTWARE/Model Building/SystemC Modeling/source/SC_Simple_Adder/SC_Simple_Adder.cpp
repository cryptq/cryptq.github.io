#include "SC_Simple_Adder.h"

SC_HAS_PROCESS(SC_Simple_Adder);

SC_Simple_Adder::SC_Simple_Adder(sc_module_name name):
sc_module(name)
{
	SC_METHOD(add);	
	sensitive<<inputA<<inputB;
}

SC_Simple_Adder::~SC_Simple_Adder()
{
}

void SC_Simple_Adder::add()
{	
	outputA.write(inputA.read() + inputB.read());	    
};