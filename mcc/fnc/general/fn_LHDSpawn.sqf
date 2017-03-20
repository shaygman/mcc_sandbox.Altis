/*===================================================================MCC_fnc_LHDspawn=====================================================================================
	Spawn CUP LHD at a given position and set it as a MCC's start location
 	Example: [_pos] spawn MCC_fnc_LHDspawn

 		<IN>
		_pos:	ARRAY/OBJECT - position or Object

		<OUT>
		Name of the LHD
==================================================================================================================================================================*/
private ["_shipParts","_dir","_shipPos","_objects","_parts","_heliPads","_cargoPos","_ship","_hq"];

params [
	["_pos", objNull, [objNull,[]]],
	["_dir", 0, [0]],
	["_loadVehicleCargo", false, [false]],
	["_side", west, [west]]
];

//If pos is an object
if (typeName _pos isEqualTo typeName objNull) then {
	_dir = getDir _pos;
	_pos = getPosASL _pos;
};

//From here on it's CUP but they have some error where the LHD spawn at the bottom of the sea

if (!isServer) exitWith {};

/*
shipParts[] = {"CUP_LHD_1","CUP_LHD_2","CUP_LHD_3","CUP_LHD_4","CUP_LHD_5","CUP_LHD_6","CUP_LHD_7","CUP_LHD_house_1","CUP_LHD_house_2","CUP_LHD_elev_1","CUP_LHD_elev_2","CUP_LHD_Light2","CUP_LHD_Int_1","CUP_LHD_Int_2","CUP_LHD_Int_3"};

model = "\CUP\WaterVehicles\CUP_WaterVehicles_LHD\LHD_select_B.p3d";
*/

//_ship = "CUP_LHD_BASE" createVehicle _pos;
_ship = createSimpleObject ["CUP_LHD_BASE", _pos];
_ship setPosasl _pos;
_ship setDir _dir;

// Build Ship Parts
_shipParts = getArray (configFile >> "CfgVehicles" >> "CUP_B_LHD_WASP_USMC_Empty" >> "shipParts");
if (count _shipParts == 0) exitWith {};

_ship setVariable ["CUP_WaterVehicles_BuildFinished",false];
_ship setVariable ["MCC_isLHD",true,true];

_ship setDir ((getDir _ship) - 180);

_dir = getDir _ship;
_shipPos = getPosASL _ship;

_ship setVariable ["CUP_WaterVehicles_Dir",_dir];

// diag_log str(_dir);

//freeze all objects that arent the ship to prevent them from falling to the ground
_objects = nearestObjects [_ship,[],(sizeOf (typeOf _ship))];

{_x enableSimulationGlobal false;} forEach _objects;

//spawn the ship
_parts = [];
{
	private ["_section"];
	_section = _x createVehicle _shipPos;
	_section setDir _dir;
	_section setPos _shipPos;

	_parts pushBack _section;
} forEach _shipParts;

//Store parts
_ship setVariable ["CUP_WaterVehicles_shipParts",_parts];

//hide but dont delete the helper so it can be accessed later if needed
_ship hideObjectGlobal true;

//give the surrounding objects their simulation back
{_x enableSimulationGlobal true;} forEach _objects;

_ship setVariable ["CUP_WaterVehicles_BuildFinished",true];


if (_loadVehicleCargo) then {
	_ship setVariable ["CUP_WaterVehicles_loadVehicleCargo",true];

	[_ship,"VehicleCargo"] call CUP_fnc_createVehicleCargo;
	[_ship,"FlightDeckCargo"] call CUP_fnc_createVehicleCargo;
};

// Spawn weapons and lights
//[_ship] call CUP_fnc_spawnShipWeapons;
[_ship] call CUP_fnc_spawnShipLights;

if (is3DEN) then {
	[_ship] call CUP_fnc_EdenShip;
} else {
	// Create heli pads
	_heliPads = [];
	{
		private ["_pad"];
		_pad = "HeliH" createVehicle [0,0,0];
		_pad attachTo [_ship,[0,0,0],_x];

		_heliPads pushBack _pad;
	} forEach (getArray (configFile >> "CfgVehicles" >> typeOf _ship >> "heliPads"));
	_ship setVariable ["CUP_WaterVehicles_heliPads",_heliPads];

	// Init CUP virtual vehicle cargo
	[_ship,"init"] call CUP_fnc_virtualVehicleCargo;

	// Move in cargo position
	_cargoPos = AGLToASL (_ship modelToWorld (_ship selectionPosition "player_cargo_pos"));
	_ship setVariable ["CUP_WaterVehicles_cargoPos",_cargoPos,true];
};

//Create a FOB
[_ship,(_dir)-90,_side,_hq,false,false,false] spawn MCC_fnc_buildSpawnPoint;

//Create start location
[_side,_ship] call BIS_fnc_addRespawnPosition;

_ship