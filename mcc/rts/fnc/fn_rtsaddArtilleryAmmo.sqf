/*=================================================================MCC_fnc_rtsaddArtilleryAmmo=============================================================================
//	Buy 10 artiilery shells
//  Parameter(s):
//     	_ctrl: CONTROL
//==============================================================================================================================================================*/
private ["_ctrl","_artyTypes","_sideVar","_ammoNew","_res","_side"];
disableSerialization;
_ctrl = _this select 0;
_res = param [1, [], [[]]];
_side = playerSide;

//remove resources
[_res] spawn MCC_fnc_baseResourceReduce;

//get the artytypes
_artyTypes = missionNamespace getVariable ["HW_arti_types",[["HE 82mm","Sh_82mm_AMOS",1,75],["Smoke White 82mm","Smoke_82mm_AMOS_White",1,20],["Smoke Green 40mm","G_40mm_SmokeGreen",1,20], ["Smoke Red 40mm","G_40mm_SmokeRed",1,20],["Flare White","F_40mm_White",2,20], ["Flare Green","F_40mm_Green",2,20], ["Flare Red","F_40mm_Red",2,20]]];

//Set default arty types if none is set
if (count _artyTypes <= 0) then {
	_artyTypes = [["HE 82mm","Sh_82mm_AMOS",1,75],["Smoke White 82mm","Smoke_82mm_AMOS_White",1,20],["Smoke Green 40mm","G_40mm_SmokeGreen",1,20], ["Smoke Red 40mm","G_40mm_SmokeRed",1,20],["Flare White","F_40mm_White",2,20], ["Flare Green","F_40mm_Green",2,20], ["Flare Red","F_40mm_Red",2,20]];
};

missionNamespace setVariable ["HW_arti_types",_artyTypes];
publicVariable "HW_arti_types";

//Give 10 more rounds
_sideVar = format ["Arti_%1_shellsleft",_side];
_ammoNew = ((missionNamespace getVariable ["MCC_server",objNull]) getVariable [_sideVar,0]) + 10;
(missionNamespace getVariable ["MCC_server",objNull]) setVariable [_sideVar,_ammoNew,true];

//Info messege
[9989,"10 Artillery Shells Added",5,true] spawn MCC_fnc_setIDCText;
