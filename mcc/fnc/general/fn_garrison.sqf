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

private ["_center","_radius","_spawnVehicles","_intanse","_faction","_unitsArray","_vehiclesArray","_SpawnUnit","_SpawnVehicle","_group","_unitsCount","_vehiclesCount","_buildingsArray","_buildingscount","_side","_spawnBuilding","_spawnPos","_unit","_type","_vehiclesNumber","_roads","_road","_vehicle","_vehicleClass","_groupUnits","_static","_locked","_roadPos"];

disableSerialization;

_center			= [_this, 0, []] call BIS_fnc_param;
_radius			= [_this, 1, 100] call BIS_fnc_param;
_spawnVehicles 	= if (typeName (_this select 2) == typeName 0) then {(_this select 2)==1} else {_this select 2};
_intanse		= [_this, 3, 5] call BIS_fnc_param;
_faction		= [_this, 4, "CIV_F"] call BIS_fnc_param;
_side			= [_this, 5, civilian] call BIS_fnc_param;
_groupUnits 	= [_this, 6, false] call BIS_fnc_param;
_locked			= [_this, 7, false] call BIS_fnc_param;

_unitsArray 	= [_faction,"soldier","men"] call MCC_fnc_makeUnitsArray;		//Let's build the faction unit's array
if(count _unitsArray < 4) then {
	_unitsArray = [_faction,"soldier"] call MCC_fnc_makeUnitsArray;
};

_vehiclesArray	= [_faction,"carx","car"] call MCC_fnc_makeUnitsArray;		//Let's build the faction vehicles's array
if(count _vehiclesArray < 4) then {
	_vehiclesArray = [_faction,"carx"] call MCC_fnc_makeUnitsArray;
};

_buildingsArray	= nearestObjects  [_center,["House","Ruins","Church","FuelStation","Strategic"],_radius];	//Let's find the buildings in the area

_unitsCount		= count _unitsArray;
_vehiclesCount	= count _vehiclesArray;
_buildingscount	= count _buildingsArray;


if (typeName _side == "STRING") then {
	switch (toLower _side) do
	{
		case "west": {_side =  west};
		case "east": {_side =  east};
		case "guer": {_side =  resistance};
		case "civ": {_side =  civilian};
	};
};

if (isnil "_side") exitWith {};

if (_buildingscount < 1) exitwith {hint "No buildings found"};	//No available buildings? stop the script!
{
	_buildingPos = _x call MCC_fnc_buildingPosCount;
	if (_buildingPos > 0) then
	{	//If the building have an interrior positions
		if (_groupUnits) then {_group = creategroup _side};

		for [{_i=0},{_i<_buildingPos},{_i=_i+1}] do
		{
			_spawnPos	= _x buildingPos _i;

			//Let's roll the dice
			if (random 30 < _intanse) then {
				//No other unit in the spawn position?
				if (count (nearestObjects [_spawnPos, ["Man"], 1])<1) then {
					_type = _unitsArray select round (random 4);
					if !(_groupUnits) then {_group = creategroup _side};
					_unit = _group createUnit [_type select 0,_spawnPos,[],0.5,"NONE"];
					waituntil {alive _unit};
					_unit setpos _spawnPos;

					//Put it on safe
					_group setBehaviour "SAFE";
					//_group setSpeedMode "LIMITED";

					//Lets make a happy walker
					if (random 1 < 0.2) then {
						[_group,_radius] spawn MCC_fnc_garrisonBehavior;
					} else {
						//Make them stand
						{
							_x setUnitPos "UP";
							_x setdir round(random 360);
						} foreach units _group;

					};

					//Cache
					_group setVariable ["mcc_gaia_cache",mcc_caching];

					//Curator
					{_x addCuratorEditableObjects [[_unit],false]} forEach allCurators;
					//_unit setVariable ["vehicleinit",";_this setpos (getpos_this);"];

				};
			}
		};
	};
} foreach _buildingsArray;

//vehicles
if (_spawnVehicles) then	{
	private ["_roadConnectedTo","_connectedRoad","_dir"];

	_vehiclesNumber=round((_buildingscount*_intanse)/12);
	if (_vehiclesNumber > 8) then {_vehiclesNumber = 8};

	_roads = _center nearRoads _radius;
	if (count _roads < 5) exitWith {};

	for "_i" from 1 to _vehiclesNumber do {
		if (count _roads <= 0) exitWith {};

		_road = _roads call BIS_fnc_selectRandom;
		_roads = _roads - [_road];

		_roadConnectedTo 	= roadsConnectedTo _road;
		_connectedRoad 		= _roadConnectedTo select 0;

		if (!isnil "_connectedRoad") then {
			_dir = [_road, _connectedRoad] call BIS_fnc_DirTo;
			if (isnil "_dir") then {_dir = getdir _road};
			_roadPos = if (random 1 > 0.5) then {_road modelToWorld [6,0,0]} else {_road modelToWorld [-6,0,0]};

			//Why the hell we have karts in a milsim?!
			_type = "";
			while {_type in ["","C_Kart_01_Blu_F","C_Kart_01_F","C_Kart_01_F_Base","C_Kart_01_Fuel_F","C_Kart_01_Red_F","C_Kart_01_Vrana_F"]} do {
				_type = (_vehiclesArray select (floor (random (_vehiclesCount)))) select 0;
				sleep 0.1;
			};

			_spawnPos = [];
			_radius = 5;
			//Make sure the vehicle is not in a wall on the road side
			while {_spawnPos isEqualTo []} do {
				_spawnPos = _roadPos findEmptyPosition [0.1,_radius, _type];
				_radius = _radius +5;
				sleep 0.1;
			};

			_vehicle= _type createVehicle _spawnPos;
			waituntil {alive _vehicle};
			_vehicle allowDamage false;
			_vehicle setpos _spawnPos;
			_vehicle setDir _dir;

			if (_locked || random 1 > 0.5) then {
				_vehicle setVehicleLock "LOCKED";
			};

			sleep 0.1;

			if (!isTouchingGround _vehicle || !alive _vehicle) then {
				deleteVehicle _vehicle;
			} else {
				_vehicle allowDamage true;

				//Curator
				{_x addCuratorEditableObjects [[_vehicle],false]} forEach allCurators;
			};
		};
	};
};