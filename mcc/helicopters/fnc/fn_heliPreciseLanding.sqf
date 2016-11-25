/*==================================================================MCC_fnc_heliPreciseLanding=========================================================================================
	Uses velocity to land an helicopter to a precise location

	<IN>
		0:	OBJECT, the helicopter
		1:	ARRAY, position in ASL

	<OUT>
		NOTHING
==============================================================================================================================================================================*/
private ["_distance","_magnitude","_vel","_vehicle","_positionASL"];
_vehicle= param [0,objNull,[objNull]];
_positionASL = param [1,[0,0,0],[[]]];

if (isNull _vehicle || str _positionASL == "[0,0,0]") exitWith {};

_distance = ((getPosASL _vehicle) distance _positionASL);

while {alive _vehicle && alive driver _vehicle && canMove _vehicle && _distance > 5} do {

	_magnitude = 8;
	_distance = ((getPosASL _vehicle) distance _positionASL);
	if( _distance <= 10 ) then {
		_magnitude = (_distance / 10) * _magnitude;
	};

	_vel = velocity _vehicle;
	_vel = _vel vectorAdd (( (getPosASL _vehicle) vectorFromTo _positionASL ) vectorMultiply _magnitude);
	_vel = (vectorNormalized _vel) vectorMultiply ( (vectorMagnitude _vel) min _magnitude );
	_vehicle setVelocity _vel;

	sleep 0.05;
};
