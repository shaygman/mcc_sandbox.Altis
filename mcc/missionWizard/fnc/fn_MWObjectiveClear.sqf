//======================================================MCC_fnc_MWObjectiveClear=================================================================================================
// Create a clear area objective
// Example:[_objPos,_isCQB,_side,_faction] call MCC_fnc_MWObjectiveClear;
// _objPos = position, objectice position
//_isCQB = Boolean, true - for CQB areay false if it doesn't matters.
//_side = enemy side
//_faction = enemy Faction
// Return - nothing
//===============================================================================================================================================================================
private ["_objPos","_isCQB","_side","_faction","_preciseMarkers","_range","_doc","_sidePlayer","_campaignMission","_maxObjectivesDistance"];

_objPos 		= _this select 0;
_isCQB 			= _this select 1;
_side 			= _this select 2;
_faction 		= _this select 3;
_sidePlayer 	= _this select 4;
_preciseMarkers = _this select 5;
_campaignMission = param [ 6, false, [false]];
_maxObjectivesDistance = param [ 7, 400, [0]];

if (_isCQB) then {
	_range = if (_campaignMission) then {100} else {50};

	_array = [_objPos, 100] call MCC_fnc_MWFindbuildingPos;
	_objPos = getpos (([_objPos, 100] call MCC_fnc_MWFindbuildingPos) select 0);
} else {
	_range = if (_campaignMission) then {200} else {100};

	//Lets spawn an FOB
	if (!_campaignMission || (random 1 > 0.7)) then {
		_doc = ["o_fobSmall","o_fobLarge"] call BIS_fnc_selectRandom;
		_dummyObject =[_objPos, random 360,_doc] call MCC_fnc_objectMapper;
		waituntil {alive _dummyObject};
	};
};

//Lets populate it
[_objPos,_range, 0, (if (_campaignMission) then {0.5} else {2}),_faction, _side] call MCC_fnc_garrison;

sleep 2;

//Create Task
[_objPos,"clear_area",_preciseMarkers,_side,_maxObjectivesDistance,_sidePlayer] call MCC_fnc_MWCreateTask;