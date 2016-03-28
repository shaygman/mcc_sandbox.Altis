//==================================================================MCC_fnc_resupply=========================================================================================
// Resupply ammo from an ammo box
// Example:[_object,false] spawn MCC_fnc_resupply;
// <IN>
//	_object:					Object- object.
//	_infinate:					BOOLEAN -
//									true - infinate resupply.
//									false - default, supply object will deleted after depleted
//
// <OUT>
//		<nothing>
//===========================================================================================================================================================================
//Add magazines
private ["_magazineCount","_magazineClass","_magazines","_trashHold","_weapon","_cost","_roleCount","_objectAmmo","_object","_infinate"];
_object = param [0, objNull, [objNull]];
_infinate = param [1, false, [false]];

if (isNull _object) exitWith {};

_objectAmmo = _object getVariable ["ammoLeft",getNumber (configFile / "CfgVehicles" / typeof _object / "ammo")];
if (_objectAmmo == 0) then {_objectAmmo = 200};

//Infinate
if (_infinate) then {_objectAmmo = 9999999};

player playactionNow "putdown";
{
	_weapon = _x;
	if (_weapon != "") then {
		_magazines = getArray (configFile / "CfgWeapons" / _weapon / "magazines");
		if (count _magazines > 0) then {
			_magazineClass = _magazines select (0 min (count _magazines - 1));
			_magazineCount = {_x == _magazineClass} count magazines player;
			_cost = getNumber(configFile >> "CfgMagazines" >> _magazineClass >> "mass");
			switch _foreachIndex do	{
				case 0 : {_trashHold = 2};
				case 1 : {_trashHold = 2};
				case 2 : {if ((getText((configFile / "CfgWeapons" / _weapon / "cursor")) == "mg")) then {_trashHold = 4} else {_trashHold = 8}};
			};

			if (_magazineCount < _trashHold) then {
				for "_i" from _magazineCount to (_trashHold-1) do {
					player addMagazine _magazineClass;
					_objectAmmo = _objectAmmo - _cost;
					if (_objectAmmo <= 0) exitWith {deleteVehicle _object};
				};
			};
		};
	};
} foreach [secondaryWeapon player,handgunWeapon player, primaryWeapon player];

//IF EGLM
_weapon = primaryWeapon player;
_eglms = getArray (configFile / "CfgWeapons" / _weapon / "muzzles");
if (count _eglms >1) then {
	_magazines = getArray (configFile / "CfgWeapons" / _weapon / (_eglms select 1) / "magazines");
	if (count _magazines > 0) then {
		_magazineClass = _magazines select (0 min (count _magazines - 1));
		_magazineCount = {_x == _magazineClass} count magazines player;
		_cost = getNumber(configFile >> "CfgMagazines" >> _magazineClass >> "mass");
		_trashHold = 8;

		if (_magazineCount < _trashHold) then {
			for "_i" from _magazineCount to (_trashHold-1) do {
				player addMagazine _magazineClass;
				_objectAmmo = _objectAmmo - _cost;
				if (_objectAmmo <= 0) exitWith {deleteVehicle _object};
			};
		};
	};
};

//Add FAIK
private ["_bandage","_count"];
if (missionNamespace getVariable ["MCC_medicComplex",false]) then {
	_bandage = "MCC_bandage";
	_count = {_bandage == _x} count magazines player;
} else {
	_bandage = if (MCC_isACE) then {"ACE_fieldDressing"} else {"FirstAidKit"};
	_count = {_bandage == _x} count items player;
};

_roleCount =  if (((getNumber(configFile >> "CfgVehicles" >> typeOf vehicle player >> "attendant")) == 1) || ((player getvariable ["CP_role",""]) == "Corpsman")) then {11} else {1};

for "_i" from _count to _roleCount do {
	if (missionNamespace getVariable ["MCC_medicComplex",false]) then {
		player addMagazine _bandage} else {player addItem _bandage};
	_objectAmmo = _objectAmmo - 1;
};

//Add complex medical items
if ((missionNamespace getVariable ["MCC_medicComplex",false]) || MCC_isACE) then {

	_bandage = if (missionNamespace getVariable ["MCC_medicComplex",false]) then {["MCC_epipen","MCC_salineBag"]} else {["ACE_epinephrine","ACE_morphine","ACE_bloodIV_250"]};

	_roleCount =  if (((getNumber(configFile >> "CfgVehicles" >> typeOf vehicle player >> "attendant")) == 1) || ((player getvariable ["CP_role",""]) == "Corpsman")) then {6} else {0};

	{
		_item = _x;
		_count = {_item == _x} count (if (missionNamespace getVariable ["MCC_medicComplex",false]) then {magazines player} else {items player});
		for "_i" from _count to _roleCount do {
			if (missionNamespace getVariable ["MCC_medicComplex",false]) then {
				player addMagazine _item} else {player addItem _item};
			_objectAmmo = _objectAmmo - 1;
		};
	} forEach _bandage;
};

//Add grenades
private ["_grenades","_grnd"];
_grenades = ["HandGrenade","SmokeShell"];

{
	_grnd = _x;
	_count = {_grnd == _x} count magazines player;

	for "_i" from _count to 1 do {
		player addMagazine _grnd;
		_objectAmmo = _objectAmmo - 5;
	};
} forEach _grenades;

//Add satchels
if (((getNumber(configFile >> "CfgVehicles" >> typeOf player >> "canDeactivateMines")) == 1) || ((player getvariable ["CP_role",""]) == "Specialist")) then {
	_bandage = "SatchelCharge_Remote_Mag";
	_count = {_bandage == _x} count magazines player;

	for "_i" from _count to 1 do {
		player addMagazine _bandage;
		_objectAmmo = _objectAmmo - 10;
	};
};

//Delete if done
if (_objectAmmo <= 0) exitWith {deleteVehicle _object};
_object setVariable ["ammoLeft",_objectAmmo,true];