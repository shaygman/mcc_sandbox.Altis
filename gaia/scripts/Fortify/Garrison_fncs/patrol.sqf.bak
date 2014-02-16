sleep 1;

// nul = [group,centre of patrol,radius,resume after contact (true or false)]; none are optional;

private ["_group","_pos","_home","_radius","_patdist","_repeating","_trgname","_trg","_angle"];

_unit = _this select 0;
_group = group _unit;
_group setbehaviour "SAFE";
_group setformation "COLUMN";
_pos = [0,0,0];
_home = if ((typename (_this select 1)) == "Array") then {_this select 1} else {getposATL (_this select 1)};
_radius = _this select 2;
_patdist = if (isnil("_radius")) then {60} else {_radius};
_repeating = if (_this select 3) then {true} else {false};

_WPNo = (count(waypoints _group)) + 1;

_num = 0;
while {sleep 1;((group _unit) getVariable ["Garrisoning",true])} do 
{
	
	while {((count units _group) > 0) && ((behaviour (leader _group)) == "SAFE")} do 
	{
		_currentpos = getpos (leader _group);

		_rdir = random 360;

		_angle = [leader _group,_home] call fnc_get_angle;
		_homedir = if (_angle > 360) then {_angle - 360} else {_angle};

		_ofdir = if ((_rdir - _homedir) < 0) then {(_rdir - _homedir) + 360} else {_rdir - _homedir};
		_dir = if (_ofdir > 180) then {_rdir + ((360 - _ofdir) / 2)} else {_homedir + (_ofdir / 2)};

		_hyp = round ((random (_patdist / 2)) + (_patdist / 2));
		_adj = _hyp * (cos _dir);
		_opp = sqrt ((_hyp * _hyp) - (_adj * _adj));

		if ((_dir > 180) && (_dir < 360)) then {_pos set [0,((_currentpos select 0) - (round _opp))]} else {_pos set [0,((_currentpos select 0) + (round _opp))]};
		_pos set [1,((_currentpos select 1) + (round _adj))];
		_pos set [2,(_currentpos select 2)];

		/*
		_markerName = format ["%1%2",_group,_num];
		createMarker [_markerName,_pos];
		_markerName setMarkerShape "Icon";
		_markerName setMarkerType "mil_dot";
		*/
		/*
		while {(count (waypoints _group)) > 0} do
		{
			deleteWaypoint ((waypoints _group) select 0);
		};
		*/
		//deleteWaypoint [_group,all];

		_wp = _group addWaypoint [_pos,0,0];

		[_group,0] setWaypointType "MOVE";

		[_group,0] setwaypointspeed "LIMITED";

		[_group,0] setWaypointBehaviour "SAFE";

		[_group,0] setwaypointstatements ["true",""];

		_group setCurrentWaypoint [_group,0];
	
		while {sleep 0.2;true} do 
		{
			if ((alive (leader _group)) && ((behaviour (leader _group)) != "SAFE")) exitwith 
			{
				deleteWaypoint [_group,0];
			};

			if ((alive (leader _group)) && (unitready (leader _group))) exitwith {};

			if ((count units _group) <= 0) exitwith {};
		};
		_num = _num + 1;
	};

	if (_repeating) then 
	{
		while {sleep 1;true} do 
		{
			if ((behaviour (leader _group)) == "SAFE") exitwith {_group setbehaviour "SAFE"};
		};
	};

	if (!(_repeating)) exitwith {};	
};