/*======================================================MCC_fnc_campaignSpawnAIInit=======================================================================================
// Spawn selected units around the player
// Example: [_spawnDistance,_maxSpawn,_faction] spawn MCC_fnc_campaignSpawnAIInit;
// _spawnDistance		INTEGER - Spawn distance around the players
// _maxSpawn			INTEGER - max groups spawned around the players
// _faction				STRING - the units' faction
//==================================================================================================================================================================*/
private ["_spawnCenters","_player","_spawnpos","_enemyFaction","_spawnDistance","_maxSpawn","_enemySide","_unitsArray","_spawnPos","_roads","_simu","_unit","_maxGroupAmount","_units","_grp","_tile"];
_spawnDistance 	= param [0, 250, [250]];
_maxSpawn 		= param [1, 12, [12]];
_enemyFaction	= param [2, "OPF_F", [""]];
_enemySide 		= (getNumber (configfile >> "CfgFactionClasses" >> _enemyFaction >> "side")) call BIS_fnc_sideType;

if (!isServer) exitWith {};

//Let's build the faction unit's array
{
	_simu = _x;
	_unitsArray = [];
	if (_simu == "soldier") then {
		// Love the x simulation
		_unitsArray= [_enemyFaction ,_simu,"men"] call MCC_fnc_makeUnitsArray;
		_unitsArray = _unitsArray + ( [_enemyFaction ,_simu+"x","men"] call MCC_fnc_makeUnitsArray);
	} else {
		// Love the x simulation
		_unitsArray= [_enemyFaction ,_simu] call MCC_fnc_makeUnitsArray;
		_unitsArray = _unitsArray + ( [_enemyFaction ,_simu+"x"] call MCC_fnc_makeUnitsArray);
	};

	missionNamespace setVariable [format ["MCC_campaignSpawnAIInit_%1",_simu],_unitsArray];
} foreach ["soldier", "car", "motorcycle", "tank","helicopter", "airplane", "ship"];

while {true} do {
	//Lets find a random player
	_spawnCenters = if (isMultiplayer) then {playableUnits} else {[player]};

	//If the player is not on enemy tile or not alive remove him from the list
	for "_i" from 0 to (count _spawnCenters)-1 step 1 do {
		_player = _spawnCenters select _i;
		if 	(
		    	!alive _player ||
		    	captive _player ||
		    	!isTouchingGround _player ||
		    	([_player,600] call MCC_fnc_campaignGetNearestTile) select 1 != _enemySide &&
		       	{([position _player,str _x] call GAIA_fnc_IsInMarker)} count ([(missionNamespace getVariable ["MCC_zones_numbers",[]]), { _x <1000}] call BIS_fnc_conditionalSelect) <= 0
			) then {
			_spawnCenters set [_i,-1];
		};
	};

	_spawnCenters = _spawnCenters - [-1];
	_maxGroupAmount = (((count _spawnCenters)max 1)*2) min _maxSpawn;

	//Do we need to spawn more AI group?
	if 	(
	     	({(_x getVariable ["MCC_MW_AMBIENT",false])} count allgroups) < _maxGroupAmount &&
	     	count _spawnCenters > 0 &&
	     	(missionNamespace getvariable [format ["campaignRep_%1",side _player],50]) > random 100
	    ) then {

		_player	= _spawnCenters call BIS_fnc_selectRandom;
		_spawnPos = [getpos _player, _spawnDistance, random 360] call BIS_fnc_relPos;
		_spawnPos =(_spawnPos) findEmptyPosition [10,150];
		_tile = ([_spawnPos,600] call MCC_fnc_campaignGetNearestTile) select 0;

		//We have an enemy tile nearby spawn by the intense of the tile
		if 	(
		     	//We found a tile
		    	_tile != "" &&

		    	//the darker the tile the more chance he have to spawn enemies
		    	random 1 < markerAlpha _tile &&

		    	//Don't spawn on a released tile
		    	([_spawnPos,600] call MCC_fnc_campaignGetNearestTile) select 1 == _enemySide &&

		    	//We don't spawn enemies in MCC zones
		    	{([_spawnPos,str _x] call GAIA_fnc_IsInMarker)} count ([(missionNamespace getVariable ["MCC_zones_numbers",[]]), { _x <1000}] call BIS_fnc_conditionalSelect) <= 0
		    ) then {

			//Land or water
			if (surfaceIsWater _spawnPos) then {
				_simu = [["helicopter", "airplane", "ship"],[0.01,0.01,1]] call BIS_fnc_selectRandomWeighted;
			} else {

				_simu = [["soldier", "car", "tank"],[1,0.4,0.01]] call BIS_fnc_selectRandomWeighted;
			};

			//Try to spawn them on roads
			if (!(isOnRoad _spawnPos) and (_simu in ["soldier", "car","motorcycle","tank"])) then {
				_roads = _spawnPos nearRoads 250;

				if (count(_roads)>0) then {
					_spawnPos = position(_roads call BIS_fnc_selectRandom);
				};
			};

			_unitsArray = missionNamespace getVariable [format ["MCC_campaignSpawnAIInit_%1",_simu],[]];

			if (count _unitsArray > 0) then {

				//Spawn units
				if (_simu == "soldier") then {
					_units = [];
					for "_i" from 0 to ((floor random 10) max 3) step 1 do {
						_units pushBack ((_unitsArray call BIS_fnc_selectRandom) select 0);
					};
					_grp = [_spawnPos, _enemySide, _units] call BIS_fnc_spawnGroup;
				} else {
					_grp = ([_spawnPos, 200, ((_unitsArray call BIS_fnc_selectRandom) select 0), _enemySide] call bis_fnc_spawnvehicle) select 2;
				};

				_grp setVariable ["GAIA_ZONE_INTEND",[([_spawnPos,1500] call MCC_fnc_campaignGetNearestTile) select 0, ["MOVE","NOFOLLOW"]call BIS_fnc_selectRandom], true];
				_grp setVariable ["MCC_MW_AMBIENT",true, false];
			};
		};
	};


	sleep 600;

	//Delete stuff
	{
		private _delete = true;
		private _grp    = _x;
		if (_grp getVariable ["MCC_MW_AMBIENT",false]) then {
			{
				_unit = _x;
				if (({(_x distance _unit < _spawnDistance*2) || !(lineintersects [eyepos _x,getposasl _unit,_x,_unit])} count _spawnCenters)>0)  exitWith {_delete = false;};
			} forEach (units _grp);

			if _delete then {
				//Delete all
				{deleteVehicle _x; sleep 0.3} foreach ([_grp] call  BIS_fnc_groupVehicles);
				{ deleteVehicle _x;sleep 0.3} forEach units _grp;
				deletegroup _grp;
			};
		};
	} forEach allgroups;
};

