#include "SystemVue/LibraryProperties.h"
bool DefineLibraryProperties(SystemVueModelBuilder::LibraryProperties* pLibraryProperties)
{	// Define the library name for the Part, Model and Enum libraries. 
	// By default, the DLL name is used.
	pLibraryProperties->SetLibraryName( "CustomUIModel" );
	// Return true to indicate success.  If you return false, {PRODUCT-NAME}
	// will report that it was unable to load the library.
	return true;
}

