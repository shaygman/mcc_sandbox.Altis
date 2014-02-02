#define MCC3D_IDD 8000
#define MCC_FACTION 8008
#define MCC_UNIT_TYPE 8001
#define MCC_UNIT_CLASS 8002
#define MCC_NAMEBOX 8003 
#define MCC_INITBOX 8004 
#define MCC_PRESETS 8005
#define MCC_SETTING_EMPTY 8006
#define MCC_ZONE_LOC 8007

#define MCC3DOpenCompIDC 8010
#define MCC_3DCompssaveListIDC 8011
#define MCC_3DCompssaveDescriptionIDC 8012
#define MCC_3DCsaveNameIDC 8013
#define MCC_3DCompsaveNameTittleIDC 8014
#define MCC_3DCompsaveUIButtonIDC 8015
#define MCC_3DComploadUIButtonIDC 8016
#define MCC_3DComploadBcgIDC 8017

ctrlShow [MCC_3DCompssaveListIDC,false];
ctrlShow [MCC_3DCompssaveDescriptionIDC,false];
ctrlShow [MCC_3DCsaveNameIDC,false];
ctrlShow [MCC_3DCompsaveNameTittleIDC,false];
ctrlShow [MCC_3DCompsaveUIButtonIDC,false];
ctrlShow [MCC_3DComploadUIButtonIDC,false];
ctrlShow [MCC_3DComploadBcgIDC,false];

disableSerialization;
private ["_mccdialog","_comboBox","_displayname","_x"];
_mccdialog = findDisplay MCC3D_IDD;

_comboBox = _mccdialog displayCtrl MCC_FACTION;		//fill combobox CFG factions
	lbClear _comboBox;
	{
		_displayname = format ["%1(%2)",_x select 0,_x select 1];
		_comboBox lbAdd _displayname;
	} foreach U_FACTIONS;
	_comboBox lbSetCurSel MCC_faction_index;

_comboBox = _mccdialog displayCtrl MCC_UNIT_TYPE;		//fill combobox CFG unit
lbClear _comboBox;
{
	_displayname =  _x;
	_index = _comboBox lbAdd _displayname;
} foreach ["Infantry", "Vehicles", "Tracked/Static", "Motorcycle", "Helicopter", "Fixed-wing", "Ship", "D.O.C", "Ammo", "Objects (Fortifications)", "Objects (Dead Bodies)", "Objects (Furniture)", 
			"Objects (Market)", "Objects (Construction)", "Objects (Signs)", "Objects (Flags)", "Objects (Military)","Objects (Small)", "Objects (Wrecks)", "Objects (Submerged)", "Objects (Tents)","Objects (Garbage)","Objects (Lamps)",
			"Objects (Container)","Objects (Structures)","Objects (Helpers)","Objects (Training)","Mines","Animals"];
_comboBox lbSetCurSel MCC_class_index;

_comboBox = _mccdialog displayCtrl MCC_SETTING_EMPTY;		//fill combobox Empty on/off
lbClear _comboBox;
{
	_displayname = format ["%1",_x select 0];
	_comboBox lbAdd _displayname;
} foreach MCC_spawn_empty;
_comboBox lbSetCurSel MCC_empty_index;

_comboBox = _mccdialog displayCtrl MCC_PRESETS;		//fill combobox Presets
lbClear _comboBox;
{
	_displayname = _x select 0;
	_comboBox lbAdd _displayname;
} foreach mccPresets;
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_ZONE_LOC;		//fill zone locations
lbClear _comboBox;
{
	_displayname = _x select 0;
	_comboBox lbAdd _displayname;
} foreach MCC_ZoneLocation;
_comboBox lbSetCurSel mcc_hc;	//MCC_ZoneLocation_index;	
