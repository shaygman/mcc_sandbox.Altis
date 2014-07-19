#define MCC_BRIEFING_TEXT 3055
disableSerialization;
private ["_type","_dlg","_string"];
hint "Diary updated";

_type = _this select 0;

_dlg = (uiNamespace getVariable "MCC_groupGen_Dialog");
_string = ctrlText (_dlg displayCtrl MCC_BRIEFING_TEXT);

[[_string, _type],"MCC_fnc_makeBriefing",false,false] spawn BIS_fnc_MP;