//==================================================================MCC_fnc_reinforcement===============================================================================================
//Contorol the paratroop reinforcement spawn
// Example:[_endPos,_side,_size,_zoneMarker,_faction,_startPosDir] spawn MCC_fnc_reinforcement;
// <IN>
//	_endPos:					Array- position.
//	_side:					String or side, side to call "West","East","Resistance"
//	_size:					Integer, 	0 -"small
//								1 - medium
//								2 - large
//	_zoneMarker				String, Zone number the reinforcement's cargo will patrol that zone. 
//	_faction					String, Faction name. 
//	_startPosDir				Array, spawn and de-spawn location for the reinforcement. 
//===========================================================================================================================================================================	
private ["_unitsArray","_endPos","_side","_size","_zoneMarker","_faction","_startPosDir","_vehiclesArray","_groupVehicles","_limit",
         "_counter","_vehicleClass","_nearRoads","_vehicle","_vehiclesTypesArray"];
_endPos 				= _this select 0;
_side					= _this select 1;
_size 					=  if (TypeName  (_this select 2) == "STRING") then {call compile (_this select 2)} else {(_this select 2)};
_zoneMarker 			=  if (TypeName  (_this select 3) == "STRING") then {(_this select 3)} else {str (_this select 3)};
_faction				= _this select 4;
_startPosDir			= _this select 5;

//player sidechat "Zone: " + _zoneMarker;
if (TypeName _side == "STRING") then
{
	switch (toUpper _side) do 
	{
		case "WEST": {_side = west};
		case "EAST": {_side = east};
		case "GUER": {_side = resistance};
		case "CIV": {_side = civilian};
	};
};

_unitsArray 	= [_faction,"soldier","men"] call MCC_fnc_makeUnitsArray;
if(count _unitsArray < 4) then 
{
	_unitsArray = [_faction,"soldier"] call MCC_fnc_makeUnitsArray;
}; 

if ( (count _unitsArray) == 0 ) exitWith { diag_log format ["MCC Warning: no suitable reinforcement group found for %1", _this]; player groupChat format ["Error: no suitable reinforcement group for this Faction"]; };

_vehiclesTypesArray 	= [_faction,"carx","car"] call MCC_fnc_makeUnitsArray;
if(count _vehiclesTypesArray < 2) then 
{
	_vehiclesTypesArray = [_faction,"carx"] call MCC_fnc_makeUnitsArray;
}; 

if ( (count _vehiclesTypesArray) == 0 ) exitWith { diag_log format ["MCC Warning: no suitable reinforcement group found for %1", _this]; player groupChat format ["Error: no suitable reinforcement group for this Faction"]; };

//Find a road
_nearRoads = ([_startPosDir,500] call MCC_fnc_nearestRoad) select 0; 
if ( isnull _nearRoads) exitWith { diag_log format ["MCC Warning: no suitable reinforcement place found for %1", _this]; player groupChat format ["Error: no suitable reinforcement place found"]; };
_startPosDir = getposAtl _nearRoads; 

//Let's build the group and vehicles 
_groupVehicles = creategroup _side;

_size = _size - 9; 
_limit = [2,3,4] select _size;
_counter = 1;
_vehiclesArray = []; 

while {_counter <=_limit} do 
{
	_vehicleClass = (_vehiclesTypesArray call BIS_fnc_selectRandom) select 0;
	if ((getNumber (configfile >> "CfgVehicles" >> _vehicleClass >> "transportSoldier") > 2) || (count (configfile >> "CfgVehicles" >> _vehicleClass >> "Turrets") >0)) then
	{
		_isFlat = _startPosDir findEmptyPosition [10, 100];
		if (count _isFlat == 0) then {_isFlat = _startPosDir}; 
		_vehicle = [_isFlat , ([_isFlat, _endPos] call BIS_fnc_dirTo), _vehicleClass, _groupVehicles] call BIS_fnc_spawnVehicle;
		_vehiclesArray set [count _vehiclesArray, (_vehicle select 0)];
		_counter = _counter + 1; 
		
		//Curator
		MCC_curator addCuratorEditableObjects [[(_vehicle select 0)],true];
	};
};

sleep 0.5;
_groupVehicles setFormation "COLUMN";	

private ["_convoyGroupArray","_cargoyGroupArray","_cargoNum","_fillSlots","_pos","_spawned","_locGr","_time","_group","_unitsArray","_type","_unit"]; 
_convoyGroupArray = []; 
_cargoyGroupArray = []; 

{
	_cargoNum = (_x emptyPositions "cargo")-2; //populate convoy before kick off
	
	if (_cargoNum > 0) then	
	{
		_fillSlots = _cargoNum - (round random (_cargoNum/4));  // random but at least majority of seats occupied
		_pos = getPosATL _x;
		_spawned = _x;
		_locGr =  _pos findEmptyPosition [10, 100];
		sleep 0.1;
		if (_locGr select 0 > 0)then 
		{
			// Check if default group config is available
			// get group configs
			{
				if ( ((_x select 3) == "Rifle Squad") || ((_x select 3) == "Recon Team") ) then 
				{ 
					_convoyGroupArray set [count _convoyGroupArray, format ["%1", ( _x select 2)]];
				};
			} forEach ([side _x,faction _x,"Infantry","LAND"] call mcc_make_array_grps);
			
			_time = time + 10; 
			While { true && time < _time} do
			{
				
				if !( (count _convoyGroupArray) == 0 ) then
				{ 
					_group = [_locGr, side _x, (call compile (_convoyGroupArray select 0)),[],[],[0.1,MCC_AI_Skill],[],[_fillSlots, 0]] call MCC_fnc_spawnGroup;
					sleep 0.1;
				}
				else 
				{
					// no default groups found so let's build the faction custom unit's array				
					_unitsArray = [];
					
					{		
						_unitsArray	set [ count _unitsArray, _x select 0];  
					} foreach ( [faction _x,"soldier"] call MCC_fnc_makeUnitsArray );	

					if !( (count _unitsArray) == 0 ) then 
					{
						_group = creategroup side _x;
						for [{_i=1},{_i<=_fillSlots},{_i=_i+1}] do 
						{
							// select random type soldier - assuming pilots, divers etc are above type #5 in the array
							_type = _unitsArray select round (random (5 min (count _unitsArray-1))); 
							_unit = _group createUnit [_type, _locGr, [], 0.5, "NONE"];
							sleep 0.1;
							
							//Curator
							MCC_curator addCuratorEditableObjects [[_unit],false];
						};
					};
				};
				 
				{
					_x moveInCargo _spawned; 
				} forEach units _group;
				_cargoyGroupArray set [count _cargoyGroupArray, _group];
				_fillSlots = _fillSlots - (count units _group);
				
				// if only 1 seat left do not create a 1 man group but leave seat empty
				if ( _fillSlots < 2 ) exitWith {}; 
			};
		};
	};
} foreach _vehiclesArray;

sleep 1;


//Find a road near destination
_nearRoads = ([_endPos,500] call MCC_fnc_nearestRoad) call BIS_fnc_selectRandom; 

//Add WP
private ["_wpPos","_car1","_car","_transportCars","_transportCarsGroup"];
if (isnull  _nearRoads) then 
{
	_wpPos = _endPos;
}
else
{
	_wpPos = getposAtl _nearRoads;
};

_wp = _groupVehicles addWaypoint [_wpPos, 30];
_wp setWaypointType "MOVE";
_wp setWaypointCompletionRadius 500;
_wp setwaypointCombatMode "YELLOW";
_wp setWaypointFormation "COLUMN";
_wp setWaypointBehaviour "SAFE";
_wp setWaypointSpeed "FULL";

_car1 = vehicle leader _groupVehicles;
waitUntil {sleep 5; (!(canMove _car1) || (currentCommand _car1 == "") || (_car1 distance _wpPos) < 50); };
sleep 3;

_transportCars = [];
_transportCarsGroup = createGroup _side; 

{
	if !( isNil "_x" ) then 
	{
		_car = _x;
		//If transport car
		if ((count (configfile >> "CfgVehicles" >> typeOF _car >> "Turrets")  == 0)) then
		{
			_transportCars set [count _transportCars, _car];
			[_car] joinSilent _transportCarsGroup;
		};
		
		[_car] spawn 
		{ 
			private ["_car"];
			_car = _this select 0;
			waitUntil { (currentCommand _car == "") };
			{
				if ( !( (_x == driver _car) || (_x == gunner _car) || (_x == commander _car) ) && ( alive _x ) ) then 
				{
					unassignVehicle _x;
					_x action ["getOut", _car];
					sleep 0.6;
				};
			} foreach crew _car;
		};
	};
} foreach _vehiclesArray;	

_vehiclesArray = _vehiclesArray - _transportCars;

{
	_x setVariable ["GAIA_ZONE_INTEND",[_zoneMarker,"MOVE"], true];
} foreach _cargoyGroupArray; 

sleep 10; 

_groupVehicles setVariable ["GAIA_ZONE_INTEND",[_zoneMarker,"MOVE"], true];
_transportCarsGroup setVariable ["GAIA_ZONE_INTEND",[_zoneMarker,"MOVE"], true];