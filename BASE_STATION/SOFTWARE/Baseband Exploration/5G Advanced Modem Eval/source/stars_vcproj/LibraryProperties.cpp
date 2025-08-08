//------------------------------------------------------------------------------
//	Copyright (c) Keysight Technologies 2009.  All rights reserved.
//	Vendor: Keysight EEsof
//	FileName: LibraryProperties.cpp
//	Description: library properties
//	Date: 2009/07/09 02:17:30 
//------------------------------------------------------------------------------

//#include "Stdafx.h"
#include "SystemVue/LibraryProperties.h"

//namespace SystemVueModelBuilder
//{
#ifndef SV_CODE_GEN
bool DefineLibraryProperties(SystemVueModelBuilder::LibraryProperties* pLibraryProperties)
{
   // Define the library name for the Part, Model and Enum libraries.  
   // By default, the DLL name is used.
   pLibraryProperties->SetLibraryName("5G Advanced Modem BEL Eval");

   // Strip the @Library suffix in the model name for auto-generated parts.
   // This allows you to use the Library Manager search path to easily override the model
   // by changing the search path.  By default, all generated parts
   // will reference the models using the full path.
//   pLibraryProperties->SetExcludeLibrarySuffixFromPartModels();

   // Declare that we have an embedded XML library that we added as a resource.
   // The library can be of any object type but in this case we have a Part library and
   // a Symbol (Design) library.
   // We imported the XML libraries as resources of type "XML", and we would like
   // the Parts in this library to be merged into the library of auto-generated parts
   // that is created for this library.
   // However, we want the symbol library to be imported as-is.
    pLibraryProperties->SetResourcePrefix( L"/Keysight/EEsof/5GAdvancedModem_BEL_Eval");
    pLibraryProperties->LoadAsStandaloneLibrary( L"5GAdvancedModem_BEL_Eval_Symbols.XML");

   // Return true to indicate success.  If you return false, {PRODUCT-NAME}
   // will report that it was unable to load the library.
   return true;
}
#endif
//}// end of namespace