//Returns the control, the pressed button, the x and y coordinates and the state of Shift, Ctrl and Alt.
private ["_params","_ctrl","_button","_posX","_posY","_shift","_ctrlKey","_alt","_class","_html","_comboBox","_displayname","_index","_pic","_actionsArray"];
#define MCC_sqlpdaMenu0 (uiNamespace getVariable "MCC_sqlpdaMenu0")

disableSerialization;
MCC_doubleClicked = true;
_params = _this select 0;

_ctrl = _params select 0;
_button = _params select 1;
_posX = _params select 2;
_posY = _params select 3;
_shift = _params select 4;
_ctrlKey = _params select 5;
_alt = _params select 6;


if (_button == 0)  then {
	//worldPos
	MCC_ConsoleWPpos = _ctrl ctrlMapScreenToWorld [_posX,_posY];

	//Reveal
	MCC_sqlpdaMenu0 ctrlShow true;
	MCC_sqlpdaMenu0 ctrlSetPosition [_posX,_posY,0.0973958 * safezoneW, 0.07* safezoneH];
	MCC_sqlpdaMenu0 ctrlCommit 0;

	MCC_sqlpdaMenu0 ctrlRemoveAllEventHandlers "LBSelChanged";

	_actionsArray = if (missionNamespace getVariable ["MCC_allowlogistics",true]) then {
						[["enemy","Spot Enemy","\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa"],["support","Call Support",format["%1data\ammo_icon.paa",MCC_path]],["build","Construct","\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"]]
					} else {
						[["enemy","Spot Enemy","\a3\Ui_F_Curator\Data\CfgMarkers\kia_ca.paa"],["support","Call Support",format["%1data\ammo_icon.paa",MCC_path]]]
					};

	_comboBox = MCC_sqlpdaMenu0;

	lbClear _comboBox;
	{
		_class			= _x select 0;
		_displayname 	= _x select 1;
		_pic 			= _x select 2;
		_index 			= _comboBox lbAdd _displayname;
		_comboBox lbSetPicture [_index, _pic];
		_comboBox lbSetData [_index, _class];
	} foreach _actionsArray;
	_comboBox lbSetCurSel 0;

	MCC_sqlpdaMenu0 ctrlAddEventHandler ["LBSelChanged","_this call MCC_fnc_SQLPDAMenuclicked"];
};
sleep 0.1;
MCC_doubleClicked = false;