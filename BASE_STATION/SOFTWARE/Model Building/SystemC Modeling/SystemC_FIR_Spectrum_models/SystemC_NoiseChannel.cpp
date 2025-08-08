// Copyright 2011 - 2014 Keysight Technologies, Inc   

#include "SystemC_NoiseChannel.h"

#include <ctime>
#include <cmath>

namespace SystemVueModelBuilder
{

    int InitializeSeed( unsigned iDeviation )
    {
        srand( time(NULL) );       
        unsigned uPrecision;

        if( iDeviation <= 2 )
            uPrecision = 4;
        else if( iDeviation <= 20 )
            uPrecision = 3;
        else if( iDeviation <= 200 )
            uPrecision = 2;
        else if( iDeviation <= 2000 )
            uPrecision = 1;
        else 
            uPrecision = 0;

        return pow( 10.0, (int)uPrecision );
    }

    double RandomValue( unsigned iDeviation, int iPrecPower, double dOffset)
    {           
        double randNum = rand() % ( 2*iDeviation*iPrecPower + 1 );
        randNum = randNum/iPrecPower + dOffset;
        randNum -= iDeviation;
        return randNum;
    }
}