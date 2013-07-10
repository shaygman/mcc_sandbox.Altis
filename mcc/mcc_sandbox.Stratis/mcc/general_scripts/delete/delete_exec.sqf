private ["_pos","_radius","_type","_nearObjects"];

_pos = _this select 0;
_radius = _this select 1;
_type =  MCC_deleteTypes select (_this select 2); 

if (_type == "All") then {
	_nearObjects = [_pos select 0, _pos select 1, 0] nearObjects _radius;
	} else	{
		_nearObjects = [_pos select 0, _pos select 1, 0] nearObjects [_type, _radius];
		};
{deleteVehicle _x} foreach _nearObjects; 


 
 

