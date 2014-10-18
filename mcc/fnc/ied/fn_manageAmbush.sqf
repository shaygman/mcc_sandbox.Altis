//======================================================MCC_fnc_manageAmbush=========================================================================================================
// Create an ambush group 
// Example:[_leader,_iedMarkerName,_groupDir,_pointB,_isSpotter,_targetSide] spawn MCC_fnc_manageAmbush; 
// _leader = unit, leader of the ambush group
//_iedMarkerName = string, name for the ambush marker if present (will be deleted after the ambush is triggered ) paste [""] for nothing
//_groupDir = integer, the direction the ambush is facing
// _pointB = Position, the WP the ambush will move to after activated
// _isSpotter = Integer, 0 - no spotter, 1 - civilan, 2- function, 3 - camofluged
// _targetSide = side for the spotter
// Return - nothing
//Made by Shay_Gman (c) 06.14
//========================================================================================================================================================================================
private ["_leader","_iedMarkerName","_groupDir","_pointB","_isSpotter","_targetSide","_group","_move","_dummyAmbush","_init"]; 

_leader			= _this select 0;
_iedMarkerName 	= _this select 1;
_groupDir 		= _this select 2;
_pointB 		= _this select 3;
_isSpotter 		= _this select 4;
_targetSide		= _this select 5;

_move			= "AWOPPERCMSTPSOPTWBINDNON_NON"; //defualt bino use when standing		
_group			= group _leader;

_group setFormDir _groupDir;
sleep 1;
_group setFormation "LINE";
_group setBehaviour "STEALTH";	
_group setSpeedMode "FULL";	
_group setCombatMode "GREEN";

_dummyAmbush = MCC_dummy createVehicle (getpos _leader);
waituntil {!isnil "_dummyAmbush"};
_dummyAmbush setdir _groupDir;
_dummyAmbush attachto [_leader,[0,0,0]];
_dummyAmbush hideobjectglobal true;

_dummyAmbush setvariable ["iedTrigered", false, true]; 
_dummyAmbush setvariable ["armed", true, true];
_dummyAmbush setvariable ["iedMarkerName", _iedMarkerName,true];
_dummyAmbush setvariable ["isAmbush", true,true];
_dummyAmbush setvariable ["dir", _groupDir,true];
_dummyAmbush setvariable ["fakeIed",_leader,true];

sleep 1;
	
if (_isSpotter > 0) then 
{													
	if (_isSpotter == 3) then 	//If it is camuflaged spotter get prone
	{										
		[_leader,"DOWN"] spawn MCC_fnc_setUnitPos;
		_move = "AwopPpneMstpSoptWbinDnon_non"; 						//defult bino use when prone
	} 
	else	
	{
		_null = [_leader,_targetSide,15] spawn MCC_fnc_manageAC;
	};
	
	[_leader,_move] spawn 
	{													//If it is a spotter make him use the binos for time 2 time
		while {alive (_this select 0)} do 
		{
			sleep (random 60) + 15; 
			(_this select 0) playmove format ["%1",(_this select 1)]; 
		};
	};
} 
else //If not all prone
{
	{
		[_x,"DOWN"] spawn MCC_fnc_setUnitPos
	} foreach units _group
};	

//Sync it with pre-sync IED
if (str (_leader getVariable ["syncedObject", [0,0,0]]) != "[0,0,0]") then
{
	[[getpos _leader , (_leader getVariable ["syncedObject", [0,0,0]])],"MCC_fnc_iedSync",false,false] call BIS_fnc_MP;
};

[_dummyAmbush,_leader,_group,_isSpotter,_pointB] spawn
{
	_dummyAmbush = _this select 0;
	_leader = _this select 1;
	_group = _this select 2;
	_isSpotter = _this select 3;
	_pointB = _this select 4;
	
	//Wait until the IED is been set off  or the ambush leader has been killed
	while {(!(_dummyAmbush getvariable "iedTrigered")) && (alive _leader)} do 
	{
		if ( str (_dummyAmbush getVariable ["syncedObject",[0,0,0]]) != "[0,0,0]") then 
		{
			_pointB 	= _dummyAmbush getVariable ["syncedObject",[0,0,0]];
		};
		sleep 5;
	};	
	
	//If the IED has been set off
	if (alive _leader) then			
	{														
		_group setBehaviour "AWARE";
		_group setCombatMode "RED";
		if (_isSpotter == 0) then 
		{
			_wp = _group addWaypoint [_pointB, 0];													//Add WP 
			{[_x,"MIDDLE"] spawn MCC_fnc_setUnitPos}foreach units _group; 							//stand up
		};
	} 	
	else	
	{																				//If the ambush leader has been killed and this is a spotter
		//Blow the IED if the spotter is dead
		if (_isSpotter > 0) then 
		{
			_dummyAmbush setvariable ["iedTrigered", true, true];						
			_leader setcaptive false;
		}; 
	};
	
	sleep 5;	//fail safe give the game enough time to read the variable from it before deleting it.
	deletevehicle _dummyAmbush;
};