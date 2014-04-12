#define MCC3DOpenCompIDC 8010
#define MCC_3DDOCIDC 8017
#define MCC_3DCompssaveListIDC 8011
#define MCC_3DCompssaveDescriptionIDC 8012
#define MCC_3DCsaveNameIDC 8013
#define MCC_3DCargoGen 8018
#define MCC_3dTasksControlsIDC 8020

private ["_mccdialog","_pos","_comboBox","_index"];
disableSerialization;
_mccdialog = uiNamespace getVariable "MCC3D_Dialog";

if (ctrlShown (_mccdialog displayctrl MCC_3DDOCIDC)) then
{
	ctrlSetText [MCC3DOpenCompIDC, "DOC -->"];
	ctrlShow [MCC_3DDOCIDC,false];
}
else
{
	ctrlShow [MCC_3DCargoGen,false];
	ctrlShow [MCC_3dTasksControlsIDC,false];
	ctrlSetText [MCC3DOpenCompIDC, "<-- DOC"];
	ctrlShow [MCC_3DDOCIDC,true];

	_comboBox = _mccdialog displayCtrl MCC_3DCompssaveListIDC; 
	lbClear _comboBox;
	{
		_index = _comboBox lbAdd _x;
	} foreach (profileNamespace getVariable "MCC_3DCompSaveNames");
	_comboBox lbSetCurSel 0;
	
	ctrlSetText [MCC_3DCompssaveDescriptionIDC,(profileNamespace getVariable "MCC_3DCompSaveFiles") select 0];
}; 
