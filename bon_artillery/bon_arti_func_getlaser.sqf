//by Bon_Inf*
/** returns the laser target the _unit is lasering at, or ObjNull if it does not exist **/

private ["_xpos","_ypos","_myLaserTarget","_lasertargets","_dir","_distance","_min","_target","_targetpos","_targetdistance","_aimpos"];
_unit = _this;
_threshold = 100;

_lasertargets = nearestObjects[_unit,["LaserTarget"],2000];
if(count _lasertargets == 0) exitWith{ObjNull};

_xpos = getPos _unit select 0;
_ypos = getPos _unit select 1;

_myLaserTarget = ObjNull;

_dir = getDir _unit;
//_dir = _unit weaponDirection "Laserdesignator";
//_dir = (_dir select 0) atan2 (_dir select 1);		// get direction of the lasermarker aiming at

_distance = _threshold * 2;
_min = _threshold * 2;

for "_i" from 0 to (count _lasertargets - 1) do
{
	_target = _lasertargets select _i;
	_targetpos = [getPos _target select 0,getPos _target select 1,0];

	_targetdistance = _targetpos distance [getPos _unit select 0, getPos _unit select 1, 0];

	_aimpos = [_xpos + _targetdistance*sin(_dir), _ypos + _targetdistance*cos(_dir),0];

	if((_targetpos distance _aimpos)<_min) then{
		_myLaserTarget=_target;
		_min = _targetpos distance _aimpos;
	};
};

if(_min > _threshold) then{_myLaserTarget = ObjNull};

_myLaserTarget