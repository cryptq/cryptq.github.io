// Copyright 2011 - 2014 Keysight Technologies, Inc   
//------------------------------------------------------------------------------
// 
//	Vendor: KeysightEEsof
//	FileName: LTE_DFParams.cpp
//	Description: add LTE parameters
//	Date: 2009/07/09 02:17:30 
//------------------------------------------------------------------------------
#include "LTE_DFParams.h"

/// Add enum
bool addParam_CRC_Length(DFInterface& model, DFParam& param, CRC_LengthEnumList &CRC_Length)
{
    param = ADD_MODEL_ENUM_PARAM(CRC_Length, CRC_LengthEnumList);
    param.AddEnumeration("CRC_24A", CRC_24A);
    param.AddEnumeration("CRC_24B", CRC_24B);
    param.AddEnumeration("CRC_16", CRC_16);
    param.AddEnumeration("CRC_8", CRC_8);
    param.SetDescription("Number of parity bits");
    //param.SetDefaultValue("CRC_24A");
    param.SetDefaultValue("0");
    return true;
}
