/*=============================================================MCC_fnc_addVelocity=========================================================================================
	adds velocity to object depends on its current velocity and with relation to center - create a shockwave
	 <IN>
		0: Object: OBJECT
		1: velocity:INTEGER - added velocity
		2: levitation:INTEGER - added Upword velocity
		3: center: OBJECT/POSITION - (optional) can be the center of velocity to simulate a shock wave - objnull for none


		EXAMPLE:
		[player,10,10] call MCC_fnc_addVelocity

	<OUT>
		Nothing
//======================================================================================================================================================================*/

params [["_object", objNull, [objNull]],
		["_speed", 0, [0]],
		["_levitation", 0, [0]],
		["_center", objNull, [objNull,[]]]
	   ];

if (isNull _object) exitWith {diag_log "MCC Error: MCC_fnc_addVelocity - invalid object"};
if (!local _object) exitWith  {diag_log "MCC Error: MCC_fnc_addVelocity - Object isn't local"};

private ["_vel","_dir"];
_object = vehicle _object;
_vel = velocity _object;

if (_center isEqualType objNull) then {
	_dir = if (isNull _center) then {direction _object} else {_center getDir _object};
} else {
	_dir = _center getDir _object;
};


_object setVelocity [
	(_vel select 0) + (sin _dir * _speed),
	(_vel select 1) + (cos _dir * _speed),
	(_vel select 2) + _levitation
];