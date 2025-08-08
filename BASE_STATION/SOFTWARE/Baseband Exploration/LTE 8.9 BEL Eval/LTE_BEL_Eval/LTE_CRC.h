//------------------------------------------------------------------------------
// 
//	Vendor: KeysightEEsof
//	FileName: LTE_CRC.h
//	Description: LTE CRC function
//	Date: 2009/07/09 02:17:30 
//------------------------------------------------------------------------------
#ifndef _LTE_CRC_H
#define _LTE_CRC_H
// Copyright 2011 - 2014 Keysight Technologies, Inc   

//-----------------------------------------------------------------------------------
// 
//-----------------------------------------------------------------------------------

/// CRC calculation based on subclause 5.1.1 of 3GPP TS 36.212 V8.4.0
/// <param name="crcLength">CRC length.</param>
/// <param name="mask">Generator function used in CRC calculation.</param>
/// <param name="MyInitialState">Initial state.</param>
/// <param name="MyMessageLength">Number of input bits to the CRC computation.</param>
/// <param name="frameP">Input bits.</param>
/// <param name="CRC_P">Parity bits.</param>
void CRC(int crcLength, int mask, int MyInitialState, int MyMessageLength,int * frameP, int * CRC_P);

#endif
