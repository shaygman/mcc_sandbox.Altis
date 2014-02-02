#define MCC3D_IDD 8000
#define MCC3DOpenCompIDC 8010
#define MCC_3DCompssaveListIDC 8011
#define MCC_3DCompssaveDescriptionIDC 8012
#define MCC_3DCsaveNameIDC 8013
#define MCC_3DCompsaveNameTittleIDC 8014
#define MCC_3DCompsaveUIButtonIDC 8015
#define MCC_3DComploadUIButtonIDC 8016
#define MCC_3DComploadBcgIDC 8017

private ["_mccdialog","_pos","_comboBox","_index"];
disableSerialization;
_mccdialog = findDisplay MCC3D_IDD;

if (ctrlShown (_mccdialog displayctrl MCC_3DComploadBcgIDC)) then
{
	ctrlSetText [MCC3DOpenCompIDC, "->"];
	ctrlShow [MCC_3DCompssaveListIDC,false];
	ctrlShow [MCC_3DCompssaveDescriptionIDC,false];
	ctrlShow [MCC_3DCsaveNameIDC,false];
	ctrlShow [MCC_3DCompsaveNameTittleIDC,false];
	ctrlShow [MCC_3DCompsaveUIButtonIDC,false];
	ctrlShow [MCC_3DComploadUIButtonIDC,false];
	_pos = ctrlPosition (_mccdialog displayctrl MCC_3DCompssaveListIDC);
	(_mccdialog displayctrl MCC_3DComploadBcgIDC) ctrlSetPosition [(_pos select 0) - 0.01,(_pos select 1) - 0.05,0,0];
	(_mccdialog displayctrl MCC_3DComploadBcgIDC) ctrlCommit 0;
	waitUntil {ctrlCommitted (_mccdialog displayctrl MCC_3DComploadBcgIDC)};
	ctrlShow [MCC_3DComploadBcgIDC,false];
}
else
{
	ctrlSetText [MCC3DOpenCompIDC, "<-"];
	ctrlShow [MCC_3DComploadBcgIDC,true];
	_pos = ctrlPosition (_mccdialog displayctrl MCC_3DCompssaveListIDC);
	(_mccdialog displayctrl MCC_3DComploadBcgIDC) ctrlSetPosition [(_pos select 0) - 0.01,(_pos select 1) - 0.05,0.269271 * safezoneW,0.4 * safezoneH];
	(_mccdialog displayctrl MCC_3DComploadBcgIDC) ctrlCommit 0;
	waitUntil {ctrlCommitted (_mccdialog displayctrl MCC_3DComploadBcgIDC)};
	
	ctrlShow [MCC_3DCompssaveListIDC,true];
	ctrlShow [MCC_3DCompssaveDescriptionIDC,true];
	ctrlShow [MCC_3DCsaveNameIDC,true];
	ctrlShow [MCC_3DCompsaveNameTittleIDC,true];
	ctrlShow [MCC_3DCompsaveUIButtonIDC,true];
	ctrlShow [MCC_3DComploadUIButtonIDC,true];
	ctrlShow [MCC_3DComploadBcgIDC,true];
	
	_comboBox = _mccdialog displayCtrl MCC_3DCompssaveListIDC; 
	lbClear _comboBox;
	{
		_index = _comboBox lbAdd _x;
	} foreach (profileNamespace getVariable "MCC_3DCompSaveNames");
	_comboBox lbSetCurSel 0;
	
	ctrlSetText [MCC_3DCompssaveDescriptionIDC,(profileNamespace getVariable "MCC_3DCompSaveFiles") select 0];
}; 
