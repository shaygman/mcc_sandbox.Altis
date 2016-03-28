private ["_disp","_exp","_idc","_displayname","_updateRoles","_sidePlayer","_activeSides","_role"];
disableSerialization;

_disp = _this select 0;
uiNamespace setVariable ["CP_GEARPANEL_IDD", _disp];
uiNamespace setVariable ["CP_ticketsWestText", _disp displayCtrl 1];
uiNamespace setVariable ["CP_ticketsEastText", _disp displayCtrl 2];
uiNamespace setVariable ["CP_deployPanelMiniMap", _disp displayCtrl 4];

uiNamespace setVariable ["CP_flag", _disp displayCtrl 20];
uiNamespace setVariable ["CP_side1", _disp displayCtrl 21];
uiNamespace setVariable ["CP_side1Score", _disp displayCtrl 22];
uiNamespace setVariable ["CP_side2", _disp displayCtrl 23];
uiNamespace setVariable ["CP_side2Score", _disp displayCtrl 24];
uiNamespace setVariable ["CP_side3", _disp displayCtrl 25];
uiNamespace setVariable ["CP_side3Score", _disp displayCtrl 26];
uiNamespace setVariable ["CP_missionName",_disp displayCtrl 1021];

uiNamespace setVariable ["messeges", _disp displayCtrl 102];
uiNamespace setVariable ["XPTitle", _disp displayCtrl 103];
uiNamespace setVariable ["XPValue", _disp displayCtrl 104];

#define messeges (uiNamespace getVariable "messeges")
#define XPTitle (uiNamespace getVariable "XPTitle")
#define XPValue (uiNamespace getVariable "XPValue")

#define CP_GEARPANEL_IDD (uiNamespace getVariable "CP_GEARPANEL_IDD")
#define CP_gearPanelCommander (uiNamespace getVariable "CP_gearPanelCommander")
#define CP_ticketsWestText (uiNamespace getVariable "CP_ticketsWestText")
#define CP_ticketsEastText (uiNamespace getVariable "CP_ticketsEastText")
#define CP_deployPanelMiniMap (uiNamespace getVariable "CP_deployPanelMiniMap")

#define CP_flag (uiNamespace getVariable "CP_flag")
#define CP_side1 (uiNamespace getVariable "CP_side1")
#define CP_side1Score (uiNamespace getVariable "CP_side1Score")
#define CP_side2 (uiNamespace getVariable "CP_side2")
#define CP_side2Score (uiNamespace getVariable "CP_side2Score")
#define CP_side3 (uiNamespace getVariable "CP_side3")
#define CP_side3Score (uiNamespace getVariable "CP_side3Score")
#define CP_missionName (uiNamespace getVariable "CP_missionName")

missionNamespace setVariable ["CP_gearPanelOpen",true];

cutText ["","BLACK IN",3];

//We came here from an item and we want to change the kit
if (isnil "CP_gearCam") then {
	{
		(_disp displayCtrl _x) ctrlShow false;
	} forEach [32,28,29,1006,1005];

	//Create Camera
	["CP_GEARPANEL_IDD"] call MCC_fnc_createCameraOnPlayer;
} else {
	//Disable Esc while respawn is on
	CP_disableEsc = CP_GEARPANEL_IDD displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];
};

_sidePlayer = player getVariable ["CP_side", side player];

//Set side flag
CP_flag ctrlSetText (missionNamespace getVariable [format ["CP_flag%1", _sidePlayer],""]);

//Mission Name
CP_missionName ctrlSetText missionName;

if (missionNamespace getvariable ["CP_activated",false]) then {
	//Sets sides Tickets
	_activeSides = [] call MCC_fnc_getActiveSides;

	_idc = 21;
	{
		ctrlSetText [_idc, str _x];
		_idc = _idc + 2;
	} foreach _activeSides;

	//Set XP
	_role = player getvariable "CP_role";
	if (isnil "_role") exitWith {};

	_exp 	 = call compile format  ["%1Level select 1",_role];
	if (isnil "_exp") exitWith {};

	if (_exp < 0) then {_exp = 0};
	_oldLevel = call compile format  ["%1Level select 0",_role];
	_html = "<t color='#818960' size='0.8' shadow='1' align='center' underline='false'>"+ _role+ " Level " + str _oldLevel + "</t>";
	messeges ctrlSetStructuredText parseText _html;

	_needXP 			= (CP_XPperLevel * _oldLevel);
	_needXPPrevLevel 	= (CP_XPperLevel * (_oldLevel-1));
	XPValue progressSetPosition (1-((_needXP-_exp)/(_needXP - _needXPPrevLevel)));
} else {
	{
		(_disp displayCtrl _x) ctrlShow false
	} forEach [102,103,104];
};

_createRoleButton = {
	params ["_disp","_idc","_ctrlGroup","_hight","_roleSummery","_cfgName"];
	_cfgName = _roleSummery select 0;
	_displayname = _roleSummery select 1;
	_pic = _roleSummery select 2;
	_minPlayersForKit = _roleSummery select 3;
	_maxKitsInGroup = _roleSummery select 4;
	_maxKitsInSide = _roleSummery select 5;

	_buttonCtrlGroup = _disp ctrlCreate ["RscControlsGroupNoScrollbars",_idc,_ctrlGroup];
	_buttonCtrlGroup ctrlSetPosition [0.001*safezoneW, 0,  0.136 * safezoneW, _hight];
	_buttonCtrlGroup ctrlCommit 0;

	//Button
	_ctrl = _disp ctrlCreate ["RscButtonEditor",_idc+200,_buttonCtrlGroup];
	_ctrl ctrlSetPosition [0.001*safezoneW, 0, 0.136 * safezoneW, _hight];
	_ctrl ctrlSetText _displayname;
	_ctrl ctrlSetBackgroundColor [0.292,0.292,0.292,0.9];
	_ctrl ctrlAddEventHandler ["MouseButtonClick",format ["[_this select 0,'%1',%2] spawn MCC_fnc_roleClicked", _cfgName,ctrlIDC _ctrlGroup]];
	_ctrl ctrlCommit 0;

	//Picture
	_ctrl = _disp ctrlCreate ["RscPicture",-1,_buttonCtrlGroup];
	_ctrl ctrlSetPosition [0.09*safezoneW, 0.005* safezoneH, 0.04 * safezoneW, _hight*0.7];
	_ctrl ctrlSetText _pic;
	_ctrl ctrlCommit 0;

	//Available Kits
	_ctrl = _disp ctrlCreate ["RscStructuredText",_idc+300,_buttonCtrlGroup];
	_ctrl ctrlSetPosition [0.08*safezoneW, 0.04* safezoneH, 0.06 * safezoneW, _hight*0.3];
	_ctrl ctrlCommit 0;

	//Level
	_ctrl = _disp ctrlCreate ["RscStructuredText",_idc+400,_buttonCtrlGroup];
	_ctrl ctrlSetPosition [0.001*safezoneW, 0.04* safezoneH, 0.06 * safezoneW, _hight*0.3];
	_ctrl ctrlCommit 0;
};

private ["_cfg","_displayname","_pic","_availableRoles","_minPlayersForKit","_maxKitsInGroup","_maxKitsInSide","_hight","_roleSummery","_idc","_ctrlGroup","_xPos","_yPos","_space","_cfgName"];

_availableRoles = [];
_cfg = if (isClass (missionconfigFile >> "MCC_loadouts" )) then {(missionconfigFile >> "MCC_loadouts")} else {(configFile >> "MCC_loadouts")};

_space = 0.005* safezoneH;
_xPos = 0;
_yPos = _space + 0;
_hight = 0.06* safezoneH;
_ctrlGroup =_disp displayCtrl 2302;

//Let's build the control buttons
for "_i" from 0 to (count _cfg -1) do {
	_cfgName = configName (_cfg select _i);
	_displayname = getText((_cfg select _i)>> "name");
	_pic = getText((_cfg select _i)>> "picture");
	_minPlayersForKit = getNumber((_cfg select _i)>> "minPlayersForKit");
	_maxKitsInGroup = getNumber((_cfg select _i)>> "maxKitsInGroup");
	_maxKitsInSide = getNumber((_cfg select _i)>> "maxKitsInSide");
	_idc = _i + 500;

	_roleSummery = [_cfgName, _displayname,_pic,_minPlayersForKit,_maxKitsInGroup,_maxKitsInSide];

	//create the control
	_null = [_disp,_idc,_ctrlGroup,_hight,_roleSummery] call _createRoleButton;

	_availableRoles pushBack _roleSummery;

	(_disp displayCtrl _idc) ctrlSetPosition [_xPos*safezoneW, _yPos, 0.2 * safezoneW, _hight];
	(_disp displayCtrl _idc) ctrlCommit 0;

	_yPos = _yPos + _hight + _space;
};

//Gear stats
[CP_GEARPANEL_IDD] call MCC_fnc_playerStats;

0 spawn {
	private ["_array","_disp","_activeSides","_commander","_commanderName","_oldCommander","_cfg","_cfgName","_minPlayersForKit","_maxKitsInSide","_maxKitsInGroup","_countRole","_idc"];
	disableSerialization;

	_cfg = if (isClass (missionconfigFile >> "MCC_loadouts" )) then {(missionconfigFile >> "MCC_loadouts")} else {(configFile >> "MCC_loadouts")};
	_oldCommander =  "";

	while {dialog && (missionNamespace getVariable ["CP_gearPanelOpen",false])} do {
		_disp = CP_GEARPANEL_IDD;

		missionNamespace setVariable ["MCCActiveSpawnPosArray",[player] call BIS_fnc_getRespawnPositions];

		//Load available resources
		_array = call compile format ["MCC_res%1",playerside];
		{_disp displayCtrl _x ctrlSetText str floor (_array select _forEachIndex)} foreach [81,82,83,84,85];

		//Clear unavailable spawn points
		{
			if (typeName _x != "GROUP") then {
				if (! (alive _x) || _x getVariable ["dead",false]) then {[player, _x] call BIS_fnc_removeRespawnPosition};
			}
		} foreach (missionNamespace getVariable "MCCActiveSpawnPosArray");

		//Time
		_t = if ((estimatedEndServerTime - serverTime)>0) then {[estimatedEndServerTime - serverTime] call MCC_fnc_time} else {"00:00:00"};
		ctrlSetText [1919,_t];

		//Tickets
		if (missionNamespace getVariable ["CP_activated",false]) then {
			_activeSides = [] call MCC_fnc_getActiveSides;

			_idc = 22;
			{
				ctrlSetText [_idc, str ([_x] call BIS_fnc_respawnTickets)];
				_idc = _idc + 2;
			} foreach _activeSides;
		};

		//Commander name
		_commander = MCC_server getVariable [format ["CP_commander%1",side player],""];

		//We have a new commander
		if (_oldCommander != _commander) then {
			//Get commanderName
			_commanderName = "";
			{
				if ((getPlayerUID _x) == _commander) then {_commanderName = name _x};
			} foreach allplayers;

			if (_commander == "") then {
				(_disp displayCtrl 919192) ctrlSetText "Take";
			} else {
				if (_commander == getPlayerUID player) then	{
					(_disp displayCtrl 919192) ctrlSetText "Leave";
				} else {
					(_disp displayCtrl 919192) ctrlSetText "Mutiny";
				};
			};

			(_disp displayCtrl 919191) ctrlSetText _commanderName;
			_oldCommander = _commander;
		};

		//Update roles
		for "_i" from 0 to (count _cfg -1) do {
			_cfgName = configName (_cfg select _i);
			_minPlayersForKit = getNumber((_cfg select _i)>> "minPlayersForKit");
			_maxKitsInGroup = getNumber((_cfg select _i)>> "maxKitsInGroup");
			_maxKitsInSide = getNumber((_cfg select _i)>> "maxKitsInSide");
			_idc = _i+ 500;

			//Update levels
			(_disp displayCtrl (_idc + 400)) ctrlSetStructuredText parseText format ["<t color='#ffffff' size='0.8' shadow='1' align='cent'>Level: %1</t><br/><br/>", call compile format ["%1Level select 0",toLower _cfgName]];

			_countRole = {(_x getvariable "CP_role") == _cfgName} count units player;
			_countRoleSide = {(_x getvariable "CP_role") == _cfgName && side _x ==  (player getVariable ["CP_side",  playerside])} count allplayers;

			(_disp displayCtrl (_idc + 300)) ctrlSetStructuredText parseText format ["<t color='#ffffff' size='0.8' shadow='1' align='right'>Kits: %1</t><br/><br/>", (_maxKitsInGroup - _countRole) min (_maxKitsInSide - _countRoleSide)];

			(_disp displayCtrl (_idc + 200)) ctrlEnable ((_countRole < _maxKitsInGroup && count units player >= _minPlayersForKit) || _cfgName == (player getvariable ["CP_role",""]));
		};

		sleep 0.01;
	};
};
