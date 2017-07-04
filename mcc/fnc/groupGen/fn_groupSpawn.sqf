//===================================================================MCC_fnc_groupSpawn=========================================================================================
// Create a group on the server
//[[_pos,_unitsArray,_loc, _side, _isEmpty, _cache],"MCC_fnc_groupSpawn",false,false] spawn BIS_fnc_MP;
//	<in>
//		_pos: Array		Position to spawn
//		_unitsArray		Array of units or Cfg path
//		_loc				Integer - 1 Headless Client
//		_side			side name or string
//		_isEmpty
//		_cache			automaticlly cache the group
//
//==============================================================================================================================================================================
//Made by Shay_Gman (c) 09.10

private ["_pos","_unitsArray","_side","_group","_loc","_isEmpty","_unitClass","_unitSim","_unit","_safePos","_waterSpawn","_cache"];

_pos 		= _this select 0;
_unitsArray = _this select 1;
_loc 		= _this select 2;
_side		= if (typeName (_this select 3) == "STRING") then
				{
					switch (tolower (_this select 3)) do
					{
						case "guer":{resistance};
						case "civ":{civilian};
						default {call compile (_this select 3)};
					};
				}
				else
				{
					(_this select 3)
				};

_isEmpty	= _this select 4;
_cache		= if (count _this > 5) then { _this select 5};

mcc_isnewzone = false;
mcc_grouptype = "";
mcc_spawntype = "";
mcc_classtype = "";
mcc_spawnname = "";
mcc_spawnfaction ="";
mcc_resetmissionmaker = false;

if (surfaceIsWater _pos) then {_waterSpawn = 2} else {_waterSpawn = 0};

if ( ( (isServer) && ( (_loc == 0) || !(MCC_isHC) ) ) || ( (MCC_isLocalHC) && (_loc == 1) ) ) then
{
	if (_isEmpty) then
	{
		_group = (_unitsArray select 0) createVehicle _pos;
		_group setpos _pos;
		{_x addCuratorEditableObjects [[_group],false]} forEach allCurators;
	}
	else
	{
		//Cfg Group
		if (typeName _unitsArray == "STRING") exitWith
		{
			_group = [_pos, _side, (call compile _unitsArray)] call MCC_fnc_spawnGroup;
			_group setVariable ["mcc_gaia_cache",_cache, true];

		};

		if (typeName _unitsArray == "CONFIG") exitWith
		{
			_group = [_pos, _side, _unitsArray] call MCC_fnc_spawnGroup;
			_group setVariable ["mcc_gaia_cache",_cache, true];
		};

		//Array group workAround
		_group = creategroup _side;
		for [{_x=0},{_x < (count _unitsArray)},{_x=_x+1}] do
		{
			_unitClass 	= _unitsArray select _x;
			_unitSim	= getText(configFile >> "CfgVehicles" >> _unitClass >> "simulation");

			switch (tolower _unitSim) do
			{
				case "soldier":
				{
					_unit = _group createunit [_unitClass,_pos,[],0,"none"];
					{_x addCuratorEditableObjects [[_unit],false]} forEach allCurators;
				};
				default
				{
					_safepos  =[_pos,1,50,2,_waterSpawn,50,0] call BIS_fnc_findSafePos;
					_unit = [[_safepos select 0,_safepos select 1,0], 0, _unitClass, _group] call BIS_fnc_spawnVehicle;
					{_x addCuratorEditableObjects [[_unit select 0],true]} forEach allCurators;
				};
			};
		};

		//Set skill
		{
			_x setSkill ["aimingspeed", (missionNamespace getVariable ["MCC_AI_Aim",0.1])];
			_x setSkill ["spotdistance", (missionNamespace getVariable ["MCC_AI_Spot",0.3])];
			_x setSkill ["aimingaccuracy", (missionNamespace getVariable ["MCC_AI_Aim",0.1])];
			_x setSkill ["aimingshake", (missionNamespace getVariable ["MCC_AI_Aim",0.1])];
			_x setSkill ["spottime", (missionNamespace getVariable ["MCC_AI_Spot",0.3])];
			_x setSkill ["commanding", (missionNamespace getVariable ["MCC_AI_Command",0.5])];
			_x setSkill ["general", (missionNamespace getVariable ["MCC_AI_Skill",0.5])];
		} foreach units _group;

		_group setVariable ["mcc_gaia_cache",_cache, true];
	};
};
_group