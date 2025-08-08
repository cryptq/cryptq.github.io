#ifndef __ADDER_H__
#define __ADDER_H__

#include "systemc.h"

template<typename T>
class Template_Adder: 
	public sc_module
{
public:

	Template_Adder(sc_module_name name);
	~Template_Adder();	
	
	sc_in<T>	inputA;
	sc_in<T>	inputB;
	sc_out<T>	result;

private:

	void	add();	
	
};

template<typename T>
Template_Adder<T>::Template_Adder(sc_module_name name):
sc_module(name)
{
	SC_HAS_PROCESS(Template_Adder);
	SC_METHOD(add);	
	sensitive << inputA << inputB;
}

template<typename T>
Template_Adder<T>::~Template_Adder()
{
}

template<typename T>
void Template_Adder<T>::add()
{	
	result.write(inputA.read() + inputB.read());	    
};

#endif //__ADDER_H__