//======================================================MCC_fnc_ambushSingle=========================================================================================================
// Create an ambush group
// Example:[_pos,_spawnName,_side,[_iedMarkerName],_groupDir,_pointB,_isSpotter,_targetSide] call MCC_fnc_ambushSingle;
// _pos = position, position to place the ambush
//_spawnName = string, group name to spawn
//_side =ambush side
//_iedMarkerName = string, name for the ambush marker if present (will be deleted after the ambush is triggered ) paste [""] for nothing
//_groupDir = integer, the direction the ambush is facing
// _pointB = Position, the WP the ambush will move to after activated
// _isSpotter = Integer, 0 - no spotter, 1 - civilan, 2- function, 3 - camofluged
// _targetSide = side for the spotter
// Return - nothing
//Made by Shay_Gman (c) 09.10
//========================================================================================================================================================================================
private ["_pos", "_spawnName", "_side","_group","_iedMarkerName","_groupDir","_init","_isSpotter","_spotterArray","_spotter","_spotterClass","_targetSide"];
disableSerialization;

_pos 			= _this select 0;
_spawnName 		= _this select 1;
_side 			= _this select 2;
_iedMarkerName 	= _this select 3 select 0;
_groupDir 		= _this select 4;
_pointB 		= _this select 5;
_isSpotter 		= _this select 6;
_targetSide		= _this select 7;

if (typeName _side == "STRING") then
{
	switch (toUpper _side) do
	{
		case "GUER":
		{
			_side = resistance;
		};

		case "WEST":
		{
			_side = west;
		};

		case "EAST":
		{
			_side = east;
		};

		case "CIV":
		{
			_side = civilian;
		};
	};
};

//If we are spawning a spotter
if (_isSpotter > 0) then
{
	switch (_isSpotter) do {
		case 1:			//Civilian
		{
			_group = creategroup civilian;
			_spotterArray = ["C_man_1","C_man_1_1_F","C_man_polo_2_F"];
			_spotterClass = _spotterArray select (floor random (count _spotterArray));
		};

		case 2:			//Function
		{
			_group = creategroup civilian;
			_spotterArray = ["Assistant","Citizen1","Functionary1","Priest","Policeman","Profiteer3","RU_Villager1","RU_Rocker1"];
			_spotterClass = _spotterArray select (floor random (count _spotterArray));
		};

		case 3:			//Camoflged
		{
			_group = creategroup _side;
			_spotterClass = switch (_targetSide) do {				//case we have a happy camuflaged spotter
								case west:
								{
									"B_spotter_F"
								};

								case east:
								{
									"O_spotter_F"
								};

								case resistance:
								{
									"I_spotter_F"
								};

								case civilian:
								{
									"C_man_hunter_1_F"
								};
							};
		};
	};

	_spotter = _group createUnit [_spotterClass , _pos, [], 0, "NONE"];
	_spotter AddWeapon "Binocular";
	{_x addCuratorEditableObjects [[_spotter],false]} forEach allCurators;
}
else
{
	_group=[_pos, _side, (call compile _spawnName)] call MCC_fnc_spawnGroup;
};


_init = format [";_this setVariable ['isIED',true,true];[_this,'%1',%2,%3,%4,%5] spawn MCC_fnc_manageAmbush;"
				 ,_iedMarkerName
				 ,_groupDir
				 ,_pointB
				 ,_isSpotter
				 ,_targetSide
				 ];

[[[netid (leader _group), leader _group], _init], "MCC_fnc_setVehicleInit", false, false] spawn BIS_fnc_MP;
(leader _group)