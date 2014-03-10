/*
	File: fn_closeDetails.sqf
	Author: TAW_Tonic
	
	Description:
	Quick like Macro for closing the details menu, doesn't work within macros.sqf
*/
#ifdef MCCMODE
 #include "\mcc_sandbox_mod\VAS\functions\macro.sqf"
#else
 #include "macro.sqf"
#endif
ctrlShow [VAS_detail_mags_list,false];
ctrlShow[VAS_detail_mags,false];
ctrlShow [VAS_detail_magsbg,false];
ctrlShow[VAS_AccBG,false];
ctrlShow[VAS_AccList,false];