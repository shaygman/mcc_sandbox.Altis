/*
	File: fn_openDetails.sqf
	Author: TAW_Tonic
	
	Description:
	Used as a quick macro to open the details menu for weapon information.
	Doesn't work within macro.sqf which is why it's a separate file.
*/
#ifdef MCCMODE
 #include "\mcc_sandbox_mod\VAS\functions\macro.sqf"
#else
 #include "macro.sqf"
#endif
ctrlShow [VAS_detail_mags_list,true];
ctrlShow[VAS_detail_mags,true];
ctrlShow [VAS_detail_magsbg,true];