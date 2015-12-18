//Made by Shay_Gman (c) 02.14
#define groupGen_IDD 2994

#define UNIT_TYPE 3010
#define UNIT_CLASS 3011
#define MCC_GGUNIT_TYPE 3012
#define MCC_GGUNIT_BEHAVIOR 3030
#define MCC_GroupGenCurrentGroup_IDD 9003
#define MCC_GGListBoxIDC 3013
#define MCC_GGADDIDC 3014
#define MCC_GGCLEARIDC 3015
#define MCC_GGUNIT_EMPTY 3016
#define MCC_GGUNIT_EMPTYTITLE 3017
#define mcc_groupGen_CurrentgroupNameTittle_IDC 3018
#define mcc_groupGen_CurrentgroupNameText_IDC 3019
#define MCC_GGSAVE_GROUPIDC 3020

private ["_action","_control","_mccdialog","_comboBox","_displayname","_pic"];
disableSerialization;

_action = _this select 0;
_mccdialog = (uiNamespace getVariable "MCC_groupGen_Dialog");
MCC_GUI1initDone = false;
//------------------------------------------------------------------------------------ Close all open boxes -------------------------------------------------------------------------------
for "_i" from 500 to 518 step 1 do
{
	(_mccdialog displayCtrl _i) ctrlShow false;
};

//-------------------------------------------------------------------------------------Weather----------------------------------------------------------------------------------------------
if (_action == 0) exitWith
{
	_control = (_mccdialog displayCtrl 501);
	_control ctrlShow true;

	(_mccdialog displayCtrl 10) sliderSetRange [0, 1];
	(_mccdialog displayCtrl 11) sliderSetRange [0, 1];
	(_mccdialog displayCtrl 12) sliderSetRange [0, 1];
	(_mccdialog displayCtrl 13) sliderSetRange [0, 1];
	(_mccdialog displayCtrl 14) sliderSetRange [0, 1];

	(_mccdialog displayCtrl 10) sliderSetPosition fog;
	(_mccdialog displayCtrl 11) sliderSetPosition rain;
	(_mccdialog displayCtrl 12) sliderSetPosition overcast;
	(_mccdialog displayCtrl 13) sliderSetPosition waves;
	(_mccdialog displayCtrl 14) sliderSetPosition windStr;
};

//-------------------------------------------------------------------------------------Time----------------------------------------------------------------------------------------------
if (_action == 1) exitWith
{
	_control = (_mccdialog displayCtrl 502);
	_control ctrlShow true;

	//--------------------------------------Fill index--------------------------------------------------------------------------
	_comboBox = (_mccdialog displayCtrl 15);		// MONTH
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x select 0];
		_comboBox lbAdd _displayname;
	} foreach MCC_months_array;
	_comboBox lbSetCurSel (date select 1)-1;

	_comboBox = (_mccdialog displayCtrl 16);		// Day
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x];
		_comboBox lbAdd _displayname;
	} foreach MCC_days_array;
	_comboBox lbSetCurSel (date select 2)-1;

	_comboBox = (_mccdialog displayCtrl 17);		//  Year
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x];
		_comboBox lbAdd _displayname;
	} foreach [1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030];
	_comboBox lbSetCurSel ((date select 0)-1990);

	_comboBox = (_mccdialog displayCtrl 18);		// HOUR
	lbClear _comboBox;
	{
		_displayname = if (_x < 10) then {format ["0%1",_x]} else {format ["%1",_x]};
		_comboBox lbAdd _displayname;
	} foreach MCC_hours_array;
	_comboBox lbSetCurSel (date select 3);

	_comboBox = (_mccdialog displayCtrl 19);		// Minutes
	lbClear _comboBox;
	{
		_displayname = if (_x < 10) then {format ["0%1",_x]} else {format ["%1",_x]};
		_comboBox lbAdd _displayname;
	} foreach MCC_minutes_array;
	_comboBox lbSetCurSel (date select 4);
};

//-------------------------------------------------------------------------------------RESPWAN----------------------------------------------------------------------------------------------
if (_action == 2) exitWith
{
	_control = (_mccdialog displayCtrl 503);
	_control ctrlShow true;

	//--------------------------------------Fill index--------------------------------------------------------------------------
	_comboBox = (_mccdialog displayCtrl 20);		// Teleport
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["None","Teleport","Paradrop","HALO"];
	_comboBox lbSetCurSel 1;

	_comboBox = (_mccdialog displayCtrl 21);		// FOB
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Primary","F.O.B"];
	_comboBox lbSetCurSel 0;
};

//-------------------------------------------------------------------------------------DEBUG----------------------------------------------------------------------------------------------
if (_action == 3) exitWith
{
	_control = (_mccdialog displayCtrl 504);
	_control ctrlShow true;
};

//-------------------------------------------------------------------------------------CAS----------------------------------------------------------------------------------------------
if (_action == 4) exitWith
{
	_control = (_mccdialog displayCtrl 500);
	_control ctrlShow true;

	//--------------------------------------CAS--------------------------------------------------------------------------

	_comboBox = (_mccdialog displayCtrl 25);		//fill combobox CAS Plane Type
	lbClear _comboBox;
	{
		_displayname =  format ["%1",(_x select 3)select 0];
		_index = _comboBox lbAdd _displayname;
		_comboBox lbsetpicture [_index, (_x select 3) select 1];
	} foreach (U_GEN_AIRPLANE+U_GEN_HELICOPTER);
	_comboBox lbSetCurSel 0;

	_comboBox = (_mccdialog displayCtrl 26);		//fill combobox CAS Bomb Type
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x];
		_comboBox lbAdd _displayname;
	} foreach MCC_CASBombs;
	_comboBox lbSetCurSel 0;
};

//-------------------------------------------------------------------------------------Artillery----------------------------------------------------------------------------------------------
if (_action == 5) exitWith
{
	_control = (_mccdialog displayCtrl 505);
	_control ctrlShow true;

	//---------------------------------Artillery----------------------------------------------------------------------------
	_comboBox = (_mccdialog displayCtrl 30);		// Artillery Type
		lbClear _comboBox;
		{
			_displayname = format ["%1",_x select 0];
			_comboBox lbAdd _displayname;
		} foreach MCC_artilleryTypeArray;
		_comboBox lbSetCurSel 0;

	_comboBox = (_mccdialog displayCtrl 31);		//Artillery Spread
		lbClear _comboBox;
		{
			_displayname = format ["%1",_x select 0];
			_comboBox lbAdd _displayname;
		} foreach MCC_artillerySpreadArray;
		_comboBox lbSetCurSel 0;

	_comboBox = (_mccdialog displayCtrl 32);		//Artillery Number
	lbClear _comboBox;
	for "_i" from 1 to 50 do
	{
		_displayname = str _i;
		_comboBox lbAdd _displayname;
	};
	_comboBox lbSetCurSel 0;

	_comboBox = (_mccdialog displayCtrl 33);		//Artillery Delay
	lbClear _comboBox;
	{
		_displayname = _x;
		_index = _comboBox lbAdd _displayname;
	} foreach ["0","20 sec","40 sec","1 min","80  sec","100  sec","2 min","140 sec","160 sec","3 min"];
	_comboBox lbSetCurSel 0;
};

//-------------------------------------------------------------------------------------SPAWN----------------------------------------------------------------------------------------------
if (_action == 6) exitWith
{
	_control = (_mccdialog displayCtrl 506);
	_control ctrlShow true;

	MCC_groupGenCurrenGroupArray = []; 		//Reset the current group

	_comboBox = _mccdialog displayCtrl UNIT_TYPE;		//fill combobox CFG unit
	lbClear _comboBox;
	{
		_displayname =  _x;
		_index = _comboBox lbAdd _displayname;
	} foreach ["Infantry", "Vehicles", "Tracked/Static", "Motorcycle", "Helicopter", "Fixed-wing", "Ship", "Ammo"];
	_comboBox lbSetCurSel MCC_class_index;

	_comboBox = _mccdialog displayCtrl MCC_GGUNIT_TYPE;
	lbClear _comboBox;
	{
		_displayname =  _x;
		_index = _comboBox lbAdd _displayname;
	} foreach ["Units", "Groups"];
	_comboBox lbSetCurSel 0;

	_comboBox = _mccdialog displayCtrl MCC_GGUNIT_BEHAVIOR;
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x select 0];
		_index = _comboBox lbAdd _displayname;
	} foreach MCC_spawn_behaviors;
	_comboBox lbSetCurSel MCC_behavior_index;

	_comboBox = _mccdialog displayCtrl MCC_GGUNIT_EMPTY;
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x select 0];
		_comboBox lbAdd _displayname;
	} foreach MCC_spawn_empty;
	_comboBox lbSetCurSel MCC_empty_index;

	_comboBox =(_mccdialog displayCtrl 0);		//fill zone locations
	lbClear _comboBox;
	{
		_displayname = _x select 0;
		_comboBox lbAdd _displayname;
	} foreach MCC_ZoneLocation;
	_comboBox lbSetCurSel mcc_hc;	//MCC_ZoneLocation_index;

	if (mcc_delayed_spawn) then {(_mccdialog displayCtrl 3022) cbSetChecked true};
	if (mcc_caching) then {(_mccdialog displayCtrl 3023) cbSetChecked true};
	while {ctrlShown _control} do
	{
		mcc_delayed_spawn = if (cbChecked (_mccdialog displayCtrl 3022)) then {true} else {false};
		mcc_caching = if (cbChecked (_mccdialog displayCtrl 3023)) then {true} else {false};
		sleep 0.1;
	};
};

//-------------------------------------------------------------------------------------EVAC----------------------------------------------------------------------------------------------
if (_action == 7) exitWith
{
	_control = (_mccdialog displayCtrl 507);
	_control ctrlShow true;

	//--------------------------------------------------------EVAC Settings---------------------------------------------------------
	_comboBox =  (_mccdialog displayCtrl 40);		//EVAC type
	lbClear _comboBox;
	{
		_displayname = _x;
		_index = _comboBox lbAdd _displayname;
	} foreach ["Helicopters", "Vehicles","Tracked", "Ships"];
	_comboBox lbSetCurSel 0;

	_comboBox = (_mccdialog displayCtrl 44);		//fill combobox Fly in Hight
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x  select 0];
		_index = _comboBox lbAdd _displayname;
	} foreach MCC_evacFlyInHight_array;
	_comboBox lbSetCurSel MCC_evacFlyInHight_index;

	_evacVehicles = missionNamespace getvariable [format ["MCC_evacVehicles_%1",playerside],[]];
	_comboBox =  (_mccdialog displayCtrl 42);		//fill combobox for availabe evac type
	lbClear _comboBox;
	{
		if (alive _x) then	{
			_vehicleDisplayName 	= getText(configFile >> "CfgVehicles" >> typeof _x >> "displayname");
			_displayname 			= format ["%1, %2",_x,_vehicleDisplayName];
			_index 					= _comboBox lbAdd _displayname;
		} else {
			_displayname 			= "N/A";
			_index 					= _comboBox lbAdd _displayname;
			};
	} foreach _evacVehicles;
	_comboBox lbSetCurSel (missionNameSpace getvariable ["MCC_evacVehicles_index",0]);

	//Change evac type by vehicle class
	if (count _evacVehicles > 0) then {
		private ["_insetionArray","_type"];
		_insetionArray = ["Move (engine on)","Move (engine off)"];
		ctrlShow [(_mccdialog displayCtrl 44),false];
		_type = _evacVehicles select (missionNameSpace getvariable ["MCC_evacVehicles_index",0]);

		//Case we choose aircrft
		if (_type iskindof "helicopter") then
		{
			_insetionArray = ["Free Landing (engine on)","Free Landing (engine off)","Hover","Helocasting(Water)","Smoke Signal","Fast-Rope"];
			ctrlShow [(_mccdialog displayCtrl 44),true];
		};

		_comboBox = (_mccdialog displayCtrl 43);					//Adjust insertion type by evac type
		lbClear _comboBox;
		{
			_displayname = _x;
			_index = _comboBox lbAdd _displayname;
		} foreach _insetionArray;
		_comboBox lbSetCurSel 0;
	};
};

//-------------------------------------------------------------------------------------IED----------------------------------------------------------------------------------------------
if (_action == 8) exitWith
{
	#define MCC_TRAPS_TYPE 2007
	#define MCC_TRAPS_OBJECT 2008
	#define MCC_TRAPS_EXPLOSIN_SIZE 2009
	#define MCC_TRAPS_EXPLOSIN_TYPE 2010
	#define MCC_TRAPS_TARGET_FACTION 2011
	#define MCC_TRAPS_JAMMABLE 2012
	#define MCC_TRAPS_DISARM 2013
	#define MCC_TRAPS_TRIGGER 2014
	#define MCC_TRAPS_PROXIMITY 2015
	#define MCC_TRAPS_AMBUSH 2016

	_control = (_mccdialog displayCtrl 508);
	_control ctrlShow true;

	//--------------------------------------------------------TRAPS Settings---------------------------------------------------------
	_comboBox = _mccdialog displayCtrl MCC_TRAPS_PROXIMITY;		//fill combobox IED Prox
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x];
		_index = _comboBox lbAdd _displayname;
	} foreach MCC_ied_proxArray;
	_comboBox lbSetCurSel 0;

	_comboBox = _mccdialog displayCtrl MCC_TRAPS_TARGET_FACTION;		//fill combobox IED Target
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x];
		_index = _comboBox lbAdd _displayname;
	} foreach MCC_ied_targetArray;
	_comboBox lbSetCurSel 0;

	_comboBox = _mccdialog displayCtrl MCC_TRAPS_TYPE;		//fill combobox IED Type
	lbClear _comboBox;
	{
		_displayname = _x;
		_index = _comboBox lbAdd _displayname;
	} foreach ["Small objects", "Medium objects", "Wrecks", "Hidden IED", "Mine Fields", "Ammoboxes", "Cars", "Armed Civilians","Suicide bombers"];
	_comboBox lbSetCurSel 0;

	_comboBox = _mccdialog displayCtrl MCC_TRAPS_EXPLOSIN_SIZE;		//fill combobox IED Explosion size
	lbClear _comboBox;
	{
		_displayname = _x;
		_index = _comboBox lbAdd _displayname;
	} foreach ["Small", "Medium", "Large"];
	_comboBox lbSetCurSel 0;

	_comboBox = _mccdialog displayCtrl MCC_TRAPS_EXPLOSIN_TYPE;		//fill combobox IED Explosion type
	lbClear _comboBox;
	{
		_displayname = _x;
		_index = _comboBox lbAdd _displayname;
	} foreach ["Deadly", "Disabling", "Fake", "No Explosion"];
	_comboBox lbSetCurSel 0;

	_comboBox = _mccdialog displayCtrl MCC_TRAPS_DISARM;		//fill combobox IED Disarm time
	lbClear _comboBox;
	{
		_displayname = _x;
		_index = _comboBox lbAdd _displayname;
	} foreach ["10 Sec", "20 Sec", "30 Sec", "40 Sec", "50 Sec", "1 Min", "2 Min", "3 Min", "4 Min", "5 Min"];
	_comboBox lbSetCurSel 0;

	_comboBox = _mccdialog displayCtrl MCC_TRAPS_JAMMABLE;		//fill combobox IED Jameable
	lbClear _comboBox;
	{
		_displayname = _x;
		_index = _comboBox lbAdd _displayname;
	} foreach ["True", "False"];
	_comboBox lbSetCurSel 0;

	_comboBox = _mccdialog displayCtrl MCC_TRAPS_TRIGGER;		//fill combobox IED Trigger Type
	lbClear _comboBox;
	{
		_displayname = _x;
		_index = _comboBox lbAdd _displayname;
	} foreach ["Proximity", "Radio - Spotter", "Mission maker only","Mini-Game(Proximity)","Mini-Game(Manual)"];
	_comboBox lbSetCurSel 0;

	_comboBox = _mccdialog displayCtrl MCC_TRAPS_AMBUSH;		//fill combobox IED Ambush group
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x select 3];
		_index = _comboBox lbAdd _displayname;
	} foreach GEN_INFANTRY;
	_index = _comboBox lbAdd "Spotter - Civilian";
	_index = _comboBox lbAdd "Spotter - Camouflaged";
	_comboBox lbSetCurSel 0;
};
//-------------------------------------------------------------------------------------CONVOY----------------------------------------------------------------------------------------------
if (_action == 9) exitWith
{
	_control = (_mccdialog displayCtrl 509);
	_control ctrlShow true;

	//------------------------------------------Convoy Generator--------------------------------------------------------
	_comboBox = (_mccdialog displayCtrl 50);		//fill combobox Car1
	lbClear _comboBox;
	{
		_displayname = format ["%1",(_x select 3) select 0];
		_index = _comboBox lbAdd _displayname;
		_comboBox lbsetpicture [_index, (_x select 3) select 1];
	} foreach U_GEN_CAR;
	_index = _comboBox lbAdd "None";
	_comboBox lbSetCurSel MCC_convoyCar1Index;

	_comboBox =  (_mccdialog displayCtrl 51);		//fill combobox Car2
	lbClear _comboBox;
	{
		_displayname = format ["%1",(_x select 3) select 0];
		_index = _comboBox lbAdd _displayname;
		_comboBox lbsetpicture [_index, (_x select 3) select 1];
	} foreach U_GEN_CAR;
	_index = _comboBox lbAdd "None";
	_comboBox lbSetCurSel MCC_convoyCar2Index;

	_comboBox =  (_mccdialog displayCtrl 52);		//fill combobox Car3
	lbClear _comboBox;
	{
		_displayname = format ["%1",(_x select 3) select 0];
		_index = _comboBox lbAdd _displayname;
		_comboBox lbsetpicture [_index, (_x select 3) select 1];
	} foreach U_GEN_CAR;
	_index = _comboBox lbAdd "None";
	_comboBox lbSetCurSel MCC_convoyCar3Index;

	_comboBox =  (_mccdialog displayCtrl 53);		//fill combobox Car4
	lbClear _comboBox;
	{
		_displayname = format ["%1",(_x select 3) select 0];
		_index = _comboBox lbAdd _displayname;
		_comboBox lbsetpicture [_index, (_x select 3) select 1];
	} foreach U_GEN_CAR;
	_index = _comboBox lbAdd "None";
	_comboBox lbSetCurSel MCC_convoyCar4Index;

	_comboBox =  (_mccdialog displayCtrl 54);		//fill combobox Car5
	lbClear _comboBox;
	{
		_displayname = format ["%1",(_x select 3) select 0];
		_index = _comboBox lbAdd _displayname;
		_comboBox lbsetpicture [_index, (_x select 3) select 1];
	} foreach U_GEN_CAR;
	_index = _comboBox lbAdd "None";
	_comboBox lbSetCurSel MCC_convoyCar5Index;

	_comboBox =  (_mccdialog displayCtrl 55);;		//fill combobox HVT
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x select 0];
		_index = _comboBox lbAdd _displayname;
	} foreach MCC_convoyHVT;
	_comboBox lbSetCurSel MCC_convoyHVTIndex;

	_comboBox =  (_mccdialog displayCtrl 56);;		//fill combobox HVT car
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x select 0];
		_index = _comboBox lbAdd _displayname;
	} foreach MCC_convoyHVTcar;
	_comboBox lbSetCurSel MCC_convoyHVTCarIndex;
};

//-------------------------------------------------------------------------------------Markers----------------------------------------------------------------------------------------------
if (_action == 10) exitWith
{
	_control = (_mccdialog displayCtrl 511);
	_control ctrlShow true;

	//------------------------------------------------Markers-------------------------------------------------------
	_comboBox =(_mccdialog displayCtrl 3051);		//fill Markers Colors 1
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x select 0];
		_comboBox lbAdd _displayname;
	} foreach MCC_colorsarray;
	_comboBox lbSetCurSel 0;

	_comboBox = (_mccdialog displayCtrl 3053);		//fill Markers Shape
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach MCC_shapeMarker;
	_comboBox lbSetCurSel 0;

	_comboBox =(_mccdialog displayCtrl 3054);		//fill Markers Brush
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x select 0];
		_index = _comboBox lbAdd _displayname;
		_pic = (_x select 1);
		if (!isnil "_pic") then {_comboBox lbsetpicture [_index, _x select 1]};
	} foreach MCC_brushesarray;
	_comboBox lbSetCurSel 0;

	_comboBox = (_mccdialog displayCtrl 3052);		//fill Markers Type
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x select 0];
		_index = _comboBox lbAdd _displayname;
		_pic = (_x select 1);
		if (!isnil "_pic") then {_comboBox lbsetpicture [_index, _x select 1]};
	} foreach MCC_markerarray;
	_comboBox lbSetCurSel 0;

	_comboBox = (_mccdialog displayCtrl 3049);		//fill Available Markers
	lbClear _comboBox;
	{
		_displayname = _x;
		_index = _comboBox lbAdd _displayname;
	} foreach (missionNamespace getVariable ["MCC_activeMarkers",[]]);
	_comboBox lbSetCurSel 0;
};

//-------------------------------------------------------------------------------------Briefing----------------------------------------------------------------------------------------------
if (_action == 11) exitWith
{
	_control = (_mccdialog displayCtrl 512);
	_control ctrlShow true;
};

//-------------------------------------------------------------------------------------TASKS----------------------------------------------------------------------------------------------
if (_action == 12) exitWith
{
	_control = (_mccdialog displayCtrl 513);
	_control ctrlShow true;

	//---------------------------------------------------Taskss--------------------------------------------------------
	_comboBox = (_mccdialog displayCtrl 3058);		//fill Tasks
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x select 0];
		_comboBox lbAdd _displayname;
	} foreach MCC_tasks;
	_comboBox lbSetCurSel 0;
};

//-------------------------------------------------------------------------------------JUKEBOX----------------------------------------------------------------------------------------------
if (_action == 13) exitWith {
	_control = (_mccdialog displayCtrl 514);
	_control ctrlShow true;

	//--------------------------------------------------Jukebox---------------------------------------------------------------------------
	#define MCC_JUKEBOX_VOLUME 3059
	#define MCC_JUKEBOX_TRACK 3060
	#define MCC_JUKEBOX_ACTIVATE 3061
	#define MCC_JUKEBOX_CONDITION 3062
	#define MCC_JUKEBOX_ZONE 3063

	private ["_trackArray","_tracksCfg","_track","_cfgname","_cfgclass"];
	_trackArray = [];

	_tracksCfg = if (missionNamespace getvariable ["MCC_jukeboxMusic",true]) then {[missionConfigFile >> "CfgMusic",configFile >> "CfgMusic"]} else {[missionConfigFile >> "CfgSounds",ConfigFile >> "CfgSounds",configFile >> "CfgSFX"]};

	{
		for "_i" from 0 to ((count _x) - 1) do {
			_track = _x select _i;
			if (isClass _track) then {
				_cfgname = getText (_track >> "name");
				_cfgclass = configName(_track);
				_trackArray pushBack [_cfgname,_cfgclass,_foreachindex];
			};
		};
	} forEach _tracksCfg;


	//fill combobox music tracks
	_comboBox = _mccdialog displayCtrl MCC_JUKEBOX_TRACK;
	lbClear _comboBox;

	{
		_displayname = format ["%1",_x select 0];
		_comboBox lbAdd _displayname;
		_comboBox lbSetData [_foreachindex,_x select 1];
	} foreach _trackArray;
	_comboBox lbSetCurSel (missionNamespace getVariable ["MCC_musicTracks_index",0]);

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
	sliderSetPosition [MCC_JUKEBOX_VOLUME, (1 - musicVolume)];
};

//-------------------------------------------------------------------------------------JUKEBOX----------------------------------------------------------------------------------------------
if (_action == 14) exitWith
{
	_control = (_mccdialog displayCtrl 515);
	_control ctrlShow true;

	//--------------------------------------------------TRIGGERS---------------------------------------------------------------------------
	#define MCC_TRIGGERS_ACTIVATE 3064
	#define MCC_TRIGGERS_CONDITION 3065
	#define MCC_TRIGGERS_SHAPE 3066
	#define MCC_TRIGGERS_LIST 3067
	#define MCC_TRIGGERS_NAME 3068
	#define MCC_TRIGGERS_TIME_MIN 3071
	#define MCC_TRIGGERS_TIME_MAX 3072
	#define MCC_TRIGGERS_STAT_COND 3073
	#define MCC_TRIGGERS_STAT_DEACTIVE 3075

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
};

//-------------------------------------------------------------------------------------CLIENT SIDE----------------------------------------------------------------------------------------------
if (_action == 15) exitWith
{
	_control = (_mccdialog displayCtrl 516);
	_control ctrlShow true;

	#define MCCVIEWDISTANCE 1006
	#define MCCGRASSDENSITY 1007

	//----------------------------------------------------------Client Side settings----------------------------------------------------------------------------

	_comboBox = _mccdialog displayCtrl MCCGRASSDENSITY;		//fill combobox Grass
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x select 0];
		_comboBox lbAdd _displayname;
	} foreach MCC_grass_array;
	_comboBox lbSetCurSel (MCC_terrainPref select 0);

	_comboBox = _mccdialog displayCtrl MCCVIEWDISTANCE;		//fill combobox View distance
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x];
		_comboBox lbAdd _displayname;
	} foreach MCC_view_array;
	_comboBox lbSetCurSel (MCC_terrainPref select 1); // set viewdistance index to current vd

	sleep 1;
	MCC_GUI1initDone = true;
};

//-------------------------------------------------------------------------------------AIRDROP----------------------------------------------------------------------------------------------
if (_action == 16) exitWith
{
	_control = (_mccdialog displayCtrl 517);
	_control ctrlShow true;

	#define MCC_AIRDROPTYPE 1031
	#define MCC_airdropArray 1033

	_comboBox = _mccdialog displayCtrl MCC_AIRDROPTYPE;		//Airdrop Type
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Vehicles", "Tracked", "Motorcycles", "Ships", "Ammo"];
	_comboBox lbSetCurSel 0;

	_comboBox = _mccdialog displayCtrl MCC_airdropArray;		//Airdrop Current Airdrop
	lbClear _comboBox;
	{
		if (!isnil "_x") then
		{
			_displayname = getText(configFile >> "CfgVehicles" >> _x >> "displayname") ;
			_comboBox lbAdd _displayname;
		};
	} foreach MCC_airDropArray;
	_comboBox lbSetCurSel 0;

	//set to parachute
	_comboBox = _mccdialog displayCtrl 1037;
	_comboBox lbSetCurSel 0;
	missionNamespace setVariable ["MCC_airdropIsParachute",true];
};

//-------------------------------------------------------------------------------------DELETE----------------------------------------------------------------------------------------------
if (_action == 17) exitWith
{
	_control = (_mccdialog displayCtrl 518);
	_control ctrlShow true;

	#define MCCDELETEBRUSH 1030

	_comboBox = _mccdialog displayCtrl MCCDELETEBRUSH;		//Delete Brush
	lbClear _comboBox;
	{
		_displayname = _x;
		_comboBox lbAdd _displayname;
	} foreach ["Delete All","Delete All Units", "Delete Men", "Delete Vehicles", "Delete Tanks", "Delete Air", "Delete Ammoboxs","Delete Markers","Delete dead bodies","Destroy Lights","Lock Doors(All)","Lock Doors(Random)","Unlock Doors(All)","Atmosphere - Warzone","Atmosphere - Sandstorm","Atmosphere - Blizzard","Atmosphere - Snow","Atmosphere - Heatwave","Atmosphere - Clear","Remove N/V from units","Add Flashlights to all units"];
	_comboBox lbSetCurSel 0;
};

sleep 1;
MCC_GUI1initDone = true;
