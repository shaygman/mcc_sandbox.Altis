#define MCC_SaveLoadScreen_IDD 7000
#define MCC_LOAD_INPUT 7001
#define MCC_SaveLoadScreen_IDD 7000
#define MCC_SAVE_LIST 7010
#define MCC_SAVE_DIS 7011
#define MCC_SAVE_NAME 7012

#define MCC_LOAD_INPUT 7001

private ["_tempText","_comboBox","_mccdialog","_savesArray","_index"];
disableSerialization;

_mccdialog = findDisplay MCC_SaveLoadScreen_IDD;
_tempText = ctrlText MCC_LOAD_INPUT;
ctrlSetText [MCC_LOAD_INPUT,format ["%1",MCC_safe]];

_comboBox = _mccdialog displayCtrl MCC_SAVE_LIST; 
	lbClear _comboBox;
	{
		_index = _comboBox lbAdd _x;
	} foreach (profileNamespace getVariable "MCC_save");
_comboBox lbSetCurSel MCC_saveIndex;

ctrlSetText [MCC_SAVE_DIS,(((profileNamespace getVariable "MCC_saveFiles") select MCC_saveIndex) select 0)];

