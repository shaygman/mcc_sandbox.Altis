//==================================================================MCC_fnc_playerStats=========================================================================================
//==============================================================================================================================================================================
//Gear stats
private ["_display","_armor","_weight","_load"];
_display = _this select 0;
_ctrl = _display displayCtrl 200;

_armor = 0;
{
	_armor = _armor + ((getNumber (configfile >> "CfgWeapons" >> _x >> "ItemInfo" >> "armor"))* (getNumber (configfile >> "CfgWeapons" >> _x >> "ItemInfo" >> "passThrough")));
} forEach [vest player];

_weight = 0;
{
	_weight = _weight + (getNumber (configfile >> "CfgWeapons" >> _x >> "ItemInfo" >> "mass"));
} forEach ([uniform player, vest player, headgear player,primaryWeapon player,secondaryWeapon player, handgunWeapon player])+items player;

_load = 0;
{
	_load = _load + (getNumber (configfile >> "CfgVehicles" >> _x >> "maximumLoad"));
	_weight = _weight + (getNumber (configfile >> "CfgVehicles" >> _x >> "mass"));
} forEach [Backpack player];

{
	_weight = _weight + (getNumber (configfile >> "CfgMagazines" >> _x >> "mass"));
} forEach (magazines player);

(_display displayCtrl 201) progressSetPosition (_armor/120);
(_display displayCtrl 202) progressSetPosition (_load/320);
(_display displayCtrl 203) progressSetPosition (_weight/500);