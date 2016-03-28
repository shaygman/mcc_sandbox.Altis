private ["_unit","_goggles","_headgear","_uniform","_uniformItems","_vest","_magazines","_primMag","_secmMag","_handMag","_assigneditems",
         "_vestItems","_handgunWeapon","_backpack","_primaryWeapon","_secondaryWeapon","_null","_killer"];

_unit 	= _this select 0;
_killer = if (count _this > 1) then {_this select 1} else {objnull};


//Case we in role selection and have tickets
if (CP_activated) then {
	private ["_side","_sideTickets","_tickets"];

	_side = _unit getVariable ["CP_side", playerside];
	_tickets = [_side] call BIS_fnc_respawnTickets;

	//Delete utility placed by the player
	{deleteVehicle _x} foreach (player getVariable ["MCC_utilityActiveCharges",[]]);

	if (_tickets > 1) then {
		_tickets = -1;
		[_side, _tickets] call BIS_fnc_respawnTickets;
	} else {
		[["sidetickets"], "BIS_fnc_endMissionServer", false, false] spawn BIS_fnc_MP;
	};
};

if (missionNamespace getvariable ["MCC_saveGear",false]) then {
	_goggles = goggles _unit; 			//Can't  save gear after killed EH
	_headgear = headgear _unit;
	_uniform = uniform _unit;
	_vest = vest _unit;
	_backpack = backpack _unit;

	_primMag = missionNamespace getVariable ["MCC_save_primaryWeaponMagazine",[]];
	_secmMag = missionNamespace getVariable ["MCC_save_secondaryWeaponMagazine",[]];
	_handMag = missionNamespace getVariable ["MCC_save_handgunMagazine",[]];
	_items = items _unit;
	_assigneditems = assigneditems _unit;

	_uniformItems = uniformItems _unit;
	_vestItems = vestItems _unit;

	_primaryWeapon = missionNamespace getVariable ["MCC_save_primaryWeapon",""];
	_secondaryWeapon =  missionNamespace getVariable ["MCC_save_secondaryWeapon",""];
	_handgunWeapon =  missionNamespace getVariable ["MCC_save_handgunWeapon",""];
	_magazines =  missionNamespace getVariable ["MCC_save_magazines", []];
};

WaitUntil {alive player};

//Mark it zero again
player addRating (-1 * (rating player));

//handle MCC medic stuff
player setVariable ["MCC_medicUnconscious",false,true];
player setVariable ["MCC_medicSeverInjury",false,true];
player setVariable ["MCC_medicBleeding",0,true];
player setvariable ["MCC_medicRemainBlood",(missionNamespace getvariable ["MCC_medicBleedingTime",200])];
player setCaptive false;

//Delete dead body
if (missionNameSpace getVariable ["MCC_deletePlayersBody",false]) then {deleteVehicle _unit};

_null = [(compile format ["MCC_curator addCuratorEditableObjects [[objectFromNetId '%1'],false];",netid player]), "BIS_fnc_spawn", false, false] call BIS_fnc_MP;

if (missionNamespace getvariable ["MCC_saveGear",false]) then {
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

	if (!isnil "_uniformItems") then
	{
		{
			switch (true) do
				{
					case (isClass (configFile >> "CfgMagazines" >> _x)) : {player addmagazine _x};
					case (isClass (configFile >> "CfgWeapons" >> _x)) : {player additem _x};
					case (isClass (configFile >> "CfgGlasses" >> _x)) : {player additem _x};
				};
		} foreach _uniformItems;
	};

	if (!isnil "_assigneditems") then
	{
		{
			switch (true) do
				{
					case (isClass (configFile >> "CfgMagazines" >> _x)) : {player addmagazine _x};
					case (isClass (configFile >> "CfgWeapons" >> _x)) : {player addWeaponGlobal _x;player linkItem  _x};
					case (isClass (configFile >> "CfgGlasses" >> _x)) : {player additem _x;player assignItem _x};
				};
		} foreach _assigneditems;
	};


	if (!isnil "_vestItems") then
	{
		{
			switch (true) do
				{
					case (isClass (configFile >> "CfgMagazines" >> _x)) : {player addmagazine _x};
					case (isClass (configFile >> "CfgWeapons" >> _x)) : {player additem _x};
					case (isClass (configFile >> "CfgGlasses" >> _x)) : {player additem _x};
				};
		} foreach _vestItems;
	};

	if (!isnil "MCC_save_Backpack") then
	{
		{
			switch (true) do
			{
				case (isClass (configFile >> "CfgMagazines" >> _x)) : {(unitBackpack player) addMagazineCargo [_x,1]};
				case (isClass (configFile >> "CfgWeapons" >> _x)) : {(unitBackpack player) addItemCargo [_x,1]};
				case (isClass (configFile >> "CfgGlasses" >> _x)) : {(unitBackpack player) addItemCargo [_x,1]};
			};
		} foreach MCC_save_Backpack;
	};

	if (!isnil "_primaryWeapon") then
	{
		player addWeaponGlobal  _primaryWeapon;
		{player addPrimaryWeaponItem _x} foreach MCC_save_primaryWeaponItems;

		{
			if (_x != "") then {player addmagazine _x};
		} foreach _primMag;
	};

	if (!isnil "_secondaryWeapon") then
	{
		player addWeaponGlobal  _secondaryWeapon;
		{player addSecondaryWeaponItem _x} foreach MCC_save_secondaryWeaponItems;

		{
			if (_x != "") then {player addmagazine _x};
		} foreach _secmMag;
	};

	if (!isnil "_handgunWeapon") then
	{
		player addWeaponGlobal  _handgunWeapon;
		{player addHandgunItem _x} foreach MCC_save_handgunitems;

			{
				if (_x != "") then {player addmagazine _x};
			} foreach _handMag;
	};

	if (!isnil "_primaryWeapon") then
	{
		player selectWeapon _primaryWeapon;
		_muzzles = getArray(configFile>>"cfgWeapons" >> _primaryWeapon >> "muzzles");
		player selectWeapon (_muzzles select 0);
	};
};

//Handle add - action
[] call MCC_fnc_handleAddaction;

//if lost curator for some reason
if (((missionNamespace getvariable ["mcc_missionmaker",""])== name player) && (player != getAssignedCuratorUnit MCC_curator)) then {
	[player, "MCC_fnc_assignCurator", false, false] spawn BIS_fnc_MP;
};


if (isnil "MCC_TRAINING") then {
	//------------T2T---------------------------------
	if (MCC_t2tIndex == 2) then {MCC_teleportToTeam = true};

	//-------------------Role selection -------------------------------------------
	if (CP_activated) then	{
		_null=[] execVM MCC_path + "mcc\roleSelection\scripts\player_init.sqf";
	} else {
		 []  call MCC_fnc_startLocations;
	};
};

