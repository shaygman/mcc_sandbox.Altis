//===================================================================MCC_fnc_trapSingle======================================================================================
// Create an IED
//Example:[[pos,IEDkind,IEDVolume,IEDExplosionType,IEDDisarmTime,IEDJammable,IEDTriggerType,IEDdistance,IEDside,IEDMarkerName,IEDDir,_groupArray,_ambushSide],'MCC_fnc_trapSingle',true,false] call BIS_fnc_MP;
// Params:
// 	pos: array, trap position
// 	IEDkind: string, any oject's vehicleClass
// 	IEDVolume: stirng, explosion radius - "small","medium","large"
//	IEDExplosionType: number, explosion type: 0-deadly, 1 - disabling (will cripple vehicles and soldiers but will not kill) 2 - Fake, will not or lightly wound soldiers.
//	IEDDisarmTime: number, time in second it will take to disarm the IED
//	IEDJammable: boolean, true - if jammer vheicle (defined in MCC_IEDJammerVehicles) can jame this IED false if not
//	IEDTriggerType: number, 0- Proximity, will explode if unit from the targer side will move faster then a slow crouch, 1- radio will explode if unit from the targer side will get close to it, if assigned to spotter the spotter must be alive, 2- manual detontion, only mission maker
//	IEDdistance: number, minimum distance which target unit have to get close to the IED to set it off
//	IEDside: side, [west, east, resistance, civilian]
//	IEDMarkerName: string, custom marker name for the IED
// 	IEDDir: number, direction of the IED
// 	_groupArray: Boolean, spawn an ambush
//	_ambushSide: side, ambush side
//==============================================================================================================================================================================

//Made by Shay_Gman (c) 09.10
private ["_pos", "_trapkind", "_trapvolume", "_IEDExplosionType", "_IEDDisarmTime", "_IEDJammable", "_IEDTriggerType", "_IEDAmbushGroup",
 "_trapdistance", "_iedside", "_iedMarkerName", "_fakeIed", "_dummy","_ok","_iedDir","_init","_time","_range","_ambushPos","_groupDir","_ambush"];
disableSerialization;

if (!isServer) exitWIth {};

_pos 				= _this select 0;
_trapkind 			= _this select 1;
_trapvolume 		= _this select 2;
_IEDExplosionType 	= _this select 3;
_IEDDisarmTime 		= MCC_IEDDisarmTimeArray select (_this select 4);
_IEDJammable 		= _this select 5;
_IEDTriggerType 	= _this select 6;
_trapdistance 		= _this select 7;
_iedside 			= _this select 8;
_iedMarkerName 		= _this select 9;
_iedDir 			= _this select 10;
_groupArray			= _this select 11;
if (isnil "_groupArray") then {_groupArray = false};
_ambushSide 		= if (_groupArray) then { _this select 12} else {east};

_init = "";

//Ammo?
_fakeIed = _trapkind createVehicle _pos;
_fakeIed setpos _pos;
_fakeIed setdir _iedDir;
_fakeIed setVariable ["isIED",true,true];
_fakeIed setvariable ["vehicleinit",format ["_null =[[_this,'%1',%2,%3,%4,%5,%6,'%7'], 'MCC_fnc_createIED', false, false] spawn BIS_fnc_MP;",_trapvolume,_IEDExplosionType,_IEDDisarmTime,_IEDJammable,_IEDTriggerType,_trapdistance,_iedside]];
MCC_curator addCuratorEditableObjects [[_fakeIed],false];

[[_fakeIed,_trapvolume,_IEDExplosionType,_IEDDisarmTime,_IEDJammable,_IEDTriggerType,_trapdistance,_iedside], "MCC_fnc_createIED", false, false] spawn BIS_fnc_MP;


//Spawn AMBUSH
if (_groupArray) then {
	//Ambush Group
	_groupArray = if (count MCC_MWGroupArrayMenRecon > 0) then {
		if (random 1 > 0.5) then {MCC_MWGroupArrayMenRecon} else {MCC_MWGroupArrayMen};
	} else {
		MCC_MWGroupArrayMen
	};

	//Choose group
	_groupName = (_groupArray call BIS_fnc_selectRandom) select 2;

	//Find an ambush position
	_time = time + 3;
	_range = 200;
	_ambushPos = [_pos, _range,100] call BIS_fnc_findOverwatch;
	while {isOnRoad _ambushPos && (time < _time)} do {
		_range = _range + 50;
		_ambushPos = [_pos, _range,100] call BIS_fnc_findOverwatch;
	};

	//Dir
	_groupDir = [_ambushPos, _pos] call BIS_fnc_dirTo;

	//spawn the ambush group
	_ambush = [_ambushPos,_groupName,_ambushSide,[""],_groupDir,_pos,0,_iedside] call MCC_fnc_ambushSingle;

	waituntil {alive _ambush};

	sleep 2;
	//Sync the IED and the ambush group
	[[_ambushPos , _pos],"MCC_fnc_iedSync",false,false] call BIS_fnc_MP;
};

_fakeIed