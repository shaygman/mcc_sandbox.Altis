//==================================================================MCC_fnc_isDoor===============================================================================================
// is the player facing a door
// Example:[_object]  call MCC_fnc_isDoor;
// <IN>
//	_target:					Object- object.
//
// <OUT>
//		Boolean
//===========================================================================================================================================================================
private ["_object","_doorTypes","_loadName","_optionalDoors","_door","_typeOfSelected"];
_object = _this select 0;

if !(_object isKindof "house" || _object isKindof "wall") exitWith {""};

_doorTypes	= ["door", "hatch"];
_loadName	= "GEOM";

_optionalDoors = [_object, _loadName] intersect [asltoatl (eyepos player),(player modelToworld [0, 3, 0])];

_door = "";
{
	_typeOfSelected = _x select 0;
	{
		if ([_x,_typeOfSelected] call BIS_fnc_inString) exitWith {_door = _typeOfSelected};
	} foreach _doorTypes;

} forEach _optionalDoors;

_door