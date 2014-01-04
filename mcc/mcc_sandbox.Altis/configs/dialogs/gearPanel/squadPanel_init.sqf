private ["_disp","_comboBox","_index","_displayname","_groups"];
disableSerialization;

_disp = _this select 0;
uiNamespace setVariable ["CP_SQUADPANEL_IDD", _disp];
uiNamespace setVariable ["CP_squadPanelSquadList", _disp displayCtrl 0];
uiNamespace setVariable ["CP_squadPanelPlayersList", _disp displayCtrl 1];
uiNamespace setVariable ["CP_squadsPanelActiveSquadTittle", _disp displayCtrl 2];
uiNamespace setVariable ["CP_squadPanelJoinButton", _disp displayCtrl 3];
uiNamespace setVariable ["CP_squadPanelCreateSquadText", _disp displayCtrl 4];
uiNamespace setVariable ["CP_squadPanelCreateSquadButton", _disp displayCtrl 5];
uiNamespace setVariable ["CP_gearPanelPiP", _disp displayCtrl 6];
uiNamespace setVariable ["CP_InfoText", _disp displayCtrl 7];

#define CP_SQUADPANEL_IDD (uiNamespace getVariable "CP_SQUADPANEL_IDD")
#define CP_squadPanelSquadList (uiNamespace getVariable "CP_squadPanelSquadList")
#define CP_squadPanelPlayersList (uiNamespace getVariable "CP_squadPanelPlayersList")
#define CP_squadsPanelActiveSquadTittle (uiNamespace getVariable "CP_squadsPanelActiveSquadTittle")
#define CP_squadPanelJoinButton (uiNamespace getVariable "CP_squadPanelJoinButton")
#define CP_squadPanelCreateSquadText (uiNamespace getVariable "CP_squadPanelCreateSquadText")
#define CP_squadPanelCreateSquadButton (uiNamespace getVariable "CP_squadPanelCreateSquadButton")
#define CP_gearPanelPiP (uiNamespace getVariable "CP_gearPanelPiP")
#define CP_InfoText (uiNamespace getVariable "CP_InfoText")

CP_respawnPanelOpen = false;
CP_groupPanelOpen	= true; 

//Disable Esc while respawn is on
CP_disableEsc = CP_SQUADPANEL_IDD displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"]; 

_groups	 = switch (side player) do	{
					case west:			{CP_westGroups};
					case east:			{CP_eastGroups};
					case resistance:	{CP_guarGroups};
					default				{CP_guarGroups};
				};
				
//Load active Groups
_comboBox = CP_squadPanelSquadList; 
lbClear _comboBox;
	{
		_displayname = _x select 1;
		_index = _comboBox lbAdd _displayname;
	} foreach _groups;
_comboBox lbSetCurSel 0;

[] spawn {
			private ["_comboBox","_displayname","_index","_groups","_array"];
			disableSerialization;
			while {dialog && CP_groupPanelOpen} do {
				_groups	 = switch (side player) do	{
					case west:			{CP_westGroups};
					case east:			{CP_eastGroups};
					case resistance:	{CP_guarGroups};
				};
				
				_array = []; 
				{
					_array set [count _array, _x select 0]; 
				} foreach _groups; 
				
				//Change leave/join squad
				if ((group player) in _array) then {
					CP_squadPanelJoinButton ctrlSetText "Leave Squad";
					} else {
							CP_squadPanelJoinButton ctrlSetText "Join Squad";
						};
				
				//Disable leaving squad 
				if (! isnil "CP_activeGroup") then {
					if ((ctrlText CP_squadPanelJoinButton == "Leave Squad") && (CP_activeGroup select 0 != (group player))) then {
						CP_squadPanelJoinButton ctrlenable false; 
						} else	{
								CP_squadPanelJoinButton ctrlenable true; 
							};
				};
						
				//Load active Groups
				_comboBox = CP_squadPanelSquadList; 
				lbClear _comboBox;
					{
						_displayname = _x select 1;
						_index = _comboBox lbAdd _displayname;
					} foreach _groups;
				
				//Rename Squad
				if (! isnil "CP_activeGroup") then {
					if (player == leader (CP_activeGroup select 0)) then {
						CP_squadPanelCreateSquadButton ctrlSetText "Rename Squad";
						} else {
								CP_squadPanelCreateSquadButton ctrlSetText "Create Squad";
							};
				}; 
				
				sleep 0.1; 
				};
		};