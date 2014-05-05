private ["_mccdialog","_comboBox","_displayname","_index","_null"];
#define MCC_3dTasksControlsIDC 8020
#define MCC_3DCargoGen 8018

disableSerialization;
_mccdialog = uiNamespace getVariable "MCC3D_Dialog";

(_mccdialog displayCtrl MCC_3dTasksControlsIDC) ctrlShow !(ctrlShown (_mccdialog displayCtrl MCC_3dTasksControlsIDC));
if (ctrlShown (_mccdialog displayCtrl MCC_3dTasksControlsIDC)) then 
{
	 if (ctrlShown (_mccdialog displayCtrl 8017)) then {_null = [0] execVM MCC_path + "mcc\general_scripts\docobject\compositionManager.sqf"};
	 ctrlShow [MCC_3DCargoGen,false];
	(_this select 0) ctrlSetText "<-- Tasks";
} 
else 
{
	(_this select 0) ctrlSetText "Tasks -->";
};

_comboBox = _mccdialog displayCtrl 8505; 
	lbClear _comboBox;
	{
		_displayname = _x;
		_index = _comboBox lbAdd _displayname;
	} foreach ["Control Area (Marker)","Move (Marker)","Pick Up (Object)","Get In (Vehicle)","Repair/Heal (Object)","Neutralize (Unit/Object)","Protect (Unit/Object)"];
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl 8506; 
	lbClear _comboBox;
	{
		_displayname = _x;
		_index = _comboBox lbAdd _displayname;
	} foreach MCC_activeMarkers;
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl 8507; 
	lbClear _comboBox;
	{
		_displayname = _x;
		_index = _comboBox lbAdd _displayname;
	} foreach ["None","Waypoint","Waypoint - Cinematic"];
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl 8508; 
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x select 0];
		_index = _comboBox lbAdd _displayname;
	} foreach ([["None"]] + MCC_tasks);
_comboBox lbSetCurSel 0;

