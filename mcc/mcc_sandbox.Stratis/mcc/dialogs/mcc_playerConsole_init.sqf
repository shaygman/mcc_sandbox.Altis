private ["_mccdialog","_comboBox","_displayname","_pic", "_index","_planeName","_counter","_type","_group",
		 "_insetionArray","_control","_unitsCount","_markerType","_markerColor","_leader","_markerInf","_markerMech","_markerArmor","_markerAir",
		"_markerName","_icon","_wpArray","_haveGPS","_behaviour","_unitsSize","_unitsSizeMarker"];
// By: Shay_gman
// Version: 1.1 (May 2012)
#define MCC_SANDBOX_IDD 1000
#define MCC_SANDBOX2_IDD 2000
#define MCC_SANDBOX3_IDD 3000
#define MCC_SANDBOX4_IDD 4000
#define MCC_MINIMAP 9120

#define mcc_playerConsole_IDD 2993

#define MCC_ConsoleCASAvailableTextBox_IDD 9100
#define MCC_ConsoleEvacFlyHightComboBox_IDD 9101
#define MCC_ConsoleEvacApproachComboBox_IDD 9102
#define MCC_ConsoleAirdropAvailableTextBox_IDD 9104
#define MCC_ConsoleEvacTypeText_IDD 9103
#define MCC_CONSOLEINFOTEXT 9150
#define MCC_CONSOLEINFOLIVEFEED 9151
#define MCC_MAPBACKGROUND 9152
#define MCC_CONSOLEINFOLIVEFEEDNV 9153
#define MCC_CONSOLEINFOLIVEFEEDTM 9154
#define MCC_CONSOLEINFOLIVEFEEDCLOSE 9155
#define MCC_CONSOLEINFOLIVEFEEDNORMAL 9156
#define MCC_CONSOLEINFOUAVCONTROL 9162

#define MCC_CONSOLEWPBCKGR 9157
#define MCC_CONSOLEWPCOMBO 9158
#define MCC_CONSOLEWPFORMATIONCOMBO 9166
#define MCC_CONSOLEWPSPEEDCOMBO 9167
#define MCC_CONSOLEWPBEHAVIORCOMBO 9168

#define MCC_CONSOLEWPADD 	9159
#define MCC_CONSOLEWPREPLACE 9160
#define MCC_CONSOLEWPCLEAR 9161
#define MCC_ConsoleMapRulerButton 9163
#define MCC_ConsoleMapRulerDir 9164
#define MCC_ConsoleMapRulerDis 9165

disableSerialization;
MCC_Console1Open = true;
MCC_Console2Open = false;
MCC_Console3Open = false;
MCC_Console4Open = false;

ctrlShow [MCC_CONSOLEINFOTEXT,false];
ctrlShow [MCC_CONSOLEINFOLIVEFEED,false];
ctrlShow [MCC_CONSOLEINFOLIVEFEEDNV,false];
ctrlShow [MCC_CONSOLEINFOLIVEFEEDTM,false];
ctrlShow [MCC_CONSOLEINFOLIVEFEEDCLOSE,false];
ctrlShow [MCC_CONSOLEINFOLIVEFEEDNORMAL,false];
ctrlShow [MCC_CONSOLEWPBCKGR,false];
ctrlShow [MCC_CONSOLEWPCOMBO,false];
ctrlShow [MCC_CONSOLEWPFORMATIONCOMBO,false];
ctrlShow [MCC_CONSOLEWPSPEEDCOMBO,false];
ctrlShow [MCC_CONSOLEWPBEHAVIORCOMBO,false];
ctrlShow [MCC_CONSOLEWPADD,false];
ctrlShow [MCC_CONSOLEWPREPLACE,false];
ctrlShow [MCC_CONSOLEWPCLEAR,false];
ctrlShow [MCC_CONSOLEINFOUAVCONTROL,false];

//set ruler data
ctrlSetText [MCC_ConsoleMapRulerDir,format ["Dir: %1",MCC_ConsoleRulerData select 0]];
ctrlSetText [MCC_ConsoleMapRulerDis,format ["Dis: %1m",MCC_ConsoleRulerData select 1]];

_mccdialog = findDisplay mcc_playerConsole_IDD;
MCC_Console1Open = true; 
//--------------------------------------------------Evac-------------------------------------------------------------------------------	
if (count MCC_evacVehicles > 0) then	{
	_comboBox = _mccdialog displayCtrl MCC_ConsoleEvacTypeText_IDD;		//fill combobox type
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
	
	_type = MCC_evacVehicles select (lbCurSel MCC_ConsoleEvacTypeText_IDD);
	ctrlShow [MCC_ConsoleEvacFlyHightComboBox_IDD,false];
	_insetionArray = ["Move (engine on)","Move (engine off)"];	
	
	if (_type iskindof "helicopter") then {									//Case we choose aircrft
		ctrlShow [MCC_ConsoleEvacFlyHightComboBox_IDD,true];
		_insetionArray = ["Free Landing (engine on)","Free Landing (engine off)","Hover","Helocasting(Water)","Smoke Signal"];
		_comboBox = _mccdialog displayCtrl MCC_ConsoleEvacFlyHightComboBox_IDD;		//fill combobox Fly in Hight
		lbClear _comboBox;
		{
			_displayname = format ["%1",_x  select 0];
			_index = _comboBox lbAdd _displayname;
		} foreach MCC_evacFlyInHight_array;
		_comboBox lbSetCurSel 0;
	};
	
		_comboBox = _mccdialog displayCtrl MCC_ConsoleEvacApproachComboBox_IDD;		//fill combobox Approach
	lbClear _comboBox;
	{
		_displayname = _x;
		_index = _comboBox lbAdd _displayname;
	} foreach _insetionArray;
	_comboBox lbSetCurSel 0;
};

//----------------------------------------------CAS--------------------------------------------------------------------------------------
_comboBox = _mccdialog displayCtrl MCC_ConsoleCASAvailableTextBox_IDD;		//fill list box for CAS Types
lbClear _comboBox;
{
	_planeName = getText (configFile >> "CfgVehicles" >> (_x  select 1) select 0>> "displayname");
	_displayname = format ["CAS:%1, Plane:%2",(_x  select 0) select 0,_planeName];
	_index = _comboBox lbAdd _displayname;
} foreach MCC_CASConsoleArray;
_comboBox lbSetCurSel 0;

//----------------------------------------------Airdrop--------------------------------------------------------------------------------------
_comboBox = _mccdialog displayCtrl MCC_ConsoleAirdropAvailableTextBox_IDD;		//fill list box for Airdrop Types
lbClear _comboBox;
_counter = 0; 
{
	_counter = _counter + 1;
	_displayname = format ["%1: ",_counter];
	{
		_displayname = format ["%1, %2",_displayname, getText(configFile >> "CfgVehicles" >> _x >> "displayname")];
	} foreach ((_x select 0) select 0);
	_index = _comboBox lbAdd _displayname;
} foreach MCC_ConsoleAirdropArray;
_comboBox lbSetCurSel 0;

//------------------------------------------Group Control-------------------------------------------------------------------------------------
//---------------------Console Groups management

if (!isnil "HCEast" ||  !isnil "HCWest" || !isnil "HCGuer") exitWith {}; 			//If HC is working aboart process
onGroupIconClick
{
    if (!(MCC_Console1Open) && dialog) exitWith {};

	_is3D = _this select 0;
    _group = _this select 1;
    _wpID = _this select 2;
    _button = _this select 3;
    _posx = _this select 4;
    _posy = _this select 5;
    _shift = _this select 6;
    _ctrl = _this select 7;
    _alt = _this select 8;
    
	[_group,_button,[_posx,_posy],_shift,_ctrl,_alt] execVm format ["%1mcc\fnc\console\fn_consoleClickGroupIcon.sqf",MCC_path];
	//[_group,_button,[_posx,_posy],_shift,_ctrl,_alt] call MCC_fnc_consoleClickGroupIcon;
};

//Add - Ctrl + number group selections handlers
if (isnil "MCC_consoleGroupSelectionEH") then
	{
		MCC_consoleGroupSelectionEH = (findDisplay 46) displayAddEventHandler  ["KeyDown", format ["nul = _this execVM '%1mcc\general_scripts\console\groupNumbersSelectionEH.sqf';",MCC_path]];
	};
	
[] call 
	{
		private ["_markerSupport","_markerAutonomous","_markerNaval","_markerRecon"]; 
		switch (format ["%1", playerside]) do 	
			{
				case "EAST": //East
					{
					_markerColor 	= [1,0,0,0.7];
					_markerInf		= "o_inf";
					_markerRecon	= "o_recon";
					_markerSupport	= "o_support";
					_markerAutonomous = "o_uav";
					_markerMech		= "o_mech_inf";
					_markerArmor	= "o_armor";
					_markerAir		= "o_air";
					_markerNaval	= "o_naval";
					}; 
					
				case "WEST": //West
					{
					_markerColor 	= [0,0,1,1];
					_markerInf		= "b_inf";
					_markerRecon	= "b_recon";
					_markerSupport	= "b_support";
					_markerAutonomous = "b_uav";
					_markerMech		= "b_mech_inf";
					_markerArmor	= "b_armor";
					_markerAir		= "b_air";
					_markerNaval	= "b_naval";
					};
					
				case "GUER": //Resistance
					{
					_markerColor 	= [0,1,0,0.7];
					_markerInf		= "n_inf";
					_markerRecon	= "n_recon";
					_markerSupport	= "n_support";
					_markerAutonomous = "n_uav";
					_markerMech		= "n_mech_inf";
					_markerArmor	= "n_armor";
					_markerAir		= "n_air";
					_markerNaval	= "n_naval";
					};
				case "CIV": //Resistance
					{
					_markerColor 	= [1,1,1,0.7];
					_markerInf		= "n_inf";
					_markerRecon	= "n_recon";
					_markerSupport	= "n_support";
					_markerAutonomous = "n_uav";
					_markerMech		= "n_mech_inf";
					_markerArmor	= "n_armor";
					_markerAir		= "n_air";
					_markerNaval	= "n_naval";
					};
			};
		
		setGroupIconsVisible [true,false];	
		setGroupIconsSelectable true;
			{
				_leader = (leader _x);
				 
				if ((side _leader == side player) && alive _leader && count (units _x)>0 ) then
					{
						_haveGPS =  ("ItemGPS" in (assignedItems _leader) || "B_UavTerminal" in (assignedItems _leader) || "MCC_Console" in (assignedItems _leader));
						_unitsCount = [group _leader] call MCC_fnc_countGroupHC;
						_unitsSize = 0;
						_markerType = nil; 
						if (_unitsCount select 0 > 0) then {_markerType = _markerInf; _unitsSize = _unitsSize + (1*(_unitsCount select 0))};
						if (_unitsCount select 1 > 0) then {_markerType = _markerMech; _unitsSize = _unitsSize + (3*(_unitsCount select 1))};
						if (_unitsCount select 2 > 0) then {_markerType = _markerArmor; _unitsSize = _unitsSize + (3*(_unitsCount select 2))};
						if (_unitsCount select 3 > 0) then {_markerType = _markerAir; _unitsSize = _unitsSize + (3*(_unitsCount select 3))};
						if (_unitsCount select 4 > 0) then {_markerType = _markerNaval; _unitsSize = _unitsSize + (3*(_unitsCount select 4))};
						if (_unitsCount select 5 > 0) then {_markerType = _markerRecon; _unitsSize = _unitsSize + (1*(_unitsCount select 5))};
						if (_unitsCount select 6 > 0) then {_markerType = _markerSupport; _unitsSize = _unitsSize + (3*(_unitsCount select 6))};
						if (_unitsCount select 7 > 0) then {_markerType = _markerAutonomous; _unitsSize = _unitsSize + (1*(_unitsCount select 7))};
						
						if (isnil "_markerType") then
						{
							_unitsCount = [group _leader] call MCC_fnc_countGroup;
							if (_unitsCount select 0 > 0) then {_markerType = _markerInf; _unitsSize = _unitsSize + (1*(_unitsCount select 0))};
							if (_unitsCount select 1 > 0) then {_markerType = _markerMech; _unitsSize = _unitsSize + (3*(_unitsCount select 1))};
							if (_unitsCount select 2 > 0) then {_markerType = _markerArmor; _unitsSize = _unitsSize + (3*(_unitsCount select 2))};
							if (_unitsCount select 3 > 0) then {_markerType = _markerAir; _unitsSize = _unitsSize + (3*(_unitsCount select 3))};
							if (_unitsCount select 4 > 0) then {_markerType = _markerNaval; _unitsSize = _unitsSize + (3*(_unitsCount select 4))};
						};
						
						//How big is the squad
						_unitsSize = floor (_unitsSize/4); 
						if (_unitsSize > 10) then {_unitsSize = 10};
						_unitsSizeMarker = format ["group_%1",_unitsSize];
						
						//Set markers
						if ((MCC_ConsoleOnlyShowUnitsWithGPS && (_haveGPS || vehicle _leader != _leader)) || !MCC_ConsoleOnlyShowUnitsWithGPS) then
							{
								_icon = _x addGroupIcon [_markerType,[0,0]];
								_x setGroupIconParams [_markerColor,groupID _x,1,true];
								_x setvariable ["MCCgroupIconData",_icon,false];
								_icon = _x addGroupIcon [_unitsSizeMarker,[0,0]];
								_x setvariable ["MCCgroupIconSize",[_icon,_unitsSizeMarker],false];
							}
					}; 
			} foreach allgroups; 
			
		while {MCC_Console1Open && dialog} do 		//Draw WP
			{
				{
					_leader = (leader _x);
					_groupStatus = _x getvariable "MCC_support";
					_wpArray = waypoints (group _leader);
					_behaviour = behaviour _leader;
					if ((side _leader == side player) && alive _leader) then
						{
							_x setGroupIconParams [_markerColor,groupID _x,1,true];
							_unitsCount = [group _leader] call MCC_fnc_countGroupHC;
							_unitsSize = 0;
							if (_unitsCount select 0 > 0) then {_unitsSize = _unitsSize + (1*(_unitsCount select 0))};
							if (_unitsCount select 1 > 0) then {_unitsSize = _unitsSize + (3*(_unitsCount select 1))};
							if (_unitsCount select 2 > 0) then {_unitsSize = _unitsSize + (3*(_unitsCount select 2))};
							if (_unitsCount select 3 > 0) then {_unitsSize = _unitsSize + (3*(_unitsCount select 3))};
							if (_unitsCount select 4 > 0) then {_unitsSize = _unitsSize + (3*(_unitsCount select 4))};
							if (_unitsCount select 5 > 0) then {_unitsSize = _unitsSize + (1*(_unitsCount select 5))};
							if (_unitsCount select 6 > 0) then {_unitsSize = _unitsSize + (3*(_unitsCount select 6))};
							if (_unitsCount select 7 > 0) then {_unitsSize = _unitsSize + (1*(_unitsCount select 7))};
							
							if (_unitsSize == 0) then
							{
								_unitsCount = [group _leader] call MCC_fnc_countGroup;
								if (_unitsCount select 0 > 0) then { _unitsSize = _unitsSize + (1*(_unitsCount select 0))};
								if (_unitsCount select 1 > 0) then { _unitsSize = _unitsSize + (3*(_unitsCount select 1))};
								if (_unitsCount select 2 > 0) then { _unitsSize = _unitsSize + (3*(_unitsCount select 2))};
								if (_unitsCount select 3 > 0) then { _unitsSize = _unitsSize + (3*(_unitsCount select 3))};
								if (_unitsCount select 4 > 0) then { _unitsSize = _unitsSize + (3*(_unitsCount select 4))};
							};
							
							//How big is the squad
							_unitsSize = floor (_unitsSize/4); 
							if (_unitsSize > 10) then {_unitsSize = 10};
							_unitsSizeMarker = format ["group_%1",_unitsSize];
							_x removeGroupIcon ((_x getvariable "MCCgroupIconSize") select 0);
							_icon = _x addGroupIcon [_unitsSizeMarker,[0,0]];
							_x setvariable ["MCCgroupIconSize",[_icon,_unitsSizeMarker],false];
								
							if ((count _wpArray > 0) && MCC_ConsoleDrawWP )then
								{
									private ["_wp","_wPos","_wType"];
									MCC_lastPos = nil; 
									for [{_i=0},{_i < count _wpArray},{_i=_i+1}] do 	//Draw the current WP
									{			
										_wp = (_wpArray select _i);
										_wPos  = waypointPosition _wp;
										_wType = waypointType _wp;
										createMarkerLocal [format["%1", _wp],_wPos];
										format["%1", _wp] setMarkerTypelocal "waypoint";
										format["%1", _wp] setMarkerColorlocal "ColorBlue";
										format["%1", _wp] setMarkerTextLocal (format ["%1",_wType]);
										MCC_groupGenTempWP set [count MCC_groupGenTempWP, format["%1", _wp]];
										if (isnil "MCC_lastPos") then {MCC_lastPos = [(getpos _leader) select 0,(getpos _leader) select 1]}; 
										[MCC_lastPos , _wPos ,format ["%1%2", _i,group _leader]] call MCC_fnc_drawLine;	//draw the line
										MCC_groupGenTempWPLines set [count MCC_groupGenTempWPLines, format["line_%1%2", _i,group _leader]];
										MCC_lastPos = _wPos; 
									};
								};

							if (! isnil "_groupStatus") then 					//Draw group status
								{
									private ["_time","_status"];
									_time 		= _groupStatus select 1; 
									_status 	= _groupStatus select 0; 
									
									if (abs (time - _time) < 180) then
										{
											_x setGroupIconParams [_markerColor,format ["%1%2",groupID _x,_status],1,true];
										}
										else
										{
											_x setGroupIconParams [_markerColor,groupID _x,1,true];
										};
								};
								
							if (_behaviour == "COMBAT") then				//Show in combat
								{
									_x setGroupIconParams [[1,1,1,1],groupID _x,1,true];
								};
						};
				} foreach allgroups; 
				sleep 0.5;
				{deletemarkerlocal _x} foreach MCC_groupGenTempWP;
				MCC_groupGenTempWP = []; 
				{deletemarkerlocal _x} foreach MCC_groupGenTempWPLines;
				MCC_groupGenTempWPLines = []; 
			}; 
		//Clear stuff after exiting
		{deletemarkerlocal _x} foreach MCC_groupGenTempWP;
		MCC_groupGenTempWP = []; 
		{deletemarkerlocal _x} foreach MCC_groupGenTempWPLines;
		MCC_groupGenTempWPLines = []; 
		{
			_leader = (leader _x); 
			if ((side _leader == side player) && alive _leader) then
				{
					clearGroupIcons _x; 
				}; 
		} foreach allgroups;
		setGroupIconsVisible [false,false];
		setGroupIconsSelectable false;
		ctrlShow [MCC_MINIMAP,true];
	};