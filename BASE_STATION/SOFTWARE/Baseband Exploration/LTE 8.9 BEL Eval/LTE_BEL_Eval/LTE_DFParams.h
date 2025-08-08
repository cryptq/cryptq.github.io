//------------------------------------------------------------------------------
// 
//	Vendor: KeysightEEsof
//	FileName: LTE_DFParams.h
//	Description: add LTE parameters
//	Date: 2009/07/09 02:17:30 
//------------------------------------------------------------------------------
#ifndef LTE_DFPARAMS_H
#define LTE_DFPARAMS_H
// Copyright 2011 - 2014 Keysight Technologies, Inc   

#include "SystemVue/ModelBuilder.h"

using namespace SystemVueModelBuilder;

/// declare Enumlist
enum CRC_LengthEnumList{CRC_24A=0, CRC_24B=1, CRC_16=2, CRC_8=3};

bool addParam_CRC_Length(DFInterface& model, DFParam& param, CRC_LengthEnumList &CRC_Length);

#endif
