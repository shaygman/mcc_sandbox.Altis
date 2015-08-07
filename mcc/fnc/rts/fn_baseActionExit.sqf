//=================================================================MCC_fnc_baseActionExit==============================================================================
//	What happened when clicking on a base's building action
//  Parameter(s):
//     _ctrl: CONTROL
//     _ctrlText: STRING
//==============================================================================================================================================================================
private ["_ctrl","_ctrlText","_disp","_text"];
disableSerialization;

_ctrl = (_this select 0) select 0;
_disp = uiNamespace getVariable "MCC_LOGISTICS_BASE_BUILD";

//Remove text
if (str (_disp displayCtrl 150) != "No control") then {
	(_disp displayCtrl 150) ctrlSetStructuredText parseText"";
};

if (count MCC_ConsoleGroupSelected <=0) then {((uiNamespace getVariable "MCC_LOGISTICS_BASE_BUILD") displayCtrl 9999) ctrlSetStructuredText parseText ""};



//Hide resources
for "_i" from 120 to 127 do {(_disp displayCtrl _i) ctrlShow false};