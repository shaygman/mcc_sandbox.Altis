private ["_disp","_comboBox","_scale","_array"];
disableSerialization;

_disp = _this select 0;

_scale = switch (player getvariable ["MCC_sqlPDAScale",0]) do {
    case 0: {
    	 [
    	 	[0.14,0.526,0.153,0.32],	//bcg
    	 	[0.14,0.526,0.153,0.32]		//map
    	 ];
    };

    case 1: {
    	 [
    	 	[0.156,0.533,0.27,0.341],	//bcg
    	 	[0.156,0.533,0.27,0.341]	//map
     	 ];
    };

    case 2: {
    	 [
    	 	[0.22,0.23,0.465,0.55],		//bcg
    	 	[0.22,0.23,0.465,0.55]		//map
    	 ];
    };
};

{
	_scale = ctrlPosition ((uiNamespace getVariable ["MCC_SQLPDA", displayNull]) displayCtrl _x);
	_ctrl = (_disp displayCtrl _x);
	_ctrl ctrlSetPosition _scale;
	_ctrl ctrlCommit 0;
} forEach [22,9120];

private ["_rscMap","_dialogMap","_dialogMapPos"];
_rscMap 	= _disp displayCtrl 9120;
_dialogMap 	= (uiNamespace getVariable "MCC_SQLPDA") displayCtrl 9120;
_dialogMapPos = ctrlPosition _dialogMap;

_rscMap ctrlMapAnimAdd [0.5, ctrlMapScale _dialogMap, _dialogMap ctrlMapScreenToWorld [(_dialogMapPos select 0) + ((_dialogMapPos select 3)/2), (_dialogMapPos select 1) + ((_dialogMapPos select 2)/2)]];

while {dialog} do {closeDialog 0; sleep 0.1};
[_rscMap] call MCC_fnc_pipOpen;
ctrlMapAnimCommit (_disp displayCtrl 9120);
//------------------------------------------Group Control-------------------------------------------------------------------------------------
//---------------------Console Groups management

MCC_fnc_mapDrawWPPDA =
{
	_map = _this select 0;
	{
		_leader = (leader _x);
		_groupControl = if ((isplayer _leader) || (getText (configfile >> "CfgVehicles" >> typeOF vehicle _leader >> "vehicleClass")== "Autonomous")) then {true} else {_x getvariable ["MCC_canbecontrolled",false]};	//Can we control this group
		_haveGPS =  if (vehicle _leader != _leader) then {true} else {("ItemGPS" in (assignedItems _leader) || "B_UavTerminal" in (assignedItems _leader) || "MCC_Console" in (assignedItems _leader))};
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

_disp call
{
	private ["_handler","_markerSupport","_markerAutonomous","_markerColor","_markerNaval","_markerRecon","_haveGPS","_leader","_groupStatus","_wpArray","_behaviour","_groupControl","_haveGPS","_groupName","_markerType","_markerInf","_markerMech","_markerArmor","_markerAir","_disp"];

	_disp = _this;
	_handler = (_disp displayCtrl 9120) ctrladdeventhandler ["draw","_this call MCC_fnc_mapDrawWPPDA;"];

	setGroupIconsVisible [true,false];


	while {(str (_disp displayCtrl 9120))!= "No control"} do 		//Draw WP
	{
		{
			_leader = (leader _x);
			_groupStatus = _x getvariable "MCC_support";
			_wpArray = waypoints (group _leader);
			_behaviour = behaviour _leader;
			_groupControl = if ((isplayer _leader) || (getText (configfile >> "CfgVehicles" >> typeOF vehicle _leader >> "vehicleClass")== "Autonomous")) then {true} else {_x getvariable ["MCC_canbecontrolled",false]};	//Can we control this group
			_haveGPS =  if (vehicle _leader != _leader) then {true} else {("ItemGPS" in (assignedItems _leader) || "B_UavTerminal" in (assignedItems _leader) || "MCC_Console" in (assignedItems _leader))};
			if (isnil "_haveGPS") then {_haveGPS = false};
			if ((side _leader == side player) && alive _leader && _groupControl && ((MCC_ConsoleOnlyShowUnitsWithGPS && _haveGPS) || !MCC_ConsoleOnlyShowUnitsWithGPS)) then
				{
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

					_groupName = _x getVariable ["name",""];

					_groupName = if (_groupName == "") then	{groupID _x} else {_groupName};

					_x setGroupIconParams [_markerColor,_groupName ,1,true];

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
	(_disp displayCtrl 9120) ctrlRemoveEventHandler ["draw",_handler];
};