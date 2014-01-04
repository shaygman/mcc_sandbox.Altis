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
// 	_groupArray: ARRAY, array of groups configs to spawn an ambush push empty array for no ambush
//	_ambushSide: side, ambush side
//==============================================================================================================================================================================	

//Made by Shay_Gman (c) 09.10
private ["_pos", "_trapkind", "_trapvolume", "_IEDExplosionType", "_IEDDisarmTime", "_IEDJammable", "_IEDTriggerType", "_IEDAmbushGroup",
 "_trapdistance", "_iedside", "_iedMarkerName", "_fakeIed", "_dummy", "_eib_marker","_ok","_iedDir","_init","_groupArray","_ambushSide"]; 
disableSerialization;

_pos 				= _this select 0; 
_trapkind 			= _this select 1; 
_trapvolume 		= _this select 2; 
_IEDExplosionType 	= _this select 3; 
_IEDDisarmTime 		= _this select 4; 
_IEDJammable 		= _this select 5;
_IEDTriggerType 	= _this select 6;
_trapdistance 		= _this select 7;
_iedside 			= _this select 8;
_iedMarkerName 		= _this select 9;
_iedDir 			= _this select 10;
_groupArray			= _this select 11;
if (count _groupArray >0 ) then {_ambushSide = _this select 12};

_eib_marker = createMarkerlocal ["traps",_pos];

_fakeIed = _trapkind createVehicle _pos; 
_fakeIed setposatl _pos;

_init ='_this addaction ["<t color=""#FF9900"">" + "Disarm IED" + "</t>","' + MCC_path + 'mcc\general_scripts\traps\ied_disarm.sqf","",6,false,true,"_target distance _this < 10"];';
[[[netid _fakeIed,_fakeIed], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;
_fakeIed setdir _iedDir;

_dummy = "Bomb" createVehicle _pos;
_dummy addEventHandler ["handleDamage",{_this call MCC_fnc_iedHit;0}];
_init = '_this hideobject true;';
[[[netid _dummy,_dummy], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;

_fakeIed setdir _iedDir;
_dummy attachto [_fakeIed,[0,0,0]];

[_fakeIed, _dummy] spawn
{
	private ["_fakeIedS"];
	_fakeIedS 	= _this select 0;
	_dummy 		= _this select 1;
	waituntil {!alive _fakeIedS || isnull _fakeIedS};
	sleep 1;
	deletevehicle _dummy;
};
	
_dummy setvariable ["fakeIed", _fakeIed ,true];
_dummy setvariable ["armed", true, true];
_dummy setvariable ["disarmTime", _IEDDisarmTime, true];
_dummy setvariable ["iedMarkerName", _iedMarkerName, true];
_dummy setvariable ["iedTrigered", false, true]; 
_dummy setvariable ["iedAmbush", false, true];

//If it is radio IED
if (_IEDTriggerType == 1) then 
{
	_dummy setvariable ["iedTrigereRadio", true, true];
}
else
{
	_dummy setvariable ["iedTrigereRadio", false, true];
};	
	
_fakeIed setvariable ["realIed", _dummy ,true];

//Spawn AMBUSH
private ["_groupArray","_time","_range","_ambushPos","_groupDir","_ambush"];
if (count _groupArray > 0) then 
{
	//Choose group
	_groupName = (_groupArray call BIS_fnc_selectRandom) select 2;
	
	//Find an ambush position
	_time = time + 3;  
	_range = 200;
	_ambushPos = [_pos, _range,100] call BIS_fnc_findOverwatch;
	while {isOnRoad _ambushPos && (time < _time)} do
	{
		_range = _range + 50;
		_ambushPos = [_pos, _range,100] call BIS_fnc_findOverwatch;
	};
	
	//Dir
	_groupDir = [_ambushPos, _pos] call BIS_fnc_dirTo;

	//spawn the ambush group
	_ambush = [_ambushPos,_groupName,_ambushSide,[""],_groupDir,_pos,0,_iedside] call MCC_fnc_ambushSingle; 
	
	waituntil {alive _ambush};
	
	//Sync the IED and the ambush group
	[[_ambushPos , _pos, 9999],"MCC_fnc_iedSync",false,false] call BIS_fnc_MP;
};

//Spawn the IED script
_ok = [_dummy,_trapvolume,_IEDExplosionType,_IEDJammable,_IEDTriggerType,_trapdistance,_iedside] execVM MCC_path +"mcc\general_scripts\traps\IED.sqf";

sleep 0.01;
deletemarker "traps";

[_dummy,_fakeIed];