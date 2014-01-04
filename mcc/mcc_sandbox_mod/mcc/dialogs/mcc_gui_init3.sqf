#define MCC_SANDBOX3_IDD 3000

#define MAIN 1050
#define MENU2 1051
#define MENU3 1052
#define MENU4 1053
#define MENU5 1054
#define MCCSTOPCAPTURE 1014
#define FACTIONCOMBO 1001
#define MCCZONENUMBER 1023
#define MCC_ZONE_LOC 1026

#define MCC_MARKER_TEXT 3050
#define MCC_MARKER_COLOR 3051
#define MCC_MARKER_TYPE 3052
#define MCC_MARKER_SHAPE 3053
#define MCC_MARKER_BRUSH 3054

#define MCC_TASKS_LIST 3058

#define MCC_JUKEBOX_VOLUME 3059
#define MCC_JUKEBOX_TRACK 3060
#define MCC_JUKEBOX_ACTIVATE 3061
#define MCC_JUKEBOX_CONDITION 3062
#define MCC_JUKEBOX_ZONE 3063

#define MCC_TRIGGERS_ACTIVATE 3064
#define MCC_TRIGGERS_CONDITION 3065
#define MCC_TRIGGERS_SHAPE 3066
#define MCC_TRIGGERS_LIST 3067

#define MCC_UAV_TYPE 3069

private ["_mccdialog","_comboBox","_displayname","_it","_x","_vehicleDisplayName"];
disableSerialization;

ctrlEnable [MAIN,false]; //Disable switching menus till the init is done
ctrlEnable [MENU2,false];
ctrlEnable [MENU3,false];
ctrlEnable [MENU4,false];
ctrlEnable [MENU5,false];
if (!MCC_capture_state) then { ctrlEnable [MCCSTOPCAPTURE,false];};

_mccdialog = findDisplay MCC_SANDBOX3_IDD;

_comboBox = _mccdialog displayCtrl MCCZONENUMBER; //fill combobox zone's numbers
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x];
		_comboBox lbAdd _displayname;
	} foreach MCC_zones_numbers;
	_comboBox lbSetCurSel MCC_zone_index;

_comboBox = _mccdialog displayCtrl MCC_ZONE_LOC;		//fill zone locations
	lbClear _comboBox;
	{
		_displayname = _x select 0;
		_comboBox lbAdd _displayname;
	} foreach MCC_ZoneLocation;
	_comboBox lbSetCurSel mcc_hc;	//MCC_ZoneLocation_index;	

_comboBox = _mccdialog displayCtrl FACTIONCOMBO;		//fill combobox CFG factions
	lbClear _comboBox;
	{
		_displayname = format ["%1(%2)",_x select 0,_x select 1];
		_comboBox lbAdd _displayname;
	} foreach U_FACTIONS;
	_comboBox lbSetCurSel MCC_faction_index;
//------------------------------------------------Markers-------------------------------------------------------
_comboBox = _mccdialog displayCtrl MCC_MARKER_COLOR;		//fill Markers Colors 1
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x select 0];
		_comboBox lbAdd _displayname;
	} foreach MCC_colorsarray;
	_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_MARKER_SHAPE;		//fill Markers Shape
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach MCC_shapeMarker;
	_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_MARKER_BRUSH;		//fill Markers Brush
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x select 0];
		_index = _comboBox lbAdd _displayname;
		_comboBox lbsetpicture [_index, _x select 1];
	} foreach MCC_brushesarray;
	_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_MARKER_TYPE;		//fill Markers Type
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x select 0];
		_index = _comboBox lbAdd _displayname;
		_comboBox lbsetpicture [_index, _x select 1];
	} foreach MCC_markerarray;
	_comboBox lbSetCurSel 0;
//---------------------------------------------------Taskss--------------------------------------------------------
_comboBox = _mccdialog displayCtrl MCC_TASKS_LIST;		//fill Tasks
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x select 0];
		_comboBox lbAdd _displayname;
	} foreach MCC_tasks;
	_comboBox lbSetCurSel 0;
//--------------------------------------------------Jukebox---------------------------------------------------------------------------
if (MCC_jukeboxMusic) then
		{
			_comboBox = _mccdialog displayCtrl MCC_JUKEBOX_TRACK; //fill combobox music tracks
			lbClear _comboBox;
				{
					_displayname = format ["%1",_x  select 0];
					_comboBox lbAdd _displayname;
				} foreach MCC_musicTracks_array;
			_comboBox lbSetCurSel MCC_musicTracks_index;
		} else
		{
			_comboBox = _mccdialog displayCtrl MCC_JUKEBOX_TRACK; //fill combobox sound tracks
			lbClear _comboBox;
				{
					_displayname = format ["%1",_x  select 0];
					_comboBox lbAdd _displayname;
				} foreach MCC_soundTracks_array;
			_comboBox lbSetCurSel MCC_musicTracks_index;
		};

_comboBox = _mccdialog displayCtrl MCC_JUKEBOX_ACTIVATE; //fill combobox Activate by

	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach MCC_musicActivateby_array;
	_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_JUKEBOX_CONDITION; //fill combobox Condition

	lbClear _comboBox;
	{
		_displayname =_x;
		_comboBox lbAdd _displayname;
	} foreach MCC_musicCond_array;
	_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_JUKEBOX_ZONE; //fill combobox zone's numbers
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x];
		_comboBox lbAdd _displayname;
	} foreach MCC_zones_numbers;
	_comboBox lbSetCurSel MCC_zone_index;
	
sliderSetRange [MCC_JUKEBOX_VOLUME, 0, 1];
_volume = musicVolume;
sliderSetPosition [MCC_JUKEBOX_VOLUME, (1 - _volume)];

//--------------------------------------------------Triggers---------------------------------------------------------------------------

_comboBox = _mccdialog displayCtrl MCC_TRIGGERS_ACTIVATE; //fill combobox Activate by

	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach MCC_musicActivateby_array;
	_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_TRIGGERS_CONDITION; //fill combobox Condition

	lbClear _comboBox;
	{
		_displayname =_x;
		_comboBox lbAdd _displayname;
	} foreach MCC_musicCond_array;
	_comboBox lbSetCurSel 0;
	
_comboBox = _mccdialog displayCtrl MCC_TRIGGERS_SHAPE;		//fill combobox Trigger Shape 
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach MCC_shapeMarker;
	_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_TRIGGERS_LIST;		//fill combobox Active triggers 
	lbClear _comboBox;
	{
		_displayname = _x select 0;
		_comboBox lbAdd _displayname;
	} foreach MCC_triggers;
	_comboBox lbSetCurSel 0;
	
//----------------------------------------------------UAV----------------------------------------------------------------------------
_comboBox = _mccdialog displayCtrl MCC_UAV_TYPE;		//fill combobox Active triggers 
	lbClear _comboBox;
	{
		_displayname = _x select 0;
		_comboBox lbAdd _displayname;
	} foreach MCC_uavSiteArray;
	_comboBox lbSetCurSel 0;
	
ctrlEnable [MAIN,true]; //Enable switching menus
ctrlEnable [MENU2,true];
ctrlEnable [MENU3,false];
ctrlEnable [MENU4,true];
ctrlEnable [MENU5,true];

