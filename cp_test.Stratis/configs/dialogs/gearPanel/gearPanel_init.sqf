private ["_disp","_comboBox","_index","_displayname"];
disableSerialization;

_disp = _this select 0;
uiNamespace setVariable ["CP_GEARPANEL_IDD", _disp];
uiNamespace setVariable ["CP_gearPanelCommander", _disp displayCtrl 0];
uiNamespace setVariable ["CP_gearPanelAR", _disp displayCtrl 1];
uiNamespace setVariable ["CP_gearPanelRifleman", _disp displayCtrl 2];
uiNamespace setVariable ["CP_gearPanelAntitank", _disp displayCtrl 3];
uiNamespace setVariable ["CP_gearPanelCorpsman", _disp displayCtrl 4];
uiNamespace setVariable ["CP_gearPanelMarksman", _disp displayCtrl 5];
uiNamespace setVariable ["CP_gearPanelSpecialist", _disp displayCtrl 6];
uiNamespace setVariable ["CP_gearPanelCrewman", _disp displayCtrl 7];
uiNamespace setVariable ["CP_gearPanelPilot", _disp displayCtrl 8];
uiNamespace setVariable ["CP_gearPanelPiP", _disp displayCtrl 9];
uiNamespace setVariable ["CP_InfoText", _disp displayCtrl 10];

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
CP_groupPanelOpen	= false; 
CP_gearPanelOpen	= true; 

//Disable Esc while respawn is on
CP_disableEsc = CP_GEARPANEL_IDD displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"]; 

CP_gearPanelCommander ctrlsettext format ["Officer lvl-%1",commanderLevel select 0];
CP_gearPanelAR ctrlsettext format ["Automatic Rifleman lvl-%1",arLevel select 0];
CP_gearPanelRifleman ctrlsettext format ["Rifleman lvl-%1",riflemanLevel select 0];
CP_gearPanelAntitank ctrlsettext format ["Anti-Tank lvl-%1",ATLevel select 0];
CP_gearPanelCorpsman ctrlsettext format ["Corpsman lvl-%1",corpsmanLevel select 0];
CP_gearPanelMarksman ctrlsettext format ["Marksman lvl-%1",marksmanLevel select 0];
CP_gearPanelSpecialist ctrlsettext format ["Specialist lvl-%1",specialistLevel select 0];
CP_gearPanelCrewman ctrlsettext format ["Crewman lvl-%1",crewLevel select 0];
CP_gearPanelPilot ctrlsettext format ["Pilot lvl-%1",pilotLevel select 0];
