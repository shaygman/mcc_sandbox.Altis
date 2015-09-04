private ["_disp","_comboBox","_index","_displayname","_html","_activeSides","_idc","_sidePlayer"];
disableSerialization;

_disp = _this select 0;
uiNamespace setVariable ["CP_RESPAWNPANEL_IDD", _disp];
uiNamespace setVariable ["CP_respawnPointsList", _disp displayCtrl 0];
uiNamespace setVariable ["CP_ticketsWestText", _disp displayCtrl 1];
uiNamespace setVariable ["CP_ticketsEastText", _disp displayCtrl 2];
uiNamespace setVariable ["CP_respawnPanelRoleCombo", _disp displayCtrl 99];
uiNamespace setVariable ["CP_deployPanelMiniMap", _disp displayCtrl 4];
uiNamespace setVariable ["CP_gearPanelPiP", _disp displayCtrl 5];
uiNamespace setVariable ["CP_InfoText", _disp displayCtrl 6];

uiNamespace setVariable ["CP_flag", _disp displayCtrl 20];
uiNamespace setVariable ["CP_side1", _disp displayCtrl 21];
uiNamespace setVariable ["CP_side1Score", _disp displayCtrl 22];
uiNamespace setVariable ["CP_side2", _disp displayCtrl 23];
uiNamespace setVariable ["CP_side2Score", _disp displayCtrl 24];
uiNamespace setVariable ["CP_side3", _disp displayCtrl 25];
uiNamespace setVariable ["CP_side3Score", _disp displayCtrl 26];

uiNamespace setVariable ["CP_RscMainXPUI", _disp displayCtrl 101];
uiNamespace setVariable ["messeges", _disp displayCtrl 102];
uiNamespace setVariable ["XPTitle", _disp displayCtrl 103];
uiNamespace setVariable ["XPValue", _disp displayCtrl 104];

#define CP_RESPAWNPANEL_IDD (uiNamespace getVariable "CP_RESPAWNPANEL_IDD")
#define CP_respawnPointsList (uiNamespace getVariable "CP_respawnPointsList")
#define CP_ticketsWestText (uiNamespace getVariable "CP_ticketsWestText")
#define CP_ticketsEastText (uiNamespace getVariable "CP_ticketsEastText")
#define CP_respawnPanelRoleCombo (uiNamespace getVariable "CP_respawnPanelRoleCombo")
#define CP_deployPanelMiniMap (uiNamespace getVariable "CP_deployPanelMiniMap")
#define CP_gearPanelPiP (uiNamespace getVariable "CP_gearPanelPiP")
#define CP_InfoText (uiNamespace getVariable "CP_InfoText")

#define CP_flag (uiNamespace getVariable "CP_flag")
#define CP_side1 (uiNamespace getVariable "CP_side1")
#define CP_side1Score (uiNamespace getVariable "CP_side1Score")
#define CP_side2 (uiNamespace getVariable "CP_side2")
#define CP_side2Score (uiNamespace getVariable "CP_side2Score")
#define CP_side3 (uiNamespace getVariable "CP_side3")
#define CP_side3Score (uiNamespace getVariable "CP_side3Score")

#define CP_RscMainXPUI (uiNamespace getVariable "CP_RscMainXPUI")
#define messeges (uiNamespace getVariable "messeges")
#define XPTitle (uiNamespace getVariable "XPTitle")
#define XPValue (uiNamespace getVariable "XPValue")

//Roles enables or just after regular respawn
if !(CP_activated) then
{
	{
		_x ctrlshow false;
	} foreach [CP_ticketsWestText,CP_ticketsEastText,CP_respawnPanelRoleCombo,CP_gearPanelPiP,CP_side1,CP_side1Score,CP_side2,CP_side2Score,CP_side3,CP_side3Score];

	for "_i" from 27 to 31 do
	{
		ctrlshow [_i,false];
	};

	(_disp displayCtrl 32) ctrlSetPosition [0.815 * safezoneW + safezoneX, 0.741906 * safezoneH + safezoneY, 0.0973958 * safezoneW, 0.0439828 * safezoneH];
	(_disp displayCtrl 32) ctrlCommit 0;

	CP_flag ctrlSetPosition [0.155 * safezoneW + safezoneX, 0.207514 * safezoneH + safezoneY, 0.0916667 * safezoneW, 0.07697 * safezoneH];
	CP_flag ctrlCommit 0;

	CP_deployPanelMiniMap  ctrlSetPosition [0.36 * safezoneW + safezoneX, 0.3 * safezoneH + safezoneY, 0.55 * safezoneW, 0.41 * safezoneH];
	CP_deployPanelMiniMap ctrlCommit 0;
	CP_RscMainXPUI ctrlShow false;
};

MCC_CPMap_mouseMoving =
{
	MC_MWMap_mousePos = [_this select 1,_this select 2];
};

MCC_CPMap_mouseUp =
{
	private ["_index","_selected"];
	_selected = missionNameSpace getVariable ["MCCSpawnPosSelected",[]];
	if (typeName _selected == "ARRAY") exitWith {};

	_index = (missionNamespace getVariable ["MCCActiveSpawnPosArray",[]]) find _selected;
	CP_respawnPointsList lbSetCurSel _index;
};

MCC_fnc_CPMapOpen_draw =
{
	private ["_spawnArray"];
	_map = _this select 0;
	_display = ctrlparent _map;
	_time = diag_ticktime;

	_mousePos = _map ctrlmapscreentoworld MC_MWMap_mousePos;
	_mouseLimit = 3.5 / safezoneh;
	missionNamespace setVariable ["MCCSpawnPosSelected",[]];

	_spawnArray = (missionNamespace getVariable "MCCActiveSpawnPosArray");

	_textureAnimPhase = abs(6 - floor (_time * 16) % 12);
	{
		_pos = if (typeName _x == "GROUP") then {getpos leader _x} else {getpos _x};
		_title = if (typeName _x == "GROUP") then
				{
					format ["%1 - %2",(_foreachIndex +1), "Leader"];
				}
				else
				{
					format ["%1- %2",(_foreachIndex +1), _x getvariable ["type","FOB"]];
				};
		_size = 22;
		_dir = 0;
		_alpha = 0.65;
		_texture = format ["\A3\Ui_f\data\Map\GroupIcons\badge_rotate_%1_gs.paa",_textureAnimPhase];

		//--- Icon is under cursor
		if ((_pos distance _mousePos) < (_mouseLimit * _size * (ctrlMapScale (uiNamespace getVariable "CP_deployPanelMiniMap") *7))) then
		{
			_size = _size * 1.6;
			_alpha = 1;
			missionNamespace setVariable ["MCCSpawnPosSelected",_x];
		};

		_map drawIcon [
			_texture,
			[0,1,1,_alpha],
			_pos,
			_size,
			_size,
			_dir,
			" " + _title,
			2,
			0.08,
			"PuristaBold"
		];
	} foreach _spawnArray;
};

_sidePlayer = player getVariable ["CP_side", side player];

//Draw Icons
_map = uiNameSpace getVariable "CP_deployPanelMiniMap";
_map ctrladdeventhandler ["draw","_this call MCC_fnc_CPMapOpen_draw;"];
_map ctrladdeventhandler ["mousemoving","_this call MCC_CPMap_mouseMoving;"];
_map ctrladdeventhandler ["mouseholding","_this call MCC_CPMap_mouseMoving;"];
_map ctrladdeventhandler ["MouseButtonUp","_this call MCC_CPMap_mouseUp;"];

//Respawn panel indecator
CP_respawnPanelOpen = true;

//Disable Esc while respawn is on
CP_disableEsc = CP_RESPAWNPANEL_IDD displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];

//Find relevent spawn points
missionNamespace setVariable ["MCCActiveSpawnPosArray",[player] call BIS_fnc_getRespawnPositions];

//Find relevent spawn points again (After cleanup)
missionNamespace setVariable ["MCCActiveSpawnPosArray",[player] call BIS_fnc_getRespawnPositions];

//Set side flag
CP_flag ctrlSetText (missionNamespace getVariable [format ["CP_flag%1", _sidePlayer],""]);

if (CP_activated) then
{
	//Sets sides Tickets
	if (CP_activated) then
	{
		_activeSides = [] call MCC_fnc_getActiveSides;

		_idc = 21;
		{
			ctrlSetText [_idc, str _x];
			_idc = _idc + 2;
		} foreach _activeSides;
	};


	//Load Classes
	_comboBox = CP_respawnPanelRoleCombo;
	lbClear _comboBox;
		{
			_displayname = _x;
			_pic = CP_classesPic select _forEachIndex;
			_index = _comboBox lbAdd _displayname;
			_comboBox lbsetpicture [_index,_pic];
		} foreach CP_classes;
	_comboBox lbSetCurSel CP_classesIndex;

	//Set XP
	_role = player getvariable "CP_role";
	if (isnil "_role") exitWith {};

	_exp 	 = call compile format  ["%1Level select 1",_role];
	if (isnil "_exp") exitWith {};

	if (_exp < 0) then {_exp = 0};
	_oldLevel = call compile format  ["%1Level select 0",_role];
	_html = "<t color='#818960' size='2' shadow='1' align='center' underline='false'>"+ _role+ " Level " + str _oldLevel + "</t>";
	messeges ctrlSetStructuredText parseText _html;

	_needXP 			= (CP_XPperLevel * _oldLevel);
	_needXPPrevLevel 	= (CP_XPperLevel * (_oldLevel-1));
	XPValue progressSetPosition (1-((_needXP-_exp)/(_needXP - _needXPPrevLevel)));


};

//Gear stats
[CP_RESPAWNPANEL_IDD] call MCC_fnc_playerStats;

//Refresh
[] spawn
	{
		private ["_comboBox","_displayname","_index","_idc","_activeSides","_sidePlayer","_leader","_firstTime","_array","_disp"];
		disableSerialization;

		_firstTime = true;
		while {dialog && CP_respawnPanelOpen} do {

			_sidePlayer = player getVariable ["CP_side", side player];
			missionNamespace setVariable ["MCCActiveSpawnPosArray",[player] call BIS_fnc_getRespawnPositions];

			_groups	 = switch (player getVariable ["CP_side", playerside]) do
						{
							case west:			{CP_westGroups};
							case east:			{CP_eastGroups};
							case resistance:	{CP_guarGroups};
						};

			_array = [];
			{
				_array set [count _array, _x select 0];
			} foreach _groups;

			//Load available resources
			_disp = CP_RESPAWNPANEL_IDD;
			_array = call compile format ["MCC_res%1",playerside];
			{_disp displayCtrl _x ctrlSetText str floor (_array select _forEachIndex)} foreach [81,82,83,84,85];

			/*
			//Add group leader as spawn point
			_leader = leader player;

			if (!(group player in (missionNamespace getVariable "MCCActiveSpawnPosArray")) && group player in _array) then
			{

				if (alive _leader && (_leader getVariable ["cpReady",true]) && _leader != player) then
				{
					_index = ([player, group player] call BIS_fnc_addRespawnPosition) select 1;
					player setVariable ["CPRespawnLeadedrIndex",_index, true];
				};
			}
			else
			{
				if (!(alive _leader) || !(_leader getVariable ["cpReady",true]) || _leader == player) then
				{
					[player, player getVariable "CPRespawnLeadedrIndex"] call BIS_fnc_removeRespawnPosition
				};
			};
			*/

			//Clear unavailable spawn points
			{
				if (typeName _x != "GROUP") then
				{
					if (! (alive _x) || _x getVariable ["dead",false]) then {[player, _x] call BIS_fnc_removeRespawnPosition};
				}
			} foreach (missionNamespace getVariable "MCCActiveSpawnPosArray");

			//Time
			_t = if ((estimatedEndServerTime - serverTime)>0) then {[estimatedEndServerTime - serverTime] call MCC_fnc_time} else {""};
			ctrlSetText [1919,_t];

			//Tickets
			if (CP_activated) then
			{
				_activeSides = [] call MCC_fnc_getActiveSides;

				_idc = 22;
				{
					ctrlSetText [_idc, str ([_x] call BIS_fnc_respawnTickets)];
					_idc = _idc + 2;
				} foreach _activeSides;
			};

			//Load respawn points
			uinameSpace setVariable ["cpLoadingSpawnPoints",true];

			_comboBox = CP_respawnPointsList;
			lbClear _comboBox;
				{
					_displayname = if (typeName _x == "GROUP") then
							{
								format ["( %1 ) - %2",(_foreachIndex +1), "Leader"];
							}
							else
							{
								format ["( %1 ) - %2",(_foreachIndex +1), _x getvariable ["type","FOB"]];
							};

					//_pic = _x select 2;
					_index = _comboBox lbAdd _displayname;
				} foreach (missionNamespace getVariable "MCCActiveSpawnPosArray");
			uinameSpace setVariable ["cpLoadingSpawnPoints",false];
			if (_firstTime) then {_firstTime = false; _comboBox lbSetCurSel CP_respawnPointsIndex};
			sleep 1;
		};
	};