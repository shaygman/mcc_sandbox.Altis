private ["_disp","_comboBox","_index","_displayname","_groups","_commander","_commanderName","_idc"];
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
uiNamespace setVariable ["CP_Exit", _disp displayCtrl 8];
uiNamespace setVariable ["CP_respawnButton", _disp displayCtrl 9];
uiNamespace setVariable ["CP_squadButton", _disp displayCtrl 10];
uiNamespace setVariable ["CP_gearButton", _disp displayCtrl 11];
uiNamespace setVariable ["CP_switchSideButton", _disp displayCtrl 12];
uiNamespace setVariable ["CP_respawnPanelBckg", _disp displayCtrl 13];
uiNamespace setVariable ["CP_LockSquad", _disp displayCtrl 14];
uiNamespace setVariable ["CP_Teleport", _disp displayCtrl 15];
uiNamespace setVariable ["CP_commanderName", _disp displayCtrl 16];
uiNamespace setVariable ["CP_Mutiny", _disp displayCtrl 17];

uiNamespace setVariable ["CP_flag", _disp displayCtrl 20];
uiNamespace setVariable ["CP_side1", _disp displayCtrl 21];
uiNamespace setVariable ["CP_side1Score", _disp displayCtrl 22];
uiNamespace setVariable ["CP_side2", _disp displayCtrl 23];
uiNamespace setVariable ["CP_side2Score", _disp displayCtrl 24];
uiNamespace setVariable ["CP_side3", _disp displayCtrl 25];
uiNamespace setVariable ["CP_side3Score", _disp displayCtrl 26];

#define CP_SQUADPANEL_IDD (uiNamespace getVariable "CP_SQUADPANEL_IDD") 
#define CP_squadPanelSquadList (uiNamespace getVariable "CP_squadPanelSquadList")
#define CP_squadPanelPlayersList (uiNamespace getVariable "CP_squadPanelPlayersList")
#define CP_squadsPanelActiveSquadTittle (uiNamespace getVariable "CP_squadsPanelActiveSquadTittle")
#define CP_squadPanelJoinButton (uiNamespace getVariable "CP_squadPanelJoinButton")
#define CP_squadPanelCreateSquadText (uiNamespace getVariable "CP_squadPanelCreateSquadText")
#define CP_squadPanelCreateSquadButton (uiNamespace getVariable "CP_squadPanelCreateSquadButton")
#define CP_gearPanelPiP (uiNamespace getVariable "CP_gearPanelPiP")
#define CP_InfoText (uiNamespace getVariable "CP_InfoText")
#define CP_Exit (uiNamespace getVariable "CP_Exit")
#define CP_respawnButton (uiNamespace getVariable "CP_respawnButton")
#define CP_squadButton (uiNamespace getVariable "CP_squadButton")
#define CP_gearButton (uiNamespace getVariable "CP_gearButton")
#define CP_switchSideButton (uiNamespace getVariable "CP_switchSideButton")
#define CP_respawnPanelBckg (uiNamespace getVariable "CP_respawnPanelBckg")
#define CP_LockSquad (uiNamespace getVariable "CP_LockSquad")
#define CP_Teleport (uiNamespace getVariable "CP_Teleport")
#define CP_commanderName (uiNamespace getVariable "CP_commanderName")
#define CP_Mutiny (uiNamespace getVariable "CP_Mutiny")

#define CP_flag (uiNamespace getVariable "CP_flag")
#define CP_side1 (uiNamespace getVariable "CP_side1")
#define CP_side1Score (uiNamespace getVariable "CP_side1Score")
#define CP_side2 (uiNamespace getVariable "CP_side2")
#define CP_side2Score (uiNamespace getVariable "CP_side2Score")
#define CP_side3 (uiNamespace getVariable "CP_side3")
#define CP_side3Score (uiNamespace getVariable "CP_side3Score")

CP_respawnPanelOpen = false;



//If we got here not after respawn
if (MCC_squadDialogOpen) then
{
	CP_Exit ctrlShow false;
	CP_respawnButton ctrlShow false;
	CP_squadButton ctrlShow false;
	CP_gearButton ctrlShow false;
	CP_switchSideButton ctrlShow false;
	CP_respawnPanelBckg ctrlSetBackgroundColor [0, 0, 0, 0.5];
}
else
{
	CP_Teleport ctrlShow false;
};

//Set side flag
CP_flag ctrlSetText call compile format ["CP_flag%1", (player getVariable ["CP_side", playerside])];

if (!MCC_teleportToTeam) then {CP_Teleport ctrlShow false};

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

//Commander
_commander = MCC_server getVariable [format ["CP_commander%1",side player],""];

if (_commander == "") then
{
	CP_Mutiny ctrlSetText "Take";
}
else
{
	if (_commander == getPlayerUID player) then
	{
		CP_Mutiny ctrlSetText "Leave";
	}
	else
	{
		CP_Mutiny ctrlSetText "Mutiny";
	};
};

//Disable Esc while respawn is on
CP_disableEsc = CP_SQUADPANEL_IDD displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"]; 

_groups	 = switch (side player) do	
			{
				case west:			{CP_westGroups};
				case east:			{CP_eastGroups};
				case resistance:	{CP_guarGroups};
				default				{CP_guarGroups};
			};
				
//Load active Groups
_groupIndex = 0;

_comboBox = CP_squadPanelSquadList; 
lbClear _comboBox;
	{
		_displayname = _x select 1;
		_index = _comboBox lbAdd _displayname;
		if (player in units (_x select 0)) then {_groupIndex = _foreachIndex};
	} foreach _groups;
	
_comboBox lbSetCurSel _groupIndex;

[] spawn 
{
	private ["_comboBox","_displayname","_index","_groups","_array","_oldCommander","_commander","_commanderName","_activeSides","_idc"];
	disableSerialization;
	_oldCommander = "";
	while {(str (CP_SQUADPANEL_IDD displayCtrl 0) != "No control")} do 
	{
		//Tickets
		if (CP_activated) then
		{
			_activeSides = [] call MCC_fnc_getActiveSides;

			_idc = 22;
			{
				ctrlSetText [_idc, str (missionNameSpace getVariable [format ["MCC_tickets%1",_x],""])];
				_idc = _idc + 2;
			} foreach _activeSides;	
		};
			
		if (str (side player) == "ENEMY") then {player addrating (abs (rating player))};
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
		
		//Change leave/join squad
		if ((group player) in _array) then 
		{
			_unit = player getVariable ["MCC_selectedUnit", objnull];
			
			//Kick or leave
			if (_unit != player && player == leader _unit) then
			{
				CP_squadPanelJoinButton ctrlSetText "Kick Player";
			}
			else
			{ 
				CP_squadPanelJoinButton ctrlSetText "Leave Squad";
			};
		} 
		else 
		{
			CP_squadPanelJoinButton ctrlSetText "Join Squad";
		};
		
		//Commander name
		_commander = MCC_server getVariable [format ["CP_commander%1",side player],""];
		
		//We have a new commander
		if (_oldCommander != _commander) then
		{
			//Get commanderName
			_commanderName = "";
			{
				if (isPlayer _x) then
				{
					if ((getPlayerUID _x) == _commander) then {_commanderName = name _x};
				};
			} foreach allUnits; 
			
			if (_commander == "") then
			{
				CP_Mutiny ctrlSetText "Take Commander";
			}
			else
			{
				if (_commander == getPlayerUID player) then
				{
					CP_Mutiny ctrlSetText "Leave Commander";
				}
				else
				{
					CP_Mutiny ctrlSetText "Start Mutiny";
				};
			};
			
			CP_commanderName ctrlSetText _commanderName;
			_oldCommander = _commander;
		};
		
		
		//Disable leaving squad 
		if (! isnil "CP_activeGroup") then 
		{
			if ((ctrlText CP_squadPanelJoinButton == "Leave Squad") && (CP_activeGroup select 0 != (group player))) then 
			{
				CP_squadPanelJoinButton ctrlenable false; 
			} 
			else
			{
				CP_squadPanelJoinButton ctrlenable true; 
			};
			
			//Lock
			if ((CP_activeGroup select 0) getVariable ["locked",false]) then
			{
				CP_LockSquad ctrlSetText (MCC_path +"data\locked.paa");
			}
			else
			{
				CP_LockSquad ctrlSetText (MCC_path +"data\unlocked.paa");
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
		if (! isnil "CP_activeGroup") then 
		{
			if (player == leader (CP_activeGroup select 0)) then 
			{
				CP_squadPanelCreateSquadButton ctrlSetText "Rename Squad";
			} 
			else 
			{
				CP_squadPanelCreateSquadButton ctrlSetText "Create Squad";
			};
		
		
			_comboBox = CP_squadPanelPlayersList; 
			lbClear _comboBox;
			{
				_role =	switch (tolower (_x getvariable ["CP_role","N/A"])) do	
						{
							case "officer":			
							{
								"(CO)"
							};
							
							case "ar":			
							{
								"(AR)"
							};
							
							case "rifleman":			
							{
								"(RL)"
							};
							
							case "at":			
							{
								"(AT)"
							};
							
							case "corpsman":			
							{
								"(Corps)"
							};
							
							case "marksman":			
							{
								"(Marks)"
							};
							
							case "specialist":			
							{
								"(Spec)"
							};
							
							case "pilot":			
							{
								"(Pilot)"
							};
							
							case "crew":			
							{
								"(Crew)"
							};
							
							default			
							{
								"(N/A)"
							};
						};
				_role = _role + "Lvl " + str floor (_x getvariable ["CP_roleLevel",1]) + ": ";
				_displayname = if (_x == leader (CP_activeGroup select 0)) then {format ["-=Leader=- %2 %1",name _x,_role]} else {format ["%2 %1",name _x,_role]};
				_index = _comboBox lbAdd _displayname;
				if (_x == player) then {_comboBox lbSetColor [_index, [0, 1, 0, 0.5]]};
			} foreach units (CP_activeGroup select 0);
		};
		
		sleep 0.1; 
	};
};