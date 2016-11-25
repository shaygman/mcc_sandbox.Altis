#define MCC_MINIMAP 9120
#define mcc_playerConsole_IDD 2993

#define MCC_ConsoleEvacTypeText_IDD 9103
#define MCC_ConsoleEvacApproachComboBox_IDD 9102
#define MCC_ConsoleEvacFlyHightComboBox_IDD 9101

disableSerialization;
private ["_mccdialog","_type","_pos","_control","_markerType","_index","_comboBox","_insetionArray","_evacVehicles"];
_mccdialog = findDisplay mcc_playerConsole_IDD;
_index = lbCurSel MCC_ConsoleEvacTypeText_IDD;
_evacVehicles = missionNamespace getvariable [format ["MCC_evacVehicles_%1",playerSide],[]];

if ((missionNameSpace getvariable ["MCC_evacVehicles_index",0]) !=_index && (count _evacVehicles > 0)) then {
	missionNameSpace setvariable ["MCC_evacVehicles_index",_index];
	deletemarkerlocal "currentEvacSelected";
	_type = _evacVehicles select (lbCurSel MCC_ConsoleEvacTypeText_IDD);
	_pos = [(getpos _type) select 0, (getpos _type) select 1];

	_insetionArray = ["Move (engine on)","Move (engine off)"];
	ctrlShow [MCC_ConsoleEvacFlyHightComboBox_IDD,false];
	_markerType = "b_inf";
	if (_type iskindof "Car") then {_markerType = "b_mech_inf";};
	if (_type iskindof "Tank") then {_markerType = "b_armor";};

	//Case we choose aircrft
	if (_type iskindof "helicopter") then
	{
		_markerType = "b_air";
		_insetionArray = ["Free Landing (engine on)","Free Landing (engine off)","Hover","Helocasting(Water)","Smoke Signal","Fast-Rope","Precise Landing"];
		ctrlShow [MCC_ConsoleEvacFlyHightComboBox_IDD,true];
		_comboBox = _mccdialog displayCtrl MCC_ConsoleEvacFlyHightComboBox_IDD;		//fill combobox Fly in Hight
		lbClear _comboBox;
		{
			_displayname = format ["%1",_x  select 0];
			_index = _comboBox lbAdd _displayname;
		} foreach MCC_evacFlyInHight_array;
		_comboBox lbSetCurSel 0;
	};

	createMarkerLocal ["currentEvacSelected",_pos];	//Create group's marker
	"currentEvacSelected" setMarkerTypeLocal _markerType;
	"currentEvacSelected" setMarkerColorLocal "ColorBlue";

	_control = _mccdialog displayCtrl MCC_MINIMAP;
	_control ctrlMapAnimAdd [1, 0.3, _pos];
	ctrlMapAnimCommit _control;

	_comboBox = _mccdialog displayCtrl MCC_ConsoleEvacApproachComboBox_IDD;					//Adjust insertion type by evac type
	lbClear _comboBox;
	{
		_displayname = _x;
		_index = _comboBox lbAdd _displayname;
	} foreach _insetionArray;
	_comboBox lbSetCurSel 0;
	};