//==================================================================MCC_fnc_manageWp===============================================================================================
// Create and control AI WP on map
// Example [] call MCC_fnc_manageWp or [[action,WPlocation,[WPType,WPcombat,WPformation,WPspeed,WPbehavior,WPcondition, WPstatment,WPtimeout],[selectedGroup1,selectedGroup2......] ]],"MCC_fnc_manageWp", group, false] spawn BIS_fnc_MP;
// actrion: Integer, 0 - ADD WP,  1 - Replace WP, 2-Delete all WP
//		WPType: Integer, a indecator from this array ["MOVE", "DESTROY", "GETIN", "SAD", "JOIN", "LEADER", "GETOUT", "CYCLE", "LOAD", "UNLOAD", "TR UNLOAD", "HOLD", "SENTRY","GUARD","SUPPORT","GETIN NEAREST","DISMISS"];
//		WPcombat: string, ["NO CHANGE", "BLUE", "GREEN", "WHITE", "YELLOW", "RED"]
//		WPformation: string, ["NO CHANGE", "COLUMN", "STAG COLUMN", "WEDGE", "ECH LEFT", "ECH RIGHT", "VEE", "LINE", "FILE", "DIAMOND"]
//		WPspeed: string, ["UNCHANGED", "LIMITED", "NORMAL", "FULL"]
//		WPbehavior: string, ["UNCHANGED", "CARELESS", "SAFE", "AWARE", "COMBAT", "STEALTH"]
//		WPcondition: string, condition for WP to be complete
//		WPstatment: string, code will run after the WP is complete
//		WPtimeout: number, waiting time  between condition is made till the WP is set to complete
//WPlocation: Array location
//==============================================================================================================================================================================	
private ["_wpArray","_wp","_wpType","_objects","_wpObject","_wp2","_groups","_wpLoc","_WPTypeIndecator","_wpTypes"];

_action 			= _this select 0; 
_wpLoc	 			= _this select 1; 
_wpArray			= _this select 2; 
if (count _wpArray > 0) then
	{
	_WPTypeIndecator 	= _wpArray select 0; 
	
	_wpTypes = ["MOVE", "DESTROY", "GETIN", "SAD", "JOIN", "LEADER", "GETOUT", "CYCLE", "LOAD", "UNLOAD", "TR UNLOAD", "HOLD", "SENTRY","GUARD","SUPPORT","GETIN NEAREST","DISMISS","Helicopter - Land","Helicopter - Get in","Artillery - Fire Mission"];
	_wpType  = _wpTypes select _WPTypeIndecator; 
	};
_groups				= _this select 3; 

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
							if ((_x emptyPositions "cargo")>3) exitWith {_wpObject = _x};
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
							[_x, _wpLoc] call fnc_DoMortar
						 };
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
					};
			};
		};
} foreach _groups;
	
