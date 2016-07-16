//================================================================MCC_fnc_pickKit===============================================================================================
//Pick up dead unit kit
//===========================================================================================================================================================================
private ["_itemsPlayer","_itemsSuspect","_wepHolder","_backPackSuspect","_backPackPlayer","_vestPlayer","_vestSuspect","_time","_wepSuspect","_wepPlayer","_suspect"];
_suspect = _this select 0;

_itemsPlayer  = itemsWithMagazines player;
_itemsSuspect = itemsWithMagazines _suspect;

_backPackSuspect	= backpack _suspect;
_backPackPlayer 	= backpack player;
_vestSuspect 		= vest _suspect;
_vestPlayer 		= vest player;

_wepPlayer = weapons player;
_wepSuspect = weapons _suspect;

//remove
removeAllItemsWithMagazines player;
removeAllItemsWithMagazines _suspect;

//Backpack
if (_backPackPlayer != "") then {
	removeBackpackGlobal player;

	if (_backPackSuspect != "") then {
		removeBackpackGlobal _suspect;
		player addBackpack _backPackSuspect;
		_time = time;
		waituntil {backpack player == _backPackSuspect || time - _time > 3 };
	};
	_suspect addBackpack _backPackPlayer;
	_time = time;
	waituntil {backpack _suspect == _backPackPlayer || time - _time > 3 };
} else {
	if (_backPackSuspect != "") then {
		removeBackpackGlobal _suspect;
		player addBackpack _backPackSuspect;
		_time = time;
		waituntil {backpack player == _backPackSuspect || time - _time > 3 };
	};
};

//Vest
if (_vestPlayer != "") then {
	removeVest player;

	if (_vestSuspect != "") then {
		removeVest _suspect;
		player addVest _vestSuspect;
		_time = time;
		waituntil {vest player == _vestSuspect || time - _time > 3 };
	};
	_suspect addVest _vestPlayer;
	_time = time;
	waituntil {vest _suspect == _vestPlayer || time - _time > 3 };
} else {
	if (_vestSuspect != "") then {
		removeVest _suspect;
		player addVest _vestSuspect;
		_time = time;
		waituntil {vest player == _vestSuspect || time - _time > 3 };
	};
};

//weapons
private ["_nearHolders","_holder"];

_nearHolders = (getpos _suspect nearObjects ["weaponHolderSimulated",5]);

if (count _wepPlayer > 0) then {
	/*
	if (count _nearHolders > 0) then {
		_nearHolders = [_nearHolders,[],{(_suspect distance _x)},"ASCEND"] call BIS_fnc_sortBy;
		_wepHolder = _nearHolders select 0;
	} else {
		_wepHolder = "weaponHolderSimulated" createVehicle getpos _suspect;
		waituntil {!isnil "_wepHolder"};
		_wepHolder setpos getpos _suspect;
	};
	*/
	_wepHolder = "weaponHolderSimulated" createVehicle getpos _suspect;
	waituntil {!isnil "_wepHolder"};
	_wepHolder setpos getpos _suspect;

	{
		_weapon = if (typeName _x == "STRING") then {_x} else {_x select 0};
		player action ["DropWeapon", _wepHolder, _weapon];
	} foreach _wepPlayer;
};

if (count _nearHolders > 0) then {
	_nearHolders = [_nearHolders,[],{(_suspect distance _x)},"ASCEND"] call BIS_fnc_sortBy;
	_wepHolder = _nearHolders select 0;
	{player action ["TakeWeapon", _wepHolder, _x]} foreach (weaponCargo _wepHolder);
};

/*
{
	_holder = _x;
	{player action ["TakeWeapon", _holder, _x]} foreach (weaponCargo _x);
} foreach _nearHolders;
*/
{
	player action ["TakeWeapon", _suspect, _x];
} foreach _wepSuspect;

//Items + mage
{
	switch (true) do {
		case (isClass (configFile >> "CfgMagazines" >> _x)) : {player addMagazine _x};
		case (isClass (configFile >> "CfgWeapons" >> _x)) : {player addItem _x};
	};
} foreach _itemsSuspect;


{
	switch (true) do
	{
		case (isClass (configFile >> "CfgMagazines" >> _x)) : {_suspect addMagazine _x};
		case (isClass (configFile >> "CfgWeapons" >> _x)) : {_suspect addItem _x};
	};
} foreach _itemsPlayer;