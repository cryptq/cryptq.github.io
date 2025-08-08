========================================================================
   SystemVue Custom UI project
========================================================================
This example shows how to implement a Custom UI for a SystemVue C++ Model 

Before you start 

- copy the top level "Custom UI" folder to another directory where you have write permission

and make sure that

- the line that sets the PATH (set PATH=<SystemVue installation directory>\Tools\CMake\bin\;%PATH%) in the batch file Configure-for-vs2017.bat points to the correct SystmeVue installation directory
- the line that sets the SystemVue installation directory (set( SystemVueInstallDirectory "<SystemVue installation directory>")) in the file Model\source\CMakeLists.txt also points to the correct SystmeVue installation directory



Instructions for Running:
1. Run Configure-for-vs2017.bat inside the Model directory. This will create Visual Studio 2017 solutions to build Custom UI example model library.
2. Open CustomUIModel.sln inside Model\build-win64. Build the INSTALL project using Release configuration.
3. Open SystemVueCustomUI.sln in Custom UI directory.
   3.1 Make sure that the Target framework is .NET Framework 4.6.1 in the Properties of SystemVueCustomUI project.
   3.2 Build the solution for the Release configuration. If you get errors due to incorrect path to Keysight.SystemVue.Extensibility, right click on the References folder under solution explorer, and add a reference to Keysight.SystemVue.Extensibility.dll, which can be found in the bin folder under SystemVue installation directory. If a reference to Keysight.SystemVue.Extensibility.dll already exists it may be pointing to an invalid path, so first remove it and then add the one from the correct installation directory.
4. Copy SystemVueCustomUI.dll from Custom UI\SystemVueCustomUI\bin\Release directory to <My Documents>\SystemVue\<version>\CustomUIs directory.
5. Open SystemVue, open Tool->Library Manager…, then add CustomUIModels.dll from Model\output\Release-SystemVue-Win64.
6. Add a SineGenerator part from CustomUIModels Parts library to design, then double click the part, and you will see the Custom UI Dialog.
