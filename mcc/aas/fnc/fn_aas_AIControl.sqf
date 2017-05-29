/*=================================================================MCC_fnc_aas_AIControl=============================================================================
		/*
			handle them AI in AAS mission
			IN
				_this select 0 -  _side 			- SIDE - side to handle
		*/
private ["_side","_sectors","_attackZonesPos","_group","_leader","_closestZonePos","_defendRatio","_allPos","_wpPos"];
_side = param [0, west];
_defendRatio = 0.2;

waituntil {time > 5};

//If not server or already initilize exit
if ((missionNamespace getVariable [format ["MCC_fnc_aas_AIControlInit_%1",_side],false]) || !isServer) exitWith {};
missionNamespace setVariable [format ["MCC_fnc_aas_AIControlInit_%1",_side],true];


_sectors = [];

//Get all sectors
{_sectors pushBack _x} foreach (allMissionObjects "moduleSector_f");
{_sectors pushBack _x} foreach (allMissionObjects "moduleSectorDummy_f");
{
	if (((_x getvariable ["ScoreReward",0]) call bis_fnc_parsenumber)>0) then {_sectors pushBack _x}
} foreach (allMissionObjects "logic");

_AIUnits = [];
while {true} do {

	// Handle zones
	_attackZonesPos = [];
	_defendZonesPos = [];

	//Get the defend & attack sectors
	{
		if ((_x getvariable ["owner",sideunknown]) != _side) then {
			_areas = _x getvariable ["areas",[]];
			{
				if (((triggerArea _x) select 0) > 0) then {
		   			_attackZonesPos pushBack position _x;
		   		};
			} forEach _areas;
		};

		if ((_x getvariable ["owner",sideunknown]) == _side) then {
			_areas = _x getvariable ["areas",[]];
			{
				if (((triggerArea _x) select 0) > 0) then {
		   			_defendZonesPos pushBack position _x;
		   		};
			} forEach _areas;
		};
	} forEach _sectors;

	_allPos = _attackZonesPos + _defendZonesPos;

	//issue commands to active AI groups
	{
		if (side _x == _side
		    && !isPlayer leader _x
		    && (_x getVariable ["MCC_canbecontrolled",false])
		    && (currentWaypoint _x >= count waypoints _x)
		    ) then {
			_group = _x;
			_leader = leader _group;

			_attackZonesPos = [_attackZonesPos,[],{_leader distance _x},"ASCEND"] call BIS_fnc_sortBy;
			_defendZonesPos = [_defendZonesPos,[],{_leader distance _x},"ASCEND"] call BIS_fnc_sortBy;

			if (count _attackZonesPos == 0) exitWith {};
			_closestZonePos = _attackZonesPos select 0;

			if (alive _leader
				&& ({_leader distance _x < 50} count _attackZonesPos ==0)
				&& ({_leader distance _x < 3000} count _allPos > 0)
				&& ((waypointPosition [_group, (currentWaypoint _group)]) distance _closestZonePos > 200)
				) then {
					_wpPos = if (random 1 < _defendRatio && (count _defendZonesPos > 0)) then {(_defendZonesPos select 0)} else {_closestZonePos};

					if (vehicle _leader isKindOf "air") then {
						[1,_wpPos,[3,"NO CHANGE","NO CHANGE","FULL","AWARE","true", "",0],[_group]] call MCC_fnc_manageWp;
					} else {
						[1,_wpPos,[0,"NO CHANGE","NO CHANGE","FULL","AWARE","true", "",0],[_group]] call MCC_fnc_manageWp;
					};
			};
		};
	} forEach allGroups;

	sleep 30;
};