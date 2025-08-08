//------------------------------------------------------------------------------
//	Copyright 2011 - 2014 Keysight Technologies 2009.  All rights reserved.
//	Vendor: Keysight EEsof
//	FileName: DFParams.h
//	Description: 
//	Date: 2014/09/01 10:00:00
//------------------------------------------------------------------------------
#ifndef _5GAdvancedModem_EVAL_DFPARAMS_H
#define _5GAdvancedModem_EVAL_DFPARAMS_H

#include "SystemVue/ModelBuilder.h" 

#include <numeric>
#include <functional>

namespace SystemVueModelBuilder {
    namespace _5GAdvancedModem_Eval {
		
extern const double PI;		
extern const double TWOPI;
extern const double _5G_DBL_MIN;
extern const double _5G_DBL_EPSILON;
extern const double _5G_DBL_MAX;
		/// declare Enumlist
		enum OversampleOptionEnumList{Ratio_1=0, Ratio_2=1, Ratio_4=2, Ratio_8=3, Ratio_16=4, Ratio_32=5, Ratio_64=6};
		enum TxFilterBankStructure {PPN_IFFT=0, Extended_IFFT=1};
		enum RxFilterBankStructure {PPN_FFT=0, Extended_FFT=1};
		enum NumEqualizerTapsEnumList {one_tap=0, two_taps=1, three_taps=2};
		enum FreqSyncEnumList {non=0, ifo=1, ifo_ffo=2};

		#ifndef SV_CODE_GEN
		bool addParam_OversampleRatio(DFInterface& model, DFParam& param, OversampleOptionEnumList &OversampleOption);
		bool addParam_NumSubcarriers(DFInterface& model, DFParam& param, int &NumSubcarriers);
		bool addParam_NumActiveSubcarriers(DFInterface& model, DFParam& param, int &NumActiveSubcarriers);
		bool addParam_FilterOverlapFactor(DFInterface& model, DFParam& param, int &FilterOverlapFactor);
		bool addParam_FilterCoef(DFInterface& model, DFParam& param, double *&FilterCoef, int &FilterCoefArraySize);
		bool addParam_NumPreambleSyms(DFInterface& model, DFParam& param, int &NumPreambleSyms);
		bool addParam_NumDataSyms(DFInterface& model, DFParam& param, int &NumDataSyms);
		bool addParam_ActiveSubcAlloc(DFInterface& model, DFParam& param, int *&ActiveSubcAlloc, int &ActiveSubcAllocArraySize);
		bool addParam_PilotAlloc(DFInterface& model, DFParam& param, int *&PilotAlloc, int &PilotAllocArraySize);
		bool addParam_NumEqualizerTaps(DFInterface& model, DFParam& param, NumEqualizerTapsEnumList &NumEqualizerTaps);
		bool addParam_FreqSync(DFInterface& model, DFParam& param, FreqSyncEnumList &FreqSync);
		bool addParam_ZC_RootIndex1(DFInterface& model, DFParam& param, int &ZC_RootIndex1);
		bool addParam_ZC_RootIndex2(DFInterface& model, DFParam& param, int &ZC_RootIndex2);
		bool addParam_IdleInterval(DFInterface& model, DFParam& param, double &IdleInterval);
		bool addParam_SampleRate(DFInterface& model, DFParam& param, double &SampleRate);
		bool addParam_Tmax(DFInterface& model, DFParam& param, double &Tmax);
		bool addParam_PilotLoc(DFInterface& model, DFParam& param, int *&PilotLoc, int &PilotLocArraySize);
		bool addParam_ActivePilotSequence(DFInterface& model, DFParam& param, std::complex<double> *&ActivePilotSequence, int &ActivePilotSequenceArraySize);
		#endif
    }// end of namespace _5GAdvancedModem
}// end of namespace SystemVueModelBuilder

#endif
