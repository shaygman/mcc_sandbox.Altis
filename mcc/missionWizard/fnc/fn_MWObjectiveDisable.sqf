//======================================================MCC_fnc_MWObjectiveDisable===============================================================================================
// Create a clear area objective
// Example:[_objPos,_isCQB,_side,_faction] call MCC_fnc_MWObjectiveDisable;
// _objPos = position, objectice position
//_isCQB = Boolean, true - for CQB areay false if it doesn't matters.
//_side = enemy side
//_faction = enemy Faction
// Return - nothing
//===============================================================================================================================================================================
private ["_objPos","_isCQB","_side","_faction","_preciseMarkers","_range","_roads","_object","_objectType","_range","_name","_sidePlayer","_time"];

_objPos = _this select 0;
_isCQB = _this select 1;
_side = _this select 2;
_faction = _this select 3;
_sidePlayer = _this select 4;
_preciseMarkers = _this select 5;

//find a location on road
/*
_time = time + 3;
_range = 50;
_roads = [];
while {count _roads <3 && (time < _time)} do {
	_roads = _objPos nearRoads _range;
	_range = _range +50;
};

_objPos = getpos (_roads select 0);
_objectType = MCC_MWIED call BIS_fnc_selectRandom;
*/

//Create the ied.
private ["_unitPlaced","_buildingPos","_array"];

_name = format ["MCCMWIEDObject_%1", ["MCCMWIEDObject_",1] call bis_fnc_counter];

if (_isCQB) then {
	_objectType = "Land_PressureWasher_01_F";
	_array = [_objPos, 50] call MCC_fnc_MWFindbuildingPos;
	_building = _array select 0;
	_buildingPos = _array select 1;

	 if (isnil "_buildingPos") exitWith {debuglog "MCC MW - MWObjectiveIED - No building pos foudn"};

	_unitPlaced = false;
	_time = time;
	 while {!_unitPlaced && (time <= (_time + 5))} do {
		_spawnPos	= _building buildingPos (floor random _buildingPos);

		//No other unit in the spawn position?
		if (count (nearestObjects [_spawnPos, ["Man"], 1])<1) then {
			//Spawn the intel
			_dummyObject = "Land_WoodenTable_small_F" createvehicle _spawnPos;
			_dummyObject setPos _spawnPos;
			_object = [_objPos,_objectType,"large",0,8,false,4,15,_sidePlayer,_name,random 360,true,_side] call MCC_fnc_trapSingle;
			_object setPos (_dummyObject modelToWorld [0,0,0.43]);
			_object setdir (getdir _dummyObject);
			_unitPlaced = true;

			//Lets spawn some body guards
			[[getpos _object,30,0,2,_faction, _side],"MCC_fnc_garrison",false,false] spawn BIS_fnc_MP;
		};
	};
} else {
	//Not CQB
	//Find an empry spot
	_objectType = "Land_Device_disassembled_F";
	_range = 50;
	_spawnPos = [_objPos,1,_range,10,0,100,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos;

	//If we haven't find it in first time increase by 50;
	while {str _spawnPos == "[-500,-500,0]"} do
	{
		_range = _range+ 50;
		_spawnPos = [_objPos,1,_range,10,0,100,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos;
	};

	//Create the object
	_object = [_objPos,_objectType,"large",0,8,false,4,15,_sidePlayer,_name,random 360,true,_side] call MCC_fnc_trapSingle;
	_object setdir random 360;
};

//Lets create an ambush
_groupArray = if (count MCC_MWGroupArrayMenRecon > 0) then {
	if (random 1 > 0.5) then {MCC_MWGroupArrayMenRecon} else {MCC_MWGroupArrayMen};
} else {
	MCC_MWGroupArrayMen
};

MCC_curator addCuratorEditableObjects [[_object],false];

[_object,"disableIED",_preciseMarkers,_side,400,_sidePlayer] call MCC_fnc_MWCreateTask;