-------------------------------------------------------------------------------
-- Automatically generated VHDL code for non-primitive component
-- M9703_MultiCh_Cali_FPGA0.vhd
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library work;
use work.p_fxp.all;


entity M9703_MultiCh_Cali_FPGA0 is
    port (
        ADC1          : in  std_logic_vector(15 downto 0);
        ADC10         : in  std_logic_vector(15 downto 0);
        ADC11         : in  std_logic_vector(15 downto 0);
        ADC12         : in  std_logic_vector(15 downto 0);
        ADC13         : in  std_logic_vector(15 downto 0);
        ADC14         : in  std_logic_vector(15 downto 0);
        ADC15         : in  std_logic_vector(15 downto 0);
        ADC16         : in  std_logic_vector(15 downto 0);
        ADC17         : in  std_logic_vector(15 downto 0);
        ADC18         : in  std_logic_vector(15 downto 0);
        ADC19         : in  std_logic_vector(15 downto 0);
        ADC2          : in  std_logic_vector(15 downto 0);
        ADC20         : in  std_logic_vector(15 downto 0);
        ADC21         : in  std_logic_vector(15 downto 0);
        ADC22         : in  std_logic_vector(15 downto 0);
        ADC23         : in  std_logic_vector(15 downto 0);
        ADC24         : in  std_logic_vector(15 downto 0);
        ADC25         : in  std_logic_vector(15 downto 0);
        ADC26         : in  std_logic_vector(15 downto 0);
        ADC27         : in  std_logic_vector(15 downto 0);
        ADC28         : in  std_logic_vector(15 downto 0);
        ADC29         : in  std_logic_vector(15 downto 0);
        ADC3          : in  std_logic_vector(15 downto 0);
        ADC30         : in  std_logic_vector(15 downto 0);
        ADC31         : in  std_logic_vector(15 downto 0);
        ADC32         : in  std_logic_vector(15 downto 0);
        ADC4          : in  std_logic_vector(15 downto 0);
        ADC5          : in  std_logic_vector(15 downto 0);
        ADC6          : in  std_logic_vector(15 downto 0);
        ADC7          : in  std_logic_vector(15 downto 0);
        ADC8          : in  std_logic_vector(15 downto 0);
        ADC9          : in  std_logic_vector(15 downto 0);
        ADCValidIn    : in  std_logic_vector(0 downto 0);
        BlockRegAddr1 : out std_logic_vector(4 downto 0);
        BlockRegAddr2 : out std_logic_vector(4 downto 0);
        BlockRegData1 : in  std_logic_vector(15 downto 0);
        BlockRegData2 : in  std_logic_vector(15 downto 0);
        BlockRegRd1   : out std_logic_vector(0 downto 0);
        BlockRegRd2   : out std_logic_vector(0 downto 0);
        DataOut1      : out std_logic_vector(43 downto 0);
        ReadyIn1      : in  std_logic_vector(0 downto 0);
        Register1     : in  std_logic_vector(15 downto 0);
        Register10    : in  std_logic_vector(31 downto 0);
        Register2     : in  std_logic_vector(0 downto 0);
        Register3     : in  std_logic_vector(31 downto 0);
        Register4     : in  std_logic_vector(31 downto 0);
        Register5     : in  std_logic_vector(31 downto 0);
        Register6     : in  std_logic_vector(31 downto 0);
        Register7     : in  std_logic_vector(31 downto 0);
        Register8     : in  std_logic_vector(31 downto 0);
        Register9     : in  std_logic_vector(31 downto 0);
        ValidOut1     : out std_logic_vector(0 downto 0);
        ce1           : in  std_logic;
        ce2           : in  std_logic;
        clk           : in  std_logic;
        rst           : in  std_logic);
end M9703_MultiCh_Cali_FPGA0;


architecture M9703_MultiCh_Cali_FPGA0_Arch of M9703_MultiCh_Cali_FPGA0 is
    
    component AddFxp
        generic (
            Overflow       : integer;
            Quantization   : integer;
            SaturationBits : integer;
            dataIn1IWL     : integer;
            dataIn1SGN     : integer;
            dataIn1WL      : integer;
            dataIn2IWL     : integer;
            dataIn2SGN     : integer;
            dataIn2WL      : integer;
            dataOutIWL     : integer;
            dataOutSGN     : integer;
            dataOutWL      : integer);
        port (
            dataIn1 : in  std_logic_vector(dataIn1WL-1 downto 0);
            dataIn2 : in  std_logic_vector(dataIn2WL-1 downto 0);
            dataOut : out std_logic_vector(dataOutWL-1 downto 0));
    end component;
    
    component BitMergeFxp
        generic (
            Overflow            : integer;
            Quantization        : integer;
            SaturationBits      : integer;
            UseInputWordlengths : integer;
            dataLSWL            : integer;
            dataMSWL            : integer;
            dataOutIWL          : integer;
            dataOutSGN          : integer;
            dataOutWL           : integer);
        port (
            dataLS  : in  std_logic_vector(dataLSWL-1 downto 0);
            dataMS  : in  std_logic_vector(dataMSWL-1 downto 0);
            dataOut : out std_logic_vector(dataOutWL-1 downto 0));
    end component;
    
    component CounterFxp
        generic (
            Direction      : integer;
            FxpInitValue   : integer;
            Overflow       : integer;
            Quantization   : integer;
            SaturationBits : integer;
            StepFxp        : integer;
            dataOutIWL     : integer;
            dataOutSGN     : integer;
            dataOutWL      : integer);
        port (
            ce      : in  std_logic;
            clk     : in  std_logic;
            dataOut : out std_logic_vector(dataOutWL-1 downto 0);
            enable  : in  std_logic;
            rdy     : out std_logic;
            reset   : in  std_logic;
            rst     : in  std_logic);
    end component;
    
    component CompareConstFxp
        generic (
            CompareOperation       : integer;
            ConstIntegerWordlength : integer;
            ConstIsSigned          : integer;
            ConstWordlength        : integer;
            FxpConstant            : integer;
            dataInAIWL             : integer;
            dataInASGN             : integer;
            dataInAWL              : integer;
            dataOutWL              : integer);
        port (
            dataInA : in  std_logic_vector(dataInAWL-1 downto 0);
            dataOut : out std_logic);
    end component;
    
    component DelayFxp
        generic (
            Delay        : integer;
            FxpInitValue : integer;
            dataInWL     : integer;
            dataOutSGN   : integer;
            dataOutWL    : integer);
        port (
            CE      : in  std_logic;
            CLK     : in  std_logic;
            RDY     : out std_logic;
            RST     : in  std_logic;
            dataIn  : in  std_logic_vector(dataInWL-1 downto 0);
            dataOut : out std_logic_vector(dataOutWL-1 downto 0));
    end component;
    
    component DownSampleFxp
        generic (
            Factor    : integer;
            Phase     : integer;
            dataInWL  : integer;
            dataOutWL : integer);
        port (
            ce      : in  std_logic;
            clk     : in  std_logic;
            dataIn  : in  std_logic_vector(dataInWL-1 downto 0);
            dataOut : out std_logic_vector(dataOutWL-1 downto 0);
            rst     : in  std_logic);
    end component;
    
    component ExtractFxp
        generic (
            LSB        : integer;
            MSB        : integer;
            dataInIWL  : integer;
            dataInWL   : integer;
            dataOutIWL : integer;
            dataOutWL  : integer);
        port (
            dataIn  : in  std_logic_vector(dataInWL-1 downto 0);
            dataOut : out std_logic_vector(dataOutWL-1 downto 0));
    end component;
    
    component Synth_Design3_Subnetwork3_FPGA0_H1
        generic (
            DDC_freq_norm_0_VIWL      : integer;
            DDC_freq_norm_0_VSGN      : integer;
            DDC_freq_norm_0_VWL       : integer;
            DDC_freq_norm_1_VIWL      : integer;
            DDC_freq_norm_1_VSGN      : integer;
            DDC_freq_norm_1_VWL       : integer;
            DDC_freq_norm_2_VIWL      : integer;
            DDC_freq_norm_2_VSGN      : integer;
            DDC_freq_norm_2_VWL       : integer;
            DDC_freq_norm_3_VIWL      : integer;
            DDC_freq_norm_3_VSGN      : integer;
            DDC_freq_norm_3_VWL       : integer;
            DDC_freq_norm_4_VIWL      : integer;
            DDC_freq_norm_4_VSGN      : integer;
            DDC_freq_norm_4_VWL       : integer;
            DDC_freq_norm_5_VIWL      : integer;
            DDC_freq_norm_5_VSGN      : integer;
            DDC_freq_norm_5_VWL       : integer;
            DDC_freq_norm_6_VIWL      : integer;
            DDC_freq_norm_6_VSGN      : integer;
            DDC_freq_norm_6_VWL       : integer;
            DDC_freq_norm_7_VIWL      : integer;
            DDC_freq_norm_7_VSGN      : integer;
            DDC_freq_norm_7_VWL       : integer;
            input_VIWL                : integer;
            input_VSGN                : integer;
            input_VWL                 : integer;
            output_rIWL               : integer;
            output_rSGN               : integer;
            output_rWL                : integer;
            output_r_ap_vldIWL        : integer;
            output_r_ap_vldSGN        : integer;
            output_r_ap_vldWL         : integer;
            reconfigcoef_0_imag_VIWL  : integer;
            reconfigcoef_0_imag_VSGN  : integer;
            reconfigcoef_0_imag_VWL   : integer;
            reconfigcoef_0_real_VIWL  : integer;
            reconfigcoef_0_real_VSGN  : integer;
            reconfigcoef_0_real_VWL   : integer;
            reconfigcoef_10_imag_VIWL : integer;
            reconfigcoef_10_imag_VSGN : integer;
            reconfigcoef_10_imag_VWL  : integer;
            reconfigcoef_10_real_VIWL : integer;
            reconfigcoef_10_real_VSGN : integer;
            reconfigcoef_10_real_VWL  : integer;
            reconfigcoef_11_imag_VIWL : integer;
            reconfigcoef_11_imag_VSGN : integer;
            reconfigcoef_11_imag_VWL  : integer;
            reconfigcoef_11_real_VIWL : integer;
            reconfigcoef_11_real_VSGN : integer;
            reconfigcoef_11_real_VWL  : integer;
            reconfigcoef_12_imag_VIWL : integer;
            reconfigcoef_12_imag_VSGN : integer;
            reconfigcoef_12_imag_VWL  : integer;
            reconfigcoef_12_real_VIWL : integer;
            reconfigcoef_12_real_VSGN : integer;
            reconfigcoef_12_real_VWL  : integer;
            reconfigcoef_13_imag_VIWL : integer;
            reconfigcoef_13_imag_VSGN : integer;
            reconfigcoef_13_imag_VWL  : integer;
            reconfigcoef_13_real_VIWL : integer;
            reconfigcoef_13_real_VSGN : integer;
            reconfigcoef_13_real_VWL  : integer;
            reconfigcoef_14_imag_VIWL : integer;
            reconfigcoef_14_imag_VSGN : integer;
            reconfigcoef_14_imag_VWL  : integer;
            reconfigcoef_14_real_VIWL : integer;
            reconfigcoef_14_real_VSGN : integer;
            reconfigcoef_14_real_VWL  : integer;
            reconfigcoef_15_imag_VIWL : integer;
            reconfigcoef_15_imag_VSGN : integer;
            reconfigcoef_15_imag_VWL  : integer;
            reconfigcoef_15_real_VIWL : integer;
            reconfigcoef_15_real_VSGN : integer;
            reconfigcoef_15_real_VWL  : integer;
            reconfigcoef_16_imag_VIWL : integer;
            reconfigcoef_16_imag_VSGN : integer;
            reconfigcoef_16_imag_VWL  : integer;
            reconfigcoef_16_real_VIWL : integer;
            reconfigcoef_16_real_VSGN : integer;
            reconfigcoef_16_real_VWL  : integer;
            reconfigcoef_17_imag_VIWL : integer;
            reconfigcoef_17_imag_VSGN : integer;
            reconfigcoef_17_imag_VWL  : integer;
            reconfigcoef_17_real_VIWL : integer;
            reconfigcoef_17_real_VSGN : integer;
            reconfigcoef_17_real_VWL  : integer;
            reconfigcoef_18_imag_VIWL : integer;
            reconfigcoef_18_imag_VSGN : integer;
            reconfigcoef_18_imag_VWL  : integer;
            reconfigcoef_18_real_VIWL : integer;
            reconfigcoef_18_real_VSGN : integer;
            reconfigcoef_18_real_VWL  : integer;
            reconfigcoef_19_imag_VIWL : integer;
            reconfigcoef_19_imag_VSGN : integer;
            reconfigcoef_19_imag_VWL  : integer;
            reconfigcoef_19_real_VIWL : integer;
            reconfigcoef_19_real_VSGN : integer;
            reconfigcoef_19_real_VWL  : integer;
            reconfigcoef_1_imag_VIWL  : integer;
            reconfigcoef_1_imag_VSGN  : integer;
            reconfigcoef_1_imag_VWL   : integer;
            reconfigcoef_1_real_VIWL  : integer;
            reconfigcoef_1_real_VSGN  : integer;
            reconfigcoef_1_real_VWL   : integer;
            reconfigcoef_20_imag_VIWL : integer;
            reconfigcoef_20_imag_VSGN : integer;
            reconfigcoef_20_imag_VWL  : integer;
            reconfigcoef_20_real_VIWL : integer;
            reconfigcoef_20_real_VSGN : integer;
            reconfigcoef_20_real_VWL  : integer;
            reconfigcoef_21_imag_VIWL : integer;
            reconfigcoef_21_imag_VSGN : integer;
            reconfigcoef_21_imag_VWL  : integer;
            reconfigcoef_21_real_VIWL : integer;
            reconfigcoef_21_real_VSGN : integer;
            reconfigcoef_21_real_VWL  : integer;
            reconfigcoef_22_imag_VIWL : integer;
            reconfigcoef_22_imag_VSGN : integer;
            reconfigcoef_22_imag_VWL  : integer;
            reconfigcoef_22_real_VIWL : integer;
            reconfigcoef_22_real_VSGN : integer;
            reconfigcoef_22_real_VWL  : integer;
            reconfigcoef_23_imag_VIWL : integer;
            reconfigcoef_23_imag_VSGN : integer;
            reconfigcoef_23_imag_VWL  : integer;
            reconfigcoef_23_real_VIWL : integer;
            reconfigcoef_23_real_VSGN : integer;
            reconfigcoef_23_real_VWL  : integer;
            reconfigcoef_24_imag_VIWL : integer;
            reconfigcoef_24_imag_VSGN : integer;
            reconfigcoef_24_imag_VWL  : integer;
            reconfigcoef_24_real_VIWL : integer;
            reconfigcoef_24_real_VSGN : integer;
            reconfigcoef_24_real_VWL  : integer;
            reconfigcoef_25_imag_VIWL : integer;
            reconfigcoef_25_imag_VSGN : integer;
            reconfigcoef_25_imag_VWL  : integer;
            reconfigcoef_25_real_VIWL : integer;
            reconfigcoef_25_real_VSGN : integer;
            reconfigcoef_25_real_VWL  : integer;
            reconfigcoef_26_imag_VIWL : integer;
            reconfigcoef_26_imag_VSGN : integer;
            reconfigcoef_26_imag_VWL  : integer;
            reconfigcoef_26_real_VIWL : integer;
            reconfigcoef_26_real_VSGN : integer;
            reconfigcoef_26_real_VWL  : integer;
            reconfigcoef_27_imag_VIWL : integer;
            reconfigcoef_27_imag_VSGN : integer;
            reconfigcoef_27_imag_VWL  : integer;
            reconfigcoef_27_real_VIWL : integer;
            reconfigcoef_27_real_VSGN : integer;
            reconfigcoef_27_real_VWL  : integer;
            reconfigcoef_28_imag_VIWL : integer;
            reconfigcoef_28_imag_VSGN : integer;
            reconfigcoef_28_imag_VWL  : integer;
            reconfigcoef_28_real_VIWL : integer;
            reconfigcoef_28_real_VSGN : integer;
            reconfigcoef_28_real_VWL  : integer;
            reconfigcoef_29_imag_VIWL : integer;
            reconfigcoef_29_imag_VSGN : integer;
            reconfigcoef_29_imag_VWL  : integer;
            reconfigcoef_29_real_VIWL : integer;
            reconfigcoef_29_real_VSGN : integer;
            reconfigcoef_29_real_VWL  : integer;
            reconfigcoef_2_imag_VIWL  : integer;
            reconfigcoef_2_imag_VSGN  : integer;
            reconfigcoef_2_imag_VWL   : integer;
            reconfigcoef_2_real_VIWL  : integer;
            reconfigcoef_2_real_VSGN  : integer;
            reconfigcoef_2_real_VWL   : integer;
            reconfigcoef_30_imag_VIWL : integer;
            reconfigcoef_30_imag_VSGN : integer;
            reconfigcoef_30_imag_VWL  : integer;
            reconfigcoef_30_real_VIWL : integer;
            reconfigcoef_30_real_VSGN : integer;
            reconfigcoef_30_real_VWL  : integer;
            reconfigcoef_31_imag_VIWL : integer;
            reconfigcoef_31_imag_VSGN : integer;
            reconfigcoef_31_imag_VWL  : integer;
            reconfigcoef_31_real_VIWL : integer;
            reconfigcoef_31_real_VSGN : integer;
            reconfigcoef_31_real_VWL  : integer;
            reconfigcoef_3_imag_VIWL  : integer;
            reconfigcoef_3_imag_VSGN  : integer;
            reconfigcoef_3_imag_VWL   : integer;
            reconfigcoef_3_real_VIWL  : integer;
            reconfigcoef_3_real_VSGN  : integer;
            reconfigcoef_3_real_VWL   : integer;
            reconfigcoef_4_imag_VIWL  : integer;
            reconfigcoef_4_imag_VSGN  : integer;
            reconfigcoef_4_imag_VWL   : integer;
            reconfigcoef_4_real_VIWL  : integer;
            reconfigcoef_4_real_VSGN  : integer;
            reconfigcoef_4_real_VWL   : integer;
            reconfigcoef_5_imag_VIWL  : integer;
            reconfigcoef_5_imag_VSGN  : integer;
            reconfigcoef_5_imag_VWL   : integer;
            reconfigcoef_5_real_VIWL  : integer;
            reconfigcoef_5_real_VSGN  : integer;
            reconfigcoef_5_real_VWL   : integer;
            reconfigcoef_6_imag_VIWL  : integer;
            reconfigcoef_6_imag_VSGN  : integer;
            reconfigcoef_6_imag_VWL   : integer;
            reconfigcoef_6_real_VIWL  : integer;
            reconfigcoef_6_real_VSGN  : integer;
            reconfigcoef_6_real_VWL   : integer;
            reconfigcoef_7_imag_VIWL  : integer;
            reconfigcoef_7_imag_VSGN  : integer;
            reconfigcoef_7_imag_VWL   : integer;
            reconfigcoef_7_real_VIWL  : integer;
            reconfigcoef_7_real_VSGN  : integer;
            reconfigcoef_7_real_VWL   : integer;
            reconfigcoef_8_imag_VIWL  : integer;
            reconfigcoef_8_imag_VSGN  : integer;
            reconfigcoef_8_imag_VWL   : integer;
            reconfigcoef_8_real_VIWL  : integer;
            reconfigcoef_8_real_VSGN  : integer;
            reconfigcoef_8_real_VWL   : integer;
            reconfigcoef_9_imag_VIWL  : integer;
            reconfigcoef_9_imag_VSGN  : integer;
            reconfigcoef_9_imag_VWL   : integer;
            reconfigcoef_9_real_VIWL  : integer;
            reconfigcoef_9_real_VSGN  : integer;
            reconfigcoef_9_real_VWL   : integer);
        port (
            DDC_freq_norm_0_V      : in  std_logic_vector(DDC_freq_norm_0_VWL-1 downto 0);
            DDC_freq_norm_1_V      : in  std_logic_vector(DDC_freq_norm_1_VWL-1 downto 0);
            DDC_freq_norm_2_V      : in  std_logic_vector(DDC_freq_norm_2_VWL-1 downto 0);
            DDC_freq_norm_3_V      : in  std_logic_vector(DDC_freq_norm_3_VWL-1 downto 0);
            DDC_freq_norm_4_V      : in  std_logic_vector(DDC_freq_norm_4_VWL-1 downto 0);
            DDC_freq_norm_5_V      : in  std_logic_vector(DDC_freq_norm_5_VWL-1 downto 0);
            DDC_freq_norm_6_V      : in  std_logic_vector(DDC_freq_norm_6_VWL-1 downto 0);
            DDC_freq_norm_7_V      : in  std_logic_vector(DDC_freq_norm_7_VWL-1 downto 0);
            ap_clk                 : in  std_logic;
            ap_rst                 : in  std_logic;
            input_V                : in  std_logic_vector(input_VWL-1 downto 0);
            output_r               : out std_logic_vector(output_rWL-1 downto 0);
            output_r_ap_vld        : out std_logic;
            reconfigcoef_0_imag_V  : in  std_logic_vector(reconfigcoef_0_imag_VWL-1 downto 0);
            reconfigcoef_0_real_V  : in  std_logic_vector(reconfigcoef_0_real_VWL-1 downto 0);
            reconfigcoef_10_imag_V : in  std_logic_vector(reconfigcoef_10_imag_VWL-1 downto 0);
            reconfigcoef_10_real_V : in  std_logic_vector(reconfigcoef_10_real_VWL-1 downto 0);
            reconfigcoef_11_imag_V : in  std_logic_vector(reconfigcoef_11_imag_VWL-1 downto 0);
            reconfigcoef_11_real_V : in  std_logic_vector(reconfigcoef_11_real_VWL-1 downto 0);
            reconfigcoef_12_imag_V : in  std_logic_vector(reconfigcoef_12_imag_VWL-1 downto 0);
            reconfigcoef_12_real_V : in  std_logic_vector(reconfigcoef_12_real_VWL-1 downto 0);
            reconfigcoef_13_imag_V : in  std_logic_vector(reconfigcoef_13_imag_VWL-1 downto 0);
            reconfigcoef_13_real_V : in  std_logic_vector(reconfigcoef_13_real_VWL-1 downto 0);
            reconfigcoef_14_imag_V : in  std_logic_vector(reconfigcoef_14_imag_VWL-1 downto 0);
            reconfigcoef_14_real_V : in  std_logic_vector(reconfigcoef_14_real_VWL-1 downto 0);
            reconfigcoef_15_imag_V : in  std_logic_vector(reconfigcoef_15_imag_VWL-1 downto 0);
            reconfigcoef_15_real_V : in  std_logic_vector(reconfigcoef_15_real_VWL-1 downto 0);
            reconfigcoef_16_imag_V : in  std_logic_vector(reconfigcoef_16_imag_VWL-1 downto 0);
            reconfigcoef_16_real_V : in  std_logic_vector(reconfigcoef_16_real_VWL-1 downto 0);
            reconfigcoef_17_imag_V : in  std_logic_vector(reconfigcoef_17_imag_VWL-1 downto 0);
            reconfigcoef_17_real_V : in  std_logic_vector(reconfigcoef_17_real_VWL-1 downto 0);
            reconfigcoef_18_imag_V : in  std_logic_vector(reconfigcoef_18_imag_VWL-1 downto 0);
            reconfigcoef_18_real_V : in  std_logic_vector(reconfigcoef_18_real_VWL-1 downto 0);
            reconfigcoef_19_imag_V : in  std_logic_vector(reconfigcoef_19_imag_VWL-1 downto 0);
            reconfigcoef_19_real_V : in  std_logic_vector(reconfigcoef_19_real_VWL-1 downto 0);
            reconfigcoef_1_imag_V  : in  std_logic_vector(reconfigcoef_1_imag_VWL-1 downto 0);
            reconfigcoef_1_real_V  : in  std_logic_vector(reconfigcoef_1_real_VWL-1 downto 0);
            reconfigcoef_20_imag_V : in  std_logic_vector(reconfigcoef_20_imag_VWL-1 downto 0);
            reconfigcoef_20_real_V : in  std_logic_vector(reconfigcoef_20_real_VWL-1 downto 0);
            reconfigcoef_21_imag_V : in  std_logic_vector(reconfigcoef_21_imag_VWL-1 downto 0);
            reconfigcoef_21_real_V : in  std_logic_vector(reconfigcoef_21_real_VWL-1 downto 0);
            reconfigcoef_22_imag_V : in  std_logic_vector(reconfigcoef_22_imag_VWL-1 downto 0);
            reconfigcoef_22_real_V : in  std_logic_vector(reconfigcoef_22_real_VWL-1 downto 0);
            reconfigcoef_23_imag_V : in  std_logic_vector(reconfigcoef_23_imag_VWL-1 downto 0);
            reconfigcoef_23_real_V : in  std_logic_vector(reconfigcoef_23_real_VWL-1 downto 0);
            reconfigcoef_24_imag_V : in  std_logic_vector(reconfigcoef_24_imag_VWL-1 downto 0);
            reconfigcoef_24_real_V : in  std_logic_vector(reconfigcoef_24_real_VWL-1 downto 0);
            reconfigcoef_25_imag_V : in  std_logic_vector(reconfigcoef_25_imag_VWL-1 downto 0);
            reconfigcoef_25_real_V : in  std_logic_vector(reconfigcoef_25_real_VWL-1 downto 0);
            reconfigcoef_26_imag_V : in  std_logic_vector(reconfigcoef_26_imag_VWL-1 downto 0);
            reconfigcoef_26_real_V : in  std_logic_vector(reconfigcoef_26_real_VWL-1 downto 0);
            reconfigcoef_27_imag_V : in  std_logic_vector(reconfigcoef_27_imag_VWL-1 downto 0);
            reconfigcoef_27_real_V : in  std_logic_vector(reconfigcoef_27_real_VWL-1 downto 0);
            reconfigcoef_28_imag_V : in  std_logic_vector(reconfigcoef_28_imag_VWL-1 downto 0);
            reconfigcoef_28_real_V : in  std_logic_vector(reconfigcoef_28_real_VWL-1 downto 0);
            reconfigcoef_29_imag_V : in  std_logic_vector(reconfigcoef_29_imag_VWL-1 downto 0);
            reconfigcoef_29_real_V : in  std_logic_vector(reconfigcoef_29_real_VWL-1 downto 0);
            reconfigcoef_2_imag_V  : in  std_logic_vector(reconfigcoef_2_imag_VWL-1 downto 0);
            reconfigcoef_2_real_V  : in  std_logic_vector(reconfigcoef_2_real_VWL-1 downto 0);
            reconfigcoef_30_imag_V : in  std_logic_vector(reconfigcoef_30_imag_VWL-1 downto 0);
            reconfigcoef_30_real_V : in  std_logic_vector(reconfigcoef_30_real_VWL-1 downto 0);
            reconfigcoef_31_imag_V : in  std_logic_vector(reconfigcoef_31_imag_VWL-1 downto 0);
            reconfigcoef_31_real_V : in  std_logic_vector(reconfigcoef_31_real_VWL-1 downto 0);
            reconfigcoef_3_imag_V  : in  std_logic_vector(reconfigcoef_3_imag_VWL-1 downto 0);
            reconfigcoef_3_real_V  : in  std_logic_vector(reconfigcoef_3_real_VWL-1 downto 0);
            reconfigcoef_4_imag_V  : in  std_logic_vector(reconfigcoef_4_imag_VWL-1 downto 0);
            reconfigcoef_4_real_V  : in  std_logic_vector(reconfigcoef_4_real_VWL-1 downto 0);
            reconfigcoef_5_imag_V  : in  std_logic_vector(reconfigcoef_5_imag_VWL-1 downto 0);
            reconfigcoef_5_real_V  : in  std_logic_vector(reconfigcoef_5_real_VWL-1 downto 0);
            reconfigcoef_6_imag_V  : in  std_logic_vector(reconfigcoef_6_imag_VWL-1 downto 0);
            reconfigcoef_6_real_V  : in  std_logic_vector(reconfigcoef_6_real_VWL-1 downto 0);
            reconfigcoef_7_imag_V  : in  std_logic_vector(reconfigcoef_7_imag_VWL-1 downto 0);
            reconfigcoef_7_real_V  : in  std_logic_vector(reconfigcoef_7_real_VWL-1 downto 0);
            reconfigcoef_8_imag_V  : in  std_logic_vector(reconfigcoef_8_imag_VWL-1 downto 0);
            reconfigcoef_8_real_V  : in  std_logic_vector(reconfigcoef_8_real_VWL-1 downto 0);
            reconfigcoef_9_imag_V  : in  std_logic_vector(reconfigcoef_9_imag_VWL-1 downto 0);
            reconfigcoef_9_real_V  : in  std_logic_vector(reconfigcoef_9_real_VWL-1 downto 0));
    end component;
    
    component unroll_reconfig_coef_Subnetwork1
        port (
            addr   : in  std_logic_vector(4 downto 0);
            ce1    : in  std_logic;
            clk    : in  std_logic;
            coef0  : out std_logic_vector(15 downto 0);
            coef1  : out std_logic_vector(15 downto 0);
            coef10 : out std_logic_vector(15 downto 0);
            coef11 : out std_logic_vector(15 downto 0);
            coef12 : out std_logic_vector(15 downto 0);
            coef13 : out std_logic_vector(15 downto 0);
            coef14 : out std_logic_vector(15 downto 0);
            coef15 : out std_logic_vector(15 downto 0);
            coef16 : out std_logic_vector(15 downto 0);
            coef17 : out std_logic_vector(15 downto 0);
            coef18 : out std_logic_vector(15 downto 0);
            coef19 : out std_logic_vector(15 downto 0);
            coef2  : out std_logic_vector(15 downto 0);
            coef20 : out std_logic_vector(15 downto 0);
            coef21 : out std_logic_vector(15 downto 0);
            coef22 : out std_logic_vector(15 downto 0);
            coef23 : out std_logic_vector(15 downto 0);
            coef24 : out std_logic_vector(15 downto 0);
            coef25 : out std_logic_vector(15 downto 0);
            coef26 : out std_logic_vector(15 downto 0);
            coef27 : out std_logic_vector(15 downto 0);
            coef28 : out std_logic_vector(15 downto 0);
            coef29 : out std_logic_vector(15 downto 0);
            coef3  : out std_logic_vector(15 downto 0);
            coef30 : out std_logic_vector(15 downto 0);
            coef31 : out std_logic_vector(15 downto 0);
            coef4  : out std_logic_vector(15 downto 0);
            coef5  : out std_logic_vector(15 downto 0);
            coef6  : out std_logic_vector(15 downto 0);
            coef7  : out std_logic_vector(15 downto 0);
            coef8  : out std_logic_vector(15 downto 0);
            coef9  : out std_logic_vector(15 downto 0);
            data   : in  std_logic_vector(15 downto 0);
            rst    : in  std_logic);
    end component;
    
    component unroll_reconfig_coef_Subnetwork2
        port (
            addr   : in  std_logic_vector(4 downto 0);
            ce1    : in  std_logic;
            clk    : in  std_logic;
            coef0  : out std_logic_vector(15 downto 0);
            coef1  : out std_logic_vector(15 downto 0);
            coef10 : out std_logic_vector(15 downto 0);
            coef11 : out std_logic_vector(15 downto 0);
            coef12 : out std_logic_vector(15 downto 0);
            coef13 : out std_logic_vector(15 downto 0);
            coef14 : out std_logic_vector(15 downto 0);
            coef15 : out std_logic_vector(15 downto 0);
            coef16 : out std_logic_vector(15 downto 0);
            coef17 : out std_logic_vector(15 downto 0);
            coef18 : out std_logic_vector(15 downto 0);
            coef19 : out std_logic_vector(15 downto 0);
            coef2  : out std_logic_vector(15 downto 0);
            coef20 : out std_logic_vector(15 downto 0);
            coef21 : out std_logic_vector(15 downto 0);
            coef22 : out std_logic_vector(15 downto 0);
            coef23 : out std_logic_vector(15 downto 0);
            coef24 : out std_logic_vector(15 downto 0);
            coef25 : out std_logic_vector(15 downto 0);
            coef26 : out std_logic_vector(15 downto 0);
            coef27 : out std_logic_vector(15 downto 0);
            coef28 : out std_logic_vector(15 downto 0);
            coef29 : out std_logic_vector(15 downto 0);
            coef3  : out std_logic_vector(15 downto 0);
            coef30 : out std_logic_vector(15 downto 0);
            coef31 : out std_logic_vector(15 downto 0);
            coef4  : out std_logic_vector(15 downto 0);
            coef5  : out std_logic_vector(15 downto 0);
            coef6  : out std_logic_vector(15 downto 0);
            coef7  : out std_logic_vector(15 downto 0);
            coef8  : out std_logic_vector(15 downto 0);
            coef9  : out std_logic_vector(15 downto 0);
            data   : in  std_logic_vector(15 downto 0);
            rst    : in  std_logic);
    end component;
    
    component trig_gen_Subnetwork24
        port (
            In0       : in  std_logic_vector(15 downto 0);
            In1       : in  std_logic_vector(15 downto 0);
            In10      : in  std_logic_vector(15 downto 0);
            In11      : in  std_logic_vector(15 downto 0);
            In12      : in  std_logic_vector(15 downto 0);
            In13      : in  std_logic_vector(15 downto 0);
            In14      : in  std_logic_vector(15 downto 0);
            In15      : in  std_logic_vector(15 downto 0);
            In2       : in  std_logic_vector(15 downto 0);
            In3       : in  std_logic_vector(15 downto 0);
            In4       : in  std_logic_vector(15 downto 0);
            In5       : in  std_logic_vector(15 downto 0);
            In6       : in  std_logic_vector(15 downto 0);
            In7       : in  std_logic_vector(15 downto 0);
            In8       : in  std_logic_vector(15 downto 0);
            In9       : in  std_logic_vector(15 downto 0);
            ce1       : in  std_logic;
            ce2       : in  std_logic;
            clk       : in  std_logic;
            ena       : in  std_logic_vector(0 downto 0);
            rst       : in  std_logic;
            start_pos : out std_logic_vector(7 downto 0);
            threshold : in  std_logic_vector(15 downto 0);
            trig_out  : out std_logic_vector(0 downto 0));
    end component;
    
    component ADCData_16To8_Subnetwork3
        port (
            ADC_0     : in  std_logic_vector(15 downto 0);
            ADC_1     : in  std_logic_vector(15 downto 0);
            ADC_10    : in  std_logic_vector(15 downto 0);
            ADC_11    : in  std_logic_vector(15 downto 0);
            ADC_12    : in  std_logic_vector(15 downto 0);
            ADC_13    : in  std_logic_vector(15 downto 0);
            ADC_14    : in  std_logic_vector(15 downto 0);
            ADC_15    : in  std_logic_vector(15 downto 0);
            ADC_2     : in  std_logic_vector(15 downto 0);
            ADC_3     : in  std_logic_vector(15 downto 0);
            ADC_4     : in  std_logic_vector(15 downto 0);
            ADC_5     : in  std_logic_vector(15 downto 0);
            ADC_6     : in  std_logic_vector(15 downto 0);
            ADC_7     : in  std_logic_vector(15 downto 0);
            ADC_8     : in  std_logic_vector(15 downto 0);
            ADC_9     : in  std_logic_vector(15 downto 0);
            ADC_Valid : in  std_logic_vector(0 downto 0);
            Out0      : out std_logic_vector(15 downto 0);
            Out1      : out std_logic_vector(15 downto 0);
            Out2      : out std_logic_vector(15 downto 0);
            Out3      : out std_logic_vector(15 downto 0);
            Out4      : out std_logic_vector(15 downto 0);
            Out5      : out std_logic_vector(15 downto 0);
            Out6      : out std_logic_vector(15 downto 0);
            Out7      : out std_logic_vector(15 downto 0);
            ce1       : in  std_logic;
            clk       : in  std_logic;
            rst       : in  std_logic);
    end component;
    
    component UpSampleFxp
        generic (
            ClockDivFactor : integer;
            Factor         : integer;
            Mode           : integer;
            Phase          : integer;
            dataInWL       : integer;
            dataOutWL      : integer);
        port (
            ceA     : in  std_logic;
            ceB     : in  std_logic;
            clk     : in  std_logic;
            dataIn  : in  std_logic_vector(dataInWL-1 downto 0);
            dataOut : out std_logic_vector(dataOutWL-1 downto 0);
            rst     : in  std_logic);
    end component;
    
    signal A1_dataOut             : std_logic_vector(0 downto 0);
    signal A2_dataOut             : std_logic_vector(0 downto 0);
    signal B10_dataOut            : std_logic_vector(0 downto 0);
    signal B11_dataOut            : std_logic_vector(0 downto 0);
    signal B12_dataOut            : std_logic_vector(0 downto 0);
    signal B13_dataOut            : std_logic_vector(0 downto 0);
    signal B14_dataOut            : std_logic_vector(0 downto 0);
    signal B16_dataOut            : std_logic_vector(0 downto 0);
    signal B1_dataOut             : std_logic_vector(0 downto 0);
    signal B22_dataOut            : std_logic_vector(63 downto 0);
    signal B23_dataOut            : std_logic_vector(127 downto 0);
    signal B2_dataOut             : std_logic_vector(0 downto 0);
    signal B4_dataOut             : std_logic_vector(31 downto 0);
    signal B5_dataOut             : std_logic_vector(31 downto 0);
    signal B6_dataOut             : std_logic_vector(43 downto 0);
    signal B7_dataOut             : std_logic_vector(31 downto 0);
    signal B8_dataOut             : std_logic_vector(31 downto 0);
    signal B9_dataOut             : std_logic_vector(63 downto 0);
    signal C1_dataOut             : std_logic_vector(11 downto 0);
    signal C2_dataOut             : std_logic_vector(0 downto 0);
    signal C3_dataOut             : std_logic_vector(7 downto 0);
    signal D15_dataOut            : std_logic_vector(127 downto 0);
    signal D16_dataOut            : std_logic_vector(0 downto 0);
    signal D17_dataOut            : std_logic_vector(0 downto 0);
    signal D19_dataOut            : std_logic_vector(0 downto 0);
    signal D1_dataOut             : std_logic_vector(0 downto 0);
    signal D20_dataOut            : std_logic_vector(0 downto 0);
    signal D3_dataOut             : std_logic_vector(15 downto 0);
    signal D5_dataOut             : std_logic_vector(0 downto 0);
    signal D6_dataOut             : std_logic_vector(43 downto 0);
    signal D7_dataOut             : std_logic_vector(0 downto 0);
    signal E1_dataOut             : std_logic_vector(4 downto 0);
    signal E2_dataOut             : std_logic_vector(4 downto 0);
    signal H1_output_r            : std_logic_vector(35 downto 0);
    signal M10_dataOut            : std_logic_vector(0 downto 0);
    signal Subnetwork1_coef0      : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef1      : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef10     : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef11     : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef12     : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef13     : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef14     : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef15     : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef16     : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef17     : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef18     : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef19     : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef2      : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef20     : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef21     : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef22     : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef23     : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef24     : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef25     : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef26     : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef27     : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef28     : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef29     : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef3      : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef30     : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef31     : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef4      : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef5      : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef6      : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef7      : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef8      : std_logic_vector(15 downto 0);
    signal Subnetwork1_coef9      : std_logic_vector(15 downto 0);
    signal Subnetwork24_start_pos : std_logic_vector(7 downto 0);
    signal Subnetwork24_trig_out  : std_logic_vector(0 downto 0);
    signal Subnetwork2_coef0      : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef1      : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef10     : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef11     : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef12     : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef13     : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef14     : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef15     : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef16     : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef17     : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef18     : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef19     : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef2      : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef20     : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef21     : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef22     : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef23     : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef24     : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef25     : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef26     : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef27     : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef28     : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef29     : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef3      : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef30     : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef31     : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef4      : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef5      : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef6      : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef7      : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef8      : std_logic_vector(15 downto 0);
    signal Subnetwork2_coef9      : std_logic_vector(15 downto 0);
    signal Subnetwork3_Out0       : std_logic_vector(15 downto 0);
    signal Subnetwork3_Out1       : std_logic_vector(15 downto 0);
    signal Subnetwork3_Out2       : std_logic_vector(15 downto 0);
    signal Subnetwork3_Out3       : std_logic_vector(15 downto 0);
    signal Subnetwork3_Out4       : std_logic_vector(15 downto 0);
    signal Subnetwork3_Out5       : std_logic_vector(15 downto 0);
    signal Subnetwork3_Out6       : std_logic_vector(15 downto 0);
    signal Subnetwork3_Out7       : std_logic_vector(15 downto 0);
    signal U1_dataOut             : std_logic_vector(7 downto 0);
    signal U2_dataOut             : std_logic_vector(0 downto 0);

begin
    
    A1_dataOut <= D1_dataOut and B1_dataOut;
    
    
    
    A2 : AddFxp
    generic map (
        Overflow       => 3,
        Quantization   => 5,
        SaturationBits => 0,
        dataIn1IWL     => 1,
        dataIn1SGN     => 0,
        dataIn1WL      => 1,
        dataIn2IWL     => 3,
        dataIn2SGN     => 0,
        dataIn2WL      => 16,
        dataOutIWL     => 1,
        dataOutSGN     => 1,
        dataOutWL      => 1)
    port map (
        dataIn1 => B2_dataOut,
        dataIn2 => D3_dataOut,
        dataOut => A2_dataOut);
    
    
    B1_dataOut <= "1";
    
    
    
    B10_dataOut <= "1";
    
    
    
    B11_dataOut <= "1";
    
    
    
    B12_dataOut <= "1";
    
    
    
    B13_dataOut <= "0";
    
    
    
    B14_dataOut <= "1";
    
    
    
    B16_dataOut <= "0";
    
    
    
    B2_dataOut <= "1";
    
    
    
    B22 : BitMergeFxp
    generic map (
        Overflow            => 3,
        Quantization        => 5,
        SaturationBits      => 0,
        UseInputWordlengths => 0,
        dataLSWL            => 32,
        dataMSWL            => 32,
        dataOutIWL          => 64,
        dataOutSGN          => 0,
        dataOutWL           => 64)
    port map (
        dataLS  => B7_dataOut,
        dataMS  => B8_dataOut,
        dataOut => B22_dataOut);
    
    
    B23 : BitMergeFxp
    generic map (
        Overflow            => 3,
        Quantization        => 5,
        SaturationBits      => 0,
        UseInputWordlengths => 0,
        dataLSWL            => 64,
        dataMSWL            => 64,
        dataOutIWL          => 128,
        dataOutSGN          => 0,
        dataOutWL           => 128)
    port map (
        dataLS  => B9_dataOut,
        dataMS  => B22_dataOut,
        dataOut => B23_dataOut);
    
    
    B4 : BitMergeFxp
    generic map (
        Overflow            => 3,
        Quantization        => 5,
        SaturationBits      => 0,
        UseInputWordlengths => 0,
        dataLSWL            => 16,
        dataMSWL            => 16,
        dataOutIWL          => 32,
        dataOutSGN          => 0,
        dataOutWL           => 32)
    port map (
        dataLS  => Subnetwork3_Out0,
        dataMS  => Subnetwork3_Out1,
        dataOut => B4_dataOut);
    
    
    B5 : BitMergeFxp
    generic map (
        Overflow            => 3,
        Quantization        => 5,
        SaturationBits      => 0,
        UseInputWordlengths => 0,
        dataLSWL            => 16,
        dataMSWL            => 16,
        dataOutIWL          => 32,
        dataOutSGN          => 0,
        dataOutWL           => 32)
    port map (
        dataLS  => Subnetwork3_Out2,
        dataMS  => Subnetwork3_Out3,
        dataOut => B5_dataOut);
    
    
    B6 : BitMergeFxp
    generic map (
        Overflow            => 3,
        Quantization        => 5,
        SaturationBits      => 0,
        UseInputWordlengths => 0,
        dataLSWL            => 36,
        dataMSWL            => 8,
        dataOutIWL          => 44,
        dataOutSGN          => 0,
        dataOutWL           => 44)
    port map (
        dataLS  => H1_output_r,
        dataMS  => U1_dataOut,
        dataOut => B6_dataOut);
    
    
    B7 : BitMergeFxp
    generic map (
        Overflow            => 3,
        Quantization        => 5,
        SaturationBits      => 0,
        UseInputWordlengths => 0,
        dataLSWL            => 16,
        dataMSWL            => 16,
        dataOutIWL          => 32,
        dataOutSGN          => 0,
        dataOutWL           => 32)
    port map (
        dataLS  => Subnetwork3_Out4,
        dataMS  => Subnetwork3_Out5,
        dataOut => B7_dataOut);
    
    
    B8 : BitMergeFxp
    generic map (
        Overflow            => 3,
        Quantization        => 5,
        SaturationBits      => 0,
        UseInputWordlengths => 0,
        dataLSWL            => 16,
        dataMSWL            => 16,
        dataOutIWL          => 32,
        dataOutSGN          => 0,
        dataOutWL           => 32)
    port map (
        dataLS  => Subnetwork3_Out6,
        dataMS  => Subnetwork3_Out7,
        dataOut => B8_dataOut);
    
    
    B9 : BitMergeFxp
    generic map (
        Overflow            => 3,
        Quantization        => 5,
        SaturationBits      => 0,
        UseInputWordlengths => 0,
        dataLSWL            => 32,
        dataMSWL            => 32,
        dataOutIWL          => 64,
        dataOutSGN          => 0,
        dataOutWL           => 64)
    port map (
        dataLS  => B4_dataOut,
        dataMS  => B5_dataOut,
        dataOut => B9_dataOut);
    
    
    C1 : CounterFxp
    generic map (
        Direction      => 0,
        FxpInitValue   => 0,
        Overflow       => 0,
        Quantization   => 5,
        SaturationBits => 0,
        StepFxp        => 1,
        dataOutIWL     => 12,
        dataOutSGN     => 0,
        dataOutWL      => 12)
    port map (
        ce      => ce2,
        clk     => clk,
        dataOut => C1_dataOut,
        enable  => D16_dataOut(0),
        rdy     => open,
        reset   => D17_dataOut(0),
        rst     => rst);
    
    
    C2 : CompareConstFxp
    generic map (
        CompareOperation       => 0,
        ConstIntegerWordlength => 12,
        ConstIsSigned          => 0,
        ConstWordlength        => 12,
        FxpConstant            => 4095,
        dataInAIWL             => 12,
        dataInASGN             => 0,
        dataInAWL              => 12,
        dataOutWL              => 1)
    port map (
        dataInA => C1_dataOut,
        dataOut => C2_dataOut(0));
    
    
    C3 : CounterFxp
    generic map (
        Direction      => 0,
        FxpInitValue   => 0,
        Overflow       => 0,
        Quantization   => 5,
        SaturationBits => 0,
        StepFxp        => 1,
        dataOutIWL     => 8,
        dataOutSGN     => 0,
        dataOutWL      => 8)
    port map (
        ce      => ce1,
        clk     => clk,
        dataOut => C3_dataOut,
        enable  => B10_dataOut(0),
        rdy     => open,
        reset   => B16_dataOut(0),
        rst     => rst);
    
    
    D1 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => ADCValidIn,
        dataOut => D1_dataOut);
    
    
    D15 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 128,
        dataOutSGN   => 0,
        dataOutWL    => 128)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => B23_dataOut,
        dataOut => D15_dataOut);
    
    
    D16 : DownSampleFxp
    generic map (
        Factor    => 2,
        Phase     => 0,
        dataInWL  => 1,
        dataOutWL => 1)
    port map (
        ce      => ce1,
        clk     => clk,
        dataIn  => B12_dataOut,
        dataOut => D16_dataOut,
        rst     => rst);
    
    
    D17 : DownSampleFxp
    generic map (
        Factor    => 2,
        Phase     => 0,
        dataInWL  => 1,
        dataOutWL => 1)
    port map (
        ce      => ce1,
        clk     => clk,
        dataIn  => B13_dataOut,
        dataOut => D17_dataOut,
        rst     => rst);
    
    
    D19 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C2_dataOut,
        dataOut => D19_dataOut);
    
    
    D2 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A1_dataOut,
        dataOut => open);
    
    
    D20 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => M10_dataOut,
        dataOut => D20_dataOut);
    
    
    D3 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 16,
        dataOutSGN   => 0,
        dataOutWL    => 16)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => Register1,
        dataOut => D3_dataOut);
    
    
    D4 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 1,
        dataOutWL    => 1)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => A2_dataOut,
        dataOut => open);
    
    
    D5 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 1,
        dataOutSGN   => 0,
        dataOutWL    => 1)
    port map (
        CE      => ce2,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => C2_dataOut,
        dataOut => D5_dataOut);
    
    
    D6 : DelayFxp
    generic map (
        Delay        => 1,
        FxpInitValue => 0,
        dataInWL     => 44,
        dataOutSGN   => 0,
        dataOutWL    => 44)
    port map (
        CE      => ce1,
        CLK     => clk,
        RDY     => open,
        RST     => rst,
        dataIn  => B6_dataOut,
        dataOut => D6_dataOut);
    
    
    D7 : DownSampleFxp
    generic map (
        Factor    => 2,
        Phase     => 0,
        dataInWL  => 1,
        dataOutWL => 1)
    port map (
        ce      => ce1,
        clk     => clk,
        dataIn  => Register2,
        dataOut => D7_dataOut,
        rst     => rst);
    
    
    E1 : ExtractFxp
    generic map (
        LSB        => 3,
        MSB        => 7,
        dataInIWL  => 8,
        dataInWL   => 8,
        dataOutIWL => 5,
        dataOutWL  => 5)
    port map (
        dataIn  => C3_dataOut,
        dataOut => E1_dataOut);
    
    
    E2 : ExtractFxp
    generic map (
        LSB        => 3,
        MSB        => 7,
        dataInIWL  => 8,
        dataInWL   => 8,
        dataOutIWL => 5,
        dataOutWL  => 5)
    port map (
        dataIn  => C3_dataOut,
        dataOut => E2_dataOut);
    
    
    H1 : Synth_Design3_Subnetwork3_FPGA0_H1
    generic map (
        DDC_freq_norm_0_VIWL      => 0,
        DDC_freq_norm_0_VSGN      => 0,
        DDC_freq_norm_0_VWL       => 32,
        DDC_freq_norm_1_VIWL      => 0,
        DDC_freq_norm_1_VSGN      => 0,
        DDC_freq_norm_1_VWL       => 32,
        DDC_freq_norm_2_VIWL      => 0,
        DDC_freq_norm_2_VSGN      => 0,
        DDC_freq_norm_2_VWL       => 32,
        DDC_freq_norm_3_VIWL      => 0,
        DDC_freq_norm_3_VSGN      => 0,
        DDC_freq_norm_3_VWL       => 32,
        DDC_freq_norm_4_VIWL      => 0,
        DDC_freq_norm_4_VSGN      => 0,
        DDC_freq_norm_4_VWL       => 32,
        DDC_freq_norm_5_VIWL      => 0,
        DDC_freq_norm_5_VSGN      => 0,
        DDC_freq_norm_5_VWL       => 32,
        DDC_freq_norm_6_VIWL      => 0,
        DDC_freq_norm_6_VSGN      => 0,
        DDC_freq_norm_6_VWL       => 32,
        DDC_freq_norm_7_VIWL      => 0,
        DDC_freq_norm_7_VSGN      => 0,
        DDC_freq_norm_7_VWL       => 32,
        input_VIWL                => 128,
        input_VSGN                => 0,
        input_VWL                 => 128,
        output_rIWL               => 36,
        output_rSGN               => 0,
        output_rWL                => 36,
        output_r_ap_vldIWL        => 1,
        output_r_ap_vldSGN        => 0,
        output_r_ap_vldWL         => 1,
        reconfigcoef_0_imag_VIWL  => 2,
        reconfigcoef_0_imag_VSGN  => 1,
        reconfigcoef_0_imag_VWL   => 16,
        reconfigcoef_0_real_VIWL  => 2,
        reconfigcoef_0_real_VSGN  => 1,
        reconfigcoef_0_real_VWL   => 16,
        reconfigcoef_10_imag_VIWL => 2,
        reconfigcoef_10_imag_VSGN => 1,
        reconfigcoef_10_imag_VWL  => 16,
        reconfigcoef_10_real_VIWL => 2,
        reconfigcoef_10_real_VSGN => 1,
        reconfigcoef_10_real_VWL  => 16,
        reconfigcoef_11_imag_VIWL => 2,
        reconfigcoef_11_imag_VSGN => 1,
        reconfigcoef_11_imag_VWL  => 16,
        reconfigcoef_11_real_VIWL => 2,
        reconfigcoef_11_real_VSGN => 1,
        reconfigcoef_11_real_VWL  => 16,
        reconfigcoef_12_imag_VIWL => 2,
        reconfigcoef_12_imag_VSGN => 1,
        reconfigcoef_12_imag_VWL  => 16,
        reconfigcoef_12_real_VIWL => 2,
        reconfigcoef_12_real_VSGN => 1,
        reconfigcoef_12_real_VWL  => 16,
        reconfigcoef_13_imag_VIWL => 2,
        reconfigcoef_13_imag_VSGN => 1,
        reconfigcoef_13_imag_VWL  => 16,
        reconfigcoef_13_real_VIWL => 2,
        reconfigcoef_13_real_VSGN => 1,
        reconfigcoef_13_real_VWL  => 16,
        reconfigcoef_14_imag_VIWL => 2,
        reconfigcoef_14_imag_VSGN => 1,
        reconfigcoef_14_imag_VWL  => 16,
        reconfigcoef_14_real_VIWL => 2,
        reconfigcoef_14_real_VSGN => 1,
        reconfigcoef_14_real_VWL  => 16,
        reconfigcoef_15_imag_VIWL => 2,
        reconfigcoef_15_imag_VSGN => 1,
        reconfigcoef_15_imag_VWL  => 16,
        reconfigcoef_15_real_VIWL => 2,
        reconfigcoef_15_real_VSGN => 1,
        reconfigcoef_15_real_VWL  => 16,
        reconfigcoef_16_imag_VIWL => 2,
        reconfigcoef_16_imag_VSGN => 1,
        reconfigcoef_16_imag_VWL  => 16,
        reconfigcoef_16_real_VIWL => 2,
        reconfigcoef_16_real_VSGN => 1,
        reconfigcoef_16_real_VWL  => 16,
        reconfigcoef_17_imag_VIWL => 2,
        reconfigcoef_17_imag_VSGN => 1,
        reconfigcoef_17_imag_VWL  => 16,
        reconfigcoef_17_real_VIWL => 2,
        reconfigcoef_17_real_VSGN => 1,
        reconfigcoef_17_real_VWL  => 16,
        reconfigcoef_18_imag_VIWL => 2,
        reconfigcoef_18_imag_VSGN => 1,
        reconfigcoef_18_imag_VWL  => 16,
        reconfigcoef_18_real_VIWL => 2,
        reconfigcoef_18_real_VSGN => 1,
        reconfigcoef_18_real_VWL  => 16,
        reconfigcoef_19_imag_VIWL => 2,
        reconfigcoef_19_imag_VSGN => 1,
        reconfigcoef_19_imag_VWL  => 16,
        reconfigcoef_19_real_VIWL => 2,
        reconfigcoef_19_real_VSGN => 1,
        reconfigcoef_19_real_VWL  => 16,
        reconfigcoef_1_imag_VIWL  => 2,
        reconfigcoef_1_imag_VSGN  => 1,
        reconfigcoef_1_imag_VWL   => 16,
        reconfigcoef_1_real_VIWL  => 2,
        reconfigcoef_1_real_VSGN  => 1,
        reconfigcoef_1_real_VWL   => 16,
        reconfigcoef_20_imag_VIWL => 2,
        reconfigcoef_20_imag_VSGN => 1,
        reconfigcoef_20_imag_VWL  => 16,
        reconfigcoef_20_real_VIWL => 2,
        reconfigcoef_20_real_VSGN => 1,
        reconfigcoef_20_real_VWL  => 16,
        reconfigcoef_21_imag_VIWL => 2,
        reconfigcoef_21_imag_VSGN => 1,
        reconfigcoef_21_imag_VWL  => 16,
        reconfigcoef_21_real_VIWL => 2,
        reconfigcoef_21_real_VSGN => 1,
        reconfigcoef_21_real_VWL  => 16,
        reconfigcoef_22_imag_VIWL => 2,
        reconfigcoef_22_imag_VSGN => 1,
        reconfigcoef_22_imag_VWL  => 16,
        reconfigcoef_22_real_VIWL => 2,
        reconfigcoef_22_real_VSGN => 1,
        reconfigcoef_22_real_VWL  => 16,
        reconfigcoef_23_imag_VIWL => 2,
        reconfigcoef_23_imag_VSGN => 1,
        reconfigcoef_23_imag_VWL  => 16,
        reconfigcoef_23_real_VIWL => 2,
        reconfigcoef_23_real_VSGN => 1,
        reconfigcoef_23_real_VWL  => 16,
        reconfigcoef_24_imag_VIWL => 2,
        reconfigcoef_24_imag_VSGN => 1,
        reconfigcoef_24_imag_VWL  => 16,
        reconfigcoef_24_real_VIWL => 2,
        reconfigcoef_24_real_VSGN => 1,
        reconfigcoef_24_real_VWL  => 16,
        reconfigcoef_25_imag_VIWL => 2,
        reconfigcoef_25_imag_VSGN => 1,
        reconfigcoef_25_imag_VWL  => 16,
        reconfigcoef_25_real_VIWL => 2,
        reconfigcoef_25_real_VSGN => 1,
        reconfigcoef_25_real_VWL  => 16,
        reconfigcoef_26_imag_VIWL => 2,
        reconfigcoef_26_imag_VSGN => 1,
        reconfigcoef_26_imag_VWL  => 16,
        reconfigcoef_26_real_VIWL => 2,
        reconfigcoef_26_real_VSGN => 1,
        reconfigcoef_26_real_VWL  => 16,
        reconfigcoef_27_imag_VIWL => 2,
        reconfigcoef_27_imag_VSGN => 1,
        reconfigcoef_27_imag_VWL  => 16,
        reconfigcoef_27_real_VIWL => 2,
        reconfigcoef_27_real_VSGN => 1,
        reconfigcoef_27_real_VWL  => 16,
        reconfigcoef_28_imag_VIWL => 2,
        reconfigcoef_28_imag_VSGN => 1,
        reconfigcoef_28_imag_VWL  => 16,
        reconfigcoef_28_real_VIWL => 2,
        reconfigcoef_28_real_VSGN => 1,
        reconfigcoef_28_real_VWL  => 16,
        reconfigcoef_29_imag_VIWL => 2,
        reconfigcoef_29_imag_VSGN => 1,
        reconfigcoef_29_imag_VWL  => 16,
        reconfigcoef_29_real_VIWL => 2,
        reconfigcoef_29_real_VSGN => 1,
        reconfigcoef_29_real_VWL  => 16,
        reconfigcoef_2_imag_VIWL  => 2,
        reconfigcoef_2_imag_VSGN  => 1,
        reconfigcoef_2_imag_VWL   => 16,
        reconfigcoef_2_real_VIWL  => 2,
        reconfigcoef_2_real_VSGN  => 1,
        reconfigcoef_2_real_VWL   => 16,
        reconfigcoef_30_imag_VIWL => 2,
        reconfigcoef_30_imag_VSGN => 1,
        reconfigcoef_30_imag_VWL  => 16,
        reconfigcoef_30_real_VIWL => 2,
        reconfigcoef_30_real_VSGN => 1,
        reconfigcoef_30_real_VWL  => 16,
        reconfigcoef_31_imag_VIWL => 2,
        reconfigcoef_31_imag_VSGN => 1,
        reconfigcoef_31_imag_VWL  => 16,
        reconfigcoef_31_real_VIWL => 2,
        reconfigcoef_31_real_VSGN => 1,
        reconfigcoef_31_real_VWL  => 16,
        reconfigcoef_3_imag_VIWL  => 2,
        reconfigcoef_3_imag_VSGN  => 1,
        reconfigcoef_3_imag_VWL   => 16,
        reconfigcoef_3_real_VIWL  => 2,
        reconfigcoef_3_real_VSGN  => 1,
        reconfigcoef_3_real_VWL   => 16,
        reconfigcoef_4_imag_VIWL  => 2,
        reconfigcoef_4_imag_VSGN  => 1,
        reconfigcoef_4_imag_VWL   => 16,
        reconfigcoef_4_real_VIWL  => 2,
        reconfigcoef_4_real_VSGN  => 1,
        reconfigcoef_4_real_VWL   => 16,
        reconfigcoef_5_imag_VIWL  => 2,
        reconfigcoef_5_imag_VSGN  => 1,
        reconfigcoef_5_imag_VWL   => 16,
        reconfigcoef_5_real_VIWL  => 2,
        reconfigcoef_5_real_VSGN  => 1,
        reconfigcoef_5_real_VWL   => 16,
        reconfigcoef_6_imag_VIWL  => 2,
        reconfigcoef_6_imag_VSGN  => 1,
        reconfigcoef_6_imag_VWL   => 16,
        reconfigcoef_6_real_VIWL  => 2,
        reconfigcoef_6_real_VSGN  => 1,
        reconfigcoef_6_real_VWL   => 16,
        reconfigcoef_7_imag_VIWL  => 2,
        reconfigcoef_7_imag_VSGN  => 1,
        reconfigcoef_7_imag_VWL   => 16,
        reconfigcoef_7_real_VIWL  => 2,
        reconfigcoef_7_real_VSGN  => 1,
        reconfigcoef_7_real_VWL   => 16,
        reconfigcoef_8_imag_VIWL  => 2,
        reconfigcoef_8_imag_VSGN  => 1,
        reconfigcoef_8_imag_VWL   => 16,
        reconfigcoef_8_real_VIWL  => 2,
        reconfigcoef_8_real_VSGN  => 1,
        reconfigcoef_8_real_VWL   => 16,
        reconfigcoef_9_imag_VIWL  => 2,
        reconfigcoef_9_imag_VSGN  => 1,
        reconfigcoef_9_imag_VWL   => 16,
        reconfigcoef_9_real_VIWL  => 2,
        reconfigcoef_9_real_VSGN  => 1,
        reconfigcoef_9_real_VWL   => 16)
    port map (
        DDC_freq_norm_0_V      => Register3,
        DDC_freq_norm_1_V      => Register4,
        DDC_freq_norm_2_V      => Register5,
        DDC_freq_norm_3_V      => Register6,
        DDC_freq_norm_4_V      => Register7,
        DDC_freq_norm_5_V      => Register8,
        DDC_freq_norm_6_V      => Register9,
        DDC_freq_norm_7_V      => Register10,
        ap_clk                 => clk,
        ap_rst                 => rst,
        input_V                => D15_dataOut,
        output_r               => H1_output_r,
        output_r_ap_vld        => open,
        reconfigcoef_0_imag_V  => Subnetwork1_coef0,
        reconfigcoef_0_real_V  => Subnetwork2_coef0,
        reconfigcoef_10_imag_V => Subnetwork1_coef10,
        reconfigcoef_10_real_V => Subnetwork2_coef10,
        reconfigcoef_11_imag_V => Subnetwork1_coef11,
        reconfigcoef_11_real_V => Subnetwork2_coef11,
        reconfigcoef_12_imag_V => Subnetwork1_coef12,
        reconfigcoef_12_real_V => Subnetwork2_coef12,
        reconfigcoef_13_imag_V => Subnetwork1_coef13,
        reconfigcoef_13_real_V => Subnetwork2_coef13,
        reconfigcoef_14_imag_V => Subnetwork1_coef14,
        reconfigcoef_14_real_V => Subnetwork2_coef14,
        reconfigcoef_15_imag_V => Subnetwork1_coef15,
        reconfigcoef_15_real_V => Subnetwork2_coef15,
        reconfigcoef_16_imag_V => Subnetwork1_coef16,
        reconfigcoef_16_real_V => Subnetwork2_coef16,
        reconfigcoef_17_imag_V => Subnetwork1_coef17,
        reconfigcoef_17_real_V => Subnetwork2_coef17,
        reconfigcoef_18_imag_V => Subnetwork1_coef18,
        reconfigcoef_18_real_V => Subnetwork2_coef18,
        reconfigcoef_19_imag_V => Subnetwork1_coef19,
        reconfigcoef_19_real_V => Subnetwork2_coef19,
        reconfigcoef_1_imag_V  => Subnetwork1_coef1,
        reconfigcoef_1_real_V  => Subnetwork2_coef1,
        reconfigcoef_20_imag_V => Subnetwork1_coef20,
        reconfigcoef_20_real_V => Subnetwork2_coef20,
        reconfigcoef_21_imag_V => Subnetwork1_coef21,
        reconfigcoef_21_real_V => Subnetwork2_coef21,
        reconfigcoef_22_imag_V => Subnetwork1_coef22,
        reconfigcoef_22_real_V => Subnetwork2_coef22,
        reconfigcoef_23_imag_V => Subnetwork1_coef23,
        reconfigcoef_23_real_V => Subnetwork2_coef23,
        reconfigcoef_24_imag_V => Subnetwork1_coef24,
        reconfigcoef_24_real_V => Subnetwork2_coef24,
        reconfigcoef_25_imag_V => Subnetwork1_coef25,
        reconfigcoef_25_real_V => Subnetwork2_coef25,
        reconfigcoef_26_imag_V => Subnetwork1_coef26,
        reconfigcoef_26_real_V => Subnetwork2_coef26,
        reconfigcoef_27_imag_V => Subnetwork1_coef27,
        reconfigcoef_27_real_V => Subnetwork2_coef27,
        reconfigcoef_28_imag_V => Subnetwork1_coef28,
        reconfigcoef_28_real_V => Subnetwork2_coef28,
        reconfigcoef_29_imag_V => Subnetwork1_coef29,
        reconfigcoef_29_real_V => Subnetwork2_coef29,
        reconfigcoef_2_imag_V  => Subnetwork1_coef2,
        reconfigcoef_2_real_V  => Subnetwork2_coef2,
        reconfigcoef_30_imag_V => Subnetwork1_coef30,
        reconfigcoef_30_real_V => Subnetwork2_coef30,
        reconfigcoef_31_imag_V => Subnetwork1_coef31,
        reconfigcoef_31_real_V => Subnetwork2_coef31,
        reconfigcoef_3_imag_V  => Subnetwork1_coef3,
        reconfigcoef_3_real_V  => Subnetwork2_coef3,
        reconfigcoef_4_imag_V  => Subnetwork1_coef4,
        reconfigcoef_4_real_V  => Subnetwork2_coef4,
        reconfigcoef_5_imag_V  => Subnetwork1_coef5,
        reconfigcoef_5_real_V  => Subnetwork2_coef5,
        reconfigcoef_6_imag_V  => Subnetwork1_coef6,
        reconfigcoef_6_real_V  => Subnetwork2_coef6,
        reconfigcoef_7_imag_V  => Subnetwork1_coef7,
        reconfigcoef_7_real_V  => Subnetwork2_coef7,
        reconfigcoef_8_imag_V  => Subnetwork1_coef8,
        reconfigcoef_8_real_V  => Subnetwork2_coef8,
        reconfigcoef_9_imag_V  => Subnetwork1_coef9,
        reconfigcoef_9_real_V  => Subnetwork2_coef9);
    
    
    with to_integer(unsigned(D7_dataOut)) select
    M10_dataOut <=
        Subnetwork24_trig_out when 0,
        D19_dataOut when 1,
        (others => '0') when others;
    
    
    
    
    Subnetwork1 : unroll_reconfig_coef_Subnetwork1
    port map (
        addr   => E2_dataOut,
        ce1    => ce1,
        clk    => clk,
        coef0  => Subnetwork1_coef0,
        coef1  => Subnetwork1_coef1,
        coef10 => Subnetwork1_coef10,
        coef11 => Subnetwork1_coef11,
        coef12 => Subnetwork1_coef12,
        coef13 => Subnetwork1_coef13,
        coef14 => Subnetwork1_coef14,
        coef15 => Subnetwork1_coef15,
        coef16 => Subnetwork1_coef16,
        coef17 => Subnetwork1_coef17,
        coef18 => Subnetwork1_coef18,
        coef19 => Subnetwork1_coef19,
        coef2  => Subnetwork1_coef2,
        coef20 => Subnetwork1_coef20,
        coef21 => Subnetwork1_coef21,
        coef22 => Subnetwork1_coef22,
        coef23 => Subnetwork1_coef23,
        coef24 => Subnetwork1_coef24,
        coef25 => Subnetwork1_coef25,
        coef26 => Subnetwork1_coef26,
        coef27 => Subnetwork1_coef27,
        coef28 => Subnetwork1_coef28,
        coef29 => Subnetwork1_coef29,
        coef3  => Subnetwork1_coef3,
        coef30 => Subnetwork1_coef30,
        coef31 => Subnetwork1_coef31,
        coef4  => Subnetwork1_coef4,
        coef5  => Subnetwork1_coef5,
        coef6  => Subnetwork1_coef6,
        coef7  => Subnetwork1_coef7,
        coef8  => Subnetwork1_coef8,
        coef9  => Subnetwork1_coef9,
        data   => BlockRegData2,
        rst    => rst);
    
    
    Subnetwork2 : unroll_reconfig_coef_Subnetwork2
    port map (
        addr   => E1_dataOut,
        ce1    => ce1,
        clk    => clk,
        coef0  => Subnetwork2_coef0,
        coef1  => Subnetwork2_coef1,
        coef10 => Subnetwork2_coef10,
        coef11 => Subnetwork2_coef11,
        coef12 => Subnetwork2_coef12,
        coef13 => Subnetwork2_coef13,
        coef14 => Subnetwork2_coef14,
        coef15 => Subnetwork2_coef15,
        coef16 => Subnetwork2_coef16,
        coef17 => Subnetwork2_coef17,
        coef18 => Subnetwork2_coef18,
        coef19 => Subnetwork2_coef19,
        coef2  => Subnetwork2_coef2,
        coef20 => Subnetwork2_coef20,
        coef21 => Subnetwork2_coef21,
        coef22 => Subnetwork2_coef22,
        coef23 => Subnetwork2_coef23,
        coef24 => Subnetwork2_coef24,
        coef25 => Subnetwork2_coef25,
        coef26 => Subnetwork2_coef26,
        coef27 => Subnetwork2_coef27,
        coef28 => Subnetwork2_coef28,
        coef29 => Subnetwork2_coef29,
        coef3  => Subnetwork2_coef3,
        coef30 => Subnetwork2_coef30,
        coef31 => Subnetwork2_coef31,
        coef4  => Subnetwork2_coef4,
        coef5  => Subnetwork2_coef5,
        coef6  => Subnetwork2_coef6,
        coef7  => Subnetwork2_coef7,
        coef8  => Subnetwork2_coef8,
        coef9  => Subnetwork2_coef9,
        data   => BlockRegData1,
        rst    => rst);
    
    
    Subnetwork24 : trig_gen_Subnetwork24
    port map (
        In0       => ADC1,
        In1       => ADC2,
        In10      => ADC11,
        In11      => ADC12,
        In12      => ADC13,
        In13      => ADC14,
        In14      => ADC15,
        In15      => ADC16,
        In2       => ADC3,
        In3       => ADC4,
        In4       => ADC5,
        In5       => ADC6,
        In6       => ADC7,
        In7       => ADC8,
        In8       => ADC9,
        In9       => ADC10,
        ce1       => ce1,
        ce2       => ce2,
        clk       => clk,
        ena       => D5_dataOut,
        rst       => rst,
        start_pos => Subnetwork24_start_pos,
        threshold => Register1,
        trig_out  => Subnetwork24_trig_out);
    
    
    Subnetwork3 : ADCData_16To8_Subnetwork3
    port map (
        ADC_0     => ADC1,
        ADC_1     => ADC2,
        ADC_10    => ADC11,
        ADC_11    => ADC12,
        ADC_12    => ADC13,
        ADC_13    => ADC14,
        ADC_14    => ADC15,
        ADC_15    => ADC16,
        ADC_2     => ADC3,
        ADC_3     => ADC4,
        ADC_4     => ADC5,
        ADC_5     => ADC6,
        ADC_6     => ADC7,
        ADC_7     => ADC8,
        ADC_8     => ADC9,
        ADC_9     => ADC10,
        ADC_Valid => ADCValidIn,
        Out0      => Subnetwork3_Out0,
        Out1      => Subnetwork3_Out1,
        Out2      => Subnetwork3_Out2,
        Out3      => Subnetwork3_Out3,
        Out4      => Subnetwork3_Out4,
        Out5      => Subnetwork3_Out5,
        Out6      => Subnetwork3_Out6,
        Out7      => Subnetwork3_Out7,
        ce1       => ce1,
        clk       => clk,
        rst       => rst);
    
    
    U1 : UpSampleFxp
    generic map (
        ClockDivFactor => 1,
        Factor         => 2,
        Mode           => 1,
        Phase          => 0,
        dataInWL       => 8,
        dataOutWL      => 8)
    port map (
        ceA     => ce2,
        ceB     => ce1,
        clk     => clk,
        dataIn  => Subnetwork24_start_pos,
        dataOut => U1_dataOut,
        rst     => rst);
    
    
    U2 : UpSampleFxp
    generic map (
        ClockDivFactor => 1,
        Factor         => 2,
        Mode           => 1,
        Phase          => 0,
        dataInWL       => 1,
        dataOutWL      => 1)
    port map (
        ceA     => ce2,
        ceB     => ce1,
        clk     => clk,
        dataIn  => D20_dataOut,
        dataOut => U2_dataOut,
        rst     => rst);
    
    
    BlockRegAddr1 <= E1_dataOut;
    BlockRegAddr2 <= E2_dataOut;
    BlockRegRd1   <= B11_dataOut;
    BlockRegRd2   <= B14_dataOut;
    DataOut1      <= D6_dataOut;
    ValidOut1     <= U2_dataOut;

end M9703_MultiCh_Cali_FPGA0_Arch;


