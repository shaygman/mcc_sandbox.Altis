private ["_unit","_target","_vec","_posATL","_abx","_aby","_abz"];

_unit = _this select 0;
_target = _this select 1; if ((typeName _target) == "OBJECT") then {_target = (getPosATL _target)};

if (!(alive _unit)) exitWith {};

_posATL = getPosATL _unit;

_abx = (_target select 0) - (_posATL select 0);
_aby = (_target select 1) - (_posATL select 1);
_abz = (_target select 2) - (_posATL select 2);

_vec = [_abx, _aby, _abz];

// Main body of the function;

_unit doWatch objNull;
_unit doTarget objNull;	
sleep 0.2;
_unit setVectorDir _vec;
sleep 0.02;
_unit doWatch _target;

