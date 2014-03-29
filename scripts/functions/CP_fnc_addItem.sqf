//==================================================================CP_fnc_addItem======================================================================================
// Sets gear to role
// Example: [_currentWeapon], "CP_fnc_addItem", true, false] spawn BIS_fnc_MP;
//==============================================================================================================================================================================	
private ["_currentWeapon","_mag"];
_currentWeapon = _this select 0;

_mag = (_currentWeapon select 1); 
if (_mag == "") exitWith {}; 
for [{_i = 0},{_i < (_currentWeapon select 2)},{_i = _i+1}] do 
	{
		if (isClass (configFile >> "CfgMagazines" >> _mag)) then {player addmagazine _mag};
		if (isClass (configFile >> "CfgWeapons" >> _mag)) then {player additem _mag};
		if (isClass (configFile >> "CfgWeapons" >> _mag) && (_mag in ["ItemMap","ItemCompass","ItemWatch","ItemRadio","B_UavTerminal","MCC_Console","ItemGPS"])) then {player assignItem _mag};
		if (isClass (configFile >> "CfgGlasses" >> _mag)) then {player additem _mag};
	};