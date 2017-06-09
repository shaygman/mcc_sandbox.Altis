/*===================================================================MCC_fnc_LHDspawn=====================================================================================
	Spawn CUP LHD at a given position and set it as a MCC's start location
 	Example: [_pos,_dir,_loadVehicleCargo] spawn MCC_fnc_LHDspawn

 		<IN>
		0:	ARRAY/OBJECT - position or Object
		1:	INTEGER	 - direction of LHD
		2: 	SIDE	- side of the owner
		3: 	BOOLEAN	- if true the LHD will act as a spawning pos
		4: 	BOOLEAN	- if true will spawn CUP LHD otherwise will spawn A3 LHD


		<OUT>
		Name of the LHD
==================================================================================================================================================================*/
private ["_shipParts","_dir","_shipPos","_objects","_parts","_heliPads","_cargoPos","_ship","_pos","_markers","_isCUP","_LHDType"];

params [
	["_pos", objNull, [objNull,[]]],
	["_dir", 0, [0]],
	["_side", west, [west]],
	["_hq", true, [true]],
	["_isCUP",false,[false]]
];

//If pos is an object
if (typeName _pos isEqualTo typeName objNull) then {
	_dir = getDir _pos;
	_pos = getPosASL _pos;
};

if (!isServer) exitWith {};

//CLose Curator
if ( !isNull(findDisplay 312) ) then {(findDisplay 312) closeDisplay 1};


_markers = [];

/*
shipParts[] = {"CUP_LHD_1","CUP_LHD_2","CUP_LHD_3","CUP_LHD_4","CUP_LHD_5","CUP_LHD_6","CUP_LHD_7","CUP_LHD_house_1","CUP_LHD_house_2","CUP_LHD_elev_1","CUP_LHD_elev_2","CUP_LHD_Light2","CUP_LHD_Int_1","CUP_LHD_Int_2","CUP_LHD_Int_3"};

model = "\CUP\WaterVehicles\CUP_WaterVehicles_LHD\LHD_select_B.p3d";
*/

if (!(isClass (configFile >> "CfgVehicles" >> "CUP_LHD_BASE")) && _isCUP) exitWith {
	private ["_str","_null"];
	_str = "<t size='0.8' t font = 'puristaLight' color='#FFFFFF'>" + "CUP Addon is required" + "</t>";
	_null = [_str,0,1.1,2,0.1,0.0] spawn bis_fnc_dynamictext;
};

_LHDType = if (_isCUP) then {"MCC_lhd"} else {"MCC_carrier"};

//Delete old LHD first
if !(isNull (missionNamespace getVariable [_LHDType,objNull])) then {
	_ship = missionNamespace getVariable [_LHDType,objNull];

	if (_ship isKindOf "CUP_LHD_BASE") then {
		{
			deleteVehicle _x;
		} forEach (_ship getVariable ["CUP_WaterVehicles_shipParts",[]]);

		{
			deleteMarker _x;
		} forEach (_ship getVariable ["MCC_LHDMarkers",[]]);
	} else {
		{
			deleteVehicle (_x select 0);
		} forEach (_ship getVariable ["bis_carrierParts",[]]);
	};
};

if (_isCUP) then {
	_ship = createSimpleObject ["CUP_LHD_BASE", _pos];
} else {

	_ship = "Land_Carrier_01_base_F" createVehicle _pos;
	/*
	sleep 2;

	//delete the ship parts and spawn them again
	{
		deleteVehicle (_x select 0);
	} forEach (_ship getVariable ["bis_carrierParts",[]]);
	*/
};

//Spawn Ship
_ship setPosasl _pos;
_ship setDir _dir;
_shipPos = getPosASL _ship;

{_x addCuratorEditableObjects [[_ship],false]} forEach allCurators;

_ship setVariable ["MCC_isLHD",true,true];

	// Build Ship Parts
_shipParts = if (_isCUP) then {getArray (configFile >> "CfgVehicles" >> "CUP_B_LHD_WASP_USMC_Empty" >> "shipParts")} else {getArray (configFile >> "CfgVehicles" >> "Land_Carrier_01_base_F" >> "multiStructureParts")};

if (count _shipParts == 0) exitWith {};

if (_isCUP) then {

	_ship setVariable ["CUP_WaterVehicles_BuildFinished",false];

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


	// Spawn weapons and lights
	//[_ship] call CUP_fnc_spawnShipWeapons;
	//[_ship] call CUP_fnc_spawnShipLights;

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


	//Aresting gear
	private ["_temp_pos","_dummy","_logcClass"];

	//H (Invisable) Startfly
	_temp_pos = _ship modeltoworld [10,100,-4.5];
	_dummy = "HeliH" createVehicle _temp_pos;
	_dummy setDir ((getDir _ship));
	_dummy setPos _temp_pos;
	missionNamespace setVariable ["MCC_startfly",_dummy];
	publicVariable "MCC_startfly";

	//H (Invisable) Cables
	_temp_pos = _ship modeltoworld [10,-60,-4.5];
	_dummy = "HeliH" createVehicle _temp_pos;
	_dummy setDir ((getDir _ship));
	_dummy setPos _temp_pos;
	missionNamespace setVariable ["MCC_cables",_dummy];
	publicVariable "MCC_cables";

	//Arresting Gear trigger
	private ["_trg"];
	_trg = createTrigger ["EmptyDetector", _temp_pos];
	_trg setDir ((getDir _ship));
	_trg setPos _temp_pos;
	_trg setTriggerArea [15, 10, 0, false];
	_trg setTriggerActivation ["ANYPLAYER", "PRESENT", true];
	_trg setTriggerStatements ["this", "{[thisTrigger, _x] remoteExec ['MCC_fnc_arrestingGear',_x]} forEach thisList;", ""];

	//Arresting Gear marker
	_dummy = createmarker ["gear",_temp_pos];
	_dummy setMarkerShape "RECTANGLE";
	_dummy setMarkerSize [15, 10];
	_dummy setMarkerBrush "Solid";
	_dummy setMarkerColor "ColorRed";

	_markers pushBack _dummy;

	private ["_vehicle","_displayName"];

	//Spawn two tractors
	{
		_vehicle = createVehicle ["CUP_B_TowingTractor_USMC", [0,0,0], [], 0, "NONE"];
		_vehicle allowDamage false;
		_vehicle setDamage 0;
		_vehicle attachTo [_ship, [0,0,1], _x];
		_vehicle setVariable ["CUP_WaterVehicles_LHD_respawnPosition", _x, true];

		detach _vehicle;
		_vehicle setDir (direction _ship);
		_vehicle allowDamage true;

		// Get display name
		_displayName = getText (configFile >> "CfgVehicles" >> "CUP_B_TowingTractor_USMC" >> "displayName");

		// For each vehicle add an action to detach from the ship - MP compliant
		[
			[_vehicle,[format ["%1 %2",localize "STR_CUP_CFG_RELEASEVEHICLE", _displayName], {[_this, "CUP_fnc_detachFromShip", _this select 0, false, true] call BIS_fnc_MP},nil, 1.5, false, true]],
			"addAction", true, true
		] call BIS_fnc_MP;


		{_x addCuratorEditableObjects [[_vehicle],false]} forEach allCurators;
	} forEach ["fd_cargo_pos_20","fd_cargo_pos_21"];

	//Create ILS
	_temp_pos = _ship modeltoworld [10,100,-4.5];
	_logcClass = if (missionNamespace getVariable ["MCC_isMode",false]) then {"mcc_sandbox_moduleILS"} else {"logic"};
	_dummy = (createGroup sideLogic) createunit [_logcClass, _temp_pos ,[],0.5,"NONE"];
	_dummy setPos _temp_pos;
	_dummy setVariable ["MCC_runwayName","LHD",true];
	_dummy setVariable ["MCC_runwayDis",100,true];
	_dummy setVariable ["MCC_runwaySide",-1,true];
	_dummy setVariable ["MCC_runwayCircles",true,true];
	_dummy setVariable ["MCC_runwayAG",(missionNamespace getVariable ["MCC_cables",objNull]),true];

	//Create Markers
	_dummy = createmarker ["MCC_LHD",_shipPos];
	_dummy setMarkerShape "RECTANGLE";
	_dummy setMarkerSize [20, 130];
	_dummy setMarkerBrush "Solid";
	_dummy setMarkerColor "ColorBlue";
	_markers pushBack _dummy;

	_dummy = createmarker ["MCC_LHD_NAME",(_ship modeltoworld [0,100,0])];
	_dummy setMarkerText "LHD";
	_dummy setMarkerColor "ColorBlack";
	_dummy setMarkerShape "ICON";
	_dummy setMarkerType "mil_dot";
	_markers pushBack _dummy;

	_ship setVariable ["MCC_LHDMarkers",_markers,true];
} else {
	[_ship] call BIS_fnc_Carrier01PosUpdate;
	sleep 5;
	_ship remoteExec ["BIS_fnc_Carrier01Init",0];
};

/*
//Create a FOB
[_pos,(_dir)-90,_side,"FOB",false,false,false] spawn MCC_fnc_buildSpawnPoint;
*/

_ship setVariable ["teleport",1,true];

//Create start location
[_side,_ship] call BIS_fnc_addRespawnPosition;

//Open dialog
if (_hq) then {
	_pos = getposasl _ship;
	_pos = _pos vectorAdd [0,0,17];
	_startLocationName = format ["MCC_START_%1", _side];
	missionNamespace setVariable [_startLocationName,_pos];
	publicVariable _startLocationName;
};

missionNamespace setVariable [_LHDType,_ship,true];
_ship

