//==================================================================MCC_fnc_createPlane===============================================================================================
// create a flying plane from the given type and return the plane , pilot and group.
// Example: _plane,_pilotGroup,_pilot = [_planeType,  _spawn, _pos, _flyHight, _captive] call MCC_fnc_createPlane;
// _planeType = string, vehicleClassName of the plane
// _spawn = position, position to spawn the plane
// _pos = position, waypoint for the plane
// _flyHight = integer, the fly hight for the plane
// _captive = boolean, true - to set the plane captive, false - for not.
//===========================================================================================================================================================================
private ["_planeType", "_spawn", "_pos", "_flyHight", "_captive", "_heading","_plane","_side","_planeArray","_vehicleClass"];

_planeType = _this select 0;
_spawn = _this select 1;
_pos = _this select 2;
_flyHight = param [3,300,[0]];
_captive = param [4,false,[false]];
_side = param [5,nil,[sideLogic,missionNamespace]];

_heading = 180;

//flying start direction
_heading = [_spawn, _pos] call BIS_fnc_dirTo;

//if ( _heading < 0 ) then { _heading = (_heading + 360); };

if (isNil "_side") then {
	_side =  [getNumber (configFile >> "CfgVehicles" >> _planeType >> "side")] call BIS_fnc_sideType;
};

_vehicleClass 	=  getText (configFile >> "CfgVehicles" >> _planeType >> "vehicleClass");
_spawn set [2,_flyHight];
//_planeArray = [_spawn, _heading, _planeType, _side] call bis_fnc_spawnvehicle;
//_plane = _planeArray select 0;

_plane = createVehicle [_planeType, _spawn, [], 0, "FLY"];
_plane setpos [(getPos _plane select 0),(getPos _plane select 1),_flyHight];
_plane setdir _heading;

createVehicleCrew _plane;

_plane flyInHeight _flyHight;
_plane setcaptive _captive;

//Give it more hight and velocity if we are spawning a jet

if !(_plane isKindOf "Helicopter") then {
	_plane setpos [(getPos _plane select 0),(getPos _plane select 1),(getPos _plane select 2)+100];
	private ["_vel","_dir","_speed"];
	_vel = velocity _plane;
	_dir = direction _plane;
	_speed = 10;
	//_plane setVelocity [(_vel select 0)+(sin _dir*_speed),(_vel select 1)+(cos _dir*_speed),45];
	_plane setVelocity [0,0,65];
};

_plane
