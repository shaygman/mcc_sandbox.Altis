private ["_disp","_comboBox","_index","_displayname","_html","_spawnArray","_activeSides","_idc","_sidePlayer"];
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

_sidePlayer = player getVariable ["CP_side", side player];
//Respawn panel indecator
CP_respawnPanelOpen = true; 

//Disable Esc while respawn is on
CP_disableEsc = CP_RESPAWNPANEL_IDD displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"]; 

//Find relevent spawn points
_spawnArray = [_sidePlayer] call BIS_fnc_getRespawnPositions; 

//Clear unavailable spawn points
{
	if (_x getVariable ["dead",false]) then {[_sidePlayer, _x] call BIS_fnc_removeRespawnPosition};
} foreach _spawnArray;

//Set side flag
CP_flag ctrlSetText call compile format ["CP_flag%1", _sidePlayer];

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
		
//Load respawn points
_comboBox = CP_respawnPointsList; 
lbClear _comboBox;
	{
		_displayname = _x getvariable ["type","FOB"];
		//_pic = _x select 2;
		_index = _comboBox lbAdd _displayname;
	} foreach _spawnArray;
_comboBox lbSetCurSel CP_respawnPointsIndex;

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

//Refresh	
[] spawn 
	{
		private ["_comboBox","_displayname","_index","_spawnArray","_idc","_activeSides"];
		disableSerialization;
		

		while {dialog && CP_respawnPanelOpen} do 
		{
			_spawnArray = [player getVariable ["CP_side", side player]] call BIS_fnc_getRespawnPositions;
			
			//Tickets
			_activeSides = [] call MCC_fnc_getActiveSides;

			_idc = 22;
			{
				ctrlSetText [_idc, str ([_x] call BIS_fnc_respawnTickets)];
				_idc = _idc + 2;
			} foreach _activeSides;	
			
			//Load respawn points
			_comboBox = CP_respawnPointsList; 
			lbClear _comboBox;
				{
					_displayname = format ["( %1 ) - %2",(_foreachIndex +1), _x getvariable ["type","FOB"]];
					//_pic = _x select 2;
					_index = _comboBox lbAdd _displayname;
				} foreach _spawnArray;
			//_comboBox lbSetCurSel CP_respawnPointsIndex;
			sleep 3; 
		};
	};