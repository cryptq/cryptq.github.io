//------------------------------------------------------------------------------
//	Copyright 2011 - 2014 Keysight Technologies 2009.  All rights reserved.
//	Vendor: Keysight EEsof
//	FileName: DFParams.cpp
//	Description: 
//	Date: 2014/09/01 10:00:00
//------------------------------------------------------------------------------
#include "DFParams.h"

namespace SystemVueModelBuilder {
    namespace _5GAdvancedModem {
		const double PI = 3.14159265358979323846264338327950288419716939937510;		
		const double TWOPI = 6.28318530717958647692528676655900576839433879875021;
		const double _5G_DBL_MIN = 2.2250738585072014e-308;
		const double _5G_DBL_EPSILON = 2.2204460492503131e-016;
		const double _5G_DBL_MAX = 1.7976931348623158e+308;
		#ifndef SV_CODE_GEN
		bool addParam_OversampleRatio(DFInterface& model, DFParam& param, OversampleOptionEnumList &OversampleOption)
		{
			param = ADD_MODEL_ENUM_PARAM(OversampleOption, SystemVueModelBuilder::_5GAdvancedModem::OversampleOptionEnumList);
			param.AddEnumeration("Ratio 1", Ratio_1);
			param.AddEnumeration("Ratio 2", Ratio_2);
			param.AddEnumeration("Ratio 4", Ratio_4);
			param.AddEnumeration("Ratio 8", Ratio_8);
			param.AddEnumeration("Ratio 16", Ratio_16);
			param.AddEnumeration("Ratio 32", Ratio_32);
			param.AddEnumeration("Ratio 64", Ratio_64);
			param.SetDescription("Oversampling ratio from 1x to 64x");
			//param.SetDefaultValue("Ratio 2");
			param.SetDefaultValue("1");
			return true;
		}
		bool addParam_NumSubcarriers(DFInterface& model, DFParam& param, int &NumSubcarriers)
		{
			param = ADD_MODEL_PARAM(NumSubcarriers);
			param.SetDescription("The total number of subcarriers in each symbol");
			param.SetDefaultValue("128");
			return true;
		}
		bool addParam_NumActiveSubcarriers(DFInterface& model, DFParam& param, int &NumActiveSubcarriers)
		{
			param = ADD_MODEL_PARAM(NumActiveSubcarriers);
			param.SetDescription("The number of active subcarriers which are used to transmit data and pilots");
			param.SetDefaultValue("128");
			return true;
		}
		bool addParam_FilterOverlapFactor(DFInterface& model, DFParam& param, int &FilterOverlapFactor)
		{
			param = ADD_MODEL_PARAM(FilterOverlapFactor);
			param.SetDescription("The number of symbols which are overlaped together");
			param.SetDefaultValue("4");
			return true;
		}
		bool addParam_FilterCoef(DFInterface& model, DFParam& param, double *&FilterCoef, int &FilterCoefArraySize)
		{
			param = ADD_MODEL_ARRAY_PARAM(FilterCoef, FilterCoefArraySize);
			param.SetDescription("Filter coefficients");
			param.SetDefaultValue("[1, -0.971960, 1/sqrt(2), -0.235147]");
			return true;
		}
		bool addParam_NumPreambleSyms(DFInterface& model, DFParam& param, int &NumPreambleSyms)
		{
			param = ADD_MODEL_PARAM(NumPreambleSyms);
			param.SetDescription("The number of symbols in Preamble section in each frame");
			param.SetDefaultValue("6");
			return true;
		}
		bool addParam_NumDataSyms(DFInterface& model, DFParam& param, int &NumDataSyms)
		{
			param = ADD_MODEL_PARAM(NumDataSyms);
			param.SetDescription("The number of symbols in Data section in each frame");
			param.SetDefaultValue("20");
			return true;
		}
		bool addParam_ActiveSubcAlloc(DFInterface& model, DFParam& param, int *&ActiveSubcAlloc, int &ActiveSubcAllocArraySize)
		{
			param = ADD_MODEL_ARRAY_PARAM(ActiveSubcAlloc, ActiveSubcAllocArraySize);
			param.SetDescription("");
			param.SetDefaultValue("[-64,63]");
			return true;
		}
		bool addParam_PilotAlloc(DFInterface& model, DFParam& param, int *&PilotAlloc, int &PilotAllocArraySize)
		{
			param = ADD_MODEL_ARRAY_PARAM(PilotAlloc, PilotAllocArraySize);
			param.SetDescription("");
			param.SetDefaultValue("[-10,10]");
			return true;
		}
		bool addParam_NumEqualizerTaps(DFInterface& model, DFParam& param, NumEqualizerTapsEnumList &NumEqualizerTaps)
		{
			param = ADD_MODEL_ENUM_PARAM(NumEqualizerTaps, SystemVueModelBuilder::_5GAdvancedModem::NumEqualizerTapsEnumList);
			param.AddEnumeration("One Tap", one_tap);
			param.AddEnumeration("Two Taps", two_taps);
			param.AddEnumeration("Three Taps", three_taps);
			param.SetDescription("The number of taps in the equalizer");
			param.SetDefaultValue("2");
			return true;
		}
		bool addParam_FreqSync(DFInterface& model, DFParam& param, FreqSyncEnumList &FreqSync)
		{
			param = ADD_MODEL_ENUM_PARAM(FreqSync, SystemVueModelBuilder::_5GAdvancedModem::FreqSyncEnumList);
			param.AddEnumeration("None", non);
			param.AddEnumeration("Integral freq compensation only", ifo);
			param.AddEnumeration("Full freq compensation", ifo_ffo);
			param.SetDescription("Frequency synchronization method");
			//param.SetDefaultValue("Ratio 2");
			param.SetDefaultValue("1");
			return true;
		}
		bool addParam_ZC_RootIndex1(DFInterface& model, DFParam& param, int &ZC_RootIndex1)
		{
			param = ADD_MODEL_PARAM(ZC_RootIndex1);
			param.SetDescription("Root index of ZC sequence 1");
			param.SetDefaultValue("7");
			return true;
		}
		bool addParam_ZC_RootIndex2(DFInterface& model, DFParam& param, int &ZC_RootIndex2)
		{
			param = ADD_MODEL_PARAM(ZC_RootIndex2);
			param.SetDescription("Root index of ZC sequence 2");
			param.SetDefaultValue("3");
			return true;
		}
		bool addParam_SampleRate(DFInterface& model, DFParam& param, double &SampleRate)
		{
			param = ADD_MODEL_PARAM(SampleRate);
			param.SetDescription("Basic sample rate without oversampling");
			param.SetDefaultValue("10e6");
			return true;
		}
		bool addParam_IdleInterval(DFInterface& model, DFParam& param, double &IdleInterval)
		{
			param = ADD_MODEL_PARAM(IdleInterval);
			param.SetDescription("Idle time at the begining of each frame");
			param.SetDefaultValue("2e-6");
			return true;
		}
		bool addParam_Tmax(DFInterface& model, DFParam& param, double &Tmax)
		{
			param = ADD_MODEL_PARAM(Tmax);
			param.SetDescription("Maxima time with mutipath");
			param.SetDefaultValue("2e7");
			return true;
		}
		bool addParam_PilotLoc(DFInterface& model, DFParam& param, int *&PilotLoc, int &PilotLocArraySize)
		{
			param = ADD_MODEL_ARRAY_PARAM(PilotLoc, PilotLocArraySize);
			param.SetDescription("Pilot allocation in active subcarriers");
			param.SetDefaultValue("[-64:8:63]");
			return true;
		}
		bool addParam_ActivePilotSequence(DFInterface& model, DFParam& param, std::complex<double> *&ActivePilotSequence, int &ActivePilotSequenceArraySize)
		{
			param = ADD_MODEL_ARRAY_PARAM(ActivePilotSequence, ActivePilotSequenceArraySize);
			param.SetDescription("Active pilot sequence");
			param.SetDefaultValue("[1;1;1;1;-1;-1;-1;1;-1;-1;-1;-1;1;1;-1;1]");
			return true;
		}
		#endif
    }// end of namespace _5GAdvancedModem
}// end of namespace SystemVueModelBuilder
