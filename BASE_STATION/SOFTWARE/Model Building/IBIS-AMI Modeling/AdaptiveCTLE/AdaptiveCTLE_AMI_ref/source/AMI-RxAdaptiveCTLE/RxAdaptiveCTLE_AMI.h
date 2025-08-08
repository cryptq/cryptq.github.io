/*
 * RxAdaptiveCTLE_AMI.h"
 * Created by SystemVue C++ Code Generator
 * Copyright © 2000-2014, Keysight Technologies, Inc.
 */

#pragma once

#if !defined _MSC_FULL_VER
#define SV_AMI_MODEL_EXPORT
#else
#define SV_AMI_MODEL_EXPORT __declspec(dllexport)
#endif

extern "C" SV_AMI_MODEL_EXPORT long AMI_Init( double *impulse_matrix, long row_size, long aggressors, double sample_interval, double bit_time, char *AMI_parameters_in, char **AMI_parameters_out, void **AMI_memory_handle, char **msg );
extern "C" SV_AMI_MODEL_EXPORT long AMI_GetWave( double *wave, long wave_size, double *clock_times, char **AMI_parameters_out, void *AMI_memory );
extern "C" SV_AMI_MODEL_EXPORT long AMI_Close( void *AMI_memory );
