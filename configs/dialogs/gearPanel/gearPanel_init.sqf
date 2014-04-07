private ["_disp","_comboBox","_index","_displayname"];
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

//Disable Esc while respawn is on
CP_disableEsc = CP_GEARPANEL_IDD displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"]; 

CP_gearPanelCommander ctrlsettext format ["Officer Level: %1 Exp: %2",OfficerLevel select 0,OfficerLevel select 1];
CP_gearPanelAR ctrlsettext format ["Automatic Rifleman Level: %1 Exp: %2",arLevel select 0,arLevel select 1];
CP_gearPanelRifleman ctrlsettext format ["Rifleman Level: %1 Exp: %2",riflemanLevel select 0,riflemanLevel select 1];
CP_gearPanelAntitank ctrlsettext format ["Anti-Tank Level: %1 Exp: %2",ATLevel select 0,ATLevel select 1];
CP_gearPanelCorpsman ctrlsettext format ["Corpsman Level: %1 Exp: %2",corpsmanLevel select 0,corpsmanLevel select 1];
CP_gearPanelMarksman ctrlsettext format ["Marksman Level: %1 Exp: %2",marksmanLevel select 0,marksmanLevel select 1];
CP_gearPanelSpecialist ctrlsettext format ["Specialist Level: %1 Exp: %2",specialistLevel select 0,specialistLevel select 1];
CP_gearPanelCrewman ctrlsettext format ["Crewman Level: %1 Exp: %2",crewLevel select 0,crewLevel select 1];
CP_gearPanelPilot ctrlsettext format ["Pilot Level: %1 Exp: %2",pilotLevel select 0,pilotLevel select 1];
