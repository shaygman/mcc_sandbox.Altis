private ["_markerArray", "_isvip", "_car1", "_car2","_car4","_car3", "_car5", "_convoyArray", "_marker", "_activewp", "_wp", 
		 "_cargoNum","_fillSlots", "_pos", "_locGr", "_spawned","_unitsArray","_group","_type"];

_markerArray = _this select 0;
_isvip = _this select 1; 

_convoyArray = [];

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

//Fill the cars
{
	[_x]  call MCC_fnc_populateVehicle;
} foreach _convoyArray;
					
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
waitUntil { sleep 5; ( !(alive _car1) || (currentCommand _car1 == "") || (_car1 distance _activewp) < 150); };

//Stop WP
[2,_activewp,[0,"NO CHANGE","NO CHANGE","UNCHANGED","UNCHANGED","", {},0],[(group _car1)]] call MCC_fnc_manageWp;