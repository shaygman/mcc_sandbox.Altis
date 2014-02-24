#define MCC_BRIEFING_TEXT 3055
disableSerialization;
private ["_type","_dlg","_string"];
hint "Diary updated";

_type = _this select 0;

_dlg = (uiNamespace getVariable "MCC_groupGen_Dialog");
_string = ctrlText (_dlg displayCtrl MCC_BRIEFING_TEXT);

mcc_safe=mcc_safe + FORMAT ["_string='%1';
							 _type=%2;
							[[_string, _type],'MCC_fnc_makeBriefing',true,false] spawn BIS_fnc_MP;
							sleep 1;"								 
							,_string
							,_type
							];
[[_string, _type],'MCC_fnc_makeBriefing',true,false] spawn BIS_fnc_MP;