//==================================================================MCC_fnc_ACSingle===============================================================================================
// Create a an armed civilian at the given position
// Example: [_pos,_trapkind,_iedside,_iedMarkerName,_iedDir] spawn MCC_fnc_ACSingle; 
// <in>: 	_pos = position, center of the explosion.
// 		_trapkind = string, unit's vehicle class
//		_iedside = side, which side trigger the armed civilian
//		_iedMarkerName = string, marker name leave "" for no marker
//		_iedDir =integer, direction the unit will be facing
// <out>	unit, object
//=================================================================================================================================================================================
private ["_pos", "_trapkind","_iedside", "_iedMarkerName", "_weaponList", "_randWeapon", "_weapon", "_mag", "_group", "_sb", "_iedDir","_init","_rank"]; 

_pos 			= _this select 0; 
_trapkind 		= _this select 1; 
_iedside		= _this select 2; 
_iedMarkerName 	= _this select 3;
_iedDir 		= _this select 4;

if (CP_debug) then {player sidechat str _iedside}; 
_weaponList = [["hgun_P07_F", "16Rnd_9x21_Mag"],["hgun_Rook40_F", "16Rnd_9x21_Mag"],["hgun_ACPC2_F", "9Rnd_45ACP_Mag"],["hgun_Pistol_heavy_01_F", "11Rnd_45ACP_Mag"],["hgun_Pistol_heavy_02_F", "6Rnd_45ACP_Cylinder"]];
_randWeapon = floor random (count _weaponList);
_weapon = (_weaponList select _randWeapon) select 0;
_mag = (_weaponList select _randWeapon) select 1;

_rank = ["SERGEANT","LIEUTENANT","CAPTAIN"] select (floor random 3); 
_group = creategroup civilian;
_sb = _group createunit [_trapkind, _pos, [], 0, "NONE"];
_null = [_sb,_iedside,25,_weapon,_mag] execVM MCC_path +"mcc\general_scripts\traps\cw.sqf";
_init = "removeallweapons _this; _this setbehaviour 'CARELESS'; _this allowfleeing 0; _this addaction ['Neutralize Suspect','"+ MCC_path +"mcc\general_scripts\traps\neutralize.sqf',[],1,true,true,'','(_target distance _this) < 3'];";
[[[netid _sb,_sb], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
_sb setpos _pos;
_sb addrating -1;
_sb setdir _iedDir;
_sb setrank _rank;
_group setformdir _iedDir; 

_sb setvariable ["armed",true,true];
_sb setvariable ["iedTrigered", false, true]; 

//Create a marker
if (_iedMarkerName != "") then
{
	[_sb, _iedMarkerName] spawn
	{
		private ["_fakeIedS", "_iedMarkerNameS"];
		_fakeIedS = _this select 0;
		_iedMarkerNameS = _this select 1;
		waituntil {!alive _fakeIedS};
		[[2,compile format ["deletemarkerlocal '%1';",_iedMarkerNameS]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;	//delete IED marker 
		_fakeIedS setvariable ["iedTrigered", true, true]; 
	};
};

_sb;