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

//cover Vault
_var 	= _logic getvariable ["coverVault",1];
MCC_coverVault = if (_var == 0) then {false} else {true};

//Switch weapon
_var 	= _logic getvariable ["switchWeapons",1];
MCC_quickWeaponChange = if (_var == 0) then {false} else {true};

//interaction
_var 	= _logic getvariable ["interaction",1];
MCC_interaction = if (_var == 0) then {false} else {true};

//interaction UI
_var 	= _logic getvariable ["interactionUI",0];
MCC_ingameUI = if (_var == 0) then {false} else {true};

//Survive mod
_var 	= _logic getvariable ["survive",0];
MCC_surviveMod = if (_var == 0) then {false} else {true};

//Action menu
_var 	= _logic getvariable ["actionMenu",1];
MCC_showActionKey = if (_var == 0) then {false} else {true};