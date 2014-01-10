//===================================================================MCC_fnc_groupGenRefresh=========================================================================================
// Refresh the group gen markers
// Example:[] call MCC_fnc_groupGenRefresh
//==============================================================================================================================================================================	
private ["_markerSupport","_markerAutonomous","_markerNaval","_markerRecon","_side","_unitsCount","_markerType","_markerColor","_leader","_markerInf",
		         "_markerMech","_markerArmor","_markerAir","_icon","_wpArray","_behaviour","_unitsSize","_unitsSizeMarker"];
#define groupGen_IDD 2994

//Group info while clicked
if (!isnil "HCEast" ||  !isnil "HCWest" || !isnil "HCGuer") exitWith {}; 			//If HC is working aboart process
onGroupIconClick
{
	if (!dialog || (tolower str (finddisplay groupGen_IDD) == "no display")) exitWith {};

	_is3D = _this select 0;
	_group = _this select 1;
	_wpID = _this select 2;
	_button = _this select 3;
	_posx = _this select 4;
	_posy = _this select 5;
	_shift = _this select 6;
	_ctrl = _this select 7;
	_alt = _this select 8;
	
	[_group,_button,[_posx,_posy],_shift,_ctrl,_alt] execVm format ["%1mcc\general_scripts\groupGen\ClickGroupIcon.sqf",MCC_path];
};

MCC_groupGenRefreshLoop = true; 
MCC_groupGenRefreshTerminate = false; 
switch (MCC_groupGenGroupStatus) do 	
	{
		case east: //East
			{
			_side			= east;
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
			
		case west: //West
			{
			_side			= west;
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
			
		case resistance: //Resistance
			{
			_side			= resistance;
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
		case civilian: //Resistance
			{
			_side			= civilian;
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
		 
		if ((side _leader == _side) && alive _leader && count (units _x)>0 ) then
			{
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
				_icon = _x addGroupIcon [_markerType,[0,0]];
				_x setGroupIconParams [_markerColor,groupID _x,1,true];
				_x setvariable ["MCCgroupIconData",_icon,false];
				_icon = _x addGroupIcon [_unitsSizeMarker,[0,0]];
				_x setvariable ["MCCgroupIconSize",[_icon,_unitsSizeMarker],false];
			}; 
	} foreach allgroups; 
_sideIndecator = MCC_groupGenGroupStatus; 	
while {dialog && (str (finddisplay groupGen_IDD) != "no display") && !MCC_groupGenRefreshTerminate} do 		//Draw WP
	{
		{
			_leader = (leader _x);
			_groupStatus = _x getvariable "MCC_support";
			_wpArray = waypoints (group _leader);
			_behaviour = behaviour _leader;
			if ((side _leader == _side) && alive _leader) then
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
						
					if (count _wpArray > 0)then
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
	if ((side _leader == _side) && alive _leader) then
		{
			clearGroupIcons _x; 
		}; 
} foreach allgroups;
setGroupIconsVisible [false,false];
setGroupIconsSelectable false;

MCC_groupGenRefreshLoop = false; 
