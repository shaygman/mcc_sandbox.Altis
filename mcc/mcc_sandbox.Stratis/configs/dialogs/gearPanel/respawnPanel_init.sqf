private ["_disp","_comboBox","_index","_displayname","_html","_spawnArray"];
disableSerialization;

_disp = _this select 0;
uiNamespace setVariable ["CP_RESPAWNPANEL_IDD", _disp];
uiNamespace setVariable ["CP_respawnPointsList", _disp displayCtrl 0];
uiNamespace setVariable ["CP_ticketsWestText", _disp displayCtrl 1];
uiNamespace setVariable ["CP_ticketsEastText", _disp displayCtrl 2];
uiNamespace setVariable ["CP_respawnPanelRoleCombo", _disp displayCtrl 3];
uiNamespace setVariable ["CP_deployPanelMiniMap", _disp displayCtrl 4];
uiNamespace setVariable ["CP_gearPanelPiP", _disp displayCtrl 5];
uiNamespace setVariable ["CP_InfoText", _disp displayCtrl 6];

#define CP_RESPAWNPANEL_IDD (uiNamespace getVariable "CP_RESPAWNPANEL_IDD")
#define CP_respawnPointsList (uiNamespace getVariable "CP_respawnPointsList")
#define CP_ticketsWestText (uiNamespace getVariable "CP_ticketsWestText")
#define CP_ticketsEastText (uiNamespace getVariable "CP_ticketsEastText")
#define CP_respawnPanelRoleCombo (uiNamespace getVariable "CP_respawnPanelRoleCombo")
#define CP_deployPanelMiniMap (uiNamespace getVariable "CP_deployPanelMiniMap")
#define CP_gearPanelPiP (uiNamespace getVariable "CP_gearPanelPiP")
#define CP_InfoText (uiNamespace getVariable "CP_InfoText")

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

{
	if (!alive _x) then {CP_guarSpawnPoints =  CP_guarSpawnPoints - [_x]; publicVariable "CP_guarSpawnPoints"};
} foreach CP_guarSpawnPoints;

_spawnArray	 = switch (side player) do	{
					case west:			{CP_westSpawnPoints};
					case east:			{CP_eastSpawnPoints};
					case resistance:	{CP_guarSpawnPoints};
					default				{CP_guarSpawnPoints};
				};
//Load respawn points
_comboBox = CP_respawnPointsList; 
lbClear _comboBox;
	{
		_displayname = _x getvariable "type";
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

waituntil {! isnil "playerLevel"}; 
//Add Info sheet data
_html = "<t color='#8E8B8A' size='1' shadow='1' align='left' underline='true'>" + name player + "Level" + str (playerLevel select 0)
		+ "</t><br/><br/>";
/*_html = _html + "<t color='#a9b08e' size='2' shadow='0' shadowColor='#312100' align='left' >" + 
		name player + "<br/>" +
		"Smooth placing: " + MCC_smooth3DText + "</t>";
	*/
CP_InfoText ctrlSetStructuredText parseText(_html);
	
[_spawnArray] spawn {
			private ["_comboBox","_displayname","_index","_spawnArray"];
			disableSerialization;
			_spawnArray = _this select 0;
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
						} foreach _spawnArray;
					//_comboBox lbSetCurSel CP_respawnPointsIndex;
					sleep 3; 
				};
		};