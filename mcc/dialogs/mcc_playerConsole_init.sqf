private ["_mccdialog","_comboBox","_displayname","_pic", "_index","_planeName","_counter","_type","_group","_groupControl",
		 "_insetionArray","_control","_unitsCount","_markerType","_markerColor","_leader","_markerInf","_markerMech","_markerArmor","_markerAir",
		"_markerName","_icon","_wpArray","_haveGPS","_behaviour","_unitsSize","_unitsSizeMarker","_arrayName","_evacVehicles"];
// By: Shay_gman
// Version: 1.1 (May 2012)
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
_evacVehicles = missionNamespace getvariable [format ["MCC_evacVehicles_%1",playerSide],[]];

{
	(_mccdialog displayCtrl _x) ctrlAddEventHandler ["MouseButtonClick",{
		_idc = (ctrlIDC (_this select 0)) +1000;
		_pos = ctrlPosition ((ctrlParent (_this select 0)) displayCtrl _idc);
		_pos set [2,0];


		((ctrlParent (_this select 0)) displayCtrl _idc) ctrlSetPosition _pos;
		((ctrlParent (_this select 0)) displayCtrl _idc) ctrlCommit 0.1;

		_pos = ctrlPosition ((ctrlParent (_this select 0)) displayCtrl (ctrlIDC (_this select 0))+1);
		_pos set [2,0.02 * safezoneW];
		((ctrlParent (_this select 0)) displayCtrl (ctrlIDC (_this select 0))+1) ctrlSetPosition _pos;
		((ctrlParent (_this select 0)) displayCtrl (ctrlIDC (_this select 0))+1) ctrlCommit 0;
		playSound "click";
	}];
} forEach [1010,1020,1030];

{
	(_mccdialog displayCtrl _x) ctrlAddEventHandler ["MouseButtonClick",{
		_idc = (ctrlIDC (_this select 0)) +999;
		_pos = ctrlPosition ((ctrlParent (_this select 0)) displayCtrl _idc);
		_pos set [2,(0.257813 * safezoneW)];

		((ctrlParent (_this select 0)) displayCtrl _idc) ctrlSetPosition _pos;
		((ctrlParent (_this select 0)) displayCtrl _idc) ctrlCommit 0.1;
		_pos = ctrlPosition (_this select 0);
		_pos set [2,0];
		(_this select 0) ctrlSetPosition _pos;
		(_this select 0) ctrlCommit 0;
		playSound "click";
	}];
} forEach [1011,1021,1031];


//--------------------------------------------------Evac-------------------------------------------------------------------------------
if (count _evacVehicles > 0) then {
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
	} foreach _evacVehicles;
	_comboBox lbSetCurSel (missionNameSpace getvariable ["MCC_evacVehicles_index",0]);

	_type = _evacVehicles select (lbCurSel MCC_ConsoleEvacTypeText_IDD);
	ctrlShow [MCC_ConsoleEvacFlyHightComboBox_IDD,false];
	_insetionArray = ["Move (engine on)","Move (engine off)"];

	if (_type iskindof "helicopter") then {									//Case we choose aircrft
		ctrlShow [MCC_ConsoleEvacFlyHightComboBox_IDD,true];
		_insetionArray = ["Free Landing (engine on)","Free Landing (engine off)","Hover","Helocasting(Water)","Smoke Signal","Fast-Rope"];
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
_arrayName	= format ["MCC_CASConsoleArray%1",(player getVariable ["CP_side",  playerside])];

_comboBox = _mccdialog displayCtrl MCC_ConsoleCASAvailableTextBox_IDD;		//fill list box for CAS Types
lbClear _comboBox;
{
	_planeName = getText (configFile >> "CfgVehicles" >> (_x  select 1) select 0>> "displayname");
	_displayname = format ["CAS:%1, Plane:%2",(_x  select 0) select 0,_planeName];
	_index = _comboBox lbAdd _displayname;
} foreach (missionNameSpace getVariable [_arrayName,[]]);
_comboBox lbSetCurSel 0;

//----------------------------------------------Airdrop--------------------------------------------------------------------------------------
_arrayName	= format ["MCC_ConsoleAirdropArray%1",(player getVariable ["CP_side",  playerside])];

_comboBox = _mccdialog displayCtrl MCC_ConsoleAirdropAvailableTextBox_IDD;		//fill list box for Airdrop Types
lbClear _comboBox;
_counter = 0;
{
	_counter = _counter + 1;
	_displayname = format ["%1: ",_counter];
	{
		_displayname = format ["%1 %2, ",_displayname, getText(configFile >> "CfgVehicles" >> _x >> "displayname")];
	} foreach ((_x select 0) select 0);
	_displayname = _displayname + (if (_x select 2) then {"-= Airdrop =-"} else {"-= Slingload =-"});
	_index = _comboBox lbAdd _displayname;
} foreach (missionNameSpace getVariable [_arrayName,[]]);
_comboBox lbSetCurSel 0;

//------------------------------------------Group Control-------------------------------------------------------------------------------------
//---------------------Console Groups management

if (!isnil "HCEast" ||  !isnil "HCWest" || !isnil "HCGuer") exitWith {}; 			//If HC is working aboart process

onGroupIconClick {
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

	[_group,_button,[_posx,_posy],_shift,_ctrl,_alt] execVM format ["%1mcc\fnc\console\fn_consoleClickGroupIcon.sqf",MCC_path];
	//[_group,_button,[_posx,_posy],_shift,_ctrl,_alt] spawn MCC_fnc_consoleClickGroupIcon;
};

//Add - Ctrl + number group selections handlers
if (isnil "MCC_consoleGroupSelectionEH") then {
	MCC_consoleGroupSelectionEH = (findDisplay 46) displayAddEventHandler  ["KeyDown", format ["nul = _this execVM '%1mcc\general_scripts\console\groupNumbersSelectionEH.sqf';",MCC_path]];
};

MCC_fnc_mapDrawWPConsole =
{
	_map = _this select 0;
	{
		_leader = (leader _x);
		_groupControl = if ((isplayer _leader) || (getText (configfile >> "CfgVehicles" >> typeOF vehicle _leader >> "vehicleClass")== "Autonomous")) then {true} else {_x getvariable ["MCC_canbecontrolled",false]};	//Can we control this group
		_haveGPS =  if ((vehicle _leader != _leader) || !isPlayer _leader) then {true} else {("ItemGPS" in (assignedItems _leader) || "B_UavTerminal" in (assignedItems _leader) || "MCC_Console" in (assignedItems _leader))};
		if (isnil "_haveGPS") then {_haveGPS = false};
		if ((side _leader == side player) && alive _leader && _groupControl && ((MCC_ConsoleOnlyShowUnitsWithGPS && _haveGPS) || !MCC_ConsoleOnlyShowUnitsWithGPS)) then
		{
			_wpArray = waypoints (group _leader);
			if (count _wpArray > 0)then
			{
				private ["_wp","_wPos","_wType"];
				MCC_lastPos = nil;
				_texture = gettext (configfile >> "CfgMarkers" >> "waypoint" >> "icon");
				for [{_i= currentWaypoint (group _leader)},{_i < count _wpArray},{_i=_i+1}] do 	//Draw the current WP
				{
					_wp = (_wpArray select _i);
					_wPos  = waypointPosition _wp;
					if ((_wPos  distance [0,0,0]) > 50) then
					{
						_wType = waypointType _wp;


						_map drawIcon [
							_texture,
							[0,0,1,1],
							_wPos,
							24,
							24,
							0,
							_wType,
							0,
							0.04,
							"PuristaBold",
							"center"
						];

						if (isnil "MCC_lastPos") then {MCC_lastPos = [(getpos _leader) select 0,(getpos _leader) select 1]};

						_map drawLine [
							MCC_lastPos,
							_wPos,
							[0,0,1,1]
						];

						MCC_lastPos = _wPos;
					};
				};
			};
		};
	} foreach allgroups;
};

[] call {
	private ["_handler","_markerSupport","_markerAutonomous","_markerNaval","_markerRecon","_haveGPS","_leader","_groupStatus","_wpArray","_behaviour","_groupControl","_haveGPS","_groupName","_groupIconData"];

	setGroupIconsVisible [true,false];
	setGroupIconsSelectable true;

	_handler = (_mccdialog displayCtrl 9120) ctrladdeventhandler ["draw","_this call MCC_fnc_mapDrawWPConsole;"];
	while {MCC_Console1Open && (str (finddisplay mcc_playerConsole_IDD) != "no display")} do 		//Draw WP
	{
		{
			_leader = (leader _x);
			_groupStatus = _x getvariable "MCC_support";
			_wpArray = waypoints (group _leader);
			_behaviour = behaviour _leader;
			_groupControl = if ((isplayer _leader) || (getText (configfile >> "CfgVehicles" >> typeOF vehicle _leader >> "vehicleClass")== "Autonomous")) then {true} else {_x getvariable ["MCC_canbecontrolled",false]};	//Can we control this group
			_haveGPS =  if ((vehicle _leader != _leader) || !isPlayer _leader) then {true} else {("ItemGPS" in (assignedItems _leader) || "B_UavTerminal" in (assignedItems _leader) || "MCC_Console" in (assignedItems _leader))};
			if (isnil "_haveGPS") then {_haveGPS = false};

			_side = side _leader;

			if ((_side == side player) && alive _leader && _groupControl && ((MCC_ConsoleOnlyShowUnitsWithGPS && _haveGPS) || !MCC_ConsoleOnlyShowUnitsWithGPS)) then {

				_groupIconData = [_x] call MCC_fnc_getGroupIconData;
				_markerColor = _groupIconData select 0;
				_groupName = _groupIconData select 1;
				_markerType = _groupIconData select 2;
				_unitsSizeMarker = _groupIconData select 3;

				//Set markers
				_x setGroupIconParams [_markerColor,_groupName ,1,true];

				_icon = (_x getvariable "MCCgroupIconData");
				if (!isnil "_icon") then {_x removeGroupIcon _icon};
				_icon = _x addGroupIcon [_markerType,[0,0]];
				_x setGroupIconParams [_markerColor,format ["%1",_groupName],1,true];
				_x setvariable ["MCCgroupIconData",_icon,false];

				_icon = (_x getvariable "MCCgroupIconSize") select 0;
				if (!isnil "_icon") then {_x removeGroupIcon _icon};
				_icon = _x addGroupIcon [_unitsSizeMarker,[0,0]];
				_x setvariable ["MCCgroupIconSize",[_icon,_unitsSizeMarker],false];

				if (! isnil "_groupStatus") then 					//Draw group status
					{
						private ["_time","_status"];
						_time 		= _groupStatus select 1;
						_status 	= _groupStatus select 0;

						if (abs (time - _time) < 180) then
							{
								_x setGroupIconParams [_markerColor,format ["%1%2",_groupName,_status],1,true];
							}
							else
							{
								_x setGroupIconParams [_markerColor,_groupName,1,true];
							};
					};

				if (_behaviour == "COMBAT") then				//Show in combat
					{
						_x setGroupIconParams [[1,1,1,1],_groupName,1,true];
					};
			};
		} foreach allgroups;
		sleep 0.5;
	};

	//Clear stuff after exiting
	{
		_leader = (leader _x);
		if ((side _leader == side player) && alive _leader) then
			{
				clearGroupIcons _x;
			};
	} foreach allgroups;

	setGroupIconsVisible [false,false];
	setGroupIconsSelectable false;

	//Remove EH
	(_mccdialog displayCtrl 9120) ctrlRemoveEventHandler ["draw",_handler];
};