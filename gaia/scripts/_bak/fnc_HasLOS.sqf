// fnc_HasLOS.sqf
// usage: [<unit>,<target>,(<range>,<fov>)] call FLAY_fnc_knowsAbout;
// returns true if <unit> can see <target> and <target> is less than <range> meters from <unit>, otherwise returns false.

private ["_unit", "_target", "_range", "_fov", "_inView", "_inSight", "_inRange", "_knowsAbout"];

_unit = [_this,0] call BIS_fnc_param; 
_target = [_this,1] call BIS_fnc_param; 
_range = [_this,2,100,[0]] call BIS_fnc_param; 
_fov = [_this,3,130,[0]] call BIS_fnc_param; 

_knowsAbout = false;
_inRange = (_unit distance _target) < _range; 
if (_inRange) then {
    _inView = [position _unit, getdir _unit, _fov, position _target] call BIS_fnc_inAngleSector; 
    _inSight = count (lineIntersectsWith [eyePos _unit, eyepos _target, _unit, _target]) == 0; 
    _knowsAbout = _inView && _inSight;
};
_knowsAbout;  