//===================================================================MCC_fnc_groupGenRefresh=========================================================================================
// Refresh the group gen markers
// Example:[] call MCC_fnc_groupGenRefresh
//==============================================================================================================================================================================
private ["_markerSupport","_markerAutonomous","_markerNaval","_markerRecon","_side","_unitsCount","_markerType","_markerColor","_leader","_markerInf","_handler",
		         "_markerMech","_markerArmor","_markerAir","_icon","_wpArray","_behaviour","_unitsSize","_unitsSizeMarker","_IsGaiaControlled","_players"];
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

setGroupIconsVisible [true,false];
setGroupIconsSelectable true;

MCC_fnc_mapDrawWP =
{
	_map = _this select 0;

	//Draw WP
	{
		if !(isNil "_x") then {
			_map drawIcon _x;
		};
	} foreach (missionNamespace getVariable ["MCC_GGIcons",[]]);

	{
		if !(isNil "_x") then {
			_map drawLine _x;
		};
	} foreach (missionNamespace getVariable ["MCC_GGLines",[]]);

	//Show towns name up to1.5Km
	if (!isnil "MCC_3D_CAM") then
	{
		{
			_pos = locationposition _x;
			_pos set [2,0];
			drawIcon3D [
							"#(argb,8,8,3)color(0,0,0,0)",
							[1,1,1,1],
							_pos,
							0,
							0,
							0,
							text _x,
							2,
							0.05
						];
		} foreach (nearestlocations [getpos MCC_3D_CAM,["nameVillage","nameCity","nameCityCapital"],1500]);

		{
			if ((markerType _x != "") && ((markerPos _x distance MCC_3D_CAM) < 1000)) then
			{
				private "_color";

				_texture = gettext (configfile >> "CfgMarkers" >> markerType _x >> "icon");
				_pos = getMarkerpos _x;
				_pos set [2,10];
				private ["_size"];
				_size =if ((1.5 - ((MCC_3D_CAM distance _pos)*0.001)) < 0) then {0} else {(1.5 - ((MCC_3D_CAM distance _pos)*0.001))};
				_color = switch (tolower (markerColor _x)) do
							{
								case "default": {[1,1,1,1]};
								case "colorblack": {[0,0,0,1]};
								case "colorgrey": {[0.2,0.2,0.2,1]};
								case "colorred": {[1,0,0,1]};
								case "colorredalpha": {[1,0,0,1]};
								case "colorgreen": {[0,1,0,1]};
								case "colorgreenalpha": {[0,1,0,1]};
								case "colorblue": {[0,0,1,1]};
								case "coloryellow": {[0.255,0.255,0,1]};
								case "colororange": {[0.255,0.165,0,1]};
								case "colorwhite": {[1,1,1,1]};
								case "colorpink": {[0.255,0.192,0.203,1]};
								case "colorbrown": {[0.165,0.42,0.42,1]};
								case "colorkhaki": {[0.240,0.230,0.140,1]};
								case "colorwest": {[0,0,1,1]};
								case "coloreast": {[1,0,0,1]};
								case "colorguer": {[0,1,0,1]};
								case "colorciv": {[1,1,1,1]};
								case "colorunknown": {[1,1,1,1]};
								case "color1_fd_f": {[0.8,0,0,1]};
								case "color2_fd_f": {[0.240,0.230,0.140,1]};
								case "color3_fd_f": {[0.255,0.165,0,1]};
								case "color4_fd_f": {[0,0,0.8,1]};
								default {[1,1,1,1]};
							};
				drawIcon3D [
								_texture,
								_color,
								_pos,
								_size,
								_size,
								markerDir _x,
								MarkerText _x,
								0,
								(_size*0.03),
								"PuristaBold",
								"center"
							];
			};
		} foreach allMapMarkers;
	};
};

_handler = ((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 9000) ctrladdeventhandler ["draw","_this call MCC_fnc_mapDrawWP;"];

while {dialog && (str (finddisplay groupGen_IDD) != "no display") && !MCC_groupGenRefreshTerminate} do 		//Draw WP
{
	private ["_tempArray1","_tempArray2"];
	_tempArray1 = [];
	_tempArray2 = [];

	{
		_leader = (leader _x);
		_groupStatus = _x getvariable "MCC_support";
		_wpArray = waypoints (group _leader);
		_behaviour = behaviour _leader;
		_players = if ("players" in MCC_groupGenGroupStatus && (count MCC_groupGenGroupStatus == 1)) then {alive _leader && isPlayer _leader} else {alive _leader};

		//Draw loop
		if (((side _leader in MCC_groupGenGroupStatus) || ("players" in MCC_groupGenGroupStatus && (count MCC_groupGenGroupStatus == 1))) && _players && !(_leader iskindof "Logic")) then
		{
			//Draw WP
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
						_tempArray1 set [count _tempArray1, [_texture,[0,0,1,1],_wPos,24,24,0,_wType,0,0.04,"PuristaBold","center"]];

						if (isnil "MCC_lastPos" || _i== currentWaypoint (group _leader) ) then {MCC_lastPos = getpos _leader};

						_tempArray2 set [count _tempArray2, [[MCC_lastPos select 0, MCC_lastPos select 1],_wPos,[0,0,1,1]]];

						/*								//We don't need it on the 3D editor too much UI lag
						if (!isnil "MCC_3D_CAM") then
						{
							if ((MCC_3D_CAM distance vehicle _leader) < 1000) then
							{
								private ["_size"];
								_size =if ((1.5 - ((MCC_3D_CAM distance vehicle _leader)*0.001)) < 0) then {0} else {(1.5 - ((MCC_3D_CAM distance vehicle _leader)*0.001))};

								if (_size>0) then
								{
									drawIcon3D [
											_texture,
											[0,1,1,0.6],
											[_wPos select 0,_wPos select 1,2],
											_size,
											_size,
											0,
											_wType,
											0,
											(_size*0.03),
											"PuristaBold",
											"center"
										];


										drawLine3D [
											[MCC_lastPos select 0, MCC_lastPos select 1, (MCC_lastPos select 2)+2],
											[_wPos select 0, _wPos select 1, (_wPos select 2)+2],
											[0,1,1,0.8]
										];
								};
							};
						};
						*/
						MCC_lastPos = _wPos;
					};
				};
			};

			//Draw group markers
			switch (side _leader) do
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

			if (isPlayer _leader) then {_markerColor = [0,0.5,1,1]};
			_IsGaiaControlled = if ((count(_x getVariable  ["GAIA_zone_intend",[]])>1)) then {"(G) "} else
				{
					if (_x getVariable  ["MCC_canbecontrolled",false]) then {"(P) "} else {""};
				};

			if (_x getVariable ["mcc_gaia_cache",false]) then {_IsGaiaControlled = _IsGaiaControlled + "(C) ";};
			if ((_x getVariable ["MCC_GAIA_RESPAWN",0]) > 0) then {_IsGaiaControlled = _IsGaiaControlled + "(R-" + (str (_x getVariable ["MCC_GAIA_RESPAWN",0])) + ") ";};

			_x setGroupIconParams [_markerColor,format ["%1%2",_IsGaiaControlled,(groupID _x)],1,true];
			_unitsCount = [group _leader] call MCC_fnc_countGroupHC;
			_unitsSize = 0;
			_markerType = _markerInf;
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

			_icon = (_x getvariable "MCCgroupIconData");
			if (!isnil "_icon") then {_x removeGroupIcon _icon};

			if !(_leader in (assignedCargo vehicle _leader)) then
			{
				_icon = _x addGroupIcon [_markerType,[0,0]];
				_x setGroupIconParams [_markerColor,format ["%1%2",_IsGaiaControlled,(groupID _x)],1,true];
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

							_x setGroupIconParams [_markerColor,format ["%1%2%3",_IsGaiaControlled,groupID _x,_status],1,true];
						}
						else
						{
							_x setGroupIconParams [_markerColor,format ["%1%2",_IsGaiaControlled,groupID _x],1,true];
						};
				};

				if (_behaviour == "COMBAT") then				//Show in combat
				{
					_x setGroupIconParams [[1,1,1,1],format ["%1%2",_IsGaiaControlled,groupID _x],1,true];
				};
			};
		};
	} foreach allgroups;

	//Draw IEDs
	{
		if (_x getVariable ["armed",false]) then
		{
			_texture =	if (_x getVariable ["isAmbush",false]) then
						{
							 gettext (configfile >> "CfgMarkers" >> "mil_ambush" >> "icon");
						}
						else
						{
							gettext (configfile >> "CfgMarkers" >> "selector_selectedMission" >> "icon");
						};

			_tempArray1 set [count _tempArray1, [_texture, [1,0,0,1], getpos _x, 24, 24, (_x getvariable ["dir",0])-90, _x getvariable ["iedMarkerName", ""],0,0.04,"PuristaBold","right"]];

			//Draw synced IED lines
			_syncedObject = _x getVariable ["syncedObject",[0,0,0]];
			if (str _syncedObject != "[0,0,0]") then
			{
				_tempArray2 set [count _tempArray2, [getpos _x,	_syncedObject,[1,0,0,1]]];
			};
		};
	} foreach (allMissionObjects MCC_dummy);

	MCC_GGIcons = _tempArray1;
	MCC_GGLines = _tempArray2;

	//Refresh UM list
	[] call MCC_fnc_groupGenUMRefresh;

	sleep 1.5;
};

//Clear stuff after exiting
{
	_leader = (leader _x);
	if ((side _leader in MCC_groupGenGroupStatus) && alive _leader) then
	{
		clearGroupIcons _x;
	};
} foreach allgroups;

setGroupIconsVisible [false,false];
setGroupIconsSelectable false;

//Artillery
missionNameSpace setVariable ["MCC_artilleryEnabled",false];
deleteMarkerLocal "mcc_arty";

//Spawn
missionNameSpace setVariable ["MCC_spawnEnabled",false];
deleteMarkerLocal "mcc_spawnMarker";

//Remove EH
((uiNamespace getVariable "MCC_groupGen_Dialog") displayCtrl 9000) ctrlRemoveEventHandler ["draw",_handler];

MCC_groupGenRefreshLoop = false;
