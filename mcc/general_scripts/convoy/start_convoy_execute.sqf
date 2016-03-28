private ["_markerArray", "_isvip", "_car1", "_convoyArray", "_marker", "_activewp", "_wp","_cargoNum","_fillSlots", "_pos", "_locGr", "_spawned","_unitsArray","_group","_type"];

_markerArray = _this select 0;
_isvip = _this select 1;

_convoyArray = missionNamespace getVariable ["MCC_convoyVehicles",[]];
_car1 = _convoyArray select 0;

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
waitUntil { sleep 5; ( !(alive _car1) || (currentCommand _car1 == "") || (_car1 distance _activewp) < 150) || !(alive driver _car1)};

//Stop WP
[2,_activewp,[0,"NO CHANGE","NO CHANGE","UNCHANGED","UNCHANGED","", {},0],[(group _car1)]] call MCC_fnc_manageWp;