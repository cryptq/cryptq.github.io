========================================================================
   5G Advanced Modem BEL Eval project
========================================================================

Instructions for Running:
1. Run "Configure-for-vs2017.bat". Make sure the SystemVue installation path is correct inside "Configure-for-vs2017.bat" and "CMakeLists.txt"(Which is inside "source"). This will create Visual Studio 2017 solutions to build 5G Advanced Modem BEL model library.
2. open "5GAdvancedModem_BEL_Eval.sln" inside "build-win64". Build project using "Release" configuration.
3. Open SystemVue, open Tool->Library Manager, then add "5GAdvancedModem_BEL_Eval.dll" from "build-win64\stars_vcproj\Release" .
4. An example is provided to use the BEL Eval, which is located at Baseband Exploration folder and called MIMO_SM_STC_BER_Test.wsv. In the example, MIMO_Encoder is derived from BEL Eval library, and MIMO_Decoder is from 5G BVL library.
5. Before running the example, be sure that your 5G BVL license is authorized. Otherwise, the MIMO_Decoder model should be bypassed.