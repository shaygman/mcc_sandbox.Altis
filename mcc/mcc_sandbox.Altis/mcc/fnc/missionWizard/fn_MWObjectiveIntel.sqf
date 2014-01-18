//======================================================MCC_fnc_MWObjectiveIntel=========================================================================================================
// Create a pick intel objective
// Example:[_objPos,_isCQB,_side,_faction] call MCC_fnc_MWObjectiveIntel; 
// _objPos = position, objectice position
//_isCQB = Boolean, true - for CQB areay false if it doesn't matters. 
//_side = enemy side
//_faction = enemy Faction
// Return - nothing
//========================================================================================================================================================================================
private ["_objPos","_isCQB","_side","_faction","_preciseMarkers","_objType","_spawnPos","_time",
         "_object","_dummyObject","_spawndir","_unitsArray","_group","_init","_range","_array","_building","_buildingPos","_unitPlaced"];

_objPos = _this select 0;
_isCQB = _this select 1;
_side = _this select 2;
_faction = _this select 3;
_preciseMarkers = _this select 4;

_objType = MCC_MWIntelObjects call BIS_fnc_selectRandom;

if (_isCQB) then
{
	_array = [_objPos, 50] call MCC_fnc_MWFindbuildingPos;
	_building = _array select 0;
	_buildingPos = _array select 1;
	 
	 if (isnil "_buildingPos") exitWith {debuglog "MCC MW - MWObjectivePickIntel - No building pos foudn"}; 
			
	_unitPlaced = false; 
	_time = time; 
	 while {!_unitPlaced && (time <= (_time + 5))} do
	{
		_spawnPos	= _building buildingPos (floor random _buildingPos); 
		if (count (nearestObjects [_spawnPos, ["Man"], 1])<1) then		//No other unit in the spawn position?
		{ 		
			//Spawn the intel
			_dummyObject = "Land_WoodenTable_small_F" createvehicle _spawnPos;
			_dummyObject setPos _spawnPos;
			_object = _objType createvehicle _spawnPos;
			_object setPos (_dummyObject modelToWorld [0,0,0.43]); 
			_object setdir (getdir _dummyObject);
			_object enablesimulation false;
			_unitPlaced = true; 
			
			//Lets spawn some body guards
			[[getpos _object,30,0,2,_faction,str _side],"MCC_fnc_garrison",false,false] spawn BIS_fnc_MP;
		};
	};
}
else		//Not CQB
{
	//Find an empry spot
	_range = 50;
	_spawnPos = [_objPos,1,_range,10,0,100,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos;

	//If we haven't find it in first time increase by 50; 
	while {str _spawnPos == "[-500,-500,0]"} do
	{
		_range = _range+ 50; 
		_spawnPos = [_objPos,1,_range,10,0,100,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos;
	};


	//find the table
	_dummyObject =[_spawnPos, random 360, "c_slums"] call MCC_fnc_objectMapper;
	waituntil {alive _dummyObject};
	_spawnPos = getpos _dummyObject;
	_spawndir = getdir _dummyObject;

	 if (isnil "_spawndir") then {_spawndir = random 360};
	 
	 //Create the object
	_object = _objType createvehicle _spawnPos;
	_object setPos (_dummyObject modelToWorld [0,0,0.43]); 
	_object setdir _spawndir;
	_object enablesimulation false;
};

//Pick Item 
_init = '_this call MCC_fnc_pickItem'; 
[[[netID _object,_object], _init], "MCC_fnc_setVehicleInit", true, true] spawn BIS_fnc_MP;

//Start Briefings
[_object,"pick_intel",_preciseMarkers] call MCC_fnc_MWCreateTask; 




				
		
