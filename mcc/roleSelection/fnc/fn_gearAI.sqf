//==================================================================MCC_fnc_gearAI==================================================================================
// Gear AI with gear acording to its role
// Example: [_currentWeapon], "MCC_fnc_addItem", true, false] spawn BIS_fnc_MP;
//===================================================================================================================================================================
private ["_role","_muzzles","_wepItems","_currentWeapon","_unit","_cfg","_items","_selectedItem","_sideUnit","_index","_currentMagazines","_currentWeaponName","_image","_weaponType"];

_role = param [0,"rifleman",[""]];
_unit = param [1,objNull,[objNull]];
waitUntil {alive _unit};

if (isNull _unit || _role == "" || !local _unit) exitWith {diag_log "MCC: MCC_fnc_gearAI not local or null unit "};

_sideUnit = str side _unit;
_cfg = if (isClass (missionconfigFile >> "MCC_loadouts" )) then {(missionconfigFile >> "MCC_loadouts")} else {(configFile >> "MCC_loadouts")};

//set unit
_image = getText(_cfg >> _role >> "picture");

_unit setvariable ["CP_role", _role, true];
_unit setvariable ["CP_roleImage", _image, true];
_unit setvariable ["CP_roleLevel", 1, true];

//Remove weapons/items/goggles
removeAllWeapons _unit;
removeAllItems _unit;
removeGoggles _unit;
removeAllAssignedItems _unit;

// Remove NVGs
if("NVGoggles" in (assignedItems _unit)) then {
	_unit unassignItem "NVGoggles";
	_unit removeItem "NVGoggles";
};

//-------------------------------------------------------------------------------------------------------------------------------------------------------


//Add NVG
_items = getArray (_cfg >> _role >> _sideUnit >> "nightVision");
_selectedItem = if (count _items > 0) then {(_items call bis_fnc_selectRandom) select 1} else {""};
if (_selectedItem != "") then {
	_unit additem _selectedItem;
	_unit assignItem _selectedItem;
};

//Add headgear
if ((Headgear _unit) != "") then {removeHeadgear _unit};
_items = getArray (_cfg >> _role >> _sideUnit >> "headgear");
_selectedItem = if (count _items > 0) then {(_items call bis_fnc_selectRandom) select 1} else {""};
if (_selectedItem != "") then {_unit addHeadgear _selectedItem};

//add goggles
_items = getArray (_cfg >> _role >> _sideUnit >> "googles");
_selectedItem = if (count _items > 0) then {(_items call bis_fnc_selectRandom) select 1} else {""};
if ((Goggles _unit) != "") then {removeGoggles _unit};
if (_selectedItem != "") then {_unit addGoggles _selectedItem};

//add vest
_items = getArray (_cfg >> _role >> _sideUnit >> "vests");
_selectedItem = if (count _items > 0) then {(_items call bis_fnc_selectRandom) select 1} else {""};
if ((vest _unit) != "") then {removeVest _unit};
if (_selectedItem != "") then {_unit addVest _selectedItem};

//add backpack
_items = getArray (_cfg >> _role >> _sideUnit >> "backpacks");
_selectedItem = if (count _items > 0) then {(_items call bis_fnc_selectRandom) select 1} else {""};
removeBackpack _unit;
if (_selectedItem != "") then {_unit addBackpack _selectedItem};

//add uniforms
_items = getArray (_cfg >> _role >> _sideUnit >> "uniforms");
_selectedItem = if (count _items > 0) then {(_items call bis_fnc_selectRandom) select 1} else {""};
if ((Uniform _unit) != "") then {removeUniform _unit};
if (_selectedItem != "") then {_unit forceAddUniform  _selectedItem};

//------------------------------------------------------------------------------------------------------------------------------------------------------
//Weapons
{
	_weaponType = _x;
	if (count (_cfg >> _role >> _sideUnit >> _weaponType)>0) then {
		_index = floor random (count (_cfg >> _role >> _sideUnit >> _weaponType));
		_currentWeapon = configName ((_cfg >> _role >> _sideUnit >> _weaponType) select _index);
		_currentWeaponName = getText (_cfg >> _role >> _sideUnit >> _weaponType >> _currentWeapon >> "cfgname");
		_currentMagazines = getArray (_cfg >> _role >> _sideUnit >> _weaponType >> _currentWeapon >> "magazines");

		if (!isnil "_currentWeapon") then {
				[[0,_currentWeaponName,_currentMagazines],_unit] call MCC_fnc_addWeapon;

				//Attachments
				{
					_items = getArray (_cfg >> _role >> _sideUnit >> _weaponType >> _currentWeapon >> _x);
					_selectedItem = if (count _items > 0) then {(_items call bis_fnc_selectRandom) select 1} else {""};
					if (_selectedItem != "") then {

						switch (_weaponType) do {
						    case "primary": {_unit addPrimaryWeaponItem _selectedItem};
						    case "secondary": {_unit addSecondaryWeaponItem _selectedItem};
						    case "handgun": {_unit addHandgunItem _selectedItem};
						};
					};
				} forEach ["attachments1","attachments2","attachments3","attachments4"];

		};
	};
} forEach ["primary","secondary","handgun"];

//-------------------------------------------------------------------------------------------------------------------------------------------
//Items
{
	_items = getArray (_cfg >> _role >> _sideUnit >> _x);
	_selectedItem = if (count _items > 0) then {_items call bis_fnc_selectRandom} else {[]};
	if (count _selectedItem > 0) then {[_selectedItem,_unit] call MCC_fnc_addItem};
} forEach ["items1","items2","items3"];

//-------------------------------------------------------------------------------------------------------------------------------------------
//Add generic items
_items = getArray (_cfg >> _role >> _sideUnit >> "generalItems");
{
	[_x,_unit] call MCC_fnc_addItem;
} foreach _items;