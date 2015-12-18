/*===================================================================MCC_fnc_fastRopeLocal======================================================================================
	handles fast rope on clients
	<IN>
		_this select 0 - unit
		_this select 1 - rope
*/
private ["_unit","_rope","_vehicle","_time","_zdelta","_zc"];
_unit = param [0,objNull,[objNull,missionNamespace]];
_rope = param [1,objNull,[objNull,missionNamespace]];
_zdelta = 7 / 10;
_zc = -4;

//Not local exit
if (isNull _unit || isNull _rope || !local _unit) exitWith {};
_vehicle = vehicle _unit;

//get out of the vehicle
//_unit action ["GETOUT", vehicle _unit];
_unit action ["Eject",_vehicle];
unassignVehicle _unit;
moveOut _unit;

//start the slide
_time = time + 5;
waituntil {(vehicle _unit == _unit) || _time < time};
if (_time < time) exitWith {};
_unit setpos [(getpos _unit select 0), (getpos _unit select 1), 0 max ((getpos _unit select 2) - 3)];
_unit switchMove "LadderRifleStatic";

_unit allowDamage false;
while { (alive _unit) && ( (getpos _unit select 2) > 0.3 ) && ( _zc > -55 ) } do {
	_unit attachTo [_rope, [0,0,_zc]];
	_zc = _zc - _zdelta;
	sleep 0.1;
};
detach _unit;

_unit playMove "LadderRifleDownOff";
_unit allowDamage true;
