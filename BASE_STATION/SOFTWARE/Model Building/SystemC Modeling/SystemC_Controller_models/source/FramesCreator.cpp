#include "FramesCreator.h"
namespace SystemVueModelBuilder
{

	//default constructor
	FramesCreator::FramesCreator( sc_module_name mName )
		:uiClockTicks(2)
	{    
		SC_HAS_PROCESS(FramesCreator);

		SC_METHOD(GenerateOutput);
		sensitive << clkIn.pos();
		dont_initialize();
	}

	//destructor
	FramesCreator::~FramesCreator()
	{};



	void FramesCreator::GenerateOutput()
	{
		uiClockTicks--;
		if( uiClockTicks == 0)
		{
			auto value = rand();
			sc_bigint<MAX_MSG_BITS> msg = value;
			msgOut.write( msg );
			uiClockTicks = (rand() % 6) + 1; // generate another msg after 1 or 2 or... 6 clock ticks
		}	
	}

}