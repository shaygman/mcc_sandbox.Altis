//==================================================================MCC_fnc_doorLock=========================================================================================
// lock door
// Example:[_object] spawn MCC_fnc_doorLock;
// <IN>
//	_object:					Object- object.
//
// <OUT>
//		<nothing>
//===========================================================================================================================================================================
private ["_object","_str","_typeOfSelected","_return","_n","_position","_c4"];

_object = _this select 0;

private ["_door","_animation","_phase","_closed","_tempArray"];
_tempArray = [_object]  call MCC_fnc_isDoor;
_door = _tempArray select 0;
_animation = _tempArray select 1;
_phase = _tempArray select 2;
_closed = _tempArray select 3;

if (_door == "") exitWith {};

closedialog 0;
["Locking",5] call MCC_fnc_interactProgress;
_object setVariable [format ["bis_disabled_%1",_door],1,true];