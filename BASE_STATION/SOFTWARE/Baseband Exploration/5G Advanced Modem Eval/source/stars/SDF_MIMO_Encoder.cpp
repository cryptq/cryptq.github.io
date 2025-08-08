//------------------------------------------------------------------------------
//	Copyright 2011 - 2014 Keysight Technologies 2009.  All rights reserved.
//	Vendor: Keysight EEsof
//	FileName: SDF_MIMO_Encoder.cpp
//	Description: MIMO Encoder
//	Date: 2014/09/01 10:00:00
//------------------------------------------------------------------------------
#include "SDF_MIMO_Encoder.h"   
        
namespace SystemVueModelBuilder {
    namespace _5GAdvancedModem_Eval {
        /// Constructor()
        MIMO_Encoder::MIMO_Encoder(void)
        {
            //set ini error flag
            m_errorFlag = 0;
       
        }
        
        /// Destructor()
        MIMO_Encoder::~MIMO_Encoder(void)
        {
        }
        
        /// setup()
        bool MIMO_Encoder::Setup()
        {
            if (0 == m_errorFlag)
            {
        		std::stringstream errorString;
        		std::stringstream infoString;
        		errorString.str("");
        		infoString.str("");
        		m_errorFlag = RangeCheck(errorString, infoString);
        		if (true != errorString.str().empty())
        			POST_ERROR(errorString.str().c_str());
        		if (true != infoString.str().empty())
        			POST_LOG(infoString.str().c_str());
        
                if (0 != m_errorFlag)
                    return 0;
        
				if (Mode == TD) //Transmit Diversity
				{
					Symbols.SetRate(1);
					TransmitData.SetRate(1);
				}
				else
				{
					Symbols.SetRate(1);
					TransmitData.SetRate(1);
				}
            }
            return true;
        }
        
        /// Initialize()
        bool MIMO_Encoder::Initialize()
        {
            if (0 == m_errorFlag)
            {
				//Restriction: currently for TD mode, only Tx=2, 4 is supported, so the channelResponseMtx should be 2(4)X M, where M is the
				//number of receiver antenna.
				if (NumTx != 2 && NumTx != 4)
				{
					POST_ERROR("Currently for Transmit Diversity mode, transmit antenna number only supports 2 or 4.");
					return false;
				}

				
				
            }
            return true;
        }
        
        /// Run()
        bool MIMO_Encoder::Run()
        {
            if (0 == m_errorFlag)
            {
				if (Mode == TD) //Transmit Diversity
				{
					//input port Symbols should be size of 1xNumTx
					if (Symbols[0].NumRows() != 1 && Symbols[0].NumColumns() != NumTx)
					{
						POST_ERROR("The size of Symbols input port should be with the size of 1 by NumTx for Transmit Diversity mode");
						return false;
					}

					TransmitData[0].Resize(NumTx, 1);
					//for (int i = 0; i < NumTx; i++)
					//	TransmitData[0](i,0) = Symbols[0](i];
					switch (NumTx)
					{
					case 2:
						TransmitData[0].Resize(2, 2);
						TransmitData[0](0,0) = Symbols[0](0,0)/sqrt(2.0);
						TransmitData[0](1,0) = -std::conj(Symbols[0](0,1))/sqrt(2.0);
						TransmitData[0](0,1) = Symbols[0](0,1)/sqrt(2.0);
						TransmitData[0](1,1) = std::conj(Symbols[0](0,0))/sqrt(2.0);
						break;
					case 4:
						TransmitData[0].Resize(4, 4);
						TransmitData[0](0,0) = Symbols[0](0,0)/sqrt(2.0);
						TransmitData[0](1,0) = 0;
						TransmitData[0](2,0) = -std::conj(Symbols[0](0,1))/sqrt(2.0);
						TransmitData[0](3,0) = 0;

						TransmitData[0](0,1) = Symbols[0](0,1)/sqrt(2.0);
						TransmitData[0](1,1) = 0;
						TransmitData[0](2,1) = std::conj(Symbols[0](0,0))/sqrt(2.0);
						TransmitData[0](3,1) = 0;

						TransmitData[0](0,2) = 0;
						TransmitData[0](1,2) = Symbols[0](0,2)/sqrt(2.0);
						TransmitData[0](2,2) = 0;
						TransmitData[0](3,2) = -std::conj(Symbols[0](0,3))/sqrt(2.0);

						TransmitData[0](0,3) = 0;
						TransmitData[0](1,3) = Symbols[0](3)/sqrt(2.0);
						TransmitData[0](2,3) = 0;
						TransmitData[0](3,3) = std::conj(Symbols[0](0,2))/sqrt(2.0);

						break;
					default:
						break;
					}
				}
				else
				{					
					//input port Symbols should be size of 1xNumTx
					if (Symbols[0].NumRows() != NumTx && Symbols[0].NumColumns() != 1)
					{
						POST_ERROR("The size of Symbols input port should be with the size of NumTx by 1 for Spatial Multiplexing mode.");
						return false;
					}

					TransmitData[0].Resize(NumTx, 1);
					for (int i = 0; i < NumTx; i++)
						TransmitData[0](i,0) = Symbols[0](i,0)/sqrt(1.0*NumTx);
				}

			}
            return true;
        }
        
        /// RangeCheck
        int MIMO_Encoder::RangeCheck(std::stringstream &errorString, std::stringstream &infoString)
        {
            int error_flag = 0;
        
			if (NumTx < 1)
			{
				errorString << "NumTx should be greater than 0.";
				error_flag = 1;
			}
			if (Mode < 0 || Mode > 1)
			{
				errorString << "Mode should be selected from {Transmit Diversity, Spatial Multiplexing}.";
				error_flag = 1;
			}
            return error_flag;
        }
        
        /// Finalize()
        bool MIMO_Encoder::Finalize()
        {
            return true;
        }
        
        /// Define DEFINE_MODEL_INTERFACE
        #ifndef SV_CODE_GEN
        DEFINE_MODEL_INTERFACE(MIMO_Encoder)
        {
            SET_MODEL_NAME("MIMO_Encoder");
            SET_MODEL_DESCRIPTION("MIMO encoder for TD and SM modes");
            ADD_MODEL_HEADER_FILE("SDF_MIMO_Encoder.h");
			SET_MODEL_NAMESPACE("SystemVueModelBuilder::_5GAdvancedModem_Eval");
        	SET_MODEL_SYMBOL("SYM_MIMO_Encoder@5G Advanced Modem BEL Eval Symbols");
            SET_MODEL_CATEGORY("MIMO & Beamforming");

			// Add parameters
			DFParam param = NULL;
			param = ADD_MODEL_ENUM_PARAM(Mode, SystemVueModelBuilder::_5GAdvancedModem_Eval::MIMO_Mode);
			param.AddEnumeration("Transmit Diversity", TD);
			param.AddEnumeration("Spatial Multiplexing", SM);
			param.SetDescription("Transmit mode");
			param.SetDefaultValue("1");

			param = ADD_MODEL_PARAMETER( NumTx );			
			param.SetDescription( "Number of transmit antenna" );
			param.SetDefaultValue("2");

            /// Add input/output ports
            DFPort inPort0 = ADD_MODEL_INPUT(Symbols);
            inPort0.SetDescription("Input symbol data");
        
            DFPort outPort0 = ADD_MODEL_OUTPUT(TransmitData);
            outPort0.SetDescription("Encoded transmit data");

            return true;
        }
        #endif
    }// end of namespace _5GAdvancedModem
}// end of namespace SystemVueModelBuilder
