#define MCC_MINIMAP 9000
#define MCC_SANDBOX2_IDD (uiNamespace getVariable "MCC_groupGen_Dialog")
#define MCC_EVAC_TYPE 40
#define MCC_EVAC_CLASS 41
#define MCC_EVAC_SELECTED 42
#define MCC_EVAC_INSERTION 43
#define MCC_EVAC_FLIGHTHIGHT 44

disableSerialization;
private ["_mccdialog","_type","_pos","_control","_markerType","_index","_comboBox","_insetionArray"];
_mccdialog = MCC_SANDBOX2_IDD;	

MCC_evacVehicles_index = lbCurSel MCC_EVAC_SELECTED;
if (count MCC_evacVehicles > 0) then {
	deletemarkerlocal "currentEvacSelected";
	_type = MCC_evacVehicles select (lbCurSel MCC_EVAC_SELECTED);
	_pos = [(getpos _type) select 0, (getpos _type) select 1];
	
	_insetionArray = ["Move (engine on)","Move (engine off)"];
	ctrlShow [MCC_EVAC_FLIGHTHIGHT,false];
	_markerType = "b_inf";
	if (_type iskindof "Car") then {_markerType = "b_mech_inf";};
	if (_type iskindof "Ship") then {_markerType = "c_ship";};
	if (_type iskindof "Tank") then {_markerType = "b_armor";};
	if (_type iskindof "helicopter") then {									//Case we choose aircrft
		_markerType = "b_air";
		_insetionArray = ["Free Landing (engine on)","Free Landing (engine off)","Hover","Helocasting(Water)","Smoke Signal","Fast-Rope"];
		ctrlShow [MCC_EVAC_FLIGHTHIGHT,true];
		};

	createMarkerLocal ["currentEvacSelected",_pos];	//Create group's marker
	"currentEvacSelected" setMarkerTypeLocal _markerType;
	"currentEvacSelected" setMarkerColorLocal "ColorBlue";
	
	if (MCC_evacVehicles_last != MCC_evacVehicles_index) then 
	{
		_control = _mccdialog displayCtrl MCC_MINIMAP;
		_control ctrlMapAnimAdd [1, ctrlMapScale _control, _pos];
		ctrlMapAnimCommit _control;
	};
	
	MCC_evacVehicles_last = MCC_evacVehicles_index;
	
	_comboBox = _mccdialog displayCtrl MCC_EVAC_INSERTION;					//Adjust insertion type by evac type
	lbClear _comboBox;
	{
		_displayname = _x;
		_index = _comboBox lbAdd _displayname;
	} foreach _insetionArray;
	_comboBox lbSetCurSel 0;
	};