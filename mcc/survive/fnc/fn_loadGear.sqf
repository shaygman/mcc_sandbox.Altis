/*=================================================================MCC_fnc_loadGear===============================================================================
  load gear from an array
  <IN>
	_goggles = param [0,"",[""]];
	_headgear = param [1,"",[""]];
	_uniform = param [2,"",[""]];
	_vest = param [3,"",[""]];
	_backpack = param [4,"",[""]];
	_backPackItems = param [5,[],[[]]];
	_primMag = param [6,[],[[]]];
	_secmMag = param [7,[],[[]]];
	_handMag = param [8,[],[[]]];
	_assigneditems = param [9,[],[[]]];
	_uniformItems = param [10,[],[[]]];
	_vestItems = param [11,[],[[]]];
	_primaryWeapon = param [12,"",[""]];
	_secondaryWeapon = param [13,"",[""]];
	_handgunWeapon = param [14,"",[""]];
	_primaryWeaponItems = param [15,[],[[]]];
	_secondaryWeaponItems = param [16,[],[[]]];
	_handgunitems = param [17,[],[[]]];

<OUT>
	NOTHING

*/
private ["_goggles","_headgear","_uniform","_vest","_backpack","_backPackItems","_primMag","_secmMag","_handMag","_assigneditems","_uniformItems","_vestItems","_primaryWeapon","_secondaryWeapon","_handgunWeapon","_primaryWeaponItems","_secondaryWeaponItems","_handgunitems"];

_goggles = param [0,"",[""]];
_headgear = param [1,"",[""]];
_uniform = param [2,"",[""]];
_vest = param [3,"",[""]];
_backpack = param [4,"",[""]];
_backPackItems = param [5,[],[[]]];
_primMag = param [6,[],[[]]];
_secmMag = param [7,[],[[]]];
_handMag = param [8,[],[[]]];
_assigneditems = param [9,[],[[]]];
_uniformItems = param [10,[],[[]]];
_vestItems = param [11,[],[[]]];
_primaryWeapon = param [12,"",[""]];
_secondaryWeapon = param [13,"",[""]];
_handgunWeapon = param [14,"",[""]];
_primaryWeaponItems = param [15,[],[[]]];
_secondaryWeaponItems = param [16,[],[[]]];
_handgunitems = param [17,[],[[]]];

{player removeMagazine _x} forEach magazines player;
removeGoggles player;
removeHeadgear player;
removeUniform player;
removeVest player;
removeBackpack player;

removeAllWeapons player;
removeAllItems player;
removeAllAssignedItems player;

if (_goggles != "") then {player addGoggles _goggles};
if (_headgear != "") then {player addHeadgear _headgear};
if (_uniform != "") then {player forceAddUniform  _uniform};
if (_vest != "") then {player addVest _vest};
if (_backpack != "") then {player addBackpack _backpack};

waituntil {backpack player == _backpack};

//Uniform Items
{
	switch (true) do
		{
			case (isClass (configFile >> "CfgMagazines" >> _x)) : {player addmagazine _x};
			case (isClass (configFile >> "CfgWeapons" >> _x)) : {player additem _x};
			case (isClass (configFile >> "CfgGlasses" >> _x)) : {player additem _x};
		};
} foreach _uniformItems;

//Assigned Items
{
	switch (true) do
		{
			case (isClass (configFile >> "CfgMagazines" >> _x)) : {player addmagazine _x};
			case (isClass (configFile >> "CfgWeapons" >> _x)) : {player addWeaponGlobal _x;player linkItem  _x};
			case (isClass (configFile >> "CfgGlasses" >> _x)) : {player additem _x;player assignItem _x};
		};
} foreach _assigneditems;

//Vest Items
{
	switch (true) do
		{
			case (isClass (configFile >> "CfgMagazines" >> _x)) : {player addmagazine _x};
			case (isClass (configFile >> "CfgWeapons" >> _x)) : {player additem _x};
			case (isClass (configFile >> "CfgGlasses" >> _x)) : {player additem _x};
		};
} foreach _vestItems;

//Backpack Items
{
	switch (true) do
	{
		case (isClass (configFile >> "CfgMagazines" >> _x)) : {(unitBackpack player) addMagazineCargo [_x,1]};
		case (isClass (configFile >> "CfgWeapons" >> _x)) : {(unitBackpack player) addItemCargo [_x,1]};
		case (isClass (configFile >> "CfgGlasses" >> _x)) : {(unitBackpack player) addItemCargo [_x,1]};
	};
} foreach _backPackItems;

//Primary weapons
if (_primaryWeapon != "") then {
	player addWeaponGlobal  _primaryWeapon;
	{
		if (_x != "") then {player addPrimaryWeaponItem _x};
	} foreach _primaryWeaponItems;

	{
		if (_x != "") then {player addmagazine _x};
	} foreach _primMag;
};

//Secondary Weapons
if (_secondaryWeapon != "") then {
	player addWeaponGlobal  _secondaryWeapon;
	{
		if (_x != "") then {player addSecondaryWeaponItem _x};
	} foreach _secondaryWeaponItems;

	{
		if (_x != "") then {player addmagazine _x};
	} foreach _secmMag;
};

//Handgun
if (_handgunWeapon != "") then {
	player addWeaponGlobal  _handgunWeapon;
	{
		if (_x != "") then {player addHandgunItem _x}
	} foreach _handgunitems;

	{
		if (_x != "") then {player addmagazine _x};
	} foreach _handMag;
};

if (_primaryWeapon != "") then
{
	player selectWeapon _primaryWeapon;
	_muzzles = getArray(configFile>>"cfgWeapons" >> _primaryWeapon >> "muzzles");
	player selectWeapon (_muzzles select 0);
};
