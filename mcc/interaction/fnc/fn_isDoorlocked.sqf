//==================================================================MCC_fnc_isDoorLocked=========================================================================================
// is the player facing a door
// Example:[_object]  call MCC_fnc_isDoorLocked;
// <IN>
//	_object:					Object- object.
//
// <OUT>
//		integer - 	0 - unknown door
//					1 - door locked
//					2 - door unlocked
//===========================================================================================================================================================================
private ["_object","_doorTypes","_loadName","_optionalDoors","_door","_typeOfSelected","_return"];
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

//If door is unlocked change the action to lock
_return = 0;
_return = (if (_object getVariable [format ["bis_disabled_%1_info",_door],false]) then {
				if ((_object getVariable [format ["bis_disabled_%1",_door],0])==0) then	{2} else {1};
			} else {0});

_return