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
#define MAX_TRESHOLD 20
#define MAX_TRESHOLD_PER_AREA 8
#define MAX_WP 2

private ["_pos","_counter","_civSpawnDistance","_nearHouses","_civArray","_building","_civClass","_civGroup","_unit","_wp","_unitsArray","_side","_civRelations","_sidePlayer","_civVests","_civUniforms","_civHead","_enemyFaction","_enemySide","_enemyArray"];
_pos = param [0, [], [[]]];
_counter =param [1, 1,[1]];
_factionCiv	= param [2, "CIV_F", [""]];
_civSpawnDistance = param [3, 250, [250]];
_unitsArray = param [4, [], [[]]];
_sidePlayer = param [5, west];
_civRelations = param [6,0.8,[0]];

//Militia
_civVests = ["","V_HarnessO_brn","V_HarnessO_gry","V_Rangemaster_belt","V_BandollierB_khk","V_BandollierB_cbr"];
_civUniforms = ["U_BG_Guerrilla_6_1","U_BG_Guerilla1_1","U_BG_Guerilla2_2","U_BG_Guerilla2_1","U_BG_leader","U_BG_Guerilla3_1"];
_civHead = ["","H_ShemagOpen_khk","H_ShemagOpen_tan","H_Bandanna_cbr","H_Bandanna_mcamo"];

//Find out who fighting the players side
_enemyFaction = "";
_enemySide = sideLogic;
{
	if (
				//The dude is alive
				alive _x
				&&
				// He is a human
				_x isKindOf "man"
				&&
				// He is not a player
				!(isplayer _x)
				&&
				//He is enemy
				([_sidePlayer, side _x] call BIS_fnc_sideIsEnemy)
		)
	then {
		_enemyFaction = faction _x;
		_enemySide = side _x;
 	};

 	if (_enemyFaction != "") exitWith {};
} foreach allUnits;

_enemyArray = [];
if (_enemyFaction != "") then {
	//Let's build the faction unit's array
	_enemyArray = missionNamespace getVariable ["MCC_ambient_enemyArray",[]];

	if (count _enemyArray == 0) then {
		_enemyArray = [_enemyFaction,"soldier","men"] call MCC_fnc_makeUnitsArray;
		if(count _enemyArray < 4) then {
			_enemyArray = [_enemyFaction,"soldier"] call MCC_fnc_makeUnitsArray;
		};

		if (count _enemyArray > 4) then {_enemyArray resize 4};
		missionNamespace setVariable ["MCC_ambient_enemyArray",_enemyArray];
	};
};


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
		if (_x distance _pos < ((_x getVariable ["radius",100])*2)) exitWith {_spawn = false};
	} forEach _deniedZones;

	if (_spawn) then {
		//Normal Civ
		if !(_civRelations < 0.4 && random 1 < 0.1) then {

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

				//Scared anim
				_unit addEventHandler ["FiredNear", {_this spawn MCC_fnc_ambientCivilianFiredNearEH}];
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

			{_x addCuratorEditableObjects [[_unit],false]} forEach allCurators;
		} else {
			//Militia
			if (count _enemyArray == 0) exitWith {};
			_civGroup = creategroup _enemySide;

			for "_i" from 1 to (random 3 + 2) step 1 do {
			    	_civClass = _enemyArray call bis_fnc_selectRandom;
					_unit = _civGroup createUnit [_civClass select 0,_pos,[],0.5,"NONE"];
					_unit forceAddUniform (_civUniforms call bis_fnc_selectRandom);
					_unit addVest (_civVests call bis_fnc_selectRandom);
					_unit addHeadgear (_civHead call bis_fnc_selectRandom);
					removeBackpack _unit;
					//remove NVG
					{
						_unit unassignItem _x;
						_unit removeItem _x;
					} foreach ["NVGoggles","NVGoggles_OPFOR","NVGoggles_INDEP"];

					//Add flashlights
					if ("acc_flashlight" in primaryWeaponItems _unit) then {
						_unit enablegunlights "forceOn";
					} else {
						_unit addPrimaryWeaponItem "acc_flashlight";
						sleep 0.3;
						_unit enablegunlights "forceOn";
					};

					_civArray pushBack _unit;
			    };

			(_civGroup) setVariable ["GAIA_ZONE_INTEND",[(missionNamespace getVariable ["mcc_zone_markername","0"]), "MOVE"], true];
		};

	};
};
missionNamespace setVariable ["MCC_ambientCivilians",_civArray];
publicVariable "MCC_ambientCivilians";