private ["_markerArray", "_isvip", "_car1", "_car2","_car4","_car3", "_car5", "_convoyArray", "_marker", "_activewp", "_wp", "_count",
		"_noleader", "_cargoNum","_fillSlots", "_pos", "_locGr", "_spawned","_unitsArray","_group","_type", "_convoyGroupArray"];

diag_log str ["start_convoy_create", _this];		
		
_markerArray = _this select 0;
_isvip = _this select 1; 

_convoyArray = [];
_convoyGroupArray = [];

_car1 = car1 select 0; 
_convoyArray set [count _convoyArray, _car1]; 

if !( isNil "car2" ) then 
{
	_car2 = car2 select 0; 
	_convoyArray set [count _convoyArray, _car2]; 
};

if !( isNil "car3" ) then 
{ 
	if (_isvip=="0") then 
	{
		_car3 = car3 select 0;
	}
	else 
	{
		_car3 = car3;
	}; 
	_convoyArray set [count _convoyArray, _car3]; 
};

if !( isNil "car4" ) then 
{
	_car4 = car4 select 0; 
	_convoyArray set [count _convoyArray, _car4]; 
};

if !( isNil "car5" ) then 
{ 
	_car5 = car5 select 0; 
	_convoyArray set [count _convoyArray, _car5]; 
};


{

	//diag_log str ["empty_pos", typeOf _x, _x, _x emptyPositions "cargo"];

	_cargoNum = (_x emptyPositions "cargo") - 2; //populate convoy before kick off
	
	if (_cargoNum > 0) then	
	{
		//_fillSlots = round ( (random _cargoNum) max ((2 * _cargoNum)/3) );  // random but at least two-third of the empty seats
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
			
			While { true } do
			{
				
				if !( (count _convoyGroupArray) == 0 ) then
				{ 
					_group = [_locGr, side _x, (call compile (_convoyGroupArray select 0)),[],[],[0.1,MCC_AI_Skill],[],[_fillSlots, 0]] call MCC_fnc_spawnGroup;
					//diag_log str ["convoy default group", _cargoNum, _fillSlots, count units _group];	
					sleep 0.1;
				}
				else 
				{
					// no default groups found so let's build the faction custom unit's array				
					_unitsArray = [];
					
					{		
						_unitsArray	set [ count _unitsArray, _x select 0];  
					} foreach ( [faction _x,"soldier"] call MCC_fnc_makeUnitsArray );	

					//diag_log format ["MCC convoy custom array: %1", _unitsArray];	
					
					if !( (count _unitsArray) == 0 ) then 
					{
						_group = creategroup side _x;
						for [{_i=1},{_i<=8},{_i=_i+1}] do 
						{
							// select random type soldier - assuming pilots, divers etc are above type #5 in the array
							_type = _unitsArray select round (random (5 min (count _unitsArray-1))); 
							_unit = _group createUnit [_type, _locGr, [], 0.5, "NONE"];
							sleep 0.1;
						};
					};
					//diag_log str ["convoy custom group", _cargoNum, _fillSlots, count units _group];					
				};
				 
				{
					_x moveInCargo _spawned; 
				} forEach units _group;
				
				_fillSlots = _fillSlots - (count units _group);
				
				// if only 1 seat left do not create a 1 man group but leave seat empty
				if ( _fillSlots < 2 ) exitWith {}; 
			};
		};
	};
} foreach _convoyArray;
					
_count= 1;
_noleader = _convoyArray - [_car1];
//{[_convoyArray, _count, false]execVM MCC_path + "mcc\general_scripts\convoy\convoy_control.sqf"; _count = _count + 1} forEach _noleader;
for "_i" from 0 to ((count _markerArray) -1) do 
			{
				_activewp = (_markerArray select _i);
				_wp = (group _car1) addWaypoint [ _activewp, 30];
				_wp setWaypointType "MOVE";
				_wp setWaypointCompletionRadius 100;
				_wp setwaypointCombatMode "YELLOW";
				_wp setWaypointFormation "COLUMN";
				_wp setWaypointBehaviour "SAFE";
			};

// wait till convoy has arrived at final destination
waitUntil { sleep 5; ( !(alive _car1) || (currentCommand _car1 == "") ); };
	
// unload crew when arrived at final destination
sleep 3;

{
	if !( isNil "_x" ) then 
	{
		_car = _x;
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
					_x setBehaviour "AWARE";
					sleep 0.8;
				};
			} foreach crew _car;
		};
	};
} foreach _convoyArray;		

//diag_log str [time, "WP END status: ", currentWaypoint group (driver _car1), currentCommand _car2];
