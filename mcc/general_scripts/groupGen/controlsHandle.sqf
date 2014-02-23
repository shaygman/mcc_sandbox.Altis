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

private ["_action","_control","_show","_mccdialog","_comboBox","_displayname"];
disableSerialization;

_action = _this select 0;

//-------------------------------------------------------------------------------------Weather----------------------------------------------------------------------------------------------
if (_action == 0) exitWith
{
	_control = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 501);
	_show = if (ctrlShown _control) then {false} else {true}; 
	_control ctrlShow _show;		
	
	if (_show) then
	{
		((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 10) sliderSetRange [0, 1];
		((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 11) sliderSetRange [0, 1];
		((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 12) sliderSetRange [0, 1];
		
		((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 10) sliderSetPosition fog;
		((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 11) sliderSetPosition rain;
		((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 12) sliderSetPosition overcast;
	};
};

//-------------------------------------------------------------------------------------Time----------------------------------------------------------------------------------------------
if (_action == 1) exitWith
{
	_control = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 502);
	_show = if (ctrlShown _control) then {false} else {true}; 
	_control ctrlShow _show;
	
	if (_show) then
	{
		//--------------------------------------Fill index--------------------------------------------------------------------------
		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 15);		// MONTH
		lbClear _comboBox;
		{
			_displayname = format ["%1",_x select 0];
			_comboBox lbAdd _displayname;
		} foreach MCC_months_array;
		_comboBox lbSetCurSel (date select 1)-1;

		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 16);		// Day
		lbClear _comboBox;
		{
			_displayname = format ["%1",_x];
			_comboBox lbAdd _displayname;
		} foreach MCC_days_array;
		_comboBox lbSetCurSel (date select 2)-1;
		
		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 17);		//  Year
		lbClear _comboBox;
		{
			_displayname = format ["%1",_x];
			_comboBox lbAdd _displayname;
		} foreach [1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2024,2025,2026,2027,2028,2029,2030];
		_comboBox lbSetCurSel ((date select 0)-1990);

		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 18);		// HOUR
		lbClear _comboBox;
		{
			_displayname = if (_x < 10) then {format ["0%1",_x]} else {format ["%1",_x]};
			_comboBox lbAdd _displayname;
		} foreach MCC_hours_array;
		_comboBox lbSetCurSel (date select 3);

		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 19);		// Minutes
		lbClear _comboBox;
		{
			_displayname = if (_x < 10) then {format ["0%1",_x]} else {format ["%1",_x]};
			_comboBox lbAdd _displayname;
		} foreach MCC_minutes_array;
		_comboBox lbSetCurSel (date select 4);
	};
};

//-------------------------------------------------------------------------------------RESPWAN----------------------------------------------------------------------------------------------
if (_action == 2) exitWith
{
	_control = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 503);
	_show = if (ctrlShown _control) then {false} else {true}; 
	_control ctrlShow _show;
	
	if (_show) then
	{
		//--------------------------------------Fill index--------------------------------------------------------------------------
		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 20);		// Teleport
		lbClear _comboBox;
		{
			_displayname = _x;
			_comboBox lbAdd _displayname;
		} foreach ["Yes","No"];
		_comboBox lbSetCurSel 0;

		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 21);		// FOB
		lbClear _comboBox;
		{
			_displayname = _x;
			_comboBox lbAdd _displayname;
		} foreach ["HQ","FOB"];
		_comboBox lbSetCurSel 0;
	};
};

//-------------------------------------------------------------------------------------DEBUG----------------------------------------------------------------------------------------------
if (_action == 3) exitWith
{
	_control = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 504);
	_show = if (ctrlShown _control) then {false} else {true}; 
	_control ctrlShow _show;
};

//-------------------------------------------------------------------------------------CAS----------------------------------------------------------------------------------------------
if (_action == 4) exitWith
{
	_control = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 500);
	_show = if (ctrlShown _control) then {false} else {true}; 
	_control ctrlShow _show;
	
	if (_show) then
	{
		//--------------------------------------CAS--------------------------------------------------------------------------

		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 25);		//fill combobox CAS Plane Type
		lbClear _comboBox;
		{
			_displayname =  format ["%1",(_x select 3)select 0];
			_index = _comboBox lbAdd _displayname;		
			_comboBox lbsetpicture [_index, (_x select 3) select 1];
		} foreach (U_GEN_AIRPLANE+U_GEN_HELICOPTER);
		_comboBox lbSetCurSel 0;

		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 26);		//fill combobox CAS Bomb Type
		lbClear _comboBox;
		{
			_displayname = format ["%1",_x];
			_comboBox lbAdd _displayname;
		} foreach MCC_CASBombs;
		_comboBox lbSetCurSel 0;
	};
};

//-------------------------------------------------------------------------------------Artillery----------------------------------------------------------------------------------------------
if (_action == 5) exitWith
{
	_control = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 505);
	_show = if (ctrlShown _control) then {false} else {true}; 
	_control ctrlShow _show;
	
	if (_show) then
	{
	//---------------------------------Artillery----------------------------------------------------------------------------
		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 30);		// Artillery Type
			lbClear _comboBox;
			{
				_displayname = format ["%1",_x select 0];
				_comboBox lbAdd _displayname;
			} foreach MCC_artilleryTypeArray;
			_comboBox lbSetCurSel 0;
			
		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 31);		//Artillery Spread
			lbClear _comboBox;
			{
				_displayname = format ["%1",_x select 0];
				_comboBox lbAdd _displayname;
			} foreach MCC_artillerySpreadArray;
			_comboBox lbSetCurSel 0;

		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 32);		//Artillery Number
			lbClear _comboBox;
			{
				_displayname = format ["%1",_x];
				_comboBox lbAdd _displayname;
			} foreach MCC_artilleryNumberArray;
			_comboBox lbSetCurSel 0;
			
		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 33);		//Artillery Delay
		lbClear _comboBox;
		{
			_displayname = _x;
			_index = _comboBox lbAdd _displayname;
		} foreach ["0","20 sec","40 sec","1 min","80  sec","100  sec","2 min","140 sec","160 sec","3 min"];
		_comboBox lbSetCurSel 0;
	};
};

//-------------------------------------------------------------------------------------SPAWN----------------------------------------------------------------------------------------------
if (_action == 6) exitWith
{
	_control = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 506);
	_show = if (ctrlShown _control) then {false} else {true}; 
	_control ctrlShow _show;
	
	if (_show) then
	{
		_mccdialog = findDisplay groupGen_IDD;
		MCC_groupGenCurrenGroupArray = []; 		//Reset the current group

		_comboBox = _mccdialog displayCtrl UNIT_TYPE;		//fill combobox CFG unit
		lbClear _comboBox;
		{
			_displayname =  _x;
			_index = _comboBox lbAdd _displayname;
		} foreach ["Infantry", "Vehicles", "Tracked", "Motorcycle", "Helicopter", "Fixed-wing", "Ship","D.O.C", "Ammo"];
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
		
		_comboBox =((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 0);		//fill zone locations
		lbClear _comboBox;
		{
			_displayname = _x select 0;
			_comboBox lbAdd _displayname;
		} foreach MCC_ZoneLocation;
		_comboBox lbSetCurSel mcc_hc;	//MCC_ZoneLocation_index;	
	};
};

//-------------------------------------------------------------------------------------EVAC----------------------------------------------------------------------------------------------
if (_action == 7) exitWith
{
	_control = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 507);
	_show = if (ctrlShown _control) then {false} else {true}; 
	_control ctrlShow _show;
	
	if (_show) then
	{
		//--------------------------------------------------------EVAC Settings---------------------------------------------------------
		_comboBox =  ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 40);		//EVAC type		
		lbClear _comboBox;
		{
			_displayname = _x;
			_index = _comboBox lbAdd _displayname;
		} foreach ["Helicopters", "Vehicles","Tracked", "Ships"];
		_comboBox lbSetCurSel 0;

		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 44);		//fill combobox Fly in Hight
		lbClear _comboBox;
		{
			_displayname = format ["%1",_x  select 0];
			_index = _comboBox lbAdd _displayname;
		} foreach MCC_evacFlyInHight_array;
		_comboBox lbSetCurSel MCC_evacFlyInHight_index;

		_comboBox =  ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 42);		//fill combobox for availabe evac type
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

		//Change evac type by vehicle class
		if (count MCC_evacVehicles > 0) then 
		{										
			private ["_insetionArray","_type"];
			_insetionArray = ["Move (engine on)","Move (engine off)"];
			ctrlShow [((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 44),false];
			_type = MCC_evacVehicles select MCC_evacVehicles_index;
			
			//Case we choose aircrft
			if (_type iskindof "helicopter") then 
			{									
				_insetionArray = ["Free Landing (engine on)","Free Landing (engine off)","Hover","Helocasting(Water)","Smoke Signal","Fast-Rope"];
				ctrlShow [((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 44),true];
			};

			_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 43);					//Adjust insertion type by evac type
			lbClear _comboBox;
			{
				_displayname = _x;
				_index = _comboBox lbAdd _displayname;
			} foreach _insetionArray;
			_comboBox lbSetCurSel 0;
		};
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
	
	_control = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 508);
	_show = if (ctrlShown _control) then {false} else {true}; 
	_control ctrlShow _show;
	
	if (_show) then
	{
		//--------------------------------------------------------TRAPS Settings---------------------------------------------------------
		_mccdialog = (uiNamespace getVariable "MCC_groupGen_Dialog");
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
	};
};
//-------------------------------------------------------------------------------------CONVOY----------------------------------------------------------------------------------------------
if (_action == 9) exitWith
{
	_control = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 509);
	_show = if (ctrlShown _control) then {false} else {true}; 
	_control ctrlShow _show;
	
	if (_show) then
	{
		//------------------------------------------Convoy Generator--------------------------------------------------------
		_comboBox = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 50);		//fill combobox Car1
		lbClear _comboBox;
		{
			_displayname = format ["%1",(_x select 3) select 0];
			_index = _comboBox lbAdd _displayname;
			_comboBox lbsetpicture [_index, (_x select 3) select 1];
		} foreach U_GEN_CAR;
		_index = _comboBox lbAdd "None";
		_comboBox lbSetCurSel MCC_convoyCar1Index;

		_comboBox =  ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 51);		//fill combobox Car2
		lbClear _comboBox;
		{
			_displayname = format ["%1",(_x select 3) select 0];
			_index = _comboBox lbAdd _displayname;
			_comboBox lbsetpicture [_index, (_x select 3) select 1];
		} foreach U_GEN_CAR;
		_index = _comboBox lbAdd "None";
		_comboBox lbSetCurSel MCC_convoyCar2Index;

		_comboBox =  ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 52);		//fill combobox Car3
		lbClear _comboBox;
		{
			_displayname = format ["%1",(_x select 3) select 0];
			_index = _comboBox lbAdd _displayname;
			_comboBox lbsetpicture [_index, (_x select 3) select 1];
		} foreach U_GEN_CAR;
		_index = _comboBox lbAdd "None";
		_comboBox lbSetCurSel MCC_convoyCar3Index;

		_comboBox =  ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 53);		//fill combobox Car4
		lbClear _comboBox;
		{
			_displayname = format ["%1",(_x select 3) select 0];
			_index = _comboBox lbAdd _displayname;
			_comboBox lbsetpicture [_index, (_x select 3) select 1];
		} foreach U_GEN_CAR;
		_index = _comboBox lbAdd "None";
		_comboBox lbSetCurSel MCC_convoyCar4Index;

		_comboBox =  ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 54);		//fill combobox Car5
		lbClear _comboBox;
		{
			_displayname = format ["%1",(_x select 3) select 0];
			_index = _comboBox lbAdd _displayname;
			_comboBox lbsetpicture [_index, (_x select 3) select 1];
		} foreach U_GEN_CAR;
		_index = _comboBox lbAdd "None";
		_comboBox lbSetCurSel MCC_convoyCar5Index;

		_comboBox =  ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 55);;		//fill combobox HVT
		lbClear _comboBox;
		{
			_displayname = format ["%1",_x select 0];
			_index = _comboBox lbAdd _displayname;
		} foreach MCC_convoyHVT;
		_comboBox lbSetCurSel MCC_convoyHVTIndex;

		_comboBox =  ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 56);;		//fill combobox HVT car
		lbClear _comboBox;
		{
			_displayname = format ["%1",_x select 0];
			_index = _comboBox lbAdd _displayname;
		} foreach MCC_convoyHVTcar;
		_comboBox lbSetCurSel MCC_convoyHVTCarIndex;
	};
};