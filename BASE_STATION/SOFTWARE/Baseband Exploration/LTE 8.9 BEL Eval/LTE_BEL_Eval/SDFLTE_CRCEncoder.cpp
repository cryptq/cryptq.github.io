// Copyright 2011 - 2014 Keysight Technologies, Inc   
//------------------------------------------------------------------------------
// 
//	Vendor: KeysightEEsof
//	FileName: SDFLTE_CRCEncoder.cpp
//	Description: Add CRC to each Transport Block for HARQ closed-loop transmission
//	Date: 2009/07/09 07:39:45
//------------------------------------------------------------------------------
#include "SDFLTE_CRCEncoder.h"
#include <sstream>
#include <string>

/// Constructor()
LTE_CRCEncoder::LTE_CRCEncoder(void)
{
    m_licenseFlag = false;
}

/// Destructor()
LTE_CRCEncoder::~LTE_CRCEncoder(void)
{
}

/// setup()
bool LTE_CRCEncoder::Setup()
{
    m_licenseFlag = true;

    std::stringstream errorString;
    std::stringstream infoString;
    errorString.str("");
    infoString.str("");
    m_ErrorFlag = RangeCheck(errorString, infoString);
    if (true != errorString.str().empty())
        POST_ERROR(errorString.str().c_str());
    if (true != infoString.str().empty())
        POST_LOG(infoString.str().c_str());

    if (0 == m_ErrorFlag)
    {
		switch (CRC_Length)
		{
		case 0: //CRC_24A
            m_GeneratorFunction = 0x1864CFB;
            m_CRCLength = 24;
			break;
		case 1: //CRC_24B
            m_GeneratorFunction = 0x1800063;
            m_CRCLength = 24;
			break;
		case 2: //CRC_16
            m_GeneratorFunction = 0x11021;
            m_CRCLength = 16;
			break;
		case 3: //CRC_8
            m_GeneratorFunction = 0x19B;
            m_CRCLength = 8;
			break;
		default: //CRC_24A
            m_GeneratorFunction = 0x1864CFB;
            m_CRCLength = 24;
		}

		//initial state is 0
        m_InitialState = 0;
       
        //each firing, one subframe matrix-based data are consumed and produced
        DataIn.SetRate( 1 );
        DataOut.SetRate( 1 );            
    }
    return true;
}

/// Initialize()
bool LTE_CRCEncoder::Initialize()
{    
    return true;
}

/// Run()
bool LTE_CRCEncoder::Run()
{
    if (m_licenseFlag)
    {
        IntMatrix& inMtx = DataIn[0];
        IntMatrix& outMtx = DataOut[0];

        if ( inMtx.NumElements() > 0 )
        {
            size_t inputSize = inMtx.NumElements();
            size_t outputSize = inputSize + m_CRCLength;

            //column vector output
            outMtx.Resize( outputSize, 1 );

            //copy inputSize bits to output array
            inMtx.CopyTo( outMtx.GetBuffer(), inputSize );

            //compute CRC parity bits to the last m_CRCLength positions in the output array
            CRC( m_CRCLength, m_GeneratorFunction, m_InitialState, inputSize, inMtx.GetBuffer(), &outMtx(inputSize) );
        }
        else
        {
            //empty input matrix, generate empty output matrix
            outMtx.Resize(0,0);
        }
        
    }
    return m_licenseFlag;
}

/// RangeCheck
int LTE_CRCEncoder::RangeCheck(std::stringstream &errorString, std::stringstream &infoString)
{
    int error_flag = 0;

    /// Check CRC_Length
    LTE_RangeCheck *pRCK = new LTE_checkCRC_Length(CRC_Length);
    if (false == pRCK->check(errorString, infoString))
        error_flag = 1;
    delete pRCK;

    return error_flag;
}

/// Finalize()
bool LTE_CRCEncoder::Finalize()
{
    return true;
}

/// Define DEFINE_MODEL_INTERFACE
#ifndef SV_CODE_GEN
DEFINE_MODEL_INTERFACE(LTE_CRCEncoder)
{
    SET_MODEL_NAME("LTE_CRCEncoder");
    SET_MODEL_DESCRIPTION("Add CRC to each Transport Block for HARQ closed-loop transmission");
    ADD_MODEL_HEADER_FILE("SDFLTE_CRCEncoder.h");
	SET_MODEL_SYMBOL("SYM_LTE_CRCEncoder@LTE 8.9 Symbols");
    SET_MODEL_CATEGORY("Channel Coding");

    // Add parameters
    DFParam param = NULL;

    /// Add enum
    addParam_CRC_Length(model, param, CRC_Length);

    /// Add input/output ports
    DFPort inputPort0 = ADD_MODEL_INPUT(DataIn);
    inputPort0.SetDescription("data in");

    DFPort outPort0 = ADD_MODEL_OUTPUT(DataOut);
    outPort0.SetDescription("data out");

	return true;
}
#endif
