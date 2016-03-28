private ["_disp","_comboBox","_activeSides","_idc","_sidePlayer"];
disableSerialization;

_disp = _this select 0;
uiNamespace setVariable ["CP_RESPAWNPANEL_IDD", _disp];
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

#define CP_RESPAWNPANEL_IDD (uiNamespace getVariable "CP_RESPAWNPANEL_IDD")
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
#define CP_CreateSquadName (uiNamespace getVariable "CP_CreateSquadName")

#define CP_maxUnits 10

//Respawn panel indecator
missionNamespace setVariable ["CP_respawnPanelOpen",true];

//If we did not got here after respawn
if (player getVariable ["cpReady",true]) then {
	{
		(_disp displayCtrl _x) ctrlShow false;
	} forEach [28,29,4,32,44,1006];
} else {
	CP_deployPanelMiniMap ctrlAddEventHandler ["Draw","_this call MCC_fnc_mapDrawPlayersWPConsole"];
};

//Roles enables or just after regular respawn
if !(CP_activated) then {
	{
		_x ctrlshow false;
	} foreach [CP_ticketsWestText,CP_ticketsEastText,CP_side1,CP_side1Score,CP_side2,CP_side2Score,CP_side3,CP_side3Score];

	for "_i" from 27 to 29 do {
		ctrlshow [_i,false];
	};
};

MCC_CPMap_mouseMoving =
{
	missionNamespace setVariable ["MC_MWMap_mousePos",[_this select 1,_this select 2]];
};

MCC_CPMap_mouseUp =
{
	private ["_selected"];
	_selected = missionNameSpace getVariable ["MCCSpawnPosSelected",[]];
	//Not a valid start location

	if (typeName _selected == "ARRAY") exitWith {};
	if !(_selected in (missionNamespace getVariable ["MCCActiveSpawnPosArray",[]])) exitWith {};

	missionNamespace setVariable ["CP_activeSpawn",_selected];
};

MCC_fnc_CPMapOpen_draw =
{
	private ["_spawnArray","_textureAnimPhase","_color"];
	_map = _this select 0;
	_display = ctrlparent _map;
	_time = diag_ticktime;

	_mousePos = _map ctrlmapscreentoworld (missionNamespace getVariable ["MC_MWMap_mousePos",[0.5,0.5]]);
	_mouseLimit = 3.5 / safezoneh;
	missionNamespace setVariable ["MCCSpawnPosSelected",[]];

	_spawnArray = (missionNamespace getVariable "MCCActiveSpawnPosArray");

	_alpha = 0.95;

	{
		_size = 22;
		_dir = 0;

		//Animate if selected
		if (str (missionNamespace getVariable ["CP_activeSpawn",objNull])== str _x) then {
			_textureAnimPhase = abs(6 - floor (_time * 16) % 12);
			_color = [0,1,1,_alpha];
		} else {
			_textureAnimPhase = 0;
			_color = [1,1,1,_alpha];
		};

		_pos = if (typeName _x == "GROUP") then {getpos leader _x} else {getpos _x};
		_title = if (typeName _x == "GROUP") then {
					format ["%1 - %2",(_foreachIndex +1), "Leader"];
				} else {
					format ["%1- %2",(_foreachIndex +1), _x getvariable ["type","FOB"]];
				};

		_texture = format ["\A3\Ui_f\data\Map\GroupIcons\badge_rotate_%1_gs.paa",_textureAnimPhase];

		//--- Icon is under cursor
		if ((_pos distance _mousePos) < (_mouseLimit * _size * (ctrlMapScale (uiNamespace getVariable "CP_deployPanelMiniMap") *7))) then {
			_size = _size * 1.6;
			_alpha = 1;
			missionNamespace setVariable ["MCCSpawnPosSelected",_x];
		};

		_map drawIcon [
			_texture,
			_color,
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

//Disable Esc while respawn is on
CP_disableEsc = CP_RESPAWNPANEL_IDD displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];

//Find relevent spawn points
missionNamespace setVariable ["MCCActiveSpawnPosArray",[player] call BIS_fnc_getRespawnPositions];

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

//Refresh
[] spawn {
	private ["_comboBox","_idc","_activeSides","_array","_disp","_ctrlGroup","_createGroupButton","_groupCtrls","_groupNames","_oldCommander","_commander"];
	disableSerialization;

	_createGroupButton = {
		params ["_disp","_idc","_ctrlGroup","_hight","_groupName","_group"];
		_buttonCtrlGroup = _disp ctrlCreate ["RscControlsGroupNoScrollbars",_idc,_ctrlGroup];
		_buttonCtrlGroup ctrlSetPosition [0*safezoneW, 0, 0.15 * safezoneW, _hight];
		_buttonCtrlGroup ctrlCommit 0;

		//Button
		_ctrl = _disp ctrlCreate ["RscText",_idc+300,_buttonCtrlGroup];
		_ctrl ctrlSetPosition [0*safezoneW, 0, 0.2 * safezoneW, _hight];
		_ctrl ctrlsetText _groupName;
		_ctrl ctrlSetBackgroundColor [0.292,0.292,0.292,0.9];
		_ctrl ctrlCommit 0;

		//Join
		_ctrl = _disp ctrlCreate ["RscButton",_idc+400,_buttonCtrlGroup];
		_ctrl ctrlSetPosition [0.113*safezoneW, 0.003* safezoneH, 0.025 * safezoneW, _hight*0.8];
		_ctrl ctrlsetText "Join";
		_ctrl ctrlSetBackgroundColor [0,0,0,0.9];
		_ctrl ctrlAddEventHandler ["MouseButtonClick",format ["['%1','%2',%3] spawn MCC_fnc_RSSquadJoin",netId _group, _groupName, _idc-500]];
		_ctrl ctrlCommit 0;

		//Lock
		_ctrl = _disp ctrlCreate ["RscActivePicture",_idc+500,_buttonCtrlGroup];
		_ctrl ctrlSetPosition [0.091*safezoneW, 0.003* safezoneH, 0.015 * safezoneW, _hight*0.8];
		_ctrl ctrlsetText (if (_group getVariable ["locked",false]) then {(MCC_path +"data\locked.paa")} else {(MCC_path +"data\unlocked.paa")});
		_ctrl ctrlAddEventHandler ["MouseButtonClick",format ["[%1] spawn MCC_fnc_RSSquadLock",_idc-500]];
		_ctrl ctrlCommit 0;

		//edit
		_ctrl = _disp ctrlCreate ["RscActivePicture",_idc+600,_buttonCtrlGroup];
		_ctrl ctrlSetPosition [0.055*safezoneW, 0.003* safezoneH, 0.012 * safezoneW, _hight*0.7];
		_ctrl ctrlsetText (MCC_path +"mcc\roleSelection\data\edit.paa");
		_ctrl ctrlAddEventHandler ["MouseButtonClick",format ["[%1,%2,_this select 0] spawn MCC_fnc_RSSquadRename",_idc-500,_idc]];
		_ctrl ctrlCommit 0;

		//units count
		_ctrl = _disp ctrlCreate ["RscText",_idc+800,_buttonCtrlGroup];
		_ctrl ctrlSetPosition [0.07*safezoneW, 0.003* safezoneH, 0.02 * safezoneW, _hight*0.7];
		_ctrl ctrlSetFontHeight (((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8);
		_ctrl ctrlsetText "";
		_ctrl ctrlCommit 0;
	};

	_disp = CP_RESPAWNPANEL_IDD;
	if (count ([player] call BIS_fnc_getRespawnPositions)>0) then {
		CP_deployPanelMiniMap ctrlmapAnimAdd [0, 0.2, (position (([player] call BIS_fnc_getRespawnPositions) select 0))];
		ctrlmapAnimCommit CP_deployPanelMiniMap;
	};

	_ctrlGroup =_disp displayCtrl 2302;
	_groupNames = [];
	_oldCommander =  "";

	while {dialog && (missionNamespace getVariable ["CP_respawnPanelOpen",false])} do {

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

		//Tickets && XP
		if (missionNamespace getVariable ["CP_activated",false]) then {
			_activeSides = [] call MCC_fnc_getActiveSides;

			_idc = 22;
			{
				ctrlSetText [_idc, str ([_x] call BIS_fnc_respawnTickets)];
				_idc = _idc + 2;
			} foreach _activeSides;
		};

		//Groups
		private ["_groups","_group","_xPos","_yPos","_space","_ctrl","_groupName","_ctrlUnits","_buttonCtrlGroup"];
		if (str (side player) == "ENEMY") then {player addrating (abs (rating player))};
		_groups	 = switch (player getVariable ["CP_side", playerside]) do {
						case west:			{CP_westGroups};
						case east:			{CP_eastGroups};
						case resistance:	{CP_guarGroups};
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

		_xPos = 0;
		_yPos = 0;
		_space = 0.001* safezoneH;
		_hight = 0.03* safezoneH;
		_lbHight = 0.023* safezoneH;
		_ctrl = controlNull;
		_ctrlUnits = nil;

		{
			_group = (_x select 0);
			_groupName = (_x select 1);

			//Not exist
			if !(_foreachIndex in _groupNames) then {
				_groupNames pushBack _foreachIndex;
				_idc = _foreachIndex+500;
				_null = [_disp,_idc,_ctrlGroup,_hight,_groupName,_group] call _createGroupButton;
			};

			_idc = _foreachIndex+500;

			//Have IDC but no control
			if ((isnull (_disp displayCtrl _idc) || !ctrlShown (_disp displayCtrl _idc))) then {
				if (isnull (_disp displayCtrl _idc)) then {
					_null =[_disp,_idc,_ctrlGroup,_hight,_groupName,_group] call _createGroupButton;
				} else {
					(_disp displayCtrl _idc) ctrlShow true;
				};
			};

			//Set group name again if it has been edited
			(_disp displayCtrl _idc+300) ctrlsetText _groupName;
			(_disp displayCtrl _idc) ctrlCommit 0;

			//Number of units
			(_disp displayCtrl _idc+800) ctrlsetText format ["%1/%2",count units _group, CP_maxUnits];
			(_disp displayCtrl _idc) ctrlCommit 0;

			if (ctrlShown (_disp displayCtrl _idc) && !isNull(_disp displayCtrl _idc)) then {
				(_disp displayCtrl _idc) ctrlSetPosition [_xPos*safezoneW, _yPos, 0.2 * safezoneW, _hight];
				(_disp displayCtrl _idc) ctrlCommit 0;

				//disable buttons
				(_disp displayCtrl _idc+400) ctrlenable !(group player == _group);
				(_disp displayCtrl _idc+500) ctrlsetText (if (_group getVariable ["locked",false]) then {(MCC_path +"data\locked.paa")} else {(MCC_path +"data\unlocked.paa")});
				(_disp displayCtrl _idc+600) ctrlShow (player == leader _group);
				_yPos = _yPos + _hight + _space;

				//Units
				_idc = _idc+100;
				//Have IDC but no control
				if ((isnull (_disp displayCtrl _idc) || !ctrlShown (_disp displayCtrl _idc)) && (count units _group > 0 )) then {
					if (isnull (_disp displayCtrl _idc)) then {
						_ctrl = _disp ctrlCreate ["RscListbox",_idc,_ctrlGroup];
						(_disp displayCtrl _idc) ctrlAddEventHandler ["LBSelChanged",format ["if ((_this select 1) > -1) then {
																							(_this select 0) lbSetCurSel -1;
																							[(_this select 0),((_this select 0) lbData (_this select 1)),(_this select 1),%1] spawn MCC_fnc_RSunitSelected;
																						}",ctrlIDC _ctrlGroup]];
					} else {
						(_disp displayCtrl _idc) ctrlShow true;
					};
				};

				(_disp displayCtrl _idc) ctrlCommit 0;
				if (ctrlShown (_disp displayCtrl _idc) && !isNull(_disp displayCtrl _idc)) then {
					_buffer = count units _group * _lbHight;
					(_disp displayCtrl _idc) ctrlSetPosition [_xPos*safezoneW, _yPos, 0.14 * safezoneW, _buffer];
					(_disp displayCtrl _idc) ctrlCommit 0;

					lbClear (_disp displayCtrl _idc);
					{
						_class			= netId _x;
						_displayname 	= name _x;
						_pic 			= _x getvariable ["CP_roleImage",""];
						_index 			= (_disp displayCtrl _idc) lbAdd _displayname;
						(_disp displayCtrl _idc) lbSetPicture [_index, _pic];
						(_disp displayCtrl _idc) lbSetData [_index, _class];
						if (_x == leader _group) then {(_disp displayCtrl _idc) lbSetPictureRight [_index, "\A3\Ui_f\data\GUI\Cfg\Ranks\colonel_gs.paa"]};
					} forEach units _group;

					_yPos = _yPos + _buffer;
				};
			};

		} forEach _groups;
		sleep 0.01;
	};
};