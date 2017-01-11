/*============================================================MCC_fnc_ambientFireStart=======================================================================
Starts fire at the given position

 In:
	0:	ARRAY/OBJECT Position or object of the fire base
	1:	BOOLEAN creat base of fire

	EXAMPLE:
	[_startPos] call MCC_fnc_ambientFireStart;

	<OUT>
		Nothing
==============================================================================================================================================================*/
#define	FIRE_OBJECTSMALL	"IncinerateShell"
#define	FIRE_OBJECTBIG	"test_EmptyObjectForFireBig"
#define	MAX_FIRES	20


params [
	["_pos",[0,0,0],[[],objNull]],
	["_baseFire",false,[false]]
];

private ["_fireDir","_fireDistance"];

if (typeName _pos == typeName objNull) then {
	_pos = getPos _pos;
};

if (_pos isEqualTo [0,0,0]) exitWith {};

//Find fire direction and distance
_fireDir = windDir;
_fireDistance = (windStr max 0.1) * 100;

//Create base of fire
if (_baseFire) then {
	private ["_effect"];
	_effect = FIRE_OBJECTSMALL createVehicle _pos;

	//Spawn light
	[_effect,5] remoteExec ["MCC_fnc_ambientFireClientSide",0];
};

//Start the fire
for "_i" from (_fireDir - 45) to (_fireDir + 45) step 15 do  {

	//Don't over use it
	while {{typeOf _x in [FIRE_OBJECTSMALL,FIRE_OBJECTBIG]} count (_pos nearObjects 50) > MAX_FIRES} do {sleep 1};
	[_pos,_fireDistance,_i] spawn MCC_fnc_ambientFirePropagation;
	/*
	if ({typeOf _x in [FIRE_OBJECTSMALL,FIRE_OBJECTBIG]} count (_pos nearObjects 50) < MAX_FIRES) then {
		[_pos,_fireDistance,_i] spawn MCC_fnc_ambientFirePropagation;
	};
	*/
	sleep 12 + floor (((random 30) - _fireDistance) max 5);
};