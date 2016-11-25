#define MCC_SANDBOX2_IDD (uiNamespace getVariable "MCC_groupGen_Dialog")
#define MCC_EVAC_TYPE 40
#define MCC_EVAC_CLASS 41
#define MCC_EVAC_SELECTED 42
#define MCC_EVAC_INSERTION 43
#define MCC_EVAC_FLIGHTHIGHT 44

disableSerialization;
private ["_evacArray","_insetionArray","_mccdialog","_type"];
_mccdialog = MCC_SANDBOX2_IDD;

_type = lbCurSel MCC_EVAC_TYPE;

switch (_type) do		//Which evac do we want
		{
		case 0:			//Choppers
			{
				_evacArray = U_GEN_HELICOPTER;
				_insetionArray = ["Free Landing (engine on)","Free Landing (engine off)","Hover","Helocasting(Water)","Smoke Signal","Fast-Rope","Precise Landing"];
				ctrlShow [MCC_EVAC_FLIGHTHIGHT,true];
			};
		case 1:			//Vehicles
			{
				_evacArray = U_GEN_CAR;
				_insetionArray = ["Move (engine on)","Move (engine off)"];
				ctrlShow [MCC_EVAC_FLIGHTHIGHT,false];
			};
		case 2:			//Tracked
			{
				_evacArray = U_GEN_TANK;
				_insetionArray = ["Move (engine on)","Move (engine off)"];
				ctrlShow [MCC_EVAC_FLIGHTHIGHT,false];
			};
		case 3:			//Ships
			{
				_evacArray = U_GEN_SHIP;
				_insetionArray = ["Move (engine on)","Move (engine off)"];
				ctrlShow [MCC_EVAC_FLIGHTHIGHT,false];
			};
		};

_comboBox = _mccdialog displayCtrl MCC_EVAC_CLASS;
lbClear _comboBox;
{
	_displayname = format ["%1",(_x select 3)select 0];
	_index = _comboBox lbAdd _displayname;
	_comboBox lbsetpicture [_index, (_x select 3) select 1];
} foreach _evacArray;
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_EVAC_INSERTION;
lbClear _comboBox;
{
	_displayname = _x;
	_index = _comboBox lbAdd _displayname;
} foreach _insetionArray;
_comboBox lbSetCurSel 0;