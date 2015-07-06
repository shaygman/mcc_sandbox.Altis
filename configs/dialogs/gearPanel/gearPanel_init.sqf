private ["_disp","_comboBox","_index","_displayname","_updateRoles"];
disableSerialization;

_disp = _this select 0;
uiNamespace setVariable ["CP_GEARPANEL_IDD", _disp];
uiNamespace setVariable ["CP_gearPanelCommander", _disp displayCtrl 10];
uiNamespace setVariable ["CP_gearPanelAR", _disp displayCtrl 11];
uiNamespace setVariable ["CP_gearPanelRifleman", _disp displayCtrl 12];
uiNamespace setVariable ["CP_gearPanelAntitank", _disp displayCtrl 13];
uiNamespace setVariable ["CP_gearPanelCorpsman", _disp displayCtrl 14];
uiNamespace setVariable ["CP_gearPanelMarksman", _disp displayCtrl 15];
uiNamespace setVariable ["CP_gearPanelSpecialist", _disp displayCtrl 16];
uiNamespace setVariable ["CP_gearPanelCrewman", _disp displayCtrl 17];
uiNamespace setVariable ["CP_gearPanelPilot", _disp displayCtrl 18];
uiNamespace setVariable ["CP_gearPanelPiP", _disp displayCtrl 19];
uiNamespace setVariable ["CP_InfoText", _disp displayCtrl 20];

#define CP_GEARPANEL_IDD (uiNamespace getVariable "CP_GEARPANEL_IDD")
#define CP_gearPanelCommander (uiNamespace getVariable "CP_gearPanelCommander")
#define CP_gearPanelAR (uiNamespace getVariable "CP_gearPanelAR")
#define CP_gearPanelRifleman (uiNamespace getVariable "CP_gearPanelRifleman")
#define CP_gearPanelAntitank (uiNamespace getVariable "CP_gearPanelAntitank")
#define CP_gearPanelCorpsman (uiNamespace getVariable "CP_gearPanelCorpsman")
#define CP_gearPanelMarksman (uiNamespace getVariable "CP_gearPanelMarksman")
#define CP_gearPanelSpecialist (uiNamespace getVariable "CP_gearPanelSpecialist")
#define CP_gearPanelCrewman (uiNamespace getVariable "CP_gearPanelCrewman")
#define CP_gearPanelPilot (uiNamespace getVariable "CP_gearPanelPilot")
#define CP_gearPanelPiP (uiNamespace getVariable "CP_gearPanelPiP")
#define CP_InfoText (uiNamespace getVariable "CP_InfoText")

CP_respawnPanelOpen = false;
CP_gearPanelOpen	= true;

//We came here from an item and we want to change the kit
if (isnil "CP_gearCam") then {

	//Disable buttons
	for "_i" from 0 to 3 do {
		(_disp displayCtrl _i) ctrlShow false;
	};

	//Create Camera
	["CP_GEARPANEL_IDD"] call MCC_fnc_createCameraOnPlayer;
} else {
	//Disable Esc while respawn is on
	CP_disableEsc = CP_GEARPANEL_IDD displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];
};

_updateRoles = {
	//Do we have enough roles
	private ["_countRole","_minPlayersForRole","_roleLimit","_roleName","_ctrl","_disp","_playerRole"];
	_disp = _this;
	_playerRole = toLower (player getVariable ["CP_role","N/A"]);

	{
		_roleName = _x;
		_roleLimit = ["SERVER_misc", "RoleSelectionDefinse", format ["CP_%1PerGroup", toLower _roleName], "SCALAR"] call iniDB_read;
		_minPlayersForRole = ["SERVER_misc", "RoleSelectionDefinse", format ["CP_%1MinPlayersInGroup", toLower _roleName], "SCALAR"] call iniDB_read;
		_countRole = {(_x getvariable "CP_role") == _roleName} count units player;

		if ((_countRole >= _roleLimit || count units player <  _minPlayersForRole) && _roleName != _playerRole) then {

			if (count units player <  _minPlayersForRole) then {
				(_disp displayCtrl (10 + _forEachIndex)) ctrlSetTooltip format ["Minimum of %1 players is needed in your squad to use this kit", _minPlayersForRole]
			};

			(_disp displayCtrl (10 + _forEachIndex)) ctrlEnable false;
			(_disp displayCtrl (110 + _forEachIndex)) ctrlEnable false;
			(_disp displayCtrl (210 + _forEachIndex)) ctrlEnable false;
		};

		//set text
		_ctrl = _disp displayCtrl (10 + _forEachIndex);
		_ctrl ctrlsettext format ["%2 lvl %1 -= Kits: %3 =-",call compile format ["%1Level select 0",toLower _x], _x , _roleLimit-_countRole];

		//Set focus
		if (_roleName == _playerRole) then {ctrlSetFocus _ctrl};

	} forEach ["Officer","AR","Rifleman","AT","Corpsman","Marksman","Specialist"];

	//pilot & crewmen
	{
		_roleName = _x;
		_roleLimit = ["SERVER_misc", "RoleSelectionDefinse", format ["CP_available%1",_roleName], "SCALAR"] call iniDB_read;
		_countRole = {isPlayer _x && side _x == playerSide && tolower (_x getvariable ["CP_role","n/a"]) == tolower _roleName} count allUnits;
		if (_countRole >= _roleLimit  && _roleName != toLower (player getVariable ["CP_role","N/A"])) then {
			(_disp displayCtrl (17 + _forEachIndex)) ctrlEnable false;
			(_disp displayCtrl (117 + _forEachIndex)) ctrlEnable false;
			(_disp displayCtrl (217 + _forEachIndex)) ctrlEnable false;
		};

		//set text
		_ctrl = _disp displayCtrl (17 + _forEachIndex);
		_ctrl ctrlsettext format ["%2 lvl %1 -= Kits: %3 =-",call compile format ["%1Level select 0",toLower _x], _x , _roleLimit-_countRole];

		//Set focus
		if (_roleName == _playerRole) then {ctrlSetFocus _ctrl};

	} forEach ["Crew","Pilot"];
};


//Gear stats
[CP_GEARPANEL_IDD] call MCC_fnc_playerStats;

_updateRoles spawn
{
	private ["_array","_disp"];
	disableSerialization;
	while {(str (CP_GEARPANEL_IDD displayCtrl 10) != "No control")} do
	{
		_disp = CP_GEARPANEL_IDD;

		//Update available rolls
		_disp call _this;
		//Time
		_t = if ((estimatedEndServerTime - serverTime)>0) then {[estimatedEndServerTime - serverTime] call MCC_fnc_time} else {""};
		ctrlSetText [1919,_t];

		//Load available resources
		_array = call compile format ["MCC_res%1",playerside];
		{_disp displayCtrl _x ctrlSetText str floor (_array select _forEachIndex)} foreach [81,82,83,84,85];
		sleep 0.1;
	};
};
