//Made by Shay_Gman (c) 09.10
private ["_pos", "_trapkind","_iedside", "_iedMarkerName", "_weaponList", "_randWeapon", "_weapon", "_mag", "_group", "_sb", "_eib_marker","_iedDir","_init"]; 

_pos 			= _this select 0; 
_trapkind 		= _this select 1; 
_iedside		= _this select 2; 
_iedMarkerName 	= _this select 3;
_iedDir 		= _this select 4;

_weaponList = [["hgun_P07_snds_F", "16Rnd_9x21_Mag"],["hgun_Rook40_F", "16Rnd_9x21_Mag"]];
_randWeapon = floor random (count _weaponList);
_weapon = (_weaponList select _randWeapon) select 0;
_mag = (_weaponList select _randWeapon) select 1;

_eib_marker = createMarkerlocal ["traps",_pos];
//_pos= getMarkerPos "traps";

_group = creategroup civilian;
_sb = _group createunit [_trapkind, _pos, [], 0, "NONE"];
_null = [_sb,_iedside,25,_weapon,_mag] execVM MCC_path +"mcc\general_scripts\traps\cw.sqf";
_init = "removeallweapons _this; _this setbehaviour 'CARELESS';removeallweapons _this; _this allowfleeing 0; _this addaction ['Neutralize Suspect','"+ MCC_path +"mcc\general_scripts\traps\neutralize.sqf',[],1,true,true,'','(_target distance _this) < 3'];";
[[[netid _sb,_sb], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
_sb setpos _pos;
_sb addrating -1;
_sb setdir _iedDir;
_group setformdir _iedDir; 

_sb setvariable ["armed",true,true];
_sb setvariable ["iedTrigered", false, true]; 

[_sb, _iedMarkerName] spawn
	{
	private ["_fakeIedS", "_iedMarkerNameS"];
	_fakeIedS = _this select 0;
	_iedMarkerNameS = _this select 1;
	waituntil {!alive _fakeIedS};
	[[2,compile format ["deletemarkerlocal '%1';",_iedMarkerNameS]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;	//delete IED marker 
	_fakeIedS setvariable ["iedTrigered", true, true]; 
	};

sleep 0.01;
deletemarker "traps";