// Copyright  2015 - 2017 Keysight Technologies, Inc
#include "PassThroughExampleSimulator.h"
#include <cstring>

using namespace SystemVue::SVEClient;

PassThroughExampleSimulator::PassThroughExampleSimulator(SVELinkRuntime* linkRunTime )
{
	// Save cosimulation link.
	m_pSVELink = linkRunTime;
}

PassThroughExampleSimulator::~PassThroughExampleSimulator()
{
}

Result PassThroughExampleSimulator::run( std::wstring& errmsg )
{
	Result eStatus = NoError;
	size_t iBlockSize = 1;
	double dSampleRate = 0;
	
	// Connect and synchronize cosim information with SystemVueEngine in a synchronous way.
	eStatus = m_pSVELink->initialize();

	// Get cosimulation ports.
	const auto& vInputPorts = m_pSVELink->getInputPorts();
	const auto& vOutputPorts = m_pSVELink->getOutputPorts();

	// Get block size (number of data transfer for each firing iteration) and sample rate for cosimulation.
	if ( eStatus == NoError )
	{
		if ( vInputPorts.size() > 0 )
		{
			Port* pPort = vInputPorts[0];
			iBlockSize = m_pSVELink->getDataFlowRate( pPort, eStatus );
			if ( eStatus == NoError )
				dSampleRate = m_pSVELink->getSampleRate( pPort, eStatus );
		}
		else if ( vOutputPorts.size() > 0 )
		{
			Port* pPort = vOutputPorts[0];
			iBlockSize = m_pSVELink->getDataFlowRate( pPort, eStatus );
			if ( eStatus == NoError )
				dSampleRate = m_pSVELink->getSampleRate( pPort, eStatus );
		}
		else
		{
			errmsg += L"No input and no ouput ports.\n";
			eStatus = ErrorUnspecified;
		}
	}

	// Verify data flow information for cosimulation.
	// In this example, assuming the block size and the sample rate is the same for all the ports.
	if ( eStatus == NoError )
	{
		size_t i=0;
		for ( i = 0; i < vInputPorts.size(); ++i )
		{
			Port* pPort = vInputPorts[i];
			size_t iBlockSizeTemp=0;
			double dSampleRateTemp = 0;
			SVELinkRuntime::DataType eDataTypeTemp=SVELinkRuntime::Double;
			
			iBlockSizeTemp = m_pSVELink->getDataFlowRate( pPort, eStatus );
			if ( eStatus == NoError )
				dSampleRateTemp = m_pSVELink->getSampleRate( pPort, eStatus );
			if ( eStatus == NoError )
				eDataTypeTemp = m_pSVELink->getDataType( pPort, eStatus );

			if ( iBlockSizeTemp != iBlockSize || dSampleRateTemp != dSampleRate || eDataTypeTemp != SVELinkRuntime::ComplexDouble )
			{
				errmsg += L"Data flow rate or sample rate or data type is not consistent for input ports.\n";
				eStatus = ErrorUnspecified;
			}
		}

		for ( i = 0; i < vOutputPorts.size(); ++i )
		{
			Port* pPort = vOutputPorts[i];
			size_t iBlockSizeTemp=0;
			double dSampleRateTemp=0;
			SVELinkRuntime::DataType eDataTypeTemp=SVELinkRuntime::Double;
			
			iBlockSizeTemp = m_pSVELink->getDataFlowRate( pPort, eStatus );
			if ( eStatus == NoError )
				dSampleRateTemp = m_pSVELink->getSampleRate( pPort, eStatus );
			if ( eStatus == NoError )
				eDataTypeTemp = m_pSVELink->getDataType( pPort, eStatus );

			if ( iBlockSizeTemp != iBlockSize || dSampleRateTemp != dSampleRate || eDataTypeTemp != SVELinkRuntime::ComplexDouble )
			{
				errmsg += L"Data flow rate or sample rate or data type is not consistent for output ports.\n";
				eStatus = ErrorUnspecified;
			}
		}
	}

	// Run cosimulation for one firing of the SVE_Link model in SystemVueEngine.
	while ( eStatus == NoError )
	{
		// Receive all input data for all input ports in a synchronous way.
		// Wait for enough space for all outputs.
		eStatus = m_pSVELink->waitForReady();

		//non-blocking version
		//bool bIsReady = false;
		//while ( !bIsReady && eStatus == NoError )
		//{
		//	eStatus = m_pSVELink->isReady( bIsReady );
		//}

		// External simulator should read the data, run the simulation, and write the data in this section of code.
		// This example simply transfer data from input to output as a pass-through device.
		if ( eStatus == NoError )
		{
			for ( size_t i = 0; i < vOutputPorts.size(); ++i )
			{
				DataBuffer* pSVEOutputBuffer = m_pSVELink->getBuffer( vOutputPorts[i], eStatus );
				if ( ! pSVEOutputBuffer || eStatus != NoError )
					break;
				std::complex<double>* pOutputBuffer = pSVEOutputBuffer->getBufferMemory<std::complex<double>>( eStatus );
				if ( ! pOutputBuffer || eStatus != NoError )
					break;

				if ( i < vInputPorts.size() )
				{
					DataBuffer* pSVEInputBuffer = m_pSVELink->getBuffer( vInputPorts[i], eStatus );
					if ( ! pSVEInputBuffer || eStatus != NoError )
						break;

					std::complex<double>* pInputBuffer = pSVEInputBuffer->getBufferMemory<std::complex<double>>( eStatus );
					memcpy( pOutputBuffer, pInputBuffer, sizeof( std::complex<double> ) * iBlockSize );
				}
				else
				{
					for ( size_t j = 0; j < iBlockSize; j++ )
						pOutputBuffer[j] = std::complex<double>( 0, 0 );
				}
			}
		}

		// Send all output data for all output ports in a synchronous way.
		if ( eStatus == NoError )
			eStatus = m_pSVELink->done();
	}

	return eStatus;
}
