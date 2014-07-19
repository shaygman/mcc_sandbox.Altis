//Made by Shay_Gman (c) 09.10
private ["_pos", "_spawnName", "_side","_group","_iedMarkerName","_groupDir","_nearObjects","_ied","_wp",
		"_dummyAmbush","_groupLeader","_isSpotter","_spotterArray","_spotter","_spotterClass","_move","_targetSide"]; 
disableSerialization;

_pos = _this select 0; 
_spawnName 		= _this select 1; 
_side 			= _this select 2;
_iedMarkerName 	= _this select 3 select 0;
_groupDir 		= _this select 4;
_pointB 		= _this select 5;
_isSpotter 		= _this select 6;
_targetSide		= _this select 7;
_nearObjects 	= [];
_move			= "AWOPPERCMSTPSOPTWBINDNON_NON"; //defualt bino use when standing

switch (_side) do	{
		case "GUE":
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

if (_isSpotter > 0) then {		//If we are spawning a spotter
	switch (_isSpotter) do {
		case 1:
		{ 
			_group = creategroup civilian;
			_spotterArray = ["C_man_1","C_man_1_1_F","C_man_polo_2_F"];
			_spotterClass = _spotterArray select (floor random (count _spotterArray)); 
		};
		
		case 2:
		{ 
			_group = creategroup civilian;
			_spotterArray = ["Assistant","Citizen1","Functionary1","Priest","Policeman","Profiteer3","RU_Villager1","RU_Rocker1"];
			_spotterClass = _spotterArray select (floor random (count _spotterArray)); 
		};
		
		case 3:
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
} else {
	_group=[_pos, _side, (call compile _spawnName)] call BIS_fnc_spawnGroup;
	};

		
_group setFormDir _groupDir;
sleep 2;
_group setFormation "LINE";
_group setBehaviour "STEALTH";	
_group setSpeedMode "FULL";	
_group setCombatMode "GREEN";
_groupLeader = leader _group;

_dummyAmbush = "bomb" createVehicle _pos;
_dummyAmbush hideobject true;
_dummyAmbush setvariable ["iedTrigered", false, true]; 

sleep 2;	
if (_isSpotter > 0) then {													
	if (_isSpotter == 3) then {											//If it is camuflaged spotter get prone
		[_spotter,"DOWN"] spawn MON_setUnitPos;
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
} else {{[_x,"DOWN"] spawn MON_setUnitPos}foreach units _group};	//If not all prone

while {(!(_dummyAmbush getvariable "iedTrigered")) && (alive _groupLeader)} do {sleep 0.1};	//Wait until the IED is been set off  or the ambush leader has been killed
if (alive _groupLeader) then	{														//If the IED has been set off
	_group setBehaviour "AWARE";
	_group setCombatMode "RED";
	if (_isSpotter == 0) then {
		_wp = _group addWaypoint [_pointB, 0];												//Add WP 
		{[_x,"MIDDLE"] spawn MON_setUnitPos}foreach units _group; 							//stand up
	};
} 	else	{																				//If the ambush leader has been killed and this is a spotter
		if (_isSpotter > 0) then {
			_dummyAmbush setvariable ["iedTrigered", true, true];						//Blow the IED if the spotter is dead
			_spotter setcaptive false;
		}; 
	};

[[2,compile format ["deletemarkerlocal '%1';",_iedMarkerName]], "MCC_fnc_globalExecute", true, false] spawn BIS_fnc_MP;	//delete IED marker 
sleep 10;	//fail safe give the game enough time to read the variable from it before deleting it.
deletevehicle _dummyAmbush;
