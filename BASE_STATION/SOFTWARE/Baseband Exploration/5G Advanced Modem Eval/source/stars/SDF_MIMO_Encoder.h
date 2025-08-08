//------------------------------------------------------------------------------
//	Copyright 2011 - 2014 Keysight Technologies 2009.  All rights reserved.
//	Vendor: Keysight EEsof
//	FileName: SDF_MIMO_Encoder.h
//	Description: 
//	Date: 2014/09/01 10:00:00
//------------------------------------------------------------------------------
#pragma once
#include "SystemVue/ModelBuilder.h"

namespace SystemVueModelBuilder {
    namespace _5GAdvancedModem_Eval {        
		enum MIMO_Mode{TD=0, SM=1};
        class MIMO_Encoder :
            public SystemVueModelBuilder::DFModel
        {
        public:
            /// Constructor and Destructor
            MIMO_Encoder();
            ~MIMO_Encoder();
        
            /// declare parameters
			MIMO_Mode Mode;
			int NumTx;
        
            /// declare ports
            CircularBuffer<DComplexMatrix>  Symbols;
			CircularBuffer<DComplexMatrix>  TransmitData;			
        
            /// declare modelbuilder interface
            DECLARE_MODEL_INTERFACE(MIMO_Encoder);
        
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
            int m_errorFlag;

        };
    }// end of namespace _5GAdvancedModem
}// end of namespace SystemVueModelBuilder
