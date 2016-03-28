#define CP_RESPAWNPANEL_IDD (uiNamespace getVariable "CP_RESPAWNPANEL_IDD")

private ["_ok","_key","_index","_commander","_screen"];
disableSerialization;

_key = _this;
if (isnil "_key") then {_key = []};

//If we didn't came from the addAction
if (count _key > 4) then {
	_index = _key select 4;
} else {
	_index = (_key select 3) select 4;
};

_screen = missionNamespace getvariable ["MCC_mcc_screen",0];

if (_index == 0) exitWith {
	if !((getplayerUID player in (missionNamespace getvariable ["MCC_allowedPlayers",[]]) || "all" in  (missionNamespace getvariable ["MCC_allowedPlayers",["all"]]) || (serverCommandAvailable "#logout" && missionNamespace getvariable ["MCC_allowAdmin",true]) || (isServer && missionNamespace getvariable ["MCC_allowAdmin",true]) || (player getvariable ["MCC_allowed",false]))) exitWith {};

	if (str findDisplay 2994 != "No display") then {
		while {dialog} do {closeDialog 0};
	} else {
		//If not the mission maker move to default screen
		if (name player != (missionNamespace getvariable ["mcc_missionMaker",""])) then {_screen =0} else {
			if (_screen == 0) then {_screen =2};
		};

		switch (_screen) do
		{
			case 0:
			{
				//Close Dialog
				if (dialog) exitWith {
					while {dialog} do {closeDialog 0};
				};

				_ok = createDialog "mcc_loginDialog";
				if !(_ok) exitWith { hint "createDialog failed" };
			};
			case 1:
			{
				_ok = createDialog "MCC3D_Dialog";
				if !(_ok) exitWith { hint "createDialog failed" };
			};
			case 2:
			{
				_ok = createDialog "mcc_groupGen";
				if !(_ok) exitWith { hint "createDialog failed" };
			};
			case 3:
			{
				_ok = createDialog "MCCMWDialog";
				if !(_ok) exitWith { hint "createDialog failed" };
			};
		};

		missionNamespace setvariable ["MCC_mcc_screen",0];
	};
};

//Console
_commander = MCC_server getVariable [format ["CP_commander%1",side player],""];
if ((_index == 1) && (_commander == getPlayerUID player) && (missionNamespace getVariable ["MCC_allowConsole",true])) exitWith {
	if (dialog) then {
		while {dialog} do {closeDialog 0};
	} else {
		_null = [nil,nil,nil,[0]] execVM  format ["%1mcc\general_scripts\console\conoleOpenMenu.sqf",MCC_path];
	};
};

//Squad Dialog
if (_index == 2 && (missionNamespace getVariable ["MCC_allowSquadDialog",true])) exitWith {
	if (dialog) then {
		while {dialog} do {closeDialog 0; sleep 0.01};
	} else {
		while {dialog} do {closeDialog 0; sleep 0.01};
		createDialog "CP_RESPAWNPANEL";
	};
};

//SQL PDA
if (_index == 3 && ((count units player > 1) && (leader player == player)) && (missionNamespace getVariable ["MCC_allowsqlPDA",true]) && "ItemGPS" in (assignedItems player)) exitWith {
		if (dialog) then {
			while {dialog} do {closeDialog 0};
		} else {
			createDialog "MCC_SQLPDA";
		};
};