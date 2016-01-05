//=================================================================MCC_fnc_initConstract========================================================================================
// Init Construction
// Example:[_conType,_pos] spawn MCC_fnc_initConstract;
// <IN>
//	_conType:					String- construction type.
//	_pos:						ARRAY- position.
//
// <OUT>
//		<nothing>
//===========================================================================================================================================================================
#define REQUIRE_SQL_CONSTRUCT_DISTANCE 200
#define REQUIRE_CONSTRUCT_CONSTRUCT_DISTANCE 50
#define REQUIRE_FOB_FOB_MIN_DISTANCE 500
#define REQUIRE_CONSTRUCT_FOB_MIN_DISTANCE 100
#define MAX_WALLS 14
#define ANCHOR_ITEM "Land_Bricks_V3_F"

private ["_conType","_available","_errorMessegeIndex","_errorMesseges","_check","_respawPositions","_error","_dir","_pos"];

_conType = param [0,"",[""]];
_pos = param [1,[0,0,0],[[]]];
if (_conType == "" || str _pos == "[0,0,0]") exitWith {};

_available = true;
_errorMessegeIndex = 0;
_dir = getdir player;

//Fortifecations don't need resource but they are limited in number per FOB
if (_conType in ["wall","bunker"]) then {
	_dir = _dir - 180;
	_errorMesseges = [
						format ["Can't order to build deployables further then %1m from the player",REQUIRE_SQL_CONSTRUCT_DISTANCE],
						"Can't build on water",
						format ["Can't build more then %1 fortifications around one FOB",MAX_WALLS],
						format ["Deployables can be build in a maximum distance of %1m from an FOB",REQUIRE_CONSTRUCT_FOB_MIN_DISTANCE],
						format ["Only one construction can be built at the same time in %1 meters radius",REQUIRE_CONSTRUCT_CONSTRUCT_DISTANCE]
                    ];

    //Check Near FOB
	_respawPositions = [player] call BIS_fnc_getRespawnPositions;
	_check = {_pos distance _x < REQUIRE_CONSTRUCT_FOB_MIN_DISTANCE} count _respawPositions;
	if (_check == 0) then {_available = false; _errorMessegeIndex = 3};

	//Check if not on water
	if (surfaceIsWater _pos) then {_available = false; _errorMessegeIndex = 1};

	//Check if not too far
	if (_pos distance player > REQUIRE_SQL_CONSTRUCT_DISTANCE) then {_available = false; _errorMessegeIndex = 0};

	//Check if not too many fortifications
	if ({_x getVariable ["MCC_CONST_FORT",false]} count (_pos nearObjects REQUIRE_CONSTRUCT_FOB_MIN_DISTANCE) >= MAX_WALLS) then {_available = false; _errorMessegeIndex = 2};
	_error = _errorMesseges select _errorMessegeIndex;

} else {

	_errorMesseges = [
						format ["Can't order to build deployables further then %1m from the player",REQUIRE_SQL_CONSTRUCT_DISTANCE],
						"Can't build on water",
						format ["FOB must be build in a minimum distance of %1m from another FOB or HQ",REQUIRE_FOB_FOB_MIN_DISTANCE],
						format ["Deployables must be build in a maximum distance of %1m from an FOB",REQUIRE_CONSTRUCT_FOB_MIN_DISTANCE],
						format ["Only one construction can be built at the same time in %1 meters radius",REQUIRE_CONSTRUCT_CONSTRUCT_DISTANCE]
                    ];

	//Check if no more then one construct from the same type is beeing build in the area and
	_check = ({alive _x} count (_pos nearObjects [ANCHOR_ITEM, REQUIRE_CONSTRUCT_CONSTRUCT_DISTANCE]));
	if (_check != 0) then {_available = false; _errorMessegeIndex = 4};

	//Check Near FOB
	_respawPositions = [player] call BIS_fnc_getRespawnPositions;
	if (_conType == "fob") then {
		_check = {_pos distance _x < REQUIRE_FOB_FOB_MIN_DISTANCE} count _respawPositions;
		_check = _check + ({((_x getVariable ["MCC_conType",""])=="fob") && (playerside == _x getVariable ["MCC_side",sidelogic])} count (_pos nearObjects [ANCHOR_ITEM, REQUIRE_FOB_FOB_MIN_DISTANCE]));
		if (_check > 0) then {_available = false; _errorMessegeIndex = 2};
	} else {
		_check = {_pos distance _x < REQUIRE_CONSTRUCT_FOB_MIN_DISTANCE} count _respawPositions;
		if (_check == 0) then {_available = false; _errorMessegeIndex = 3};
	};

	//Check if not on water
	if (surfaceIsWater _pos) then {_available = false; _errorMessegeIndex = 1};

	//Check if not too far
	if (_pos distance player > REQUIRE_SQL_CONSTRUCT_DISTANCE) then {_available = false; _errorMessegeIndex = 0};

	_error = _errorMesseges select _errorMessegeIndex;
};

//Create structure
if (_available) then {
	_success = ["Deploying",5] call MCC_fnc_interactProgress;
	if !(_success) exitWith {};

	[[_conType, _pos, playerside, str _dir] ,"MCC_fnc_construction", false,false] call BIS_fnc_MP;

	//broadcast
	player globalRadio "SentAssemble";
	[[player,(if (side player == west) then {format["mp_groundsupport_01_slingloadrequested_BHQ_%1",floor random 3]} else {format["mp_groundsupport_01_slingloadrequested_IHQ_%1",floor random 3]})] ,"MCC_fnc_radioSupport", playerside,false] call BIS_fnc_MP;
} else {
	private ["_str"];
	_str = "<t size='1' t font = 'puristaLight' color='#FFFFFF'>" + _error + "</t>";
	[_str,0,0.2,5,1,0.0] spawn bis_fnc_dynamictext;
	player globalRadio "SentCommandFailed";
};
