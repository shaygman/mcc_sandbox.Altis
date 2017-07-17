#define MCC_SaveLoadScreen_IDD 7000
#define MCC_LOAD_INPUT 7001
#define MCC_SaveLoadScreen_IDD 7000
#define MCC_SAVE_LIST 7010
#define MCC_SAVE_DIS 7011
#define MCC_SAVE_NAME 7012
#define MCC_SAVE_PERSISTENT 7013

#define MCC_LOAD_INPUT 7001

private ["_tempText","_comboBox","_savesArray","_index","_disp"];
disableSerialization;

_disp = _this select 0;
uiNamespace setVariable ["MCC_SaveLoadScreen_IDD", _disp];
uiNamespace setVariable ["MCC_SaveButton", _disp displayCtrl 0];

#define MCC_SaveButton (uiNamespace getVariable "MCC_SaveButton")

//Disable save to clipboard on dedicated
if (MCC_isDedicated) then {MCC_SaveButton ctrlEnable false};

_tempText = ctrlText MCC_LOAD_INPUT;
ctrlSetText [MCC_LOAD_INPUT,format ["%1",MCC_safe]];

(_disp displayCtrl MCC_SAVE_PERSISTENT) ctrlEnable (!(missionnamespace getVariable ["MCC_fnc_saveServerIsrunning",false]) && !(missionnamespace getVariable ["MCC_fnc_savePlayerIsrunning",false]));

_comboBox = _disp displayCtrl MCC_SAVE_LIST;
	lbClear _comboBox;
	{
		_index = _comboBox lbAdd _x;
	} foreach (profileNamespace getVariable "MCC_save");
_comboBox lbSetCurSel MCC_saveIndex;

ctrlSetText [MCC_SAVE_NAME, (missionnamespace getvariable ["bis_fnc_moduleMissionName_name",""])];
ctrlSetText [MCC_SAVE_DIS,(((profileNamespace getVariable "MCC_saveFiles") select MCC_saveIndex) select 0)];

