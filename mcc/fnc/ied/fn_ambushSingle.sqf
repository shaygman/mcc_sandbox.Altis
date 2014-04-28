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
private ["_pos", "_spawnName", "_side","_group","_iedMarkerName","_groupDir","_nearObjects","_ied","_wp","_init",
		"_dummyAmbush","_groupLeader","_isSpotter","_spotterArray","_spotter","_spotterClass","_move","_targetSide"]; 
disableSerialization;

_pos 			= _this select 0; 
_spawnName 		= _this select 1; 
_side 			= _this select 2;
_iedMarkerName 	= _this select 3 select 0;
_groupDir 		= _this select 4;
_pointB 		= _this select 5;
_isSpotter 		= _this select 6;
_targetSide		= _this select 7;
_nearObjects 	= [];
_move			= "AWOPPERCMSTPSOPTWBINDNON_NON"; //defualt bino use when standing

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
									"USMC_SoldierS_Spotter"
								};
								
								case east:
								{ 
									"RU_Soldier_Spotter"
								};
								
								case resistance:
								{ 
									"GUE_Soldier_Scout"
								};
								
								case civilian:
								{ 
									"Woodlander3"
								};
							};
		};
	};
	
	_spotter = _group createUnit [_spotterClass , _pos, [], 0, "NONE"];
	_spotter setcaptive true;
	_spotter AddWeapon "Binocular";
} 
else 
{
	_group=[_pos, _side, (call compile _spawnName)] call MCC_fnc_spawnGroup;
	{
		MCC_curator removeCuratorEditableObjects [[_x],false];
	} foreach units _group; 
};

		
_group setFormDir _groupDir;
sleep 2;
_group setFormation "LINE";
_group setBehaviour "STEALTH";	
_group setSpeedMode "FULL";	
_group setCombatMode "GREEN";
_groupLeader = leader _group;

_dummyAmbush = "bomb" createVehicle _pos;
_init = '_this hideobject true;';

waituntil {alive _dummyAmbush};
[[[netid _dummyAmbush,_dummyAmbush], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;

_dummyAmbush setvariable ["iedTrigered", false, true]; 

sleep 2;	
if (_isSpotter > 0) then {													
	if (_isSpotter == 3) then {											//If it is camuflaged spotter get prone
		[_spotter,"DOWN"] spawn MCC_fnc_setUnitPos;
		_move = "AwopPpneMstpSoptWbinDnon_non"; 						//defualt bino use when prone
	} else	{
		_null = [_spotter,_targetSide,15,"Makarov","8Rnd_9x18_Makarov"] execVM MCC_path + "mcc\general_scripts\traps\cw.sqf";
		};
	[_spotter,_move] spawn {													//If it is a spotter make him use the binos for time 2 time
		while {alive (_this select 0)} do {
			sleep random 60; 
			(_this select 0) playmove format ["%1",(_this select 1)]; 
		};
	};
} else {{[_x,"DOWN"] spawn MCC_fnc_setUnitPos}foreach units _group};	//If not all prone

if (isnil "_spotter") then {_spotter = ""}; //failsafe for passing the variables
[_dummyAmbush,_groupLeader,_group,_isSpotter,_pointB,_iedMarkerName,_spotter] spawn
{
	_dummyAmbush = _this select 0;
	_groupLeader = _this select 1;
	_group = _this select 2;
	_isSpotter = _this select 3;
	_pointB = _this select 4;
	_iedMarkerName = _this select 5;
	_spotter = _this select 6;
	
	while {(!(_dummyAmbush getvariable "iedTrigered")) && (alive _groupLeader)} do {sleep 0.1};	//Wait until the IED is been set off  or the ambush leader has been killed
	if (alive _groupLeader) then	{														//If the IED has been set off
		_group setBehaviour "AWARE";
		_group setCombatMode "RED";
		if (_isSpotter == 0) then {
			_wp = _group addWaypoint [_pointB, 0];												//Add WP 
			{[_x,"MIDDLE"] spawn MCC_fnc_setUnitPos}foreach units _group; 							//stand up
		};
	} 	else	{																				//If the ambush leader has been killed and this is a spotter
			if (_isSpotter > 0) then {
				_dummyAmbush setvariable ["iedTrigered", true, true];						//Blow the IED if the spotter is dead
				_spotter setcaptive false;
			}; 
		};

	if (_iedMarkerName !="") then
	{
		[[2,compile format ["deletemarkerlocal '%1';",_iedMarkerName]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;	//delete IED marker 
	};
	sleep 10;	//fail safe give the game enough time to read the variable from it before deleting it.
	deletevehicle _dummyAmbush;
};

_dummyAmbush