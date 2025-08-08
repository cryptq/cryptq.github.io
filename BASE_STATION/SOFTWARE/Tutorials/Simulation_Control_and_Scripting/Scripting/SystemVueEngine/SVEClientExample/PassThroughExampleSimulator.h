// Copyright  2015 - 2017 Keysight Technologies, Inc
#pragma once

#include "SystemVue/Engine/Client.h"

class PassThroughExampleSimulator
{
public:
	PassThroughExampleSimulator(SystemVue::SVEClient::SVELinkRuntime* link );
	~PassThroughExampleSimulator();

	SystemVue::SVEClient::Result run( std::wstring& errmsg );

private:
	SystemVue::SVEClient::SVELinkRuntime* m_pSVELink;
};
