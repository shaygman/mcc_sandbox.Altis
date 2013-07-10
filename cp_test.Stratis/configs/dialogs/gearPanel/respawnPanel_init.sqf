private ["_disp","_comboBox","_index","_displayname"];
disableSerialization;

_disp = _this select 0;
uiNamespace setVariable ["CP_RESPAWNPANEL_IDD", _disp];
uiNamespace setVariable ["CP_respawnPointsList", _disp displayCtrl 0];
uiNamespace setVariable ["CP_ticketsWestText", _disp displayCtrl 1];
uiNamespace setVariable ["CP_ticketsEastText", _disp displayCtrl 2];
uiNamespace setVariable ["CP_respawnPanelRoleCombo", _disp displayCtrl 3];
uiNamespace setVariable ["CP_deployPanelMiniMap", _disp displayCtrl 4];

#define CP_RESPAWNPANEL_IDD (uiNamespace getVariable "CP_RESPAWNPANEL_IDD")
#define CP_respawnPointsList (uiNamespace getVariable "CP_respawnPointsList")
#define CP_ticketsWestText (uiNamespace getVariable "CP_ticketsWestText")
#define CP_ticketsEastText (uiNamespace getVariable "CP_ticketsEastText")
#define CP_respawnPanelRoleCombo (uiNamespace getVariable "CP_respawnPanelRoleCombo")
#define CP_deployPanelMiniMap (uiNamespace getVariable "CP_deployPanelMiniMap")

//Respawn panel indecator
CP_respawnPanelOpen = true; 

//Disable Esc while respawn is on
CP_disableEsc = CP_RESPAWNPANEL_IDD displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"]; 

//Clear unavailable spawn points
{
	if (!alive _x) then {CP_westSpawnPoints =  CP_westSpawnPoints - [_x]; publicVariable "CP_westSpawnPoints"};
} foreach CP_westSpawnPoints; 

{
	if (!alive _x) then {CP_eastSpawnPoints =  CP_eastSpawnPoints - [_x]; publicVariable "CP_eastSpawnPoints"};
} foreach CP_eastSpawnPoints; 

//Load respawn points
_comboBox = CP_respawnPointsList; 
lbClear _comboBox;
	{
		_displayname = _x getvariable "type";
		//_pic = _x select 2;
		_index = _comboBox lbAdd _displayname;
	} foreach (if ((side player)== west) then {CP_westSpawnPoints} else {CP_eastSpawnPoints});
_comboBox lbSetCurSel CP_respawnPointsIndex;

//Load Classes
_comboBox = CP_respawnPanelRoleCombo; 
lbClear _comboBox;
	{
		_displayname = _x;
		//_pic = _x select 2;
		_index = _comboBox lbAdd _displayname;
	} foreach CP_classes;
_comboBox lbSetCurSel CP_classesIndex;

[] spawn {
			private ["_comboBox","_displayname","_index"];
			disableSerialization;
			while {dialog && CP_respawnPanelOpen} do {
					//Tickets
					CP_ticketsWestText ctrlSetText format ["WEST: %1",CP_westTickets];
					CP_ticketsEastText ctrlSetText format ["EAST: %1",CP_eastTickets];
					
					//Load respawn points
					_comboBox = CP_respawnPointsList; 
					lbClear _comboBox;
						{
							_displayname = format ["(%1) - %2",_x getvariable "side", _x getvariable "type"];
							//_pic = _x select 2;
							_index = _comboBox lbAdd _displayname;
						} foreach (if ((side player)== west) then {CP_westSpawnPoints} else {CP_eastSpawnPoints});
					//_comboBox lbSetCurSel CP_respawnPointsIndex;
					sleep 3; 
				};
		};