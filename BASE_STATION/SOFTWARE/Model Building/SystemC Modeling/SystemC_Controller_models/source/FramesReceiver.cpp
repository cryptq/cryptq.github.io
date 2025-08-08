#include "FramesReceiver.h"
namespace SystemVueModelBuilder
{

	//default constructor
	FramesReceiver::FramesReceiver( sc_module_name mName )
		:m_bIdle(true),
		m_bNextBitStuff(false),
		m_bExpectEOF(false),
		m_bContError(false),
		m_bPendingCorrect(false),
		m_iRxBits(0),
		m_iRxFrames(0),
		m_iRxErrorFrames(0),
		m_iRxCorrectFrames(0),
		m_iSeqBits(1),
		m_iLength(MAX_FRAME_BITS)
	{    
		SC_HAS_PROCESS(FramesReceiver);

		ReceivedFrames.initialize(SC_LOGIC_0);
		ErrorFrames.initialize(SC_LOGIC_0);
		CorrectFrames.initialize(SC_LOGIC_0);

		SC_METHOD(ReadInput);
		sensitive << clkIn.pos();
		dont_initialize();    
	}

	//destructor
	FramesReceiver::~FramesReceiver()
	{};

	void FramesReceiver::ReadInput()
	{        
		sc_logic sampleIn = SerialIn.read();

		if( m_bIdle )
		{
			ErrorFrames.write( SC_LOGIC_0 );
			CorrectFrames.write(SC_LOGIC_0);
			if( sampleIn == SC_LOGIC_0 ) // JUST STARTED A NEW FRAME
			{
				m_bContError = false;
				m_bIdle = false;
				m_iRxFrames++;
				ReceivedFrames.write( SC_LOGIC_1 );
				m_lLastBitValue = sampleIn;
			}
		}
		else
		{
			ReceivedFrames.write( SC_LOGIC_0 );
			ProcessInput( sampleIn );            
		}
	}

	void FramesReceiver::SaveInput( sc_logic valueIn )
	{
		m_lvFrame <<= 1;
		m_lvFrame.set_bit( 0, valueIn.value() );    
	}
	   
	void FramesReceiver::ProcessInput( sc_logic valueIn )
	{     
		bool bOK = true;
		m_iRxBits++;    

		if(!m_bExpectEOF)
		{
			if(m_bNextBitStuff)
			{
				bOK = false;
				if( valueIn == m_lLastBitValue )
				{   
	#ifdef _DEBUG
					cout << "Stuff error at Frame#: " << m_iRxFrames << endl;
					cout << "Frame State: " << m_lvFrame << "\n valid bits: "<< m_iRxBits << "\n counted length: " << m_iLength <<endl;
					cout << "CRC calculated: " << m_lvCRC << endl;
					system("pause");
	#endif
					// STUFF BIT ERROR!
					m_iRxErrorFrames++;
					ErrorFrames.write( SC_LOGIC_1 );
					m_bExpectEOF = true;            
					m_bContError = true;
					m_iRxBits = 0;  
				}
				else
				{
					m_iSeqBits = 1;
					m_lLastBitValue = valueIn;
					m_bNextBitStuff = false;
					m_iRxBits--;                
				}
			}
			else
			{
				if( valueIn == m_lLastBitValue )
					m_iSeqBits++;
				else
				{
					m_iSeqBits = 1;
					m_lLastBitValue = valueIn;
				}

				if(m_iSeqBits == 5)
					m_bNextBitStuff = true;
			}

			if(bOK)
				SaveInput(valueIn);

			if( m_iRxBits == 14 )
				m_iLength = FindLength(); //calculate msg bits

			if( m_iRxBits == m_iLength )
				m_lvCRC = CalculateCRC();

			if( m_iRxBits == m_iLength + 15 )
			{
				bOK = CheckCRC();
				if(bOK)
				{
					m_bExpectEOF = true;
					m_bPendingCorrect = true;
					m_iRxBits = 0;
				}
				else
				{
	#ifdef _DEBUG
					cout << "CRC error at Frame#: " << m_iRxFrames << endl;
					cout << "Frame State: " << m_lvFrame << "\n valid bits: "<< m_iRxBits << "\n counted length: " << m_iLength <<endl;
					cout << "CRC calculated: " << m_lvCRC << endl;
					system("pause");
	#endif
					// CRC ERROR!
					m_iRxErrorFrames++;
					ErrorFrames.write( SC_LOGIC_1 );
					m_bExpectEOF = true;         
					m_bContError = true;
					m_iRxBits = 0;  
				}
			}
		}
		else
		{
			if(m_bNextBitStuff)
			{            
				m_bNextBitStuff = false;
				m_iRxBits--;  
				return;
			}
			
			if( valueIn == SC_LOGIC_1)
			{            
				if( m_iRxBits == 7 )
				{
					m_bIdle = true;
					m_bExpectEOF = false;
					m_iRxBits = 0;
					m_iSeqBits = 1;
					m_iLength = MAX_FRAME_BITS;
					m_bNextBitStuff = false;

					if(m_bPendingCorrect)
					{
						m_iRxCorrectFrames++;
						CorrectFrames.write(SC_LOGIC_1);
						m_bPendingCorrect = false;
					}
				}
			}    
			else
			{
				if(!m_bContError)
				{
	#ifdef _DEBUG
					cout << "EOF error at Frame#: " << m_iRxFrames << endl;
					cout << "Frame State: " << m_lvFrame << "\n valid bits: "<< m_iRxBits << "\n counted length: " << m_iLength <<endl;
					cout << "CRC calculated: " << m_lvCRC << endl;
					system("pause");
	#endif
					// EOF ERROR!
					m_iRxErrorFrames++;
					ErrorFrames.write( SC_LOGIC_1 );
					m_bContError = true;
				}
				m_iRxBits = 0;   
				m_bNextBitStuff = false;
				m_bPendingCorrect = false;
			}
		}
	}

	bool FramesReceiver::CheckCRC()
	{
		size_t RxCRC = m_lvFrame.range( 14, 0 ).to_uint();
		size_t CalcCRC = m_lvCRC.to_uint();

		return ( RxCRC == CalcCRC );
	}


	size_t FramesReceiver::FindLength()
	{
		size_t iDataLength =  m_lvFrame.range( 2, 0 ).to_uint();
		return (iDataLength*8) + 11 + 3;
	}

	sc_lv<15> FramesReceiver::CalculateCRC()
	{
		sc_lv<15> crcReg = 0; 

		for( int i = m_iLength - 1; i >= 0; i-- )
		{	        
			sc_logic crcNext = m_lvFrame[i] ^ crcReg[14];		
			crcReg <<= 1;				
			if (crcNext == SC_LOGIC_1)        			
				crcReg ^= 0x4599;	        
		}

		return crcReg;		
	}
}