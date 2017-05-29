private ["_unit","_goggles","_headgear","_uniform","_uniformItems","_vest","_magazines","_primMag","_secmMag","_handMag","_assigneditems","_side","_vestItems","_handgunWeapon","_backpack","_primaryWeapon","_secondaryWeapon","_null","_killer"];

_unit 	= _this select 0;
_killer = if (count _this > 1) then {_this select 1} else {objnull};


//Delete utility placed by the player
{deleteVehicle _x} foreach (player getVariable ["MCC_utilityActiveCharges",[]]);

/*
//Reduce tickets if any
_side = _unit getVariable ["CP_side", playerside];
if ([_side] call BIS_fnc_respawnTickets > 0) then {
	private ["_sideTickets","_tickets"];

	_tickets = [_side] call BIS_fnc_respawnTickets;

	if (_tickets > 1) then {
		_tickets = -1;
		[_side, _tickets] call BIS_fnc_respawnTickets;
	} else {
		[["sidetickets"], "BIS_fnc_endMissionServer", false, false] spawn BIS_fnc_MP;
	};
};
*/

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

//Fatigue
if (missionNamespace getVariable ["MCC_disableFatigue",false]) then {
	player enableFatigue false;
};

//Delete dead body
if (missionNameSpace getVariable ["MCC_deletePlayersBody",false]) then {deleteVehicle _unit};

_null = [(compile format ["MCC_curator addCuratorEditableObjects [[objectFromNetId '%1'],false];",netid player]), "BIS_fnc_spawn", false, false] call BIS_fnc_MP;

if (missionNamespace getvariable ["MCC_saveGear",false]) then {
	[	_goggles,
		_headgear,
		_uniform,
		_vest,
		_backpack,
		missionNamespace getVariable ["MCC_save_Backpack",[]],
		_primMag,
		_secmMag,
		_handMag,
		_assigneditems,
		_uniformItems,
		_vestItems,
		_primaryWeapon,
		_secondaryWeapon,
		_handgunWeapon,
		missionNamespace getVariable ["MCC_save_primaryWeaponItems",[]],
		missionNamespace getVariable ["MCC_save_secondaryWeaponItems",[]],
		missionNamespace getVariable ["MCC_save_handgunitems",[]]
	] call MCC_fnc_loadGear;
};

//Handle add - action
[] call MCC_fnc_handleAddaction;

//if lost curator for some reason
if (((missionNamespace getvariable ["mcc_missionmaker",""])== name player) && (player != getAssignedCuratorUnit MCC_curator)) then {
	[player, "MCC_fnc_assignCurator", false, false] spawn BIS_fnc_MP;
};


if (isnil "MCC_TRAINING") then {
	//------------T2T---------------------------------
	if ((missionNamespace getVariable ["MCC_t2tIndex",0]) > 1) then {MCC_teleportToTeam = true};

	//-------------------Role selection -------------------------------------------
	if (CP_activated) then	{
		_null=[] execVM MCC_path + "mcc\roleSelection\scripts\player_init.sqf";
	} else {
		 []  call MCC_fnc_startLocations;
	};
};

