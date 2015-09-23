private ["_unit","_index","_type","_pistol","_magazines","_ammoCount","_items"];
_unit =  _this select 0;
_index = _this select 2;
_type = _this select 3;

if (_unit getVariable["MCC_drawGunIsRuning",false]) exitwith {};
_unit setVariable["MCC_drawGunIsRuning",true];

//No handgun?
if (handgunWeapon _unit	== "") then {
	_unit setVariable ["MCC_undercoverGunHolstered",false];

	_pistol = _unit getvariable ["MCC_undercoverGunClass",""];
	_magazines = _unit getvariable ["MCC_undercoverMags",[]];
	_ammoCount = _unit getvariable ["MCC_undercoverAmmoCount",0];
	_items = _unit getvariable ["MCC_undercoverItems",[]];

	_unit addmagazine ((getArray (configFile >> "cfgWeapons" >> _pistol >> "magazines")) select 0);
	_unit addweapon _pistol;
	_unit setAmmo [_pistol, _ammoCount];

	{
		_unit addmagazine _x;
	} forEach _magazines;

	{
		_unit addItem _x;
	} forEach _items;

	_unit setVariable["MCC_drawGunIsRuning",false];
} else {
	//Holster
	_magazines = magazines _unit;
	_items = items _unit;

	_pistol = handgunWeapon _unit;
	_ammoCount = _unit ammo _pistol;

	_unit setvariable ["MCC_undercoverAmmoCount",_ammoCount];
	_unit setvariable ["MCC_undercoverGunClass",_pistol];
	_unit setvariable ["MCC_undercoverItems",_items];

	removeallweapons player;

	_unit setvariable ["MCC_undercoverMags",_magazines];
	_unit setVariable["MCC_drawGunIsRuning",false];
	_unit setVariable ["MCC_undercoverGunHolstered",true];
};