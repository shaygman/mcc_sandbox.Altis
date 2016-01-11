//==================================================================MCC_fnc_playerStats=========================================================================================
//==============================================================================================================================================================================
//Gear stats
private ["_display","_armor","_weight","_load","_role","_oldLevel","_html","_item"];
_display = _this select 0;

_role = player getvariable ["CP_role",""];
_oldLevel = call compile format  ["%1Level select 0",_role];
_html = "<t color='#818960' size='0.8' shadow='1' align='center' underline='false'>"+ _role+ " Level " + str _oldLevel + "</t>";
(_display displayCtrl 102) ctrlSetStructuredText parseText _html;

_armor = 0;
{
	_item = _x;
	{
		_armor = _armor + ((getNumber (configfile >> "CfgWeapons" >> _item >> "ItemInfo" >> "HitpointsProtectionInfo" >> _x >> "armor"))* (getNumber (configfile >> "CfgWeapons" >> _item >> "ItemInfo" >> "HitpointsProtectionInfo" >> _x >> "passThrough")));
	} forEach ["Head","Abdomen","Body","Chest","Diaphragm","Neck","Face","Pelvis","Arms","Hands","Legs"];
} forEach [vest player,headgear player];

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

(_display displayCtrl 201) progressSetPosition ((_armor/30) min 1);
(_display displayCtrl 202) progressSetPosition ((_load/320) min 1);
(_display displayCtrl 203) progressSetPosition ((_weight/500) min 1);