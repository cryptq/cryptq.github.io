// Copyright 2011 - 2014 Keysight Technologies, Inc   
//------------------------------------------------------------------------------
// 
//	Vendor: KeysightEEsof
//	FileName: LTE_RangeCheck.h
//	Description: LTE range check functions
//	Date: 2009/07/09 02:17:30 
//------------------------------------------------------------------------------
#include "LTE_RangeCheck.h"
#include <vector>

using namespace std;

// Check CRC_Length
bool LTE_checkCRC_Length::check(std::stringstream &errorString, std::stringstream &infoString)
{    
    if (m_CRC_Length < 0 || m_CRC_Length > 4)
    {
        errorString << "\nThe CRC_Length should be chosen from {CRC_24A, CRC_24B, CRC_16, CRC_8}.";
        return false;
    }
    return true;
}
