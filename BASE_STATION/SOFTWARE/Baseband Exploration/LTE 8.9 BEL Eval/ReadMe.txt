========================================================================
   LTE BEL Eval project
========================================================================

Instructions for Running:
1. Run "run-cmake-vs2017.bat". Make sure the SystemVue installation path is correct inside "run-cmake-vs2017.bat" and "CMakeLists.txt". This will create Visual Studio 2017 solutions to build LTE_BEL model library.
2. Open "LTE_BEL.sln" inside "build-win64". Build "LTE_BEL_Eval" project using "Release" configuration.
3. Open SystemVue, open Tool->Library Manager, then add "LTE_BEL_Eval.dll" from "build-win64\LTE_BEL_Eval\Release".
