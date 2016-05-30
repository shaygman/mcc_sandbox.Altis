//==================================================================MCC_fnc_addWeapon======================================================================================
// Sets gear to role
// Example: [_currentWeapon], "MCC_fnc_addWeapon", true, false] spawn BIS_fnc_MP;
//==============================================================================================================================================================================
private ["_magazines","_currentWeapon","_mag","_unit"];
_currentWeapon = _this select 0;
_unit = param [1,player];

_magazines = (_currentWeapon select 2);
for [{_i = 0},{_i < count _magazines},{_i = _i+2}] do {
	_mag = _magazines select _i;
	for [{_x = 0},{_x < (_magazines select (_i+1))},{_x = _x+1}] do
		{
			if (isClass (configFile >> "CfgMagazines" >> _mag)) then {_unit addmagazine _mag};
			if (isClass (configFile >> "CfgWeapons" >> _mag)) then {_unit additem _mag};
			if (isClass (configFile >> "CfgGlasses" >> _mag)) then {_unit additem _mag};
		};
};

if ((_currentWeapon select 1) != "") then {_unit addWeapon (_currentWeapon select 1)};