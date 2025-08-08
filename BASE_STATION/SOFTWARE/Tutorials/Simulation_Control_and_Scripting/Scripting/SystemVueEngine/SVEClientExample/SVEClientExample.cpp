#include "SystemVue/Engine/Client.h"
#include "SystemVue/Engine/SVELinkProperties.h"
#include "PassThroughExampleSimulator.h"
#include <iostream>
#include <string>

int main()
{
	const std::wstring svePath = L"C:/Program Files/Keysight/SystemVue2020/bin/SystemVueEngine.exe";
	const std::wstring workspaceFilename = L"C:/Program Files/Keysight/SystemVue2020Update1/Examples/VTB/Communications/Tx/VTB_Example.wsv";
	const std::wstring outputDirectory = L"C:/tmp/results";
	const std::wstring outputLog = L"C:/tmp/results/SVE_Output_Log.txt";

	using namespace SystemVue::SVEClient;

	Result eStatus = NoError;
	SVESession* pSession = openSession( svePath.c_str(), outputLog.c_str() );
	Workspace* pWorkspace = nullptr;
	
	if( pSession )
		pWorkspace = pSession->openWorkspace( workspaceFilename.c_str(), eStatus );
	else
	{
		std::wcout << L"Failed to create session with file: \"" << svePath.c_str() << "\"\n";
		return 1;
	}

	if ( ! pWorkspace )
	{
		std::wcout << L"Failed to open workspace: \"" << workspaceFilename << "\"\n";
		return 1;
	}

	for ( size_t i=0; i<pWorkspace->getAnalyses().size(); i++ )
	{
		auto pAnalysis = pWorkspace->getAnalyses()[i];
		std::wcout << L"Running analysis: \"" << pAnalysis->getName() << "\"\n";

		{
			// Set the output file path
			std::wstring outputFilePath = outputDirectory + L"/" + pAnalysis->getName() + L".adx";
			pAnalysis->setOutputFilePath( outputFilePath.c_str() );
		}

		// Get SVELink setup information: whether it is part of a feedback loop and the ports' Fc and SampleRate
		if ( pAnalysis->getSVELinks().size() > 0 )
		{
			Result result;
			const auto& sveLinkProperties = pAnalysis->getSVELinkProperties( result );

			if ( Success( result ) )
			{
				for ( auto sveLinkPropertiesIter = sveLinkProperties.cbegin(); sveLinkPropertiesIter != sveLinkProperties.cend(); sveLinkPropertiesIter++ )
				{
					auto pSVELinkProperties = *sveLinkPropertiesIter;
					std::wcout << L"SVELink '" << pSVELinkProperties->getName( ) << L"' is" << ( pSVELinkProperties->isInFeedbackLoop() ? ( L" " ) : ( L" NOT " ) ) << L"in a feedback loop." << std::endl;

					const auto& sveLinkInputPortProperties = pSVELinkProperties->getInputPortProperties();

					for ( auto sveLinkPortPropertiesIter = sveLinkInputPortProperties.cbegin(); sveLinkPortPropertiesIter != sveLinkInputPortProperties.cend(); sveLinkPortPropertiesIter++ )
					{
						auto pSVELinkPortProperties = *sveLinkPortPropertiesIter;
						std::wcout << L"   Input port '" << pSVELinkPortProperties->getName( ) << L"': ";
						std::wcout << L"Fc = " << pSVELinkPortProperties->getCharacterizationFrequency( ) << L" Hz, ";
						std::wcout << L"Sample Rate = " << pSVELinkPortProperties->getSampleRate( ) << L" Hz." << std::endl;
					}

					const auto& sveLinkOutputPortProperties = pSVELinkProperties->getOutputPortProperties();

					for ( auto sveLinkPortPropertiesIter = sveLinkOutputPortProperties.cbegin(); sveLinkPortPropertiesIter != sveLinkOutputPortProperties.cend(); sveLinkPortPropertiesIter++ )
					{
						auto pSVELinkPortProperties = *sveLinkPortPropertiesIter;
						std::wcout << L"   Output port '" << pSVELinkPortProperties->getName( ) << L"': ";
						std::wcout << L"Fc = " << pSVELinkPortProperties->getCharacterizationFrequency( ) << L" Hz, ";
						std::wcout << L"Sample Rate = " << pSVELinkPortProperties->getSampleRate( ) << L" Hz." << std::endl;
					}
				}
			}
		}

		AnalysisRuntime* pAnalysisRuntime = pAnalysis->start();

		std::wstring cosimErrorMessage;
		if ( Success( pAnalysisRuntime->getAnalysisResult() ) )
		{
			for ( auto link : pAnalysisRuntime->getSVELinks())
			{
				PassThroughExampleSimulator sim(link);
				eStatus = sim.run( cosimErrorMessage );
				if ( ! Success(eStatus) )
					std::wcout << L"Cosim failed. ";
				if ( ! cosimErrorMessage.empty() )
					std::wcout << L"Cosim error message: " << cosimErrorMessage;
			}
		}

		// Blocking call to wait until runtime is finished - for the non-blocking version use isRunning() instead
		Result runtimeResult = pAnalysisRuntime->waitForFinished();

		if ( Success( runtimeResult ) )
			std::wcout << L"Succeeded\n";
		else
			std::wcout << L"Failed\n";

		pAnalysisRuntime->release();
	}

	pSession->closeWorkspace( pWorkspace );
	closeSession( pSession );

	return 0;
}
