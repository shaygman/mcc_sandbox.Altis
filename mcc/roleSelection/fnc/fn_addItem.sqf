//==================================================================MCC_fnc_addItem======================================================================================
// Sets gear to role
// Example: [_currentWeapon], "MCC_fnc_addItem", true, false] spawn BIS_fnc_MP;
//==============================================================================================================================================================================
private ["_currentWeapon","_mag"];
_currentWeapon = _this select 0;

_mag = (_currentWeapon select 1);
if (typeName (_currentWeapon select 2) == typeName []) then {_currentWeapon set [2,1]};

if (_mag == "") exitWith {};
for [{_i = 0},{_i < (_currentWeapon select 2)},{_i = _i+1}] do {
	switch (true) do {
	    case (isClass (configFile >> "CfgMagazines" >> _mag)): {player addmagazine _mag};
	    case (isClass (configFile >> "CfgWeapons" >> _mag) && (_mag in ["ItemMap","ItemCompass","ItemWatch","ItemRadio","B_UavTerminal","ItemGPS"])): {player linkItem _mag};
	    case (isClass (configFile >> "CfgWeapons" >> _mag)): {player addWeapon _mag; if !(_mag in (weapons player + items player)) then {player additem _mag}};
	    case (isClass (configFile >> "CfgGlasses" >> _mag)): {player additem _mag};
	};
};