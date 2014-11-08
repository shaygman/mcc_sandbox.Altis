//==================================================================MCC_fnc_settingsCover===============================================================================================
// module
// Example: [] call MCC_fnc_settingsCover;
// _group1 = group, the group name
//===========================================================================================================================================================================	
private ["_logic","_var"];

_logic	= _this select 0;

//cover
_var 	= _logic getvariable ["cover",1];
MCC_cover = if (_var == 0) then {false} else {true};	

//coverRecoil
_var 	= _logic getvariable ["coverRecoil",1];
MCC_changeRecoil = if (_var == 0) then {false} else {true};		

//coverUI
_var 	= _logic getvariable ["coverUI",1];
MCC_coverUI = if (_var == 0) then {false} else {true};	

//cover Cault
_var 	= _logic getvariable ["coverVault",1];
MCC_coverVault = if (_var == 0) then {false} else {true};		