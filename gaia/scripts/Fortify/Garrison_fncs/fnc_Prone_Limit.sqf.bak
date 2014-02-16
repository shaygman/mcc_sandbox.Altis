private ["_unit","_cansee","_cansee"];

_unit = _this select 0;

while {alive _unit} do
{
	_stance = stance _unit;
	
	if (_stance == "Prone") then
	{	
		_unit setUnitPos "Middle";
		
		_cansee = [_unit] call fnc_cansee;
		
		if (_cansee) exitWith {sleep 5; _unit setUnitPos "Auto";};
		
		_unit setUnitPos "Up";	
		
		sleep 5;
		_unit setUnitPos "Auto"
	};
	sleep 2;
};