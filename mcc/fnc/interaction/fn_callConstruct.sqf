//==================================================================MCC_fnc_callConstruct===========================================================================
// Call support from ACE menu
// Example:[_type]  call MCC_fnc_callConstruct;
// <IN>
//	_type:					string - type of enemy to spot
//
// <OUT>
//		<Nothing>
//===========================================================================================================================================================================
private ["_conType","_available","_errorMessegeIndex","_errorMessege","_check","_respawPositions"];
#define REQUIRE_SQL_CONSTRUCT_DISTANCE 200
#define REQUIRE_CONSTRUCT_CONSTRUCT_DISTANCE 300
#define REQUIRE_FOB_FOB_MIN_DISTANCE 1000
#define REQUIRE_CONSTRUCT_FOB_MIN_DISTANCE 500
#define ANCHOR_ITEM "Land_Rampart_F"

_conType = [_this, 0, "", [""]] call BIS_fnc_param;
_pos = MCC_ACEKeyPos;

if (_conType =="") exitWith {};
_available = true;
_errorMessegeIndex = 0;
_errorMessege = [
          format ["Can't order to build deployables further then %1m from the player",REQUIRE_SQL_CONSTRUCT_DISTANCE],
          "Can't build on water",
          format ["FOB must be build in a minimum distance of %1m from another FOB or HQ",REQUIRE_FOB_FOB_MIN_DISTANCE],
          format ["Deployables can be build in a maximum distance of %1m from an FOB",REQUIRE_CONSTRUCT_FOB_MIN_DISTANCE],
          format ["Only one construction can be built at the same time in %1 meters radius",REQUIRE_CONSTRUCT_CONSTRUCT_DISTANCE]
                  ];

//Check if no more then one construct from the same type is beeing build in the area and
_check = ({alive _x} count (_pos nearObjects [ANCHOR_ITEM, REQUIRE_CONSTRUCT_CONSTRUCT_DISTANCE]));
if (_check != 0) then {_available = false; _errorMessegeIndex = 4};

//Check Near FOB
_respawPositions = [player] call BIS_fnc_getRespawnPositions;
if (_conType == "fob") then
{
  _check = {_pos distance _x < REQUIRE_FOB_FOB_MIN_DISTANCE} count _respawPositions;
  _check = _check + ({((_x getVariable ["MCC_conType",""])=="fob") && (playerside == _x getVariable ["MCC_side",sidelogic])} count (_pos nearObjects [ANCHOR_ITEM, REQUIRE_FOB_FOB_MIN_DISTANCE]));
  if (_check > 0) then {_available = false; _errorMessegeIndex = 2};
}
else
{
  _check = {_pos distance _x < REQUIRE_CONSTRUCT_FOB_MIN_DISTANCE} count _respawPositions;
  if (_check == 0) then {_available = false; _errorMessegeIndex = 3};
};

//Check if not on water
if (surfaceIsWater _pos) then {_available = false; _errorMessegeIndex = 1};

//Check if not too far
if (_pos distance player > REQUIRE_SQL_CONSTRUCT_DISTANCE) then {_available = false; _errorMessegeIndex = 0};


//Create structure
if (_available) then
{
  _path = "";
  [[_conType, _pos, playerside, str (getdir player)] ,"MCC_fnc_construction", false,false] call BIS_fnc_MP;

  //broadcast
  player globalRadio "SentAssemble";
  [[player,(if (side player == west) then {format["mp_groundsupport_01_slingloadrequested_BHQ_%1",floor random 3]} else {format["mp_groundsupport_01_slingloadrequested_IHQ_%1",floor random 3]})] ,"MCC_fnc_radioSupport", playerside,false] call BIS_fnc_MP;
}
else
{
  titleText [(_errorMessege select _errorMessegeIndex),"PLAIN DOWN"];
  titleFadeOut 10;
};
