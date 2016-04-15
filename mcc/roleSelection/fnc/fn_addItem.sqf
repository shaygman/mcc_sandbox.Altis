//==================================================================MCC_fnc_addItem======================================================================================
// Sets gear to role
// Example: [_currentWeapon], "MCC_fnc_addItem", true, false] spawn BIS_fnc_MP;
//==============================================================================================================================================================================
private ["_currentWeapon","_mag","_index","_array"];
_currentWeapon = _this select 0;

_mag = (_currentWeapon select 1);
_index = if (typeName (_currentWeapon select 2) == typeName 0) then {_currentWeapon select 2} else {1};

if (_mag == "" || isNil "_index") exitWith {};



for "_i" from 1 to _index step 1 do {
	switch (true) do {
		case ((tolower (getText (configFile >> "CfgWeapons" >> _mag >> "simulation"))) in ["itemmap","itemcompass","itemwatch","itemradio","itemgps"]): {
			player linkItem _mag;
		};
		case ((tolower (getText (configFile >> "CfgWeapons" >> _mag >> "simulation"))) in ["binocular"]): {
			player addWeapon _mag;
		};
	    case (isClass (configFile >> "CfgMagazines" >> _mag)): {player addmagazine _mag};
	    case (isClass (configFile >> "CfgWeapons" >> _mag)): {player addItem _mag; if !(_mag in (weapons player + items player)) then {player addWeapon _mag}};
	    case (isClass (configFile >> "CfgGlasses" >> _mag)): {player additem _mag};
	};
};

//Add magazines
if (typeName (_currentWeapon select 2) == typeName []) exitWith {
	if (count (_currentWeapon select 2) == 2) then {
		_array = [0];
		_array = _array + (_currentWeapon select 2);
		[_array] call MCC_fnc_addItem
	};
};