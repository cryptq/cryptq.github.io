========================================================================
 SystemVue LTE 8.9 BEL evaluation project to create custom LTE C++ models
========================================================================

This project is preconfigured with one LTE 8.9 C++ model (LTE_CRCEncoder). 
1) LTE_CRC.h/.cc: define CRC core implementation function

2) SDFLTE_CRCEncoder.h/.cpp: define interface of LTE_CRCEncoder model where the 
   input/output ports, parameters are defined
   
3) LTE_DFParams.h/.cpp: define functions for adding new parameters

4) LTE_RangeCheck.h/.cpp: define functions for checking input parameters

5) Compile the visual studio solution/project. It will create
   a dll with the name of LTE_BEL_Eval.dll

6) Use SystemVue libray manager to load the dll and to use your model.
	run 3GPP_LTE_DL_ChannelCoding_cpp_Eval.wsv where LTE_CRCEncoder part will call this dll.