//============================================================MCC_fnc_ambientSpawnCiv===================================================================================
// Spawn civilians around the player
// In:
//	_pos:	ARRAY of players that can see the civilians
//	_counter:  INTEGER max civilians to spawn
//	_civSpawnDistance: INTEGER distance to delete
//	_sidePlayer : SIDE
//
//<OUT>
//	Nothing
//===================================================================================================================================================================
#define MAX_TRESHOLD 15
#define MAX_TRESHOLD_PER_AREA 5
#define MAX_WP 4

private ["_pos","_counter","_civSpawnDistance","_nearHouses","_civArray","_building","_civClass","_civGroup","_unit","_wp","_unitsArray","_side","_civRelations","_sidePlayer"];
_pos = param [0, [], [[]]];
_counter =param [1, 1,[1]];
_factionCiv	= param [2, "CIV_F", [""]];
_civSpawnDistance = param [3, 250, [250]];
_unitsArray = param [4, [], [[]]];
_sidePlayer = param [5, west];
_civRelations = param [6,0.8,[0]];

if (count _unitsArray <=0) exitWith {};

_side = [(getNumber (configfile >> "CfgFactionClasses" >> _factionCiv >> "side"))] call BIS_fnc_sideType;
_civArray = missionNamespace getVariable ["MCC_ambientCivilians",[]];

//Find nearest houses
_nearHouses = [_pos,_civSpawnDistance] call MCC_fnc_findCivHouse;

//No houses around? go home
if (count _nearHouses <= 0 || count _civArray >= MAX_TRESHOLD) exitWith {};

//Don't spawn more the treshold per area
_civInArea = (MAX_TRESHOLD_PER_AREA - ({_x distance _pos < _civSpawnDistance} count _civArray));
if (_counter > _civInArea) then {_counter = _civInArea};

//Don't spawn more AI then houses
_counter = _counter min (count _nearHouses);

//Denied zones
_deniedZones = (_pos nearEntities ["MCC_Module_ambientCiviliansDenied", 2000]) + (_pos nearEntities ["MCC_Module_ambientCiviliansCuratorDenied", 2000]);

for "_i" from 1 to _counter do {
	_building = _nearHouses call bis_fnc_selectRandom;
	_pos = getpos _building;

	//Are we inside denied zone
	private ["_spawn"];
	_spawn = true;
	{
		if (_x distance _pos < (_x getVariable ["radius",100])) exitWith {_spawn = false};
	} forEach _deniedZones;

	if (_spawn) then {
		if (count _unitsArray > 6) then {_unitsArray resize 6};
		_civClass = _unitsArray call bis_fnc_selectRandom;

		_civGroup = creategroup _side;
		_unit = _civGroup createUnit [_civClass select 0,_pos,[],0.5,"NONE"];

		if (_side == civilian) then {
			//Add coleteral damage EH
			_unit addEventHandler ["killed", {
												_killer = _this select 1;
												if (isplayer _killer) then {
													_killed = missionNamespace getvariable [format ["MCC_civiliansKilled_%1",side _killer],0];
													_killed = _killed +1;
													missionNamespace setvariable [format ["MCC_civiliansKilled_%1",side _killer],_killed];
													publicVariable format ["MCC_civiliansKilled_%1",side _killer];
												}}];
		};
		_civArray pushBack _unit;

		//Lets check the civilians reaction to the player and spawn an armed civilian
		if (random 1 > _civRelations) then {
			//Rep is bad spawn suicide bomber
			if (_civRelations < 0.4 && random 1 < 0.1) then {
				[_unit,_sidePlayer,["small","medium","large"] call bis_fnc_selectRandom,[0,2] call bis_fnc_selectRandom] spawn MCC_fnc_manageSB;
			} else {
				if ( random 1 < 0.4) then {
					//Spawn armed civilian
					_unit setVariable ["static",true,true];
					_unit setVariable ["MCC_IEDtype","ac",true];
					[_unit,_sidePlayer,35] spawn MCC_fnc_manageAC;
				};
			};
		};

		_civGroup setspeedmode "LIMITED";
		_civGroup setBehaviour "SAFE";

		for "_i" from 0 to MAX_WP do {
			_building = _nearHouses call bis_fnc_selectRandom;

			_wp = _civGroup addWaypoint [(getPos _building), 0];
			_wp setWaypointType "MOVE";
			_wp setWaypointHousePosition (floor random (_building call MCC_fnc_buildingPosCount));
			_wp setWaypointTimeout [10, 30, 120];
			_wp waypointAttachObject _building;
		};

		_wp = _civGroup addWaypoint [_pos,(count waypoints _civGroup)];
		_wp setWaypointType "Cycle";

		MCC_curator addCuratorEditableObjects [[_unit],false];
	};
};
missionNamespace setVariable ["MCC_ambientCivilians",_civArray];
publicVariable "MCC_ambientCivilians";