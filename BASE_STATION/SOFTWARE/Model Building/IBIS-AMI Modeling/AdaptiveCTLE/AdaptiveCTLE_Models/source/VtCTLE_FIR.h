/*
 * VtCTLE_FIR.h
 * Created by SystemVue C++ Code Generator
 * Copyright © 2000-2010, Keysight Technologies, Inc.
 */

#pragma once

#include "SystemVue/ModelBuilder.h"
#include "CTLE_FIR.h"

class VtCTLE_FIR : public CTLE_FIR
{
public:
	DECLARE_MODEL_INTERFACE(VtCTLE_FIR)
	VtCTLE_FIR();
	~VtCTLE_FIR();

	bool Setup();
	bool Initialize();
	bool Run();
	bool Finalize();

	// input, rate=1
	int CTLE_control;

protected:
	// delete array parameters
	void DeleteVtArrayParameters();

	bool b_ctrlErrFlag;
	double **d_taps, *d_tapsscale, *d_xbuffer;
	int *i_numtaps, i_maxtaps;

};

