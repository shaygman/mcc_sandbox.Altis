private ["_uav","_logicMARTA","_radius","_wpcount","_step","_add","_cw","_dir","_lastWP","_spawn","_waypoints","_lastWPpos","_pos","_wp","_currentWP"];
// By: Shay_gman
// Version: 1.1 (May 2012)

_uav = _this select 0;

//--- UAV ID
if (isnil "MCC_uavlastID") then {MCC_uav_lastID = -1};
MCC_uav_lastID = MCC_uav_lastID + 1;
MCC_uav = _uav;
_uav setvehiclevarname "MCC_uav";
publicvariable "MCC_uav";
//call compile format ["MCC_uav_%1 = _uav; _uav setvehiclevarname 'MCC_uav_%1';publicvariable 'MCC_uav_%1'",MCC_uav_lastID];
_uav setVariable ["ID",MCC_uav_lastID, true];

/*
//--- First call
if (MCC_uav_lastID == 0) then {

	//--- Execute MARTA
	if (isnil "bis_marta_mainscope") then {
		_logicMARTA = (group _uav) createunit ["MartaManager",position _uav,[],0,"none"];
	};
};
*/
sleep 0.01;
//--- UAV waypoints --------------------------------------------------------------------------------------

if ((count units _uav) > 1) then
{//UAV should not have leader
  [driver _uav] join grpnull;
};

_radius = 1000;
_wpcount = 4;
_step = 360 / _wpcount;
_add = 0;
_cw = true;
_dir = 0;
deletewaypoint _lastWP;

_spawn = [] spawn {}; //--- Empty spawn
while {alive _uav} do {
	waituntil {waypointdescription [group _uav,currentwaypoint group _uav] != ' ' || !alive _uav};
	terminate _spawn; //--- Terminate spawn from previous loop
	if !(alive _uav) exitwith {};

	_waypoints = waypoints _uav;
	_lastWP = _waypoints select (count _waypoints - 1);
	_lastWPpos = waypointposition _lastWP;
	deletewaypoint _lastWP;
	for "_d" from 0 to (360-_step) step _step do
	{
		_add = _d;
		if !(_cw) then {_add = -_d};
		_pos = [_lastWPpos, _radius, _dir+_add] call bis_fnc_relPos;
		_wp = (group _uav) addwaypoint [_pos,0];
		_wp setWaypointType "MOVE";
		_wp setwaypointdescription ' ';
		_wp setwaypointcompletionradius (1000/_wpcount);
	};

	_spawn = [_uav,_add,_step,_lastWPpos,_radius,_dir] spawn {
		_uav = _this select 0;
		_add = _this select 1;
		_step = _this select 2;
		_lastWPpos = _this select 3;
		_radius = _this select 4;
		_dir = _this select 5;
		_currentWP = currentwaypoint group _uav;
		while {alive _uav} do {
			waituntil {_currentWP != currentwaypoint group _uav};
			sleep .01;
			_add = _add + _step;
			if !(_cw) then {_add = -_add};
			_pos = [_lastWPpos, _radius, _dir+_add] call bis_fnc_relPos;
			_wp = (group _uav) addwaypoint [_pos,0];
			_wp setWaypointType "MOVE";
			_wp setwaypointdescription ' ';
			_wp setwaypointcompletionradius (1000/_wpcount);
			_currentWP = currentwaypoint group _uav;
		};
	};

	_wpcount = count waypoints _uav;
	waituntil {waypointdescription [group _uav,currentwaypoint group _uav] == ' ' || _wpcount != count waypoints _uav || !alive _uav};
	if !(alive _uav) exitwith {};
};



