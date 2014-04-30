//===================================================================MCC_fnc_garrison======================================================================================
//Populate soldiers inside empty houses
//Example:[[center,radius,action,intanse,faction,side,_groupUnits],"MCC_fnc_garrison",true,false] call BIS_fnc_MP;
// Params: 
// 	center: array, center of the town to garrison.
//	radius: number,radius in meters units will garrison buildings.
//	action:  number, 0 - do not spawn empty vehicles 1 - spawn empty vehicles. 
//	intanse:  number, probability of a garrison units between 0-10 the higher the number more units will show
//	faction: units will garrison from the same faction. 
//	side: side, [west, east, resistance, civilian]
//	_groupUnits (optional) if broadcast will build all units in the same group
//=========================================================================================

private ["_center","_radius","_action","_intanse","_faction","_unitsArray","_vehiclesArray","_SpawnUnit","_SpawnVehicle","_group",
		"_unitsCount","_vehiclesCount","_buildingsArray","_buildingscount","_side","_spawnBuilding","_spawnPos","_unit","_type",
		"_vehiclesNumber","_roads","_road","_vehicle","_vehicleClass","_groupUnits","_static","_dir"];

disableSerialization;

_center			= _this select 0;
_radius			= _this select 1;
_action 		= _this select 2;
_intanse		= _this select 3;
_faction		= _this select 4;
_side			= _this select 5;
_groupUnits 	= if (count _this >6) then {true} else {false};

_unitsArray 	= [_faction,"soldier","men"] call MCC_fnc_makeUnitsArray;		//Let's build the faction unit's array
if(count _unitsArray < 4) then 
{
	_unitsArray = [_faction,"soldier"] call MCC_fnc_makeUnitsArray;
}; 

_vehiclesArray	= [_faction,"carx","car"] call MCC_fnc_makeUnitsArray;		//Let's build the faction vehicles's array
if(count _vehiclesArray < 4) then 
{
	_vehiclesArray = [_faction,"carx"] call MCC_fnc_makeUnitsArray;
}; 
_buildingsArray	= nearestObjects  [_center,["House","Ruins","Church","FuelStation","Strategic"],_radius];	//Let's find the buildings in the area

_unitsCount		= count _unitsArray;
_vehiclesCount	= count _vehiclesArray;
_buildingscount	= count _buildingsArray;

switch (toLower _side) do	
{
	case "west": {_side =  west};
	case "east": {_side =  east};
	case "guer": {_side =  resistance};
	case "civ": {_side =  civilian};
};

if (isnil "_side") exitWith {}; 
		
if (_action == 0 || _action == 1) then	//Garisson
{	
	if (_buildingscount < 1) exitwith {hint "No buildings found"};	//No available buildings? stop the script!
	if (_groupUnits) then {_group = creategroup _side}; 
	{
		_buildingPos = _x call MCC_fnc_buildingPosCount;
		if (_buildingPos > 0) then	
		{	//If the building have an interrior positions
			for [{_i=0},{_i<_buildingPos},{_i=_i+1}] do 
			{
				_spawnPos	= _x buildingPos _i; 
				
				//Let's roll the dice 
				if (random 10 < _intanse) then	
				{	
					//No other unit in the spawn position?
					if (count (nearestObjects [_spawnPos, ["Man"], 1])<1) then	
					{ 	
						_type = _unitsArray select round (random 4); 
						if !(_groupUnits) then {_group = creategroup _side}; 
						_unit = _group createUnit [_type select 0,_spawnPos,[],0.5,"NONE"];
						waituntil {alive _unit}; 
						_unit setpos _spawnPos;
						
						//Put it on safe
						_group setBehaviour "SAFE";
						_group setSpeedMode "LIMITED";
						
						_dir = round(random 360); 
						
						//Make them stand
						{
							_x setUnitPos "UP";
							_x setdir _dir;
						} foreach units _group;
						
						//Look somewhere randomly
						_group setFormDir _dir;
						
						_static = if (random 1 > 0.1) then {true} else {false};
						[_group, _static] spawn MCC_fnc_garrisonBehavior;
						
						//Curator
						MCC_curator addCuratorEditableObjects [[_unit],false];
						//_unit setVariable ["vehicleinit",";_this setpos (getpos_this);"];
						
					};
				}
			};
		};
	} foreach _buildingsArray;
};

if (_action == 1) then	{	//vehicles
	private ["_roadConnectedTo","_connectedRoad","_dir"];
	
	_vehiclesNumber=round((_buildingscount*_intanse)/6);
	if (_vehiclesNumber > 8) then {_vehiclesNumber = 8}; 
	
	_roads = _center nearRoads _radius;
	if (count _roads < 5) exitWith {}; 
	
	for "_i" from 1 to _vehiclesNumber do
	{        
		_road = _roads call BIS_fnc_selectRandom;
		_roads = _roads - [_road];
		
		_roadConnectedTo 	= roadsConnectedTo _road;
		_connectedRoad 		= _roadConnectedTo select 0;
		
		if (!isnil "_connectedRoad") then
		{
			_dir = [_road, _connectedRoad] call BIS_fnc_DirTo;
			if (isnil "_dir") then {_dir = getdir _road}; 
			_spawnPos = _road modelToWorld [5,0,0];
			
			//Make sure the vehicle is not in a wall on the road side
			_spawnPos = _spawnPos findEmptyPosition [0.1,10];
			
			_type = _vehiclesArray select (floor (random (_vehiclesCount)));
			_vehicle= (_type select 0) createVehicle _spawnPos;
			waituntil {alive _vehicle}; 
			
			_vehicle setpos _spawnPos;
			_vehicle setDir _dir;
			_vehicle setVehicleLock "LOCKED";
			
			//Curator
			MCC_curator addCuratorEditableObjects [[_vehicle],false];
		};
	};
};