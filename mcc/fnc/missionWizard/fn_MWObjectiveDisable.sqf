//======================================================MCC_fnc_MWObjectiveDisable=========================================================================================================
// Create a clear area objective
// Example:[_objPos,_isCQB,_side,_faction] call MCC_fnc_MWObjectiveDisable; 
// _objPos = position, objectice position
//_isCQB = Boolean, true - for CQB areay false if it doesn't matters. 
//_side = enemy side
//_faction = enemy Faction
// Return - nothing
//========================================================================================================================================================================================
private ["_objPos","_isCQB","_side","_faction","_preciseMarkers","_range","_roads","_object","_objectType","_range","_name","_sidePlayer","_ied",
	    "_time"];

_objPos = _this select 0;
_isCQB = _this select 1;
_side = _this select 2;
_faction = _this select 3;
_sidePlayer = _this select 4;
_preciseMarkers = _this select 5;

//find a location on road
_time = time + 3; 
_range = 50;
_roads = [];
while {count _roads <3 && (time < _time)} do
{
	_roads = _objPos nearRoads _range;
	_range = _range +50;
};

_objPos = getpos (_roads select 0); 

//Create the ied.
_name = format ["MCCMWIEDObject_%1", ["MCCMWIEDObject_",1] call bis_fnc_counter]; 
_objectType = MCC_MWIED call BIS_fnc_selectRandom;	

//Lets create an ambush
_groupArray = if (count MCC_MWGroupArrayMenRecon > 0) then 
{
	if (random 1 > 0.5) then {MCC_MWGroupArrayMenRecon} else {MCC_MWGroupArrayMen};
} 
else 
{
	MCC_MWGroupArrayMen
}; 

//Spawn it
_ied = ([_objPos,_objectType,"large",0,2,false,0,15,_sidePlayer,_name,random 360,_groupArray,_side] call MCC_fnc_trapSingle) select 0;

[_ied,"disableIED",_preciseMarkers] call MCC_fnc_MWCreateTask; 