// Copyright 2011 - 2014 Keysight Technologies, Inc   
//------------------------------------------------------------------------------
// 
//	Vendor: KeysightEEsof
//	FileName: LTE_RangeCheck.h
//	Description: LTE range check functions
//	Date: 2009/07/09 02:17:30 
//------------------------------------------------------------------------------
#pragma once

#include "SystemVue/ModelBuilder.h"
#include <vector>

using namespace SystemVueModelBuilder;

// base LTE_RangeCheck
class LTE_RangeCheck {
public:
    virtual bool check(std::stringstream &errorString, std::stringstream &infoString) { return true; }
};

// check CRC_Length
class LTE_checkCRC_Length : public LTE_RangeCheck{
    int m_CRC_Length;
public:
    LTE_checkCRC_Length (const int &CRC_Length) {m_CRC_Length = CRC_Length;}
    virtual bool check(std::stringstream &errorString, std::stringstream &infoString);
};
