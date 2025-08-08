// Copyright 2011 - 2014 Keysight Technologies, Inc   
//------------------------------------------------------------------------------
// 
//	Vendor: KeysightEEsof
//	FileName: LTE_CRC.h
//	Description: LTE CRC function
//	Date: 2009/07/09 02:17:30 
//------------------------------------------------------------------------------

#include "LTE_CRC.h"

/// CRC calculation based on subclause 5.1.1 of 3GPP TS 36.212 V8.4.0
/// <param name="crcLength">CRC length.</param>
/// <param name="mask">Generator function used in CRC calculation.</param>
/// <param name="MyInitialState">Initial state.</param>
/// <param name="MyMessageLength">Number of input bits to the CRC computation.</param>
/// <param name="frameP">Input bits.</param>
/// <param name="CRC_P">Parity bits.</param>
void CRC(int crcLength, int mask, int MyInitialState, int MyMessageLength,int * frameP, int * CRC_P)
{
	//nowState is the current state of feed back of generator.
	int i, nowState;    
	int modul;

	//the upper bound value of shift register
	modul  = 1 << crcLength;               

	//remove the MSB of the mask which is of no use in computing.
	mask = mask & (modul-1);               

	// initialize the registor state
	int regState = MyInitialState;         

	//Do the dividing, while the times is according to the data length
	for (i = 0; i < MyMessageLength ; i++)             
	{
		regState <<=  1;

		//regState >=  modul indicates that the shifted-out bit is '1'.
		if ( regState >= modul)                          
		{
			//keep the value of regState below the upper bound.
			regState -= modul;                          
			nowState = 0;
			if (frameP [i] == 0)
				//if current input of generator is 0 then the feedback is '1'
				//so the register will exculsive OR with the mask.
				nowState = mask;                       
		}
		else                                            
		{
			//the shifted-out bit is '0'.

			nowState = mask;

			//if the input bit is '0' then the feed back will be '0'
			if (frameP [i] == 0)                        
				nowState = 0;
		}
		 // update regState
		regState = nowState ^ regState; 
	}

	//export the frame quality indicator bit.
	for (i = 0; i < crcLength; i++ )
	{
		//Use this variable to test the bit in register, the MSB is exported first.
		modul  =  modul>>1;                             

		if ((modul & regState) == 0)
			//if that bit doesn't equal to zero, it equals to 1.
			CRC_P [i] = 0;                           
		else
			CRC_P [i] = 1;
	}
}
