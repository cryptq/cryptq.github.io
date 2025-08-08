// Copyright 2011 - 2014 Keysight Technologies, Inc   
//------------------------------------------------------------------------------
// 
//	Vendor: KeysightEEsof
//	FileName: SDFLTE_CRCEncoder.h
//	Description: Add CRC to each Transport Block for HARQ closed-loop transmission
//	Date: 2009/07/09 07:39:45 $
//------------------------------------------------------------------------------
#pragma once
#include "SystemVue/ModelBuilder.h"
#include "LTE_DFParams.h"
#include "LTE_RangeCheck.h"
#include "LTE_CRC.h"
#include "SystemVue/Matrix.h"
using namespace SystemVueModelBuilder;

class LTE_CRCEncoder :
    public SystemVueModelBuilder::DFModel
{
public:
    /// Constructor and Destructor
    LTE_CRCEncoder();
    ~LTE_CRCEncoder();

    /// declare parameters
    CRC_LengthEnumList CRC_Length;

    /// declare ports
    CircularBuffer<IntMatrix> DataIn;
    CircularBuffer<IntMatrix> DataOut;

    /// declare modelbuilder interface
    DECLARE_MODEL_INTERFACE(LTE_CRCEncoder);

    /// declear functions 
    virtual bool Setup();
    virtual bool Initialize();
    virtual bool Run();
    virtual bool Finalize();
    int RangeCheck(std::stringstream &errorString, std::stringstream &infoString);


    /// declare protected variables
protected:

    /// declare private variables
private:
    //flag for license check
    bool m_licenseFlag;
    int m_GeneratorFunction;
    int m_CRCLength;
    int m_InitialState;
    int m_ErrorFlag;
};
