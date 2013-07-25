//Made by Shay_Gman (c) 09.10
#define groupGen_IDD 2994

#define MCC_GroupGenCurrentGroup_IDD 9003
#define MCC_GroupGenWPType_IDD 9004
#define MCC_GroupGenWPConbatMode_IDD 9005
#define MCC_GroupGenWPFormation_IDD 9006
#define MCC_MINIMAP 9000

#define MCC_GroupGenWPSpeed_IDD 9007
#define MCC_GroupGenWPBehavior_IDD 9008
#define MCC_GroupGenWPStatement_IDD 9009
#define MCC_GroupGenGroups_IDD 9010

private ["_action", "_type", "_comboBox", "_mccdialog", "_groupArray","_displayname","_index","_leader","_markerColor","_tempVehicles","_wp",
	     "_wPos","_lastPos","_wpArray","_unitsCount","_maxUnit","_markerType","_control"];
disableSerialization;

_action 				= _this select 0;	//What are we doing

_mccdialog = findDisplay groupGen_IDD;	

if (_action == 0) then {								//Mark the group
		if (count MCC_groupGenGroupArray > 0) then {
			{deletemarkerlocal _x} foreach MCC_groupGenTempWP;
			{deletemarkerlocal _x} foreach MCC_groupGenTempWPLines;
			
			MCC_groupGenTempWP = [];
			MCC_groupGenTempWPLines = [];
			
			_tempVehicles = [];
			_leader = leader (MCC_groupGenGroupArray select (lbCurSel MCC_GroupGenGroups_IDD));
			switch (format ["%1", side  _leader]) do 	{
				case "EAST": //East
					{
					_markerColor = "ColorRed";
					}; 
					
				case "WEST": //West
					{
					_markerColor = "ColorBlue";
					};
					
				case "GUER": //Resistance
					{
					_markerColor = "ColorGreen";
					};
				case "CIV": //Resistance
					{
					_markerColor = "ColorYellow";
					};
				};
				
			deletemarkerlocal "currentUnitSelected";
			
			_unitsCount = [group _leader] call MCC_COUNT_GROUP;			//Let's count the units' type
			_maxUnit	= [_unitsCount,1] call BIS_fnc_findExtreme;		//Let's find out what majority of units type we have 
			
			_markerType = "b_inf";											//What kind of marker should we put
			if (_unitsCount select 0 > 0) then {_markerType = "b_inf";};
			if (_unitsCount select 1 > 0) then {_markerType = "b_mech_inf";};
			if (_unitsCount select 2 > 0) then {_markerType = "b_armor";};
			if (_unitsCount select 3 > 0) then {_markerType = "b_air";};
			
			createMarkerLocal ["currentUnitSelected", getpos _leader];	//Create group's marker
			"currentUnitSelected" setMarkerTypeLocal _markerType;
			"currentUnitSelected" setMarkerColorLocal _markerColor;

			_wpArray = waypoints (group _leader);
			if (count _wpArray > 0) then {
				for [{_x=0},{_x < count _wpArray},{_x=_x+1}] do {			//Draw the current WP
					_wp = (_wpArray select _x);
					_wPos  = waypointPosition _wp;
					_wType = waypointType _wp;
					createMarkerLocal [format["%1", _wp],_wPos];
					format["%1", _wp] setMarkerTypelocal "waypoint";
					format["%1", _wp] setMarkerColorlocal "ColorBlue";
					format["%1", _wp] setMarkerTextLocal (format ["%1 - %2",_wType,group _leader]);
					MCC_groupGenTempWP set [count MCC_groupGenTempWP, format["%1", _wp]];
					if (isnil "MCC_lastPos") then {MCC_lastPos = _wPos}; 
					[MCC_lastPos , _wPos ,format ["%1", _x]] call MCC_fnc_drawLine;	//draw the line
					MCC_groupGenTempWPLines set [count MCC_groupGenTempWPLines, format["line_%1", _x]];
					MCC_lastPos = _wPos; 
				};
			};
		if (MCC_groupGenGroupselectedIndex != (lbCurSel MCC_GroupGenGroups_IDD)) then {
			_control = _mccdialog displayCtrl MCC_MINIMAP;					//Set Map focus
			_control ctrlMapAnimAdd [1, 0.25, getmarkerpos "currentUnitSelected"];
			ctrlMapAnimCommit _control;
		}; 
		MCC_groupGenGroupselectedIndex = (lbCurSel MCC_GroupGenGroups_IDD);
		};
	};
	
if (_action == 1) then {	//Change group
	MCC_groupGenGroupStatus = _this select 1; 					//Which faction
	MCC_groupGenGroupArray = [];
	_comboBox = _mccdialog displayCtrl MCC_GroupGenGroups_IDD;
	lbClear _comboBox;

	if (MCC_groupGenGroupStatus == 0) then 	//West
		{	
			{
			if ((side (leader _x) == west) && !(isPlayer leader _x)) then	
				{
					_unitsCount = [_x] call MCC_COUNT_GROUP;
					_displayname =  format ["%1 Inf:%2 Cars:%3 Tanks:%4 Air:%5 Ships:%6", _x, _unitsCount select 0, _unitsCount select 1, _unitsCount select 2, _unitsCount select 3, _unitsCount select 4];
					_comboBox lbAdd _displayname;
					MCC_groupGenGroupArray = MCC_groupGenGroupArray + [_x];
				};
			} forEach  allgroups;
		};
		
	if (MCC_groupGenGroupStatus == 1) then 	//East
		{	
			{
			if ((side (leader _x) == east) && !(isPlayer leader _x)) then	
				{
					_unitsCount = [_x] call MCC_COUNT_GROUP;
					_displayname =  format ["%1 Inf:%2 Cars:%3 Tanks:%4 Air:%5 Ships:%6", _x, _unitsCount select 0, _unitsCount select 1, _unitsCount select 2, _unitsCount select 3, _unitsCount select 4];
					_comboBox lbAdd _displayname;
					MCC_groupGenGroupArray = MCC_groupGenGroupArray + [_x];
				};
			} forEach  allgroups;
		};
		
	if (MCC_groupGenGroupStatus == 2) then 	//Guer 
		{	
			{
			if ((side (leader _x) == resistance) && !(isPlayer leader _x)) then	
				{
					_unitsCount = [_x] call MCC_COUNT_GROUP;
					_displayname =  format ["%1 Inf:%2 Cars:%3 Tanks:%4 Air:%5 Ships:%6", _x, _unitsCount select 0, _unitsCount select 1, _unitsCount select 2, _unitsCount select 3, _unitsCount select 4];
					_comboBox lbAdd _displayname;
					MCC_groupGenGroupArray = MCC_groupGenGroupArray + [_x];
				};
			} forEach  allgroups;
		};
		
	if (MCC_groupGenGroupStatus == 3) then 	//Civ 
		{	
			{
			if ((side (leader _x) == civilian) && !(isPlayer leader _x)) then	
				{
					_unitsCount = [_x] call MCC_COUNT_GROUP;
					_displayname =  format ["%1 Inf:%2 Cars:%3 Tanks:%4 Air:%5 Ships:%6", _x, _unitsCount select 0, _unitsCount select 1, _unitsCount select 2, _unitsCount select 3, _unitsCount select 4];
					_comboBox lbAdd _displayname;
					MCC_groupGenGroupArray = MCC_groupGenGroupArray + [_x];
				};
			} forEach  allgroups;
		};
	_comboBox lbSetCurSel MCC_groupGenGroupselectedIndex;
	};
	
					