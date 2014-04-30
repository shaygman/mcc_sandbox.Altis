//===================================================================MCC_fnc_groupSpawn=========================================================================================
// Create a group on the server
//[[_type,_pos,_unitsArray,_loc],"MCC_fnc_groupSpawn",false,false] spawn BIS_fnc_MP;
//	<in>
//		_pos: Array		Position to spawn
//		_unitsArray		Array of units or Cfg path
//		_loc				Integer - 1 Headless Client
//		_side			side name or string
//==============================================================================================================================================================================	
//Made by Shay_Gman (c) 09.10

private ["_pos","_unitsArray","_side","_group","_loc","_isEmpty","_unitClass","_unitSim","_unit","_safePos","_waterSpawn"];

_pos 		= _this select 0; 
_unitsArray = _this select 1; 
_loc 		= _this select 2;
_side		= if (typeName (_this select 3) == "STRING") then 
				{
					if (tolower (_this select 3) == "guer") then
					{
						resistance
					}
					else
					{
						call compile (_this select 3);
					};
				} 
				else 
				{
					(_this select 3)
				};

_isEmpty	= _this select 4;


if (surfaceIsWater _pos) then {_waterSpawn = 2} else {_waterSpawn = 0}; 

if ( ( (isServer) && ( (_loc == 0) || !(MCC_isHC) ) ) || ( (MCC_isLocalHC) && (_loc == 1) ) ) then 
{
	if (_isEmpty) then
	{
		_group = (_unitsArray select 0) createVehicle _pos;
		_group setpos _pos;
		MCC_curator addCuratorEditableObjects [[_group],false];
	}
	else
	{
		//Cfg Group
		if (typeName _unitsArray == "STRING") exitWith 
		{
			_group = [_pos, _side, (call compile _unitsArray)] call MCC_fnc_spawnGroup;
		};

		if (typeName _unitsArray == "CONFIG") exitWith 
		{
			_group = [_pos, _side, _unitsArray] call MCC_fnc_spawnGroup;
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
					MCC_curator addCuratorEditableObjects [[_unit],false];
				};
				default 
				{
					_safepos  =[_pos,1,50,2,_waterSpawn,50,0] call BIS_fnc_findSafePos;
					_unit = [[_safepos select 0,_safepos select 1,0], 0, _unitClass, _group] call BIS_fnc_spawnVehicle;
					MCC_curator addCuratorEditableObjects [[_unit select 0],true];
				};
			};
		};
		
		//Set skill
		{
			_x setSkill ["aimingspeed", MCC_AI_Aim];
			_x setSkill ["spotdistance", MCC_AI_Spot];
			_x setSkill ["aimingaccuracy", MCC_AI_Aim];
			_x setSkill ["aimingshake", MCC_AI_Aim];
			_x setSkill ["spottime", MCC_AI_Spot];
			_x setSkill ["commanding", MCC_AI_Command];
			_x setSkill ["general", MCC_AI_Skill];
		} foreach units _group;
	};
};
