//============================================================MCC_fnc_ambientBirdsSpawn==============================================================================
// Spawn a flock of birds from a nearby tree or bush
// In:
//	0:	ARRAY/OBJECT Position or Object - must have a tree nearby
//
//<OUT>
//	Nothing
//===========================================================================================================================================================================
params [
	["_pos",[0,0,0],[[],objNull]]
];

#define	 MCC_ANIMALSTYPE ["Seagull","Crowe","Kestrel_random_F"]

private ["_trees","_maxHeight","_type","_animal","_animals","_tree"];

if (typeName _pos == typeName objNull) then {
	_pos = getPos _pos;
};

if (_pos isEqualTo [0,0,0]) exitWith {};


_trees = nearestTerrainObjects [_pos, ["Tree","Bush","SMALL TREE"], 30];

if (count _trees <=0) exitWith {};
_tree = (_trees select 0);
_pos = getpos _tree;
_type = (MCC_ANIMALSTYPE call BIS_fnc_selectRandom);
_maxHeight = getnumber (configfile >> "cfgnonaivehicles" >> _type >> "maxHeight");
_animals = [];

for "_i" from 1 to (2 + random 4) do {
	_animal = createvehicle [_type,_pos,[],_maxHeight * 0.1,"none"];
	_animal setdir (random 360);
	_animal setpos _pos;
	_animals pushBack _animal;
};


_animals spawn {
	_delay = 3 / count _this;
	{
		_x enablesimulation true;
		_x switchmove "walkf";
		sleep _delay;
	} foreach _this;
};


[_tree,"moduleSeagulls","say3d"] remoteExec ["bis_fnc_sayMessage", 0];

[_animals,_maxHeight] spawn {
	params ["_animals","_maxHeight"];

	{
		_wp = [_X, 100, random 360] call  BIS_fnc_relPos;
		_wp set [2,_maxHeight];
		_x camsetpos _wp;
		_x camCommit 0;
	} foreach _animals;

	_delay = 10 / count _animals;
	{
		sleep _delay;
		deleteVehicle _x;
	} foreach _animals;
};