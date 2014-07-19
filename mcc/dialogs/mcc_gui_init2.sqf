#define MCC_SANDBOX2_IDD 2000

#define MAIN 1050
#define MENU2 1051
#define MENU3 1052
#define MENU4 1053
#define MENU5 1054
#define MCCSTOPCAPTURE 1014

#define FACTIONCOMBO 1001
#define MCCZONENUMBER 1023
#define MCC_ZONE_LOC 1026

#define MCC_CLTEXT 2001
#define MCC_CASPLANETYPE 2002
#define MCC_CASTYPE 2003
#define MCC_ARTYTYPE 2004
#define MCC_ARTYSPREAD 2005
#define MCC_ARTYNUMBER 2006
#define MCC_artilleryDelayIDC 2037

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

#define MCC_EVAC_TYPE 2020
#define MCC_EVAC_CLASS 2021
#define MCC_EVAC_SELECTED 2022
#define MCC_EVAC_INSERTION 2023
#define MCC_EVAC_FLIGHTHIGHT 2024

#define MCC_CONVOY_CAR1 2030
#define MCC_CONVOY_CAR2 2031
#define MCC_CONVOY_CAR3 2032
#define MCC_CONVOY_CAR4 2033
#define MCC_CONVOY_CAR5 2034
#define MCC_CONVOY_HVT 2035
#define MCC_CONVOY_HVTCAR 2036

private ["_mccdialog","_comboBox","_displayname","_it","_x","_vehicleDisplayName"];
disableSerialization;

ctrlEnable [MAIN,false]; //Disable switching menus till the init is done
ctrlEnable [MENU2,false];
ctrlEnable [MENU3,false];
ctrlEnable [MENU4,false];
ctrlEnable [MENU5,false];
if (!MCC_capture_state) then { ctrlEnable [MCCSTOPCAPTURE,false];};

_mccdialog = findDisplay MCC_SANDBOX2_IDD;

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
//--------------------------------------CAS--------------------------------------------------------------------------

_comboBox = _mccdialog displayCtrl MCC_CASPLANETYPE;		//fill combobox CAS Plane Type
	lbClear _comboBox;
	{
		_displayname =  format ["%1",(_x select 3)select 0];
		_index = _comboBox lbAdd _displayname;		
		_comboBox lbsetpicture [_index, (_x select 3) select 1];
	} foreach (U_GEN_AIRPLANE+U_GEN_HELICOPTER);
	_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_CASTYPE;		//fill combobox CAS Bomb Type
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x];
		_comboBox lbAdd _displayname;
	} foreach MCC_CASBombs;
	_comboBox lbSetCurSel 0;
//---------------------------------Artillery----------------------------------------------------------------------------
_comboBox = _mccdialog displayCtrl MCC_ARTYTYPE;		//fill combobox CFG Artillery Type
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x select 0];
		_comboBox lbAdd _displayname;
	} foreach MCC_artilleryTypeArray;
	_comboBox lbSetCurSel 0;
	
_comboBox = _mccdialog displayCtrl MCC_ARTYSPREAD;		//fill combobox CFG Artillery Spread
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x select 0];
		_comboBox lbAdd _displayname;
	} foreach MCC_artillerySpreadArray;
	_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_ARTYNUMBER;		//fill combobox CFG Artillery Number
	lbClear _comboBox;
	{
		_displayname = format ["%1",_x];
		_comboBox lbAdd _displayname;
	} foreach MCC_artilleryNumberArray;
	_comboBox lbSetCurSel 0;
	
_comboBox = _mccdialog displayCtrl MCC_artilleryDelayIDC;		//fill combobox IED Ambush group
lbClear _comboBox;
{
	_displayname = _x;
	_index = _comboBox lbAdd _displayname;
} foreach ["0","20 sec","40 sec","1 min","80  sec","100  sec","2 min","140 sec","160 sec","3 min"];
_comboBox lbSetCurSel 0;

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
} foreach ["Proximity", "Radio - Spotter", "Mission maker only"];
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_TRAPS_AMBUSH;		//fill combobox IED Ambush group
lbClear _comboBox;
{
	_displayname = format ["%1",_x select 3];
	_index = _comboBox lbAdd _displayname;
} foreach GEN_INFANTRY;
_index = _comboBox lbAdd "Spotter - Civilian";
_comboBox lbSetCurSel 0;



//--------------------------------------------------------EVAC Settings---------------------------------------------------------

_comboBox = _mccdialog displayCtrl MCC_EVAC_TYPE;		
lbClear _comboBox;
{
	_displayname = _x;
	_index = _comboBox lbAdd _displayname;
} foreach ["Helicopters", "Vehicles","Tracked", "Ships"];
_comboBox lbSetCurSel 0;

_comboBox = _mccdialog displayCtrl MCC_EVAC_FLIGHTHIGHT;		//fill combobox Fly in Hight
lbClear _comboBox;
{
	_displayname = format ["%1",_x  select 0];
	_index = _comboBox lbAdd _displayname;
} foreach MCC_evacFlyInHight_array;
_comboBox lbSetCurSel MCC_evacFlyInHight_index;

_comboBox = _mccdialog displayCtrl MCC_EVAC_SELECTED;		//fill combobox for availabe evac type
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
} foreach MCC_evacVehicles;
_comboBox lbSetCurSel MCC_evacVehicles_index;

if (count MCC_evacVehicles > 0) then {										//Change evac type by vehicle class
	private ["_insetionArray","_type"];
	_insetionArray = ["Move (engine on)","Move (engine off)"];
	ctrlShow [MCC_EVAC_FLIGHTHIGHT,false];
	_type = MCC_evacVehicles select MCC_evacVehicles_index;
	if (_type iskindof "helicopter") then {									//Case we choose aircrft
			_insetionArray = ["Free Landing (engine on)","Free Landing (engine off)","Hover","Helocasting(Water)"];
			ctrlShow [MCC_EVAC_FLIGHTHIGHT,true];
			};

	_comboBox = _mccdialog displayCtrl MCC_EVAC_INSERTION;					//Adjust insertion type by evac type
		lbClear _comboBox;
		{
			_displayname = _x;
			_index = _comboBox lbAdd _displayname;
		} foreach _insetionArray;
		_comboBox lbSetCurSel 0;
};

//------------------------------------------Convoy Generator--------------------------------------------------------
_comboBox = _mccdialog displayCtrl MCC_CONVOY_CAR1;		//fill combobox Car1
lbClear _comboBox;
{
	_displayname = format ["%1",(_x select 3) select 0];
	_index = _comboBox lbAdd _displayname;
	_comboBox lbsetpicture [_index, (_x select 3) select 1];
} foreach U_GEN_CAR;
_index = _comboBox lbAdd "None";
_comboBox lbSetCurSel MCC_convoyCar1Index;

_comboBox = _mccdialog displayCtrl MCC_CONVOY_CAR2;		//fill combobox Car2
lbClear _comboBox;
{
	_displayname = format ["%1",(_x select 3) select 0];
	_index = _comboBox lbAdd _displayname;
	_comboBox lbsetpicture [_index, (_x select 3) select 1];
} foreach U_GEN_CAR;
_index = _comboBox lbAdd "None";
_comboBox lbSetCurSel MCC_convoyCar2Index;

_comboBox = _mccdialog displayCtrl MCC_CONVOY_CAR3;		//fill combobox Car3
lbClear _comboBox;
{
	_displayname = format ["%1",(_x select 3) select 0];
	_index = _comboBox lbAdd _displayname;
	_comboBox lbsetpicture [_index, (_x select 3) select 1];
} foreach U_GEN_CAR;
_index = _comboBox lbAdd "None";
_comboBox lbSetCurSel MCC_convoyCar3Index;

_comboBox = _mccdialog displayCtrl MCC_CONVOY_CAR4;		//fill combobox Car4
lbClear _comboBox;
{
	_displayname = format ["%1",(_x select 3) select 0];
	_index = _comboBox lbAdd _displayname;
	_comboBox lbsetpicture [_index, (_x select 3) select 1];
} foreach U_GEN_CAR;
_index = _comboBox lbAdd "None";
_comboBox lbSetCurSel MCC_convoyCar4Index;

_comboBox = _mccdialog displayCtrl MCC_CONVOY_CAR5;		//fill combobox Car5
lbClear _comboBox;
{
	_displayname = format ["%1",(_x select 3) select 0];
	_index = _comboBox lbAdd _displayname;
	_comboBox lbsetpicture [_index, (_x select 3) select 1];
} foreach U_GEN_CAR;
_index = _comboBox lbAdd "None";
_comboBox lbSetCurSel MCC_convoyCar5Index;

_comboBox = _mccdialog displayCtrl MCC_CONVOY_HVT;		//fill combobox HVT
lbClear _comboBox;
{
	_displayname = format ["%1",_x select 0];
	_index = _comboBox lbAdd _displayname;
} foreach MCC_convoyHVT;
_comboBox lbSetCurSel MCC_convoyHVTIndex;

_comboBox = _mccdialog displayCtrl MCC_CONVOY_HVTCAR;		//fill combobox HVT car
lbClear _comboBox;
{
	_displayname = format ["%1",_x select 0];
	_index = _comboBox lbAdd _displayname;
} foreach MCC_convoyHVTcar;
_comboBox lbSetCurSel MCC_convoyHVTCarIndex;

ctrlEnable [MAIN,true]; //Enable switching menus
ctrlEnable [MENU2,false];
ctrlEnable [MENU3,true];
ctrlEnable [MENU4,true];
ctrlEnable [MENU5,true];

