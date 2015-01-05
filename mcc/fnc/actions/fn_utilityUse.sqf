//==================================================================MCC_fnc_utilityUse===============================================================================================
//use utility
// Example: [] call MCC_fnc_utilityUse;
//===========================================================================================================================================================================
private ["_utility","_vel","_dir","_handPos","_item","_mag","_itemClass","_charges","_cfg","_putCfg","_putCfgArray","_putCfgName","_magMuzzle"];
_primaryMod = _this select 0;
_mag 		= (player getVariable ["MCC_utilityItem",["",""]]) select 0;
_itemClass	= (player getVariable ["MCC_utilityItem",["",""]]) select 1;

if (_mag == "" && _primaryMod) exitWith {};

if (!_primaryMod) exitWith
{
	_charges = player getVariable ["MCC_utilityActiveCharges",[]];
	if (count _charges > 0 ) then
	{
		_utility = _charges select 0;
		_charges set [0,-1];
		_charges = _charges - [-1];
		_utility setdamage 1;
		player setVariable ["MCC_utilityActiveCharges",_charges];
	};
};

player removeMagazine _mag;
player playactionNow "putdown";
sleep 0.3;
_handPos = player selectionPosition "LeftHand";
_utility = _itemClass createvehicle (player modelToWorld [(_handPos select 0),(_handPos select 1)+1.8,(_handPos select 2)]);
_utility setpos (player modelToWorld [(_handPos select 0),(_handPos select 1)+1,0]);
_utility setdir getdir player;

if !(_mag in magazines player) then
{
	player setVariable ["MCC_utilityItem",["",""]];
	[5] call MCC_fnc_weaponSelect;
};

if (_itemClass in ["DemoCharge_Remote_Ammo_Scripted","SatchelCharge_Remote_Ammo_Scripted","IEDUrbanBig_Remote_Ammo","IEDLandBig_Remote_Ammo",
			"ATMine_Range_Ammo","APERSMine_Range_Ammo","APERSBoundingMine_Range_Ammo","SLAMDirectionalMine_Wire_Ammo","APERSTripMine_Wire_Ammo",
			"ClaymoreDirectionalMine_Remote_Ammo_Scripted","IEDUrbanSmall_Remote_Ammo","IEDLandSmall_Remote_Ammo"]) then
{
	_charges = player getVariable ["MCC_utilityActiveCharges",[]];
	_charges pushback _utility;
	player setVariable ["MCC_utilityActiveCharges",_charges];
};

if (_itemClass == "MCC_ammoBox") then
{
	[_utility, "Hold %1 to resupply"] spawn MCC_fnc_createHelper;
	_utility spawn
	{
		private ["_t"];
		_t = time + 600;
		while {alive _this && time < _t} do {sleep 5};
		if (alive _this) exitWith {deleteVehicle _this};
	};
};

/*
_vel = velocity player;
_dir = direction player;

_utility setVelocity [
	(_vel select 0) + (sin _dir * _speed),
	(_vel select 1) + (cos _dir * _speed),
	_speed
];

private ["_cfg","_putCfg","_putCfgArray","_putCfgName","_magMuzzle"];
_cfg = (configfile >> "CfgWeapons" >> "Put");

for "_i" from 0 to ((count _cfg) - 1) do
{
	_putCfg = (_cfg select _i);
	if (isClass _putCfg) then
	{
		_putCfgName = configName _putCfg;
		_putCfgArray = getArray(_cfg >>_putCfgName >>"magazines");
		if (_mag in _putCfgArray) then {_magMuzzle = configname(_putCfg)};
	 };
};

player playActionNow "PutDown";
player selectWeapon _magMuzzle;
player fire [_magMuzzle, _magMuzzle, _mag];
player setWeaponReloadingTime [player, _magMuzzle, 0];
*/