/*============================================================MCC_fnc_ambientambientFirePropagation======================================================================= 	Propagat fire from tree to tree

 In:
	0:	ARRAY Position the fire base
	1:	INTEGER Distance of the flames
	2:	INTEGER Direction of the flames

	EXAMPLE:
	[_startPos,_fireDistance,_dir] call MCC_fnc_ambientambientFirePropagation;

	<OUT>
		Nothing
==============================================================================================================================================================*/
#define	FIRE_OBJECTSMALL	"IncinerateShell"
#define	FIRE_OBJECTBIG	"test_EmptyObjectForFireBig"
#define	PLACE_HOLDER	"Land_HelipadEmpty_F"
#define	MAX_FIRES	5

params [
	["_startPos",[0,0,0],[[],objNull]],
	["_fireDistance",10,[0]],
	["_dir",0,[0]]
];

if (_fireDistance <=0) exitWith {};

private ["_pos","_fire","_fireSpread","_posTree","_dummy","_effect"];
_fireSpread = 7;

_pos = [_startPos,_fireSpread,_dir] call BIS_fnc_relPos;

//Some randomness
_pos set [0, (_pos select 0) + random 5 - random 5];
_pos set [1, (_pos select 1) + random 5 - random 5];
_pos set [2, (_pos select 2) + 0.3];

//If rain then the fire will most likely die
if (random 1 < rain) exitWith {};

//Burn trees
{
	_posTree = getPosATL _x;
	if (damage _x < 0.5 &&
	    ({typeOf _x in [PLACE_HOLDER,FIRE_OBJECTBIG]} count (_posTree nearObjects 5) <= 0) &&
	     ({typeOf _x in [PLACE_HOLDER,FIRE_OBJECTBIG]} count (_posTree nearObjects 50) < MAX_FIRES)
	   ) then {
		_dummy = PLACE_HOLDER createVehicle _posTree;
		_dummy setPos _posTree;
		_effect = FIRE_OBJECTBIG createVehicle _posTree;
		_effect attachTo [_dummy,[0,0,0]];

		//Spawn light
		[_effect,10] remoteExec ["MCC_fnc_ambientFireClientSide",0];

		//Each tree have a chance create new fire source
		if (random 10 > 6) then {
			[_posTree] spawn MCC_fnc_ambientFireStart;
		};

		//Put fire out after sometime
		[_effect, _dummy, _x] spawn {
			params ["_effect","_dummy","_tree"];
			sleep 180 + random 120;
			_tree setdamage 1;
			sleep 60 + random 60;
			while {!isnull (attachedTo _effect)} do {detach _effect};
			_nearObjects =  (getpos _effect) nearObjects 5;
			{
				if (typeOf _x in [FIRE_OBJECTBIG,"#particlesource","#lightpoint"]) then {deletevehicle _x};
			} foreach _nearObjects;
		};

		sleep random 10;
	};
} foreach (nearestTerrainObjects [_pos, ["Tree","Bush","SMALL TREE"], 8]);

//Propagation on land
if (["grass", tolower (surfaceType _pos)] call BIS_fnc_inString ||
    ["forest", tolower (surfaceType _pos)] call BIS_fnc_inString ||
    ["dirt", tolower (surfaceType _pos)] call BIS_fnc_inString
    ) then {

	_fire  = FIRE_OBJECTSMALL createVehicle _pos;
	_fire setPosATL _pos;

	//Spawn light
	[_fire,5] remoteExec ["MCC_fnc_ambientFireClientSide",0];

	//Next step
	_fireDistance = _fireDistance - _fireSpread;

	sleep 10 + (random 30);
	[_pos,_fireDistance,_dir] spawn MCC_fnc_ambientFirePropagation;
};

