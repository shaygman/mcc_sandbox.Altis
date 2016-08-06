/*===========================================MCC_fnc_MWattackBase============================================
/	Spawn random AI to attack the base
/	IN	<>
/		0: SIDE 	Base under attack side - must be MCC start location
/		1: STRING	Enemy faction
/
/	OUT <NOTHING>
/=========================================================================================================*/
private ["_side","_factionEnemy","_enemySide","_startLocation","_strength","_fronts","_d","_spawnPos","_simu","_roads","_unitsArray","_grp"];
_side = param [0, sideLogic, [sideLogic]];
_factionEnemy = param [1,"OPF_F",[""]];
_enemySide = (getNumber (configfile >> "CfgFactionClasses" >> _factionEnemy >> "side")) call BIS_fnc_sideType;

_startLocation = missionNamespace getVariable [format ["MCC_START_%1",_side],[0,0,0]];

if (str _startLocation == "[0,0,0]") exitWith {diag_log "MCC: MCC_fnc_attackBase error - base not found"};

//Lets calculate strength
_strength = (_side countSide allUnits) max 10;

//Find at least one front
_fronts = [];
for "_i" from 0 to 360 step 30 do {

	//find land
	_d = 1000;
	while {surfaceIsWater ([_startLocation, _d,_i] call BIS_fnc_relPos) && _d < 1500} do {
		_d = _d + 100;
	};

	_fronts pushBack ([_startLocation, _d,_i] call BIS_fnc_relPos);
};

if (count _fronts <=0) exitWith {diag_log "MCC: MCC_fnc_attackBase error - no fronts found"};

//spawn units acoording to the strength of the base
for "_i" from 0 to _strength step 5 do {
	_spawnPos = _fronts call BIS_fnc_selectRandom;

	_simu = [["soldier", "car", "tank"],[1,0.4,0.01]] call BIS_fnc_selectRandomWeighted;

	//Try to spawn them on roads
	if (!(isOnRoad _spawnPos) and (_simu in ["soldier", "car","motorcycle","tank"])) then {
		_roads = _spawnPos nearRoads 300;

		if (count(_roads)>0) then {
			_spawnPos = position(_roads call BIS_fnc_selectRandom);
		};
	};

	//Let's build the faction unit's array
	_unitsArray = missionNamespace getVariable [format ["MCC_campaignSpawnAIInit_%1",_simu],[]];
	if (count _unitsArray <= 0) then {
		if (_simu == "soldier") then {
			// Love the x simulation
			_unitsArray= [_factionEnemy ,_simu,"men"] call MCC_fnc_makeUnitsArray;
			_unitsArray = _unitsArray + ( [_factionEnemy ,_simu+"x","men"] call MCC_fnc_makeUnitsArray);
		} else {
			// Love the x simulation
			_unitsArray= [_factionEnemy ,_simu] call MCC_fnc_makeUnitsArray;
			_unitsArray = _unitsArray + ( [_factionEnemy ,_simu+"x"] call MCC_fnc_makeUnitsArray);
		};
	};

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

		//order attack
		_grp setVariable ["GAIA_ZONE_INTEND",[([_startLocation,1500] call MCC_fnc_campaignGetNearestTile) select 0, "MOVE"], true];
	};
};