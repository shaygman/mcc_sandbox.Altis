#define MCC_MINIMAP 9000
#define MCC_SANDBOX2_IDD (uiNamespace getVariable "MCC_groupGen_Dialog")
#define MCC_EVAC_TYPE 40
#define MCC_EVAC_CLASS 41
#define MCC_EVAC_SELECTED 42
#define MCC_EVAC_INSERTION 43
#define MCC_EVAC_FLIGHTHIGHT 44

disableSerialization;
private ["_mccdialog","_type","_pos","_control","_index","_comboBox","_insetionArray","_evacVehicles"];
_mccdialog = MCC_SANDBOX2_IDD;
_evacVehicles = missionNamespace getvariable [format ["MCC_evacVehicles_%1",playerside],[]];

missionNameSpace setvariable ["MCC_evacVehicles_index",lbCurSel MCC_EVAC_SELECTED];
if (count _evacVehicles > 0) then
{

	_type = _evacVehicles select (lbCurSel MCC_EVAC_SELECTED);
	_pos = [(getpos _type) select 0, (getpos _type) select 1];

	_insetionArray = ["Move (engine on)","Move (engine off)"];
	ctrlShow [MCC_EVAC_FLIGHTHIGHT,false];

	//Case we choose aircrft
	if (_type iskindof "helicopter") then
	{
		_insetionArray = ["Free Landing (engine on)","Free Landing (engine off)","Hover","Helocasting(Water)","Smoke Signal","Fast-Rope","Precise Landing"];
		ctrlShow [MCC_EVAC_FLIGHTHIGHT,true];
	};

	if ((missionNameSpace getvariable ["MCC_evacVehicles_last",0]) != (missionNameSpace getvariable ["MCC_evacVehicles_index",0])) then {
		_control = _mccdialog displayCtrl MCC_MINIMAP;
		_control ctrlMapAnimAdd [1, ctrlMapScale _control, _pos];
		ctrlMapAnimCommit _control;
	};

	missionNameSpace setvariable ["MCC_evacVehicles_last",MCC_evacVehicles_index];

	_comboBox = _mccdialog displayCtrl MCC_EVAC_INSERTION;					//Adjust insertion type by evac type
	lbClear _comboBox;
	{
		_displayname = _x;
		_index = _comboBox lbAdd _displayname;
	} foreach _insetionArray;
	_comboBox lbSetCurSel 0;
};