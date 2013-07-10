//Made by Shay_Gman (c) 09.10

private ["_pos","_wpArray","_group","_wp"];

_action 	= _this select 0; 
_pos 		= _this select 1; 
_wpArray 	= _this select 2;
_group 		= _this select 3;

switch (_action) do { 			//Add WP
	case 0:  
		{
			/*mcc_safe = mcc_safe + FORMAT ['
						_wp = (groupFromNetId "%1") addWaypoint [%2, 0];
						_wp setWaypointType "%3";
						_wp setWaypointCombatMode "%4";
						_wp setWaypointFormation "%5";
						_wp setWaypointSpeed "%6";
						_wp setWaypointBehaviour "%7";
						_wp setWaypointStatements ["%8","%9"];
						_wp setWaypointTimeout [%10,%10,%10];
						'
						,netID _group
						,_pos
						,(_wpArray select 0)
						,(_wpArray select 1)
						,(_wpArray select 2)
						,(_wpArray select 3)
						,(_wpArray select 4)
						,(_wpArray select 5)
						,(_wpArray select 6)
						,(_wpArray select 7)
						];*/
			_wp = _group addWaypoint [_pos, 0];
			_wp setWaypointType (_wpArray select 0);
			_wp setWaypointCombatMode (_wpArray select 1);
			_wp setWaypointFormation (_wpArray select 2);
			_wp setWaypointSpeed (_wpArray select 3);
			_wp setWaypointBehaviour (_wpArray select 4);
			_wp setWaypointStatements [(_wpArray select 5),(_wpArray select 6)];
			_wp setWaypointTimeout [_wpArray select 7,_wpArray select 7,_wpArray select 7];
		}; 
		
	case 1: 					//delete all WP
		{
			while {(count (waypoints _group)) > 0} do { deleteWaypoint ((waypoints _group) select 0)};
		};
	};