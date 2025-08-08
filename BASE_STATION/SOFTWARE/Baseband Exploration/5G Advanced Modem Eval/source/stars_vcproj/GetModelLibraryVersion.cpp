//------------------------------------------------------------------------------
//	Copyright (c) Keysight Technologies 2009.  All rights reserved.
//	Vendor: Keysight EEsof
//	FileName: GetModelLibraryVersion.cpp
//	Description: get model library version
//	Date: 2009/07/09 02:17:30 
//------------------------------------------------------------------------------
//#include "stdafx.h"

extern "C"
{
	__declspec(dllexport) int GetModelLibraryVersion( void )
    {
	    return 10;
    }
}
