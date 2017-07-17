/*==================================================================MCC_fnc_manageWp==================================================================================
	Create and control AI WP on map
	Example [] call MCC_fnc_manageWp or [[action,WPlocation,[WPType,WPcombat,WPformation,WPspeed,WPbehavior,WPcondition, WPstatment,WPtimeout],[selectedGroup1,selectedGroup2......] ]],"MCC_fnc_manageWp", group, false] spawn BIS_fnc_MP;

	0	action: Integer, 0 - ADD WP,  1 - Replace WP, 2-Delete all WP
	1	WPlocation: Array location
			2.1		WPType: Integer, a indecator from this array ["MOVE", "DESTROY", "GETIN", "SAD", "JOIN", "LEADER", "GETOUT", "CYCLE", "LOAD", "UNLOAD", "TR UNLOAD", "HOLD","SENTRY","GUARD","SUPPORT","GETIN NEAREST","DISMISS"];
			2.2		WPcombat: string, ["NO CHANGE", "BLUE", "GREEN", "WHITE", "YELLOW", "RED"]
			2.3		WPformation: string, ["NO CHANGE", "COLUMN", "STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "LINE", "FILE", "DIAMOND"]
			2.4		WPspeed: string, ["UNCHANGED", "LIMITED", "NORMAL", "FULL"]
			2.5		WPbehavior: string, ["UNCHANGED", "CARELESS", "SAFE", "AWARE", "COMBAT", "STEALTH"]
			2.6		WPcondition: string, condition for WP to be complete
			2.7		WPstatment: string, code will run after the WP is complete
			2.8		WPtimeout: number, waiting time  between condition is made till the WP is set to complete
	3 	SelectedGroups: Array containing all the groups to be effected
//==========================================================================================================================================================*/
private ["_wpArray","_wp","_wpType","_objects","_wpObject","_wp2","_groups","_wpLoc","_WPTypeIndecator","_wpTypes","_isShown"];

_action 			= _this select 0;
_wpLoc	 			= _this select 1;
_wpArray			= _this select 2;
_groups				= _this select 3;
_isShown			= [_this,4,false,[false]] call bis_fnc_param;

if (count _wpArray > 0) then
{
_WPTypeIndecator 	= _wpArray select 0;

	_wpTypes = ["MOVE", "DESTROY", "GETIN", "SAD", "JOIN", "LEADER", "GETOUT", "CYCLE", "LOAD", "UNLOAD", "TR UNLOAD", "HOLD", "SENTRY","GUARD","SUPPORT","GETIN NEAREST","DISMISS","Helicopter - Land","Helicopter - Get in","Artillery - Fire Mission","Loiter"];
	_wpType  = _wpTypes select _WPTypeIndecator;
};


{
	if (_action != 0) then {while {(count (waypoints _x)) > 0} do {deleteWaypoint ((waypoints _x) select 0)}};	//Delete WP
	if (_action <2) then																						//Add or replace WP
		{
			switch _wpType do
			{
				case "GETIN":
					{
						//Find nearest transport
						_objects 	= nearestObjects [[_wpLoc select 0,_wpLoc select 1,0],["Car","Tank","AIR"], 100];
						{
							if ((_x emptyPositions "cargo")>1) exitWith {_wpObject = _x};
						} foreach _objects;

						if (isnil "_wpObject") exitWith 				//Exit - no vehicle found
							{
								_wp = _x addWaypoint [_wpLoc, 0];
								_wp setWaypointType _wpType;
								_wp setWaypointCombatMode (_wpArray select 1);
								_wp setWaypointFormation (_wpArray select 2);
								_wp setWaypointSpeed (_wpArray select 3);
								_wp setWaypointBehaviour (_wpArray select 4);
								_wp setWaypointStatements [(_wpArray select 5),(_wpArray select 6)];
								_wp setWaypointTimeout [_wpArray select 7,_wpArray select 7,_wpArray select 7];
							};
						//If transport isn't empty
						if ({alive _x} count crew _wpObject != 0) then
							{
								while {(count (waypoints (group _wpObject))) > 0} do {deleteWaypoint ((waypoints (group _wpObject)) select 0)};

								{_x assignAsCargo _wpObject;} foreach (units _x);
								if (isNull driver _wpObject) then {(leader _x) assignAsDriver _wpObject};
								if ((isNull gunner _wpObject) && ((count units _x) > 1)) then {(units _x select 1) assignAsGunner _wpObject};
								if ((isNull commander _wpObject) && ((count units _x) > 2)) then {(units _x) select 2 assignAsCommander _wpObject};
								(units _x) orderGetIn true;

								_wp = _x addWaypoint [_wpLoc, 0];
								_wp setWaypointType _wpType;
								_wp setWaypointCombatMode (_wpArray select 1);
								_wp setWaypointFormation (_wpArray select 2);
								_wp setWaypointSpeed (_wpArray select 3);
								_wp setWaypointBehaviour (_wpArray select 4);
								_wp setWaypointStatements [(_wpArray select 5),(_wpArray select 6)];
								_wp setWaypointTimeout [_wpArray select 7,_wpArray select 7,_wpArray select 7];
								_wp2 = (group _wpObject) addWaypoint [_wpLoc, 0];
								_wp2 setWaypointType "LOAD";
								_wp synchronizeWaypoint [_wp2];
							}
							else
							{
								_wp = _x addWaypoint [_wpObject, 0];	//If transport empty
								_wp setWaypointType _wpType;
								_wp setWaypointCombatMode (_wpArray select 1);
								_wp setWaypointFormation (_wpArray select 2);
								_wp setWaypointSpeed (_wpArray select 3);
								_wp setWaypointBehaviour (_wpArray select 4);
								_wp setWaypointStatements [(_wpArray select 5),(_wpArray select 6)];
								_wp setWaypointTimeout [_wpArray select 7,_wpArray select 7,_wpArray select 7];
							};
					};

				case "JOIN":
					{
						_group = _x;
						//Find nearest group
						{
							if (((leader _x distance _wpLoc) < 50) &&(_x != _group) && (side _x == side _group) && !isPlayer leader _x)exitWith {_wpObject = _x};
						} foreach allGroups;

						if (isnil "_wpObject") exitWith 				//Exit - no group found
							{
								_wp = _x addWaypoint [_wpLoc, 0];
								_wp setWaypointType _wpType;
								_wp setWaypointCombatMode (_wpArray select 1);
								_wp setWaypointFormation (_wpArray select 2);
								_wp setWaypointSpeed (_wpArray select 3);
								_wp setWaypointBehaviour (_wpArray select 4);
								_wp setWaypointStatements [(_wpArray select 5),(_wpArray select 6)];
								_wp setWaypointTimeout [_wpArray select 7,_wpArray select 7,_wpArray select 7];
							};

						//If group found
						while {(count (waypoints _wpObject)) > 0} do {deleteWaypoint ((waypoints _wpObject) select 0)};
						_wp = _x addWaypoint [_wpLoc, 0];
						_wp setWaypointType _wpType;
						_wp setWaypointCombatMode (_wpArray select 1);
						_wp setWaypointFormation (_wpArray select 2);
						_wp setWaypointSpeed (_wpArray select 3);
						_wp setWaypointBehaviour (_wpArray select 4);
						_wp setWaypointStatements [(_wpArray select 5),(_wpArray select 6)];
						_wp setWaypointTimeout [_wpArray select 7,_wpArray select 7,_wpArray select 7];
						_wp2 = _wpObject addWaypoint [_wpLoc, 0];
						_wp2 setWaypointType "LEADER";
						_wp synchronizeWaypoint [_wp2];
					};

				case "LEADER":
					{
						_group = _x;
						//Find nearest group
						{
							if (((leader _x distance _wpLoc) < 50) &&(_x != _group) && (side _x == side _group))exitWith {_wpObject = _x};
						} foreach allGroups;

						if (isnil "_wpObject") exitWith 			//Exit - no group found
							{
								_wp = _x addWaypoint [_wpLoc, 0];
								_wp setWaypointType _wpType;
								_wp setWaypointFormation (_wpArray select 2);
								_wp setWaypointSpeed (_wpArray select 3);
								_wp setWaypointBehaviour (_wpArray select 4);
								_wp setWaypointStatements [(_wpArray select 5),(_wpArray select 6)];
								_wp setWaypointTimeout [_wpArray select 7,_wpArray select 7,_wpArray select 7];

							};

						//If group found
						while {(count (waypoints _wpObject)) > 0} do {deleteWaypoint ((waypoints _wpObject) select 0)};
						_wp = _x addWaypoint [_wpLoc, 0];
						_wp setWaypointType _wpType;
						_wp setWaypointFormation (_wpArray select 2);
						_wp setWaypointSpeed (_wpArray select 3);
						_wp setWaypointBehaviour (_wpArray select 4);
						_wp setWaypointStatements [(_wpArray select 5),(_wpArray select 6)];
						_wp setWaypointTimeout [_wpArray select 7,_wpArray select 7,_wpArray select 7];
						_wp2 = _wpObject addWaypoint [_wpLoc, 0];
						_wp2 setWaypointType "JOIN";
						_wp synchronizeWaypoint [_wp2];
					};

				case "LOAD":
					{
						_group = _x;
						//Find nearest group
						{
							if (((leader _x distance _wpLoc) < 50) &&(_x != _group) && (side _x == side _group))exitWith {_wpObject = _x};
						} foreach allGroups;

						if (isnil "_wpObject") exitWith 			//Exit - no group found
						{
							_wp = _x addWaypoint [_wpLoc, 0];
							_wp setWaypointType _wpType;
							_wp setWaypointFormation (_wpArray select 2);
							_wp setWaypointSpeed (_wpArray select 3);
							_wp setWaypointBehaviour (_wpArray select 4);
							_wp setWaypointStatements [(_wpArray select 5),(_wpArray select 6)];
							_wp setWaypointTimeout [_wpArray select 7,_wpArray select 7,_wpArray select 7];

						};

						//If group found
						while {(count (waypoints _wpObject)) > 0} do {deleteWaypoint ((waypoints _wpObject) select 0)};
						_wp = _group addWaypoint [_wpLoc, 0];
						_wp setWaypointType _wpType;
						_wp setWaypointFormation (_wpArray select 2);
						_wp setWaypointSpeed (_wpArray select 3);
						_wp setWaypointBehaviour (_wpArray select 4);
						_wp setWaypointStatements [(_wpArray select 5),(_wpArray select 6)];
						_wp setWaypointTimeout [_wpArray select 7,_wpArray select 7,_wpArray select 7];
						_wp2 = _wpObject addWaypoint [_wpLoc, 0];
						_wp2 setWaypointType "GETIN";
						_wp synchronizeWaypoint [_wp2];
					};

				case "Helicopter - Land":
					{
						_wp = _x addWaypoint [_wpLoc, 0];
						_wp setWaypointType "MOVE";
						_wp setWaypointFormation (_wpArray select 2);
						_wp setWaypointSpeed (_wpArray select 3);
						_wp setWaypointBehaviour (_wpArray select 4);
						_wp setWaypointStatements ["true",'vehicle this land "LAND"'];
						_wp setWaypointTimeout [_wpArray select 7,_wpArray select 7,_wpArray select 7];
					};

				case "Helicopter - Get in":
					{
						_wp = _x addWaypoint [_wpLoc, 0];
						_wp setWaypointType "MOVE";
						_wp setWaypointFormation (_wpArray select 2);
						_wp setWaypointSpeed (_wpArray select 3);
						_wp setWaypointBehaviour (_wpArray select 4);
						_wp setWaypointStatements ["true",'vehicle this land "GET IN"'];
						_wp setWaypointTimeout [_wpArray select 7,_wpArray select 7,_wpArray select 7];
					};

				case "Artillery - Fire Mission":
					{
						private "_isArty";
						_isArty= getNumber (configfile >> "CfgVehicles" >> typeof (vehicle leader _x) >> "artilleryScanner");
						 if ((vehicle (leader _x) != leader _x) && (_isArty ==1)) then
						 {
							_x setVariable ["GAIA_MortarRound",6];
							[_x, _wpLoc] call GAIA_fnc_doMortar;
						 };
					};

				case "Loiter":
					{
						_wp = _x addWaypoint [_wpLoc, 0];
						_wp setWaypointType "LOITER";
						_wp setWaypointLoiterType "CIRCLE_L";
						_wp setWaypointSpeed "LIMITED";
						_wp setWaypointLoiterRadius 1000;
					};

				default
					{
						_wp = _x addWaypoint [_wpLoc, 0];
						_wp setWaypointType _wpType;
						_wp setWaypointFormation (_wpArray select 2);
						_wp setWaypointSpeed (_wpArray select 3);
						_wp setWaypointBehaviour (_wpArray select 4);
						_wp setWaypointStatements [(_wpArray select 5),(_wpArray select 6)];
						_wp setWaypointTimeout [_wpArray select 7,_wpArray select 7,_wpArray select 7];
						if (_isShown) then {_wp showWaypoint "ALWAYS"};
						if (_action != 0) then {{_x doMove _wpLoc} forEach units _x};
					};
			};
		};
} foreach _groups;

