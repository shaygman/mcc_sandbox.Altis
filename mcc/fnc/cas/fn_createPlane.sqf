//==================================================================MCC_fnc_createPlane===============================================================================================
// create a flying plane from the given type and return the plane , pilot and group.
// Example: _plane,_pilotGroup,_pilot = [_planeType,  _spawn, _pos, _flyHight, _captive] call MCC_fnc_createPlane;
// _planeType = string, vehicleClassName of the plane
// _spawn = position, position to spawn the plane
// _pos = position, waypoint for the plane
// _flyHight = integer, the fly hight for the plane
// _captive = boolean, true - to set the plane captive, false - for not. 
//===========================================================================================================================================================================			
private ["_i","_planeType", "_spawn", "_pos", "_flyHight", "_captive", "_pilotType","_pilotGroup",
		 "_turrets", "_heading", "_entry","_path","_unit","_plane","_side","_planeArray","_safepos","_vehicleClass"];

_planeType = _this select 0;
_spawn = _this select 1;
_pos = _this select 2;
_flyHight = _this select 3; //integer e.g. 100
_captive = _this select 4; //true or false

_heading = 180;

_heading = [_spawn, _pos] call BIS_fnc_dirTo; //flying start direction
if ( _heading < 0 ) then { _heading = (_heading + 360); };

if ( count _this > 5 ) then 
{
	_side = _this select 5; 
}
else
{ 
	_side =  getNumber (configFile >> "CfgVehicles" >> _planeType >> "side");
	
	switch (_side) do	
	{
		case 0:					//east
		{ 
			_side = east;
		};
		
		case 1:					//west
		{ 
			_side = west;
		};
		
		case 2:					//GUR
		{ 
			_side = resistance;
		};
		
		case 3:					//Civilian
		{ 
			_side = civilian;
		};
	};
};

_vehicleClass 	=  getText (configFile >> "CfgVehicles" >> _planeType >> "vehicleClass");

if (IsNil "_flyHight") then { _flyHight = 300};
_safepos     =[_spawn ,1,100,2,1,10,0,[],[[-500,-500,0],[-500,-500,0]]] call BIS_fnc_findSafePos;
_planeArray = [[_safepos select 0,_safepos select 1, _flyHight], _heading, _planeType, _side] call bis_fnc_spawnvehicle;

_plane = _planeArray select 0;

_plane flyInHeight _flyHight;
			
if (IsNil "_captive") then { _captive = false; };
_plane setcaptive _captive;

//If autonomous
if (_vehicleClass == "autonomous") then 
{
	createVehicleCrew _plane;
};

//Give it more hight and velocity if we are spawning a jet
if !(_plane isKindOf "Helicopter") then	
{
	_plane setpos [(getPos _plane select 0),(getPos _plane select 1),(getPos _plane select 2)+500];
	private ["_vel","_dir","_speed"];
	_vel = velocity _plane;
	_dir = direction _plane;
	_speed = 10; 
	_plane setVelocity [(_vel select 0)+(sin _dir*_speed),(_vel select 1)+(cos _dir*_speed),(_vel select 2)];
	// set marker on map
	[_plane, "B_AIR", _planeType, "ColorBlack", 99] execVM MCC_path + "mcc\general_scripts\cas\cas_marker.sqf";
};

_plane
