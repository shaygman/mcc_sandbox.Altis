private ["_markerArray", "_isvip", "_car1", "_car2","_car4","_car3", "_car5", "_convoyArray", "_marker", "_activewp", "_wp", "_count",
		"_noleader", "_cargoNum","_fillSlots", "_pos", "_locGr", "_spawned","_unitsArray","_group","_type"];
_markerArray = _this select 0;
_isvip = _this select 1; 
_car1 = car1 select 0;
_car2 = car2 select 0;
_car4 = car4 select 0;
_car5 = car5 select 0;

if (_isvip=="0") then {_car3=car3 select 0} else {_car3=car3};
_convoyArray = [_car1, _car2, _car3 , _car4, _car5];

{_cargoNum = _x emptyPositions "cargo"; //populate convoy before kick off
	if (_cargoNum > 0) then	{
		_fillSlots = round (random _cargoNum);
		_pos = getpos _x;
		_locGr =  _pos findEmptyPosition [10, 100];
		sleep .2;
		if (_locGr select 0 > 0)then {
			_unitsArray	= [faction _x,"soldier"] call MCC_fnc_makeUnitsArray;	//Let's build the faction unit's array
			_group = creategroup side _x;
			for [{_i=1},{_i<=_fillSlots},{_i=_i+1}] do {
				_type = _unitsArray select round (random (count _unitsArray-1)); 
				_unit = _group createUnit [_type select 0,_locGr,[],0.5,"NONE"];
				sleep 0.3;
			};
			 _spawned = _x;
			{_x moveInCargo _spawned;} forEach units _group;
		};
	};
} foreach _convoyArray;
					
_count= 1;
_noleader = _convoyArray - [_car1];
//{[_convoyArray, _count, false]execVM MCC_path + "mcc\general_scripts\convoy\convoy_control.sqf"; _count = _count + 1} forEach _noleader;
for "_i" from 0 to ((count _markerArray) -1) do 
			{
				_activewp = (_markerArray select _i);
				_wp = (group _car1) addWaypoint [ _activewp, 30];
				[(group _car1),_i] setWaypointType "MOVE";
				[(group _car1),_i] setWaypointCompletionRadius 100;
				[(group _car1),_i] setwaypointCombatMode "YELLOW";
				[(group _car1),_i] setWaypointFormation "COLUMN";
				[(group _car1),_i] setWaypointBehaviour "SAFE";
			};
