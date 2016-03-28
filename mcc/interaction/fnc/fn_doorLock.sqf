//==================================================================MCC_fnc_doorLock=========================================================================================
// lock door
// Example:[_object] spawn MCC_fnc_doorLock;
// <IN>
//	_object:					Object- object.
//
// <OUT>
//		<nothing>
//===========================================================================================================================================================================
private ["_object","_door","_str","_animation","_door","_typeOfSelected","_return","_n","_position","_c4"];
#define MCC_ARMA2MAPS ["takistan","zargabad","chernarus","utes"]

_object = _this select 0;

_door = [_object]  call MCC_fnc_isDoor;
if (_door == "") exitWith {};

if (tolower worldName in MCC_ARMA2MAPS) then {
	_str = [_door,"[01234567890]"] call BIS_fnc_filterString;
	_animation = "dvere"+_str;
} else {
	_animation = _door + "_rot";
};

closedialog 0;
["Locking",5] call MCC_fnc_interactProgress;
_object setVariable [format ["bis_disabled_%1",_door],1,true];