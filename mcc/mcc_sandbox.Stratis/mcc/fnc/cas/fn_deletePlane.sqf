//==================================================================MCC_fnc_deletePlane===============================================================================================
// set a plane to move to a location and delete it once it come closer then 800 meters 
// Example: [_pilotGroup, _pilot, _plane, _away] call MCC_fnc_deletePlane;
// _pilotGroup = group, the plane's pilot group
// _pilot = unit, the plane's pilot
// _plane = unit, the plane
// _away = position, waypoint for the plane
//===========================================================================================================================================================================						
private ["_pilotGroup", "_pilot", "_plane", "_away", "_flyInHeight", "_x"];

_pilotGroup = _this select 0;
_pilot = _this select 1;
_plane = _this select 2;
_away = _this select 3;
_flyInHeight = _this select 4;
						
{ deleteWaypoint _x; } foreach waypoints (group _plane);
_plane setfuel 0.1;
_pilotGroup setSpeedMode "FULL";
_pilotGroup setCombatMode "BLUE";
_pilotGroup setBehaviour "CARELESS";
_plane disableAI "AUTOTARGET";
if (IsNil "_flyInHeight") then { _flyInHeight = 300; };
_plane flyInHeight _flyInHeight;

if (isnil "_away") then {_away = [100,100,100]};
_pilotGroup move _away;
_pilot domove _away;

// If plane is far away enough delete it			
waituntil {sleep 1;((_plane distance _away) < 800) || (!alive _plane);};

if (alive _plane) then {
	{deleteVehicle _x} forEach crew _plane + [_plane];
};
