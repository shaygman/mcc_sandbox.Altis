/*=================================================================MCC_fnc_aas_AIspawn=============================================================================
/*
			Spawns AI in AAS mission in start location and captured zones

			_this select 0 -  _side 			- SIDE - side to handle
			_this select 1 -  _enemySide 		- SIDE - enemy side to handle
			_this select 2 -  _autoBalance		- BOOLEAN - auto balance the number of AI to the numbers of players
			_this select 3 -  _minPerSide		- INTEGER - minimun number of AI no matter how many players
			_this select 4 -  _spawnInDefensive	- BOOLEAN - spawn infantry on defence zones
			_this select 5 -  _faction			- STRING - faction's name as defined in cfgFaction
			_this select 6 -  _searchRadius		- INTEGER - how far should look for empty vehicles around the module location for empty vehicles
			_this select 7 -  _useDefaultGear	- Array - define the roles to spawn and propobility leave empty for non [["rifleman","ar","at","corpsman","marksman","officer"],[0.5,0.1,0.1,0.1,0.1,0.1]] from the RS cfg files.
			_this select 8 -  _startPos			- ARRAY - position of the defualt start location
*/

private ["_sectors","_autoBalance","_minPerSide","_spawnInDefensive","_AIUnits","_enemyNumber","_startPos","_sideNumber","_counter","_unitsArray","_spawnPos","_numberOfGroups","_groupArray","_group","_enemySide","_side","_maxUnits","_defendZonesPos","_areas","_faction","_nearVehicles","_searchRadius","_vehicleClass","_simType","_wepArray","_useDefaultGear","_unitNumber","_groupSize","_tempGroup","_vehicleGear","_i"];

_side = param [0, west];
_enemySide = param [1, east];
_autoBalance = param [2, true];
_minPerSide = param [3, 20];
_spawnInDefensive = param [4, true];
_faction =  param [5, "BLU_F"];
_searchRadius = param [6, 200];
_useDefaultGear = param [7, []];
_startPos = param [8, [0,0,0]];
_groupSize = 5;

//group spawn
MCC_fnc_AASgroupSpawn  = {
	private ["_unitNumber","_groupSize","_useDefaultGear","_groupArray","_defaultGroups","_group","_tempGroup","_unit","_selectedRole","_side","_unitsArray","_spawnPos","_i","_p","_t"];
	_unitNumber = param [0,4];
	_groupSize = param [1,6];
	_useDefaultGear = param [2,[]];
	_vehicle = param [3,objNull];
	_side = param [4,sideUnknown];
	_unitsArray = param [5,[]];
	_spawnPos = param [6,[]];

	_groupArray = [];
	for "_p" from 1 to _unitNumber step 1 do {
		_groupArray pushBack ((_unitsArray call bis_fnc_selectRandom) select 0);
	};

	//find group
	_defaultGroups = missionNamespace getVariable [format ["CP_%1Groups",_side],[]];
	_group = grpNull;

	for "_p" from 0 to (count _defaultGroups -1) step 1 do {
		_tempGroup = (_defaultGroups select _p) select 0;

		//vehicles put in a seperated group
		if (isNull _vehicle) then {
			if (!(_tempGroup getVariable ["locked",false]) && (!isPlayer leader _tempGroup) && ((count units _tempGroup)+_unitNumber) <= _groupSize  && ({vehicle _x != _x} count units _tempGroup == 0)) then {
    			_group = _tempGroup;
    		};
		} else {
    		if (!(_tempGroup getVariable ["locked",false]) && count units _tempGroup == 0) then {
    			_group = _tempGroup;
    		};
		};

		if (!isNull _group) exitWith {};
	};

	if (isNull _group) then {
		_group = createGroup _side;
		waituntil {!isnil "_group"};
		_name = ["Alpha","Bravo","Charlie","Delta","Echo","Foxtrot","Golf","Hotel","India","Juliett","Kilo","Lima","Mike","November","Oscar","Papa"] select (count _defaultGroups min 15);
		_group setVariable ["MCC_CPGroup",true,true];
		_group setVariable ["name",_name,true];
		_defaultGroups pushBack [_group,_name];
		missionNamespace setVariable [format ["CP_%1Groups",_side],_defaultGroups];
		publicVariable format ["CP_%1Groups",_side];
	};


	_group setVariable ["MCC_canbecontrolled",true,true];

	//spawn unit
	if (isNull _vehicle) then {
		{
			_unit =_group createUnit [(_groupArray call bis_fnc_selectRandom), _spawnPos, [], 0, "FORM"];
			waitUntil {alive _unit};

			_unit addEventHandler ["killed",format ["[%1, -1] call BIS_fnc_respawnTickets", _side]];

			//set gear
			if (count _useDefaultGear > 0) then {
				{
					_selectedRole = _x;
					if ({(_x getVariable ["CP_role",""]) == _selectedRole} count (units _group) == 0) exitWith {};
				} forEach _useDefaultGear;
				[_selectedRole,_unit] call MCC_fnc_gearAI;
			};

			MCC_curator addCuratorEditableObjects [[_unit],false];
		} forEach _groupArray;
	} else {
		private ["_cfg","_turrets","_path","_index","_isCargo","_t"];
		_cfg = configFile >> "CfgVehicles" >> typeOf _vehicle;
		_turrets = [_cfg >> "turrets"] call BIS_fnc_returnVehicleTurrets;			//All turrets were found, now spawn crew for them
		_path = [];
		_t = 0;
		_index = 0;

		//driver
		_unit = _group createUnit [getText(_cfg >> "crew"), position _vehicle, [], 0, "NONE"];
		_unit assignAsDriver _vehicle;
		_unit moveindriver _vehicle;
		_unit addEventHandler ["killed",format ["[%1, -1] call BIS_fnc_respawnTickets", _side]];

		//set gear
		if (count _useDefaultGear > 0) then {
			[(_useDefaultGear) call bis_fnc_selectRandomWeighted,_unit] spawn MCC_fnc_gearAI;
		};
		MCC_curator addCuratorEditableObjects [[_unit],false];

		while {_t < (count _turrets)} do {
			private ["_turretIndex", "_thisTurret"];
			_turretIndex = _turrets select _t;
			_thisTurret = _path + [_turretIndex];
			_turretPath = configName ((configFile >> "CfgVehicles" >> typeOf _vehicle >> "turrets") Select _index);

			_isCargo = ["cargo",tolower _turretPath] call BIS_fnc_inString;
			if (isNull (_vehicle turretUnit _thisTurret) && !_isCargo) then {
				_unit = _group createUnit [getText(_cfg >> "crew"), position _vehicle, [], 0, "NONE"];
				_unit moveInTurret [_vehicle, _thisTurret];

				//set gear
				if (count _useDefaultGear > 0) then {
					[(_useDefaultGear) call bis_fnc_selectRandomWeighted,_unit] spawn MCC_fnc_gearAI;
				};

				_unit addEventHandler ["killed",format ["[%1, -1] call BIS_fnc_respawnTickets", _side]];
				MCC_curator addCuratorEditableObjects [[_unit],false];
			};

			_t = _t + 2;
			_index = _index + 1;
		};
	};

	_group
};


//Spawn AI
_unitsArray 	= [_faction,"soldier","men",false] call MCC_fnc_makeUnitsArray;
if (count _unitsArray < 4) then {
	_unitsArray = [_faction,"soldier","",false] call MCC_fnc_makeUnitsArray;
};

//No units get out
if (count _unitsArray <4) exitWith {diag_log "MCC: MCC_fnc_aas_AIControl _unitsArray < 4"};

_sectors = [];

//Get all sectors
{_sectors pushBack _x} foreach (allMissionObjects "moduleSector_f");
{_sectors pushBack _x} foreach (allMissionObjects "moduleSectorDummy_f");
{
	if ((_x getvariable ["ScoreReward",-1])>0) then {_sectors pushBack _x}
} foreach (allMissionObjects "logic");

while {true} do {

	_enemyNumber =  0;
	_sideNumber =  0;

	_enemyNumber = _enemySide countSide allUnits;
	_sideNumber = _side countSide allUnits;

	_maxUnits = _enemyNumber max _minPerSide;
	_counter = (_maxUnits - _sideNumber) max 0;

	//Find spawn pos
	_defendZonesPos = [];
	if (_spawnInDefensive) then {

	 	//Get a defend zone that is not contested
		{
			if ((_x getvariable ["owner",sideunknown]) == _side) then {
				_areas = _x getvariable ["areas",[]];
				{
					if (((triggerArea _x) select 0) == 0) then {
			   			_defendZonesPos pushBack position _x;
			   		};
				} forEach _areas;
			};
		} forEach _sectors;

		//did we found any zone?
		_spawnPos = if (count _defendZonesPos > 0) then {_defendZonesPos call bis_fnc_selectRandom} else {_startPos};
	} else {
		_spawnPos = _startPos;
	};

	//Find nearest vehicles
	_nearVehicles = nearestObjects [_startPos, ["Motorcycle","Car","Tank"], _searchRadius];  //"Helicopter"


	{
		_vehicleClass = tolower (gettext (configFile >> "CfgVehicles" >> typeof _x >> "vehicleClass"));
		_simType = tolower (getText  (configFile >> "CfgVehicles" >> typeof _x >> "simulation"));
		_wepArray = (getArray  (configFile >> "CfgVehicles" >> typeof _x >> "weapons"));

		//Spawn crew
		if (_counter > _groupSize &&
			(count ((typeof _x) call GAIA_fnc_getTurretWeapons)>0 || count _wepArray > 1)
			) then {
				_vehicleGear = if (_x isKindOf "air") then {[["pilot"],[1]]} else {[["crew"],[1]]};
				_group = [_groupSize,_groupSize,_vehicleGear,_x,_side,_unitsArray,_spawnPos] call MCC_fnc_AASgroupSpawn;
				_counter = _counter - count crew _x;
				_counter = _counter max 0;
		};

	} forEach _nearVehicles;

	//Spawn AI
	_numberOfGroups = (_counter / _groupSize);

	if (_numberOfGroups > 0) then {
		for [{_i=1},{_i<=_numberOfGroups},{_i=_i+1}] do {

			_group = [_groupSize,_groupSize,_useDefaultGear,objNull,_side,_unitsArray,_spawnPos] call MCC_fnc_AASgroupSpawn;
			sleep 1;
		};


		//spawn the rest as a group - DISABLED WE WANT A FULL SQUAD SPAWN
		if (_counter mod _groupSize > 0) then {
			[_counter mod _groupSize,_groupSize,_useDefaultGear,objNull,_side,_unitsArray,_spawnPos] call MCC_fnc_AASgroupSpawn;
		};
	};

	sleep 120;
};