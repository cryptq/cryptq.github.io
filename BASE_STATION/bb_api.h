// Copyright (c).2014-2022, Signal Hound
// For licensing information, please see the API license in the software_licenses folder
 
#ifndef BB_API_H
#define BB_API_H
 
#if defined(_WIN32)
    #ifdef BB_EXPORTS
        #define BB_API __declspec(dllexport)
    #else
        #define BB_API __declspec(dllimport)
    #endif
 
    // bare minimum stdint typedef support
    #if _MSC_VER < 1700 // For VS2010 or earlier
        typedef signed char        int8_t;
        typedef short              int16_t;
        typedef int                int32_t;
        typedef long long          int64_t;
        typedef unsigned char      uint8_t;
        typedef unsigned short     uint16_t;
        typedef unsigned int       uint32_t;
        typedef unsigned long long uint64_t;
    #else
        #include <stdint.h>
    #endif
 
    #define BB_DEPRECATED(comment) __declspec(deprecated(comment))
#else // Linux
    #define BB_API __attribute__((visibility("default")))
 
    #include <stdint.h>
 
    #if defined(__GNUC__)
        #define BB_DEPRECATED(comment) __attribute__((deprecated))
    #else
        #define BB_DEPRECATED(comment) comment
    #endif
#endif
 
#define BB_TRUE (1)
#define BB_FALSE (0)
 
#define BB_DEVICE_NONE (0)
#define BB_DEVICE_BB60A (1)
#define BB_DEVICE_BB60C (2)
#define BB_DEVICE_BB60D (3)
 
#define BB_MAX_DEVICES (8)
 
#define BB_MIN_FREQ (9.0e3)
#define BB_MAX_FREQ (6.4e9)
 
#define BB_MIN_SPAN (20.0)
#define BB_MAX_SPAN (BB_MAX_FREQ - BB_MIN_FREQ)
 
#define BB_MIN_RBW (0.602006912)
#define BB_MAX_RBW (10100000.0)
 
#define BB_MIN_SWEEP_TIME (0.00001) // 10us
#define BB_MAX_SWEEP_TIME (1.0) // 1s
 
#define BB_MIN_RT_RBW (2465.820313)
#define BB_MAX_RT_RBW (631250.0)
#define BB_MIN_RT_SPAN (200.0e3)
#define BB60A_MAX_RT_SPAN (20.0e6)
#define BB60C_MAX_RT_SPAN (27.0e6)
 
#define BB_MIN_USB_VOLTAGE (4.4)
 
#define BB_MAX_REFERENCE (20.0)
 
#define BB_AUTO_ATTEN (-1)
#define BB_MAX_ATTEN (3)
#define BB_AUTO_GAIN (-1)
#define BB_MAX_GAIN (3)
 
#define BB_MIN_DECIMATION (1)
#define BB_MAX_DECIMATION (8192)
 
#define BB_IDLE (-1)
#define BB_SWEEPING (0)
#define BB_REAL_TIME (1)
#define BB_STREAMING (4)
#define BB_AUDIO_DEMOD (7)
#define BB_TG_SWEEPING (8)
 
#define BB_NO_SPUR_REJECT (0)
#define BB_SPUR_REJECT (1)
 
#define BB_LOG_SCALE (0)
#define BB_LIN_SCALE (1)
#define BB_LOG_FULL_SCALE (2)
#define BB_LIN_FULL_SCALE (3)
 
#define BB_RBW_SHAPE_NUTTALL (0)
#define BB_RBW_SHAPE_FLATTOP (1)
#define BB_RBW_SHAPE_CISPR (2)
 
#define BB_MIN_AND_MAX (0)
#define BB_AVERAGE (1)
 
#define BB_LOG (0)
#define BB_VOLTAGE (1)
#define BB_POWER (2)
#define BB_SAMPLE (3)
 
#define BB_DEMOD_AM (0)
#define BB_DEMOD_FM (1)
#define BB_DEMOD_USB (2)
#define BB_DEMOD_LSB (3)
#define BB_DEMOD_CW (4)
 
#define BB_STREAM_IQ (0x0)
#define BB_DIRECT_RF (0x2)
#define BB_TIME_STAMP (0x10)
 
#define BB60C_PORT1_AC_COUPLED (0x00)
#define BB60C_PORT1_DC_COUPLED (0x04)
#define BB60C_PORT1_10MHZ_USE_INT (0x00)
#define BB60C_PORT1_10MHZ_REF_OUT (0x100)
#define BB60C_PORT1_10MHZ_REF_IN (0x8)
#define BB60C_PORT1_OUT_LOGIC_LOW (0x14)
#define BB60C_PORT1_OUT_LOGIC_HIGH (0x1C)
#define BB60C_PORT2_OUT_LOGIC_LOW (0x00)
#define BB60C_PORT2_OUT_LOGIC_HIGH (0x20)
#define BB60C_PORT2_IN_TRIG_RISING_EDGE (0x40)
#define BB60C_PORT2_IN_TRIG_FALLING_EDGE (0x60)
 
#define BB60D_PORT1_DISABLED (0)
#define BB60D_PORT1_10MHZ_REF_IN (1)
#define BB60D_PORT2_DISABLED (0)
#define BB60D_PORT2_10MHZ_REF_OUT (1)
#define BB60D_PORT2_IN_TRIG_RISING_EDGE (2)
#define BB60D_PORT2_IN_TRIG_FALLING_EDGE (3)
#define BB60D_PORT2_OUT_LOGIC_LOW (4)
#define BB60D_PORT2_OUT_LOGIC_HIGH (5)
#define BB60D_PORT2_OUT_UART (6)
 
#define BB60D_UART_BAUD_4_8K (0)
#define BB60D_UART_BAUD_9_6K (1)
#define BB60D_UART_BAUD_19_2K (2)
#define BB60D_UART_BAUD_38_4K (3)
#define BB60D_UART_BAUD_14_4K (4)
#define BB60D_UART_BAUD_28_8K (5)
#define BB60D_UART_BAUD_57_6K (6)
#define BB60D_UART_BAUD_115_2K (7)
#define BB60D_UART_BAUD_125K (8)
#define BB60D_UART_BAUD_250K (9)
#define BB60D_UART_BAUD_500K (10)
#define BB60D_UART_BAUD_1000K (11)
 
#define BB60D_MIN_UART_STATES (2)
#define BB60D_MAX_UART_STATES (8)
 
#define TG_THRU_0DB (0x1)
#define TG_THRU_20DB (0x2)
 
#define TG_REF_UNUSED (0)
#define TG_REF_INTERNAL_OUT (1)
#define TG_REF_EXTERNAL_IN (2)
 
typedef struct bbIQPacket {
    void *iqData;
    int iqCount;
    int *triggers;
    int triggerCount;
    int purge;
    int dataRemaining;
    int sampleLoss;
    int sec;
    int nano;
} bbIQPacket;
 
typedef enum bbStatus {
    bbInvalidModeErr             = -112,
    bbReferenceLevelErr          = -111,
    bbInvalidVideoUnitsErr       = -110,
    bbInvalidWindowErr           = -109,
    bbInvalidBandwidthTypeErr    = -108,
    bbInvalidSweepTimeErr        = -107,
    bbBandwidthErr               = -106,
    bbInvalidGainErr             = -105,
    bbAttenuationErr             = -104,
    bbFrequencyRangeErr          = -103,
    bbInvalidSpanErr             = -102,
    bbInvalidScaleErr            = -101,
    bbInvalidDetectorErr         = -100,
 
    bbInvalidFileSizeErr         = -19,
    bbLibusbError                = -18,
    bbNotSupportedErr            = -17,
    bbTrackingGeneratorNotFound  = -16,
 
    bbUSBTimeoutErr              = -15,
    bbDeviceConnectionErr        = -14,
    bbPacketFramingErr           = -13,
    bbGPSErr                     = -12,
    bbGainNotSetErr              = -11,
    bbDeviceNotIdleErr           = -10,
    bbDeviceInvalidErr           = -9,
    bbBufferTooSmallErr          = -8,
    bbNullPtrErr                 = -7,
    bbAllocationLimitErr         = -6,
    bbDeviceAlreadyStreamingErr  = -5,
    bbInvalidParameterErr        = -4,
    bbDeviceNotConfiguredErr     = -3,
    bbDeviceNotStreamingErr      = -2,
    bbDeviceNotOpenErr           = -1,
 
    bbNoError                    = 0,
 
    // Warnings/Messages
 
    bbAdjustedParameter          = 1,
    bbADCOverflow                = 2,
    bbNoTriggerFound             = 3,
    bbClampedToUpperLimit        = 4,
    bbClampedToLowerLimit        = 5,
    bbUncalibratedDevice         = 6,
    bbDataBreak                  = 7,
    bbUncalSweep                 = 8,
    bbInvalidCalData             = 9
} bbStatus;
 
typedef enum bbDataType {
    bbDataType32fc = 0,
    bbDataType16sc = 1
} bbDataType;
 
typedef enum bbPowerState {
    bbPowerStateOn = 0,
    bbPowerStateStandby = 1
} bbPowerState;
 
#ifdef __cplusplus
extern "C" {
#endif
 
BB_API bbStatus bbGetSerialNumberList(int serialNumbers[BB_MAX_DEVICES], int *deviceCount);
 
BB_API bbStatus bbGetSerialNumberList2(int serialNumbers[BB_MAX_DEVICES],
                                       int deviceTypes[BB_MAX_DEVICES],
                                       int *deviceCount);
 
BB_API bbStatus bbOpenDevice(int *device);
 
BB_API bbStatus bbOpenDeviceBySerialNumber(int *device, int serialNumber);
 
BB_API bbStatus bbCloseDevice(int device);
 
BB_API bbStatus bbSetPowerState(int device, bbPowerState powerState);
 
BB_API bbStatus bbGetPowerState(int device, bbPowerState *powerState);
 
BB_API bbStatus bbPreset(int device);
 
BB_API bbStatus bbPresetFull(int *device);
 
BB_API bbStatus bbSelfCal(int device);
 
BB_API bbStatus bbGetSerialNumber(int device, uint32_t *serialNumber);
 
BB_API bbStatus bbGetDeviceType(int device, int *deviceType);
 
BB_API bbStatus bbGetFirmwareVersion(int device, int *version);
 
BB_API bbStatus bbGetDeviceDiagnostics(int device, float *temperature, float *usbVoltage, float *usbCurrent);
 
BB_API bbStatus bbConfigureIO(int device, uint32_t port1, uint32_t port2);
 
BB_API bbStatus bbSyncCPUtoGPS(int comPort, int baudRate);
 
BB_API bbStatus bbSetUARTRate(int device, int rate);
 
BB_API bbStatus bbEnableUARTSweeping(int device, const double *freqs, const uint8_t *data, int states);
 
BB_API bbStatus bbDisableUARTSweeping(int device);
 
BB_API bbStatus bbEnableUARTStreaming(int device, const uint8_t *data, const uint32_t *counts, int states);
 
BB_API bbStatus bbDisableUARTStreaming(int device);
 
BB_API bbStatus bbWriteUARTImm(int device, uint8_t data);
 
BB_API bbStatus bbConfigureRefLevel(int device, double refLevel);
 
BB_API bbStatus bbConfigureGainAtten(int device, int gain, int atten);
 
BB_API bbStatus bbConfigureCenterSpan(int device, double center, double span);
 
BB_API bbStatus bbConfigureSweepCoupling(int device, double rbw, double vbw, double sweepTime,
                                         uint32_t rbwShape, uint32_t rejection);
 
BB_API bbStatus bbConfigureAcquisition(int device, uint32_t detector, uint32_t scale);
 
BB_API bbStatus bbConfigureProcUnits(int device, uint32_t units);
 
BB_API bbStatus bbConfigureRealTime(int device, double frameScale, int frameRate);
 
BB_API bbStatus bbConfigureRealTimeOverlap(int device, double advanceRate);
 
BB_API bbStatus bbConfigureIQCenter(int device, double centerFreq);
 
BB_API bbStatus bbConfigureIQ(int device, int downsampleFactor, double bandwidth);
 
BB_API bbStatus bbConfigureIQDataType(int device, bbDataType dataType);
 
BB_API bbStatus bbConfigureIQTriggerSentinel(int sentinel);
 
BB_API bbStatus bbConfigureDemod(int device, int modulationType, double freq, float IFBW,
                                 float audioLowPassFreq, float audioHighPassFreq, float FMDeemphasis);
 
BB_API bbStatus bbInitiate(int device, uint32_t mode, uint32_t flag);
 
BB_API bbStatus bbAbort(int device);
 
BB_API bbStatus bbQueryTraceInfo(int device, uint32_t *traceLen, double *binSize, double *start);
 
BB_API bbStatus bbQueryRealTimeInfo(int device, int *frameWidth, int *frameHeight);
 
BB_API bbStatus bbQueryRealTimePoi(int device, double *poi);
 
BB_API bbStatus bbQueryIQParameters(int device, double *sampleRate, double *bandwidth);
 
BB_API bbStatus bbGetIQCorrection(int device, float *correction);
 
BB_API bbStatus bbFetchTrace_32f(int device, int arraySize, float *traceMin, float *traceMax);
 
BB_API bbStatus bbFetchTrace(int device, int arraySize, double *traceMin, double *traceMax);
 
BB_API bbStatus bbFetchRealTimeFrame(int device, float *traceMin, float *traceMax, float *frame, float *alphaFrame);
 
BB_API bbStatus bbGetIQ(int device, bbIQPacket *pkt);
 
BB_API bbStatus bbGetIQUnpacked(int device, void *iqData, int iqCount, int *triggers,
                                int triggerCount, int purge, int *dataRemaining,
                                int *sampleLoss, int *sec, int *nano);
 
BB_API bbStatus bbFetchAudio(int device, float *audio);
 
BB_API bbStatus bbAttachTg(int device);
 
BB_API bbStatus bbIsTgAttached(int device, bool *attached);
 
BB_API bbStatus bbConfigTgSweep(int device, int sweepSize, bool highDynamicRange, bool passiveDevice);
 
BB_API bbStatus bbStoreTgThru(int device, int flag);
 
BB_API bbStatus bbSetTg(int device, double frequency, double amplitude);
 
BB_API bbStatus bbGetTgFreqAmpl(int device, double *frequency, double *amplitude);
 
BB_API bbStatus bbSetTgReference(int device, int reference);
 
BB_API const char* bbGetAPIVersion();
 
BB_API const char* bbGetProductID();
 
BB_API const char* bbGetErrorString(bbStatus status);
 
// Deprecated functions, use suggested alternatives
 
// Use bbConfigureRefLevel instead
BB_API bbStatus bbConfigureLevel(int device, double ref, double atten);
// Use bbConfigureGainAtten instead
BB_API bbStatus bbConfigureGain(int device, int gain);
// Use bbQueryIQParameters instead
BB_API bbStatus bbQueryStreamInfo(int device, int *return_len, double *bandwidth, int *samples_per_sec);
 
#ifdef __cplusplus
} // extern "C"
#endif
 
// Deprecated macros, use alternatives where available
#define BB60_MIN_FREQ (BB_MIN_FREQ)
#define BB60_MAX_FREQ (BB_MAX_FREQ)
#define BB60_MAX_SPAN (BB_MAX_SPAN)
#define BB_MIN_BW (BB_MIN_RBW)
#define BB_MAX_BW (BB_MAX_RBW)
#define BB_MAX_ATTENUATION (30.0) // For deprecated bbConfigureLevel function
#define BB60C_MAX_GAIN (BB_MAX_GAIN)
#define BB_PORT1_INT_REF_OUT (0x00)
#define BB_PORT1_EXT_REF_IN (BB60C_PORT1_10MHZ_REF_IN)
#define BB_RAW_PIPE (BB_STREAMING)
#define BB_STREAM_IF (0x1) // No longer supported
// Use new device specific port 1 macros
#define BB_PORT1_AC_COUPLED (BB60C_PORT1_AC_COUPLED)
#define BB_PORT1_DC_COUPLED (BB60C_PORT1_DC_COUPLED)
#define BB_PORT1_10MHZ_USE_INT (BB60C_PORT1_10MHZ_USE_INT)
#define BB_PORT1_10MHZ_REF_OUT (BB60C_PORT1_10MHZ_REF_OUT)
#define BB_PORT1_10MHZ_REF_IN (BB60C_PORT1_10MHZ_REF_IN)
#define BB_PORT1_OUT_LOGIC_LOW (BB60C_PORT1_OUT_LOGIC_LOW)
#define BB_PORT1_OUT_LOGIC_HIGH (BB60C_PORT1_OUT_LOGIC_HIGH)
// Use new device specific port 2 macros
#define BB_PORT2_OUT_LOGIC_LOW (BB60C_PORT2_OUT_LOGIC_LOW)
#define BB_PORT2_OUT_LOGIC_HIGH (BB60C_PORT2_OUT_LOGIC_HIGH)
#define BB_PORT2_IN_TRIGGER_RISING_EDGE (BB60C_PORT2_IN_TRIG_RISING_EDGE)
#define BB_PORT2_IN_TRIGGER_FALLING_EDGE (BB60C_PORT2_IN_TRIG_FALLING_EDGE)
 
#endif // BB_API_H