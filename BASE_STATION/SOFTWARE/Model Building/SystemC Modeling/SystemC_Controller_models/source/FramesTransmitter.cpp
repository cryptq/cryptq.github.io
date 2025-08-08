#include "FramesTransmitter.h"
namespace SystemVueModelBuilder
{

	//default constructor
    FramesTransmitter::FramesTransmitter(sc_module_name mName, size_t iBufferSize)
		:m_bPostpone(false),
		m_iTxFrames(0),
        m_vlvBuffer(iBufferSize)
	{    
		SC_HAS_PROCESS(FramesTransmitter);
        
		TxFrames.initialize(SC_LOGIC_0);

		SC_METHOD(SaveMsg);
		sensitive << msgIn.data_written();
		dont_initialize();

		SC_THREAD(GenerateOutputSignal);
		sensitive << clkIn.pos();
		dont_initialize();
	}

	//destructor
	FramesTransmitter::~FramesTransmitter()
	{};

	void FramesTransmitter::SaveMsg()
	{        
		sc_lv<MAX_MSG_BITS> receivedMsg = msgIn.read().reverse();
		auto str = receivedMsg.to_string();

		if( m_vlvBuffer.num_free() )
			m_vlvBuffer.write( receivedMsg );
		else
			SC_REPORT_WARNING("WriteFifo","Write FIFO failed. Probably FIFO is full!"); // buffer is full
	}
	   
	void FramesTransmitter::ProcessMsg()
	{ 
		std::string str;
		size_t iPos = m_lvFrame.length() - 1;
		sc_lv<MAX_MSG_BITS> receivedMsg = m_vlvBuffer.read();
		
		m_lvFrame[iPos] = 0; //SOF
		iPos--;

		//m_lvFrame.range( iPos, iPos - receivedMsg.length()) = receivedMsg;
		for( size_t i = 0; i < receivedMsg.length(); i++ )
		{
			m_lvFrame[iPos - i] = receivedMsg[receivedMsg.length() - i - 1]; 
		}
			
		m_iLength = FindLength();        
		iPos -= m_iLength - 1;

		sc_lv<15> crcReg = CalculateCRC();
				
		//m_lvFrame.range( iPos, iPos - 15) = crcReg;
		for( size_t i = 0; i < 15; i++ )
		{
			m_lvFrame[iPos - i] = crcReg[14 - i]; 
		}
		m_iLength += 15;
		iPos -= 15;

		str = crcReg.to_string();
		str = m_lvFrame.to_string();
			
		unsigned int countStuffBits = BitStuffing();
	   // m_iLength += countStuffBits;
		iPos -= countStuffBits;
			
		//m_lvFrame.range( iPos, iPos - 7) = "1111111"; //EOF
		for( size_t i = 0; i < 7; i++ )
		{
			m_lvFrame[iPos - i] = SC_LOGIC_1; 
		}
		iPos -= 7;

		m_lvFrame[ iPos ] = SC_LOGIC_Z;

		str = crcReg.to_string();
		str = m_lvFrame.to_string();
		m_bPostpone = true;
		
	}

	void FramesTransmitter::GenerateOutputSignal()
	{
		while(true)
		{
			if(m_bPostpone)
			{
				sc_logic bitOut = m_lvFrame[MAX_FRAME_BITS - 1];
				if( bitOut == SC_LOGIC_Z || bitOut == SC_LOGIC_X )
				{
					m_iTxFrames++;
					TxFrames.write( SC_LOGIC_1 );
					SerialOut.write( SC_LOGIC_1 );
					if( m_vlvBuffer.num_available() )
						ProcessMsg();
					m_bPostpone = false;
				}
				else       
				{
					SerialOut.write( bitOut );
					TxFrames.write( SC_LOGIC_0 );
					m_lvFrame <<= 1;
				}
			}
			else
			{
				TxFrames.write( SC_LOGIC_0 );
				SerialOut.write( SC_LOGIC_1 );
				if( m_vlvBuffer.num_available() )
					ProcessMsg();
			}

			wait();
		}
	}

	unsigned int FramesTransmitter::BitStuffing()
	{
		size_t seqBits = 1;
		sc_logic lastBit = SC_LOGIC_X;
		unsigned int count = 0;

		for( size_t i = MAX_FRAME_BITS - 1; i > MAX_FRAME_BITS - m_iLength - 1; i-- )
		{	
			  if( m_lvFrame[i] == lastBit )
			  {
				  seqBits++;
			  }
			  else
			  {
				  seqBits = 1;
				  lastBit = m_lvFrame[i];
			  }

			  if( seqBits == 5 )
			  {
				  std::string str = m_lvFrame.to_string();
				  m_lvFrame.range(i-1,0) >>= 1;
				  str = m_lvFrame.to_string();
				  m_lvFrame[i-1] = ~lastBit;
				  str = m_lvFrame.to_string();
				  m_iLength++;
				  count++;
			  }
		}

		return count;
	}

	size_t FramesTransmitter::FindLength()
	{
		size_t iDataLength =  m_lvFrame.range( MAX_FRAME_BITS - 13, MAX_FRAME_BITS - 15 ).to_uint();
		return (iDataLength*8) + 11 + 3 + 1;
	}

	sc_lv<15> FramesTransmitter::CalculateCRC()
	{
		sc_lv<15> crcReg = 0;    
		
		for( size_t i = MAX_FRAME_BITS - 1; i > MAX_FRAME_BITS - m_iLength - 1; i-- )
		{	
			sc_logic crcNext = m_lvFrame[i] ^ crcReg[14];		
			crcReg <<= 1;				
			if (crcNext == SC_LOGIC_1)        			
				crcReg ^= 0x4599;	        
		}

		std::string str = crcReg.to_string();
		
		return crcReg;		
	};
}


