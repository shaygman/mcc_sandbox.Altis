//==================================================================MCC_fnc_settingsCover============================================================================
// module
// Example: [] call MCC_fnc_settingsCover;
// _group1 = group, the group name
//==============================================================================================================================================================
private ["_module","_var","_pos"];

_module = param [0, objNull, [objNull]];
if (isNull _module) exitWith {deleteVehicle _module};


if (typeName (_module getVariable ["cover",true]) == typeName 0) exitWith {

	//cover
	_var 	= _module getvariable ["cover",1];
	MCC_cover = if (_var == 0) then {false} else {true};

	//coverRecoil
	_var 	= _module getvariable ["coverRecoil",1];
	MCC_changeRecoil = if (_var == 0) then {false} else {true};

	//coverUI
	_var 	= _module getvariable ["coverUI",1];
	MCC_coverUI = if (_var == 0) then {false} else {true};

	//cover Vault
	_var 	= _module getvariable ["coverVault",1];
	MCC_coverVault = if (_var == 0) then {false} else {true};

	//Switch weapon
	_var 	= _module getvariable ["switchWeapons",1];
	MCC_quickWeaponChange = if (_var == 0) then {false} else {true};

	//interaction
	_var 	= _module getvariable ["interaction",1];
	MCC_interaction = if (_var == 0) then {false} else {true};

	//interaction UI
	_var 	= _module getvariable ["interactionUI",0];
	MCC_ingameUI = if (_var == 0) then {false} else {true};

	//Survive mod
	_var 	= _module getvariable ["survive",0];
	MCC_surviveMod = _var > 0;
	MCC_surviveModAllowSearch = _var ==1;

	//Action menu
	_var 	= _module getvariable ["actionMenu",1];
	MCC_showActionKey = if (_var == 0) then {false} else {true};

	//Arcade Tanks
	MCC_arcadeTanks = ((_module getvariable ["arcadeTanks",0])==1);

	//Breaching Ammo
	MCC_breacingAmmo = call compile (_module getvariable ["breachingAmmo","[]"]);

	//Non Lethal Ammo
	MCC_nonLeathalAmmo = call compile (_module getvariable ["nonLeathalAmmo","[]"]);
};

//Not curator exit
if (!(local _module) || isnull curatorcamera) exitWith {};

_resualt = ["Settings MCC Mechanics",[
 						["Action Menu",true],
 						["Cover System",true],
 						["Cover System UI",true],
 						["Vault/Climb",true],
 						["Weapons Binds",true],
 						["Interaction",true],
 						["Interaction UI",true],
 						["One Man Tanks",true],
 						["Survival Mod",["No","Yes - Enable searching loot","Yes - Disable searching loot"]]
 					  ]] call MCC_fnc_initDynamicDialog;

if (count _resualt == 0) exitWith {deleteVehicle _module};

{
	missionNamespace setVariable [_x,_resualt select _foreachindex];
	publicvariable _x;
} forEach ["MCC_showActionKey",
           "MCC_cover",
           "MCC_coverUI",
           "MCC_coverVault",
           "MCC_quickWeaponChange",
           "MCC_interaction",
           "MCC_ingameUI",
           "MCC_arcadeTanks"
          ];

_var = (_resualt select 8);
MCC_surviveMod = _var > 0;
publicvariable "MCC_surviveMod";

MCC_surviveModAllowSearch = _var ==1;
publicvariable "MCC_surviveModAllowSearch";

deleteVehicle _module;