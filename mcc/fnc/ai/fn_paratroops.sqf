/*==================================================================MCC_fnc_paratroops==========================================================================
//Contorol the paratroop reinforcement spawn
// Example:[_pos,_paraSide,_paraType,_p_mcc_zone_markername,_p_mcc_zone_behavior,_p_mcc_awareness,_p_mcc_spawnfaction,_startPosDir] spawn MCC_fnc_paratroops;
// <IN>
//	_pos:					Array- position.
//	_paraSide:				String, side to call "West","East","Resistance"
//	_paraType:				Integer, 	0 - "paradrop: small - Spec-Ops "
//										1 - "paradrop: medium - QRF"
//										2 - "paradrop: large - Airborne"
//										3 - "drop-off: small - Spec-Ops "
//										4 - "drop-off: medium - QRF"
//										5 - "drop-off: large - Airborne"
//										6 - "fast-rope: small - Spec-Ops "
//										7 - "fast-rope: medium - QRF"
//										8 - "fast-rope: large - Airborne"
//	_p_mcc_zone_markername		String, Zone number the helicopter's cargo will patrol that zone.
//	_p_mcc_zone_behavior		String, The helicopter's cargo will have this behavior ("MOVE","FORTIFY" exc...)
// 	_p_mcc_awareness			String, The helicopter's cargo will have this awareness ("default","safe" exc...)
//	_p_mcc_spawnfaction			String, Faction name.
//	_startPosDir				Array, spawn and de-spawn location for the helicopter.
//==============================================================================================================================================================*/
private ["_away","_p_mcc_zone_markername","_heli","_heliCrew","_pos","_paraSide", "_paraType", "_helitype","_heli_pilot","_spawn","_heliPilot","_gunnersGroup","_type","_entry","_turrets","_path", "_timeOut","_unit", "_side", "_spawnParaGroup", "_paraGroupArray", "_paraGroup", "_paraMode", "_heliCrewCount","_p_mcc_spawnfaction", "_p_mcc_zone_behavior", "_mcc_awareness", "_newParaGroup", "_rampOutPos", "_flyHeight","_dropPos", "_rope", "_ropes","_vehicleClass"];

_pos 					= _this select 0;
_paraSide				= param [1,"",["",east]];
_paraType 				=  if (TypeName  (_this select 2) == "STRING") then {call compile (_this select 2)} else {(_this select 2)};
_p_mcc_zone_markername  = _this select 3;
_p_mcc_zone_behavior	= _this select 4;
_p_mcc_awareness		= _this select 5;
_p_mcc_spawnfaction		= _this select 6;
_startPosDir			= _this select 7;

if ( isNil "_startPosDir" ) then {
	_spawn = [(_pos select 0)+1000,_pos select 1,(_pos select 2) + 100];
	_away  = [(_pos select 0)-2000,_pos select 1,(_pos select 2) + 100];
} else {
	_spawndir = [_pos, _startPosDir] call BIS_fnc_dirTo;
	_spawn = [_pos,2000,_spawndir] call BIS_fnc_relpos;
	_away  = [_pos,2000,_spawndir - 180] call BIS_fnc_relpos;
};

//id sent a string
if (typeName _paraSide isEqualTo typeName sideLogic) then {
	_paraSide = str _paraSide;
};
_unitspawned = [];
_paraGroupArray = [];
_customParaGroup = false;
_dropPos = [];
_rampOutPos = [];
_ropes = [];
_actualRopes = [];

// get group configs
{
	if ( ((_x select 3) == "Rifle Squad") || ((_x select 3) == "Recon Team") ) then {
		_paraGroupArray pushBack (format ["%1", ( _x select 2)]);
	};
} forEach ([_paraSide,_p_mcc_spawnfaction,"Infantry","LAND"] call mcc_make_array_grps);


if ( (count _paraGroupArray) == 0 ) then {
	_customParaGroup = true;
	_unitsArray = [];

	//Let's build the faction unit's array
	{
		_unitsArray	pushBack (_x select 0);
	} foreach ([_p_mcc_spawnfaction,"soldier","",false] call MCC_fnc_makeUnitsArray);

	//diag_log format ["MCC paradrop custom array: %1", _unitsArray];

	if ( (count _unitsArray) == 0 ) exitWith {};

	_paraGroupArray set [0, _unitsArray];

	//diag_log format ["MCC paradrop custom array: %1", count _paraGroupArray];
};

if ( (count _paraGroupArray) == 0 ) exitWith { diag_log format ["MCC Warning: no suitable paratrooper group found for %1", _this]; player groupChat format ["Error: no suitable paratrooper group for this Faction"]; };

//Set default helicopter and crew
switch (_paraSide) do {
	case "WEST": {
		_side = west;
		switch (_paraType % 3) do
		{
			case 0: // 0, 3, 6
			{
				_helitype = "B_Heli_Light_01_F";
				//_spawnParaGroup = _paraGroupArray select 1;
				_spawnParaGroup = _paraGroupArray select ((count _paraGroupArray) -1);
				_ropes = [[0.6,0.5,0],[-0.8,0.5,0]];
			};
			case 1: // 1, 4, 7
			{
				_helitype = "B_Heli_Transport_01_F";
				_spawnParaGroup = _paraGroupArray select ((count _paraGroupArray) -1);
				_ropes = [[-1.11,2.5,0],[1.11,2.5,0]];
			};
			case 2: // 2, 5, 8
			{
				_helitype = "B_Heli_Transport_03_F";
				_spawnParaGroup = _paraGroupArray select 0;
				_ropes = [[1,-4,-1],[-1,-4,-1]];
			};
		};
	};

	case "EAST": {
		_side = east;
		switch (_paraType % 3) do
		{
			case 0:
			{
				_helitype = "O_Heli_Attack_02_F";
				_spawnParaGroup = _paraGroupArray select ((count _paraGroupArray) - 1);
				_ropes = [[1.35,1.35,0],[-1.45,1.35,0]];
			};
			case 1:
			{
				_helitype = "O_Heli_Light_02_F";
				_spawnParaGroup = _paraGroupArray select ((count _paraGroupArray) -1);
				//_ropes = [[1.3,1.3,-25],[-1.3,1.3,-25]];
				_ropes = [[1.3,1.3,0],[-1.3,1.3,0]];
			};
			case 2:
			{
				_helitype = "O_Heli_Transport_04_covered_F";
				_spawnParaGroup = _paraGroupArray select 0;
				_ropes = [[1,-4,-1],[-1,-4,-1]];
			};
		};
	};

	default {
		_side = resistance;
		_helitype = "I_Heli_Transport_02_F";

		switch (_paraType % 3) do
		{
			case 0:
			{
				_helitype = "I_Heli_light_03_F";
				_spawnParaGroup = _paraGroupArray select ((count _paraGroupArray) -1);
				_ropes = [[1.3,1.3,0],[-1.3,1.3,0]];
			};
			case 1:
			{
				_helitype = "I_Heli_light_03_unarmed_F";
				_spawnParaGroup = _paraGroupArray select ((count _paraGroupArray) -1);
				_ropes = [[1.3,1.3,0],[-1.3,1.3,0]];
			};
			case 2:
			{
				_helitype = "I_Heli_Transport_02_F";
				_spawnParaGroup = _paraGroupArray select 0;
				_ropes = [[1,-5,0],[-1,-5,0]];
			};
		};
	};
};


if ( isNil "_spawnParaGroup" ) exitWith { diag_log format ["MCC ERROR: no group found for %1", _this]; };

//Try to find an helicopter from the faction
private ["_minSpaces","_vehiclesTypesArray","_availableSpaces","_newHeliClassesArray","_totalSeats","_crewSeats"];
_minSpaces = switch (_paraType % 3) do {
				case 0: {6};
				case 1: {12};
				default {18};
			};

_vehiclesTypesArray = [_p_mcc_spawnfaction,"helicopterrtd","air"] call MCC_fnc_makeUnitsArray;
if (count _vehiclesTypesArray < 2) then {
	_vehiclesTypesArray = [_p_mcc_spawnfaction,"helicopterrtd"] call MCC_fnc_makeUnitsArray;
};

_vehiclesTypesArray = _vehiclesTypesArray + ([_p_mcc_spawnfaction,"helicopterX"] call MCC_fnc_makeUnitsArray);

_newHeliClassesArray = [];

for "_i" from 0 to (count _vehiclesTypesArray)-1 step 1 do {
	_vehicleClass = (_vehiclesTypesArray select _i) select 0;
    _availableSpaces = [_vehicleClass, "allCargo"] call MCC_fnc_crewCount;

	//if enogh cargo space add it
	if ( _availableSpaces >= _minSpaces) then {
		_newHeliClassesArray pushBack [_availableSpaces, _vehicleClass]
	};
};

if (count _newHeliClassesArray > 0) then {
	_newHeliClassesArray sort true;
	_helitype = (_newHeliClassesArray select 0) select 1;
};

if ( _paraType < 3 ) then {
	_paraMode = 0; // paradrop
	_flyHeight = 400;
} else {
	if ( _paraType < 6 ) then
	{
		_paraMode = 1; // drop-off
	}
	else
	{
		_paraMode = 2; // fast-rope
	};
	_flyHeight = 50;
};

_heli 				= [_helitype, _spawn, _pos, _flyHeight, false, _side] call MCC_fnc_createPlane;
_heliCrew			= group _heli;
_heliPilot			= driver _heli;
crew _heli joinSilent _heliCrew;

if ( _heliType == "I_Heli_Transport_02_F" ) then
{
	if (_paraSide == "EAST") then
	{
		_heli setObjectTextureGlobal [0,'#(rgb,8,8,3)color(0.635,0.576,0.447,0.5)'];
		_heli setObjectTextureGlobal [1,'#(rgb,8,8,3)color(0.635,0.576,0.447,0.5)'];
		_heli setObjectTextureGlobal [2,'#(rgb,8,8,3)color(0.635,0.576,0.447,0.5)'];
	};
	if (_paraSide == "WEST") then
	{
		_heli setObjectTextureGlobal [0,'#(rgb,8,8,3)color(0.960,0.990,0.990,0.1)'];
		_heli setObjectTextureGlobal [1,'#(rgb,8,8,3)color(0.960,0.990,0.990,0.1)'];
		_heli setObjectTextureGlobal [2,'#(rgb,8,8,3)color(0.960,0.990,0.990,0.1)'];
	};
};

_heli setBehaviour "CARELESS";

_heliCrewCount = count (crew _heli);

// In case of drop-off or fast-rope return to start position
if ( _paraMode > 0 ) then {
	_away = _spawn;
	_heli flyInHeight _flyHeight;
	_heliPilot flyInHeight _flyHeight;
};

private ["_cargoNum","_unitsArray","_i","_type","_z","_cargoGroups"];
//--------spawn the jumping group----------------------
_cargoNum = [_helitype, "allCargo"] call MCC_fnc_crewCount; //populate heli before kick off
_cargoGroups = [];

if (_cargoNum > 0) then {

	//Limit group size
	switch (_paraType % 3) do {
		case 0:
		{
			_cargoNum =  _cargoNum min 6
		};

		case 1:
		{
			_cargoNum =  _cargoNum min 12
		};

		default
		{
			_cargoNum =  _cargoNum min 18
		};
	};

	//lets spawn groups
	for "_i" from 0 to (ceil (_cargoNum /6)) step 1 do {

		if !( _customParaGroup ) then {
			_unitspawned=[[100,100,5000], _side, (call compile _spawnParaGroup),[],[],[0.1,(missionNamespace getVariable ["MCC_AI_Skill",0.5])],[],[(6 min _cargoNum), 0]] call MCC_fnc_spawnGroup;
			sleep 0.1;
		} else {

			_unitspawned = createGroup _side;

			for "_z" from 1 to (6 min _cargoNum) step 1 do	{
				_type = _spawnParaGroup select round (random 4);
				_unit = _unitspawned createUnit [_type, _spawn, [], 0.5, "NONE"];

				//Curator
				{_x addCuratorEditableObjects [[_unit],false]} forEach allCurators;
			};
		};

		_cargoGroups pushBack _unitspawned;
		_cargoNum = _cargoNum - (count units _unitspawned);

		{
			_x assignAsCargo _heli;
			_x moveInCargo _heli;
			_x setSkill ["aimingspeed", (missionNamespace getVariable ["MCC_AI_Aim",0.1])];
			_x setSkill ["spotdistance", (missionNamespace getVariable ["MCC_AI_Spot",0.3])];
			_x setSkill ["aimingaccuracy", (missionNamespace getVariable ["MCC_AI_Aim",0.1])];
			_x setSkill ["aimingshake", (missionNamespace getVariable ["MCC_AI_Aim",0.1])];
			_x setSkill ["spottime", (missionNamespace getVariable ["MCC_AI_Spot",0.3])];
			_x setSkill ["commanding", (missionNamespace getVariable ["MCC_AI_Command",0.5])];
			_x setSkill ["general", (missionNamespace getVariable ["MCC_AI_Skill",0.5])];
			/*
				removeBackpack _x;
				_x addBackpack "B_Parachute";
			*/
		} forEach (units _unitspawned);
	};
};

_dropPos = _pos findEmptyPosition [10,150,_heliType];
if ( count _dropPos == 0 ) then { _dropPos = _pos; };

//Set waypoint
_heliCrew move _pos;
(driver _heli) move _pos;

_heli setSpeedMode "FULL";
_heli setDestination [_away, "VehiclePlanned", true];

waitUntil { sleep 1;(driver _heli) move _pos;(_heli distance2d _dropPos) < 100};  // include heli heigth else if flying higher then 250 m this wil be 'true'

//Open doors
[_heli,true] spawn MCC_fnc_heliOpenCloseDoor;

// toss ropes for fast-rope
if ( _paraMode == 2 ) then {

	_heli flyInHeight 35;
	sleep 4;
	doStop (driver _heli);
	_timeOut = time + 10;
	waitUntil { sleep 1; ( (abs(speed _heli) < 0.5) && ((getPos _heli select 2) < 50) )  || !alive _heli || !alive (driver _heli) || time > _timeOut};
	if ( !alive _heli || !alive (driver _heli)) exitWith {};

	{
		_rope = ropeCreate [_heli, _x,55,[10],[10], true];
		_actualRopes set [count _actualRopes, _rope];
		/*
		_rope = createVehicle ["land_rope_f", [0,0,0], [], 0, "CAN_COLLIDE"];
		sleep 0.3;
		_rope allowDamage false;
		_rope disableCollisionWith _heli;
		_actualRopes set [count _actualRopes, _rope];
		_rope setdir (getdir _heli);
		_rope attachto [_heli, _x];
		*/
		sleep 0.5;
	} forEach _ropes;
};

{
	[units _x] allowGetIn false;
	[_x, _heli, _p_mcc_zone_markername, _p_mcc_zone_behavior, _p_mcc_awareness, _paraMode, _paraType, _actualRopes, (_forEachIndex % 2), count _cargoGroups] spawn
	{
		private ["_paraGroup", "_dir", "_p_mcc_zone_markername", "_p_mcc_zone_behavior", "_p_mcc_awareness", "_paraMode", "_paraType",
					"_actualRopes", "_rope", "_index", "_number"];

		_paraGroup 	= _this select 0;
		_heli = (_this select 1);
		_p_mcc_zone_markername = _this select 2;
		_p_mcc_zone_behavior = _this select 3;
		_p_mcc_awareness = _this select 4;
		_paraMode = _this select 5;
		_paraType = _this select 6;
		_actualRopes = _this select 7;
		_index = _this select 8;
		_number = _this select 9;
		_dir = (direction _heli) + 180;

		 switch ( _paraMode ) do
		{
			case 0: // paradrop
			{
				_heli flyInHeight (getPosATL _heli select 2); // to maintain current altitude
				{
					if (typeOf _heli == "I_Heli_Transport_02_F") then
					{
						sleep 1.6;

						_d = if ((speed _heli) <= 40) then {6} else {5};

						_rampOutPos = [_heli, _d, ((getDir _heli) + 180)] call BIS_fnc_relPos;
						_altitude = getPosATL _heli;

						_a = if ((speed _heli) <= 40) then {3} else {0};

						_rampOutPos set [2, ((_altitude select 2) - _a)];

						_x setPosATL _rampOutPos;
						_x setDir ((getDir _heli) + 180);
					}
					else
					{
						sleep 0.8;
					};

					_x allowDamage false;
					_x action ["GETOUT",vehicle _x];
					unassignVehicle _x;
					//_x action ["GetOut",vehicle _x];
					sleep 1;
					_chute = createVehicle ["NonSteerable_Parachute_F", position _x, [], ((_dir)-5+(random 10)), 'NONE'];
					_chute setPos (getPos _x);
					_chute setDir ((_dir)-5+(random 10));
					_x setDir ( direction _chute );
					_chute setPos (getPos _x);
					_x moveindriver _chute;
					(vehicle _x) setDir ((_dir)-5+(random 10));
					_x allowDamage true;
				} foreach (units _paraGroup);
			};

			case 1: // drop-off
			{
				{
					_x allowDamage false;
					unassignVehicle _x;
					waituntil {isTouchingGround _x};
					_x allowDamage true;
				} foreach (units _paraGroup);
			};

			case 2: // fast-rope
			{
				_heli doMove (getPosATL _heli);
				//doStop _heli;
				doStop driver _heli;

				{
					if ( _number > 1 ) then
					{
						_rope = _actualRopes select _index;
					}
					else
					{
						_rope = _actualRopes select (_forEachIndex % 2);
					};

					[_x, _rope] spawn
						{
							private ["_unit", "_zc", "_zdelta", "_rope"];
							_unit = _this select 0;
							_rope = _this select 1;
							_zdelta = 7 / 10;
							_zc = -4;

							if (isNil "_rope") exitWith {};

							_unit action ["GETOUT", vehicle _unit];
							unassignVehicle _unit;
							[compile format ["objectFromNetID '%1' switchmove 'crew_tank01_out'", netID _unit], "BIS_fnc_spawn", true, false] call BIS_fnc_MP;
							//_unit switchmove "crew_tank01_out";

							_unit setpos [(getpos _unit select 0), (getpos _unit select 1), 0 max ((getpos _unit select 2) - 3)];

							while { (alive _unit) && ( (getpos _unit select 2) > 0.3 ) && ( _zc > -55 ) } do
							{
								_unit attachTo [_rope, [0,0,_zc]];
								_zc = _zc - _zdelta;
								sleep 0.1;
							};

							[compile format ["objectFromNetID '%1' switchmove ''", netID _unit], "BIS_fnc_spawn", true, false] call BIS_fnc_MP;
							//_unit switchmove "";
							detach _unit;
						};
					sleep ( 1 + ((random 6)/10) );
				} foreach (units _paraGroup);
			};
		};
	};

	sleep 0.8; // 2nd group will disembark in parallel with offset of 0.8 seconds

} foreach _cargoGroups;

if ( _paraMode > 0 ) then  // Drop-off or fast-rope
{
	// if chopper is still around after 40/70 seconds leave to avoid getting stuck
	if ( _paraMode > 1 ) then {
		_timeOut = time + 40;
	} else {
		_timeOut = time + 70;
	};

	{
		_x setBehaviour "AWARE";
	} foreach _cargoGroups;

	//wait untill all paratroopers are out
	waitUntil { sleep 1; (count crew _heli == _heliCrewCount) || (time > _timeOut);  };

	// toss ropes for fast-rope
	if ( _paraMode == 2 ) then
	{
		//make sure all AI cargo has left the chopper - give 4 seconds for last unit to slide down the rope
		waitUntil { sleep 1; (count crew _heli == _heliCrewCount) || (time > _timeOut + 20);  };
		sleep 4;

		// drop the ropes and delete them
		{
			_attachPoint = _ropes select _forEachIndex;
			_zc = -22;
			while { _zc > -50 } do
			{
				_x attachTo [_heli, [_attachPoint select 0 , _attachPoint select 1,_zc]];
				_zc = _zc - 2;
				sleep 0.1;
			};
			deletevehicle _x;
		} foreach _actualRopes;

		//wait 3 seconds before flying away
		sleep 3;
	};

	_away = _spawn;
	_heli flyInHeight _flyHeight;
	_heliPilot flyInHeight _flyHeight;

	//Set waypoint
	_heli doMove _away;
	_heliPilot doMove _away;
}
else // Paradrop
{
	sleep 10;
	_heli flyInHeight _flyHeight;
	_heliPilot flyInHeight _flyHeight;
};


_heliPilot doMove _away;
_heli setSpeedMode "FULL";
_heli setBehaviour "CARELESS";

_heli setDestination [_away, "VehiclePlanned", true];

//Close doors
[_heli,false] spawn MCC_fnc_heliOpenCloseDoor;

// Allow chopper to leave else AI will board again :-/
sleep 5;

// activate GAIA for each paragroup
if (_p_mcc_zone_behavior in ["bis", "bisd","bisp"]) then {

	[1,_pos,[3,"NO CHANGE","NO CHANGE","FULL","AWARE","true", "",0],_cargoGroups] spawn MCC_fnc_manageWp;

} else {

	{
		private ["_paraGroup"];

		_paraGroup = _x;

		if ( _p_mcc_awareness == "Default" ) then // MM most likely forgot to set awareness - paratroopers are not default :-)
		{
			_p_mcc_awareness = "AWARE";
		};

		//_null = [leader _paraGroup, _p_mcc_zone_markername,_p_mcc_zone_behavior,_p_mcc_awareness,"SHOWMARKER","spawned" ] spawn mcc_ups;
		_paraGroup setVariable ["GAIA_ZONE_INTEND",[_p_mcc_zone_markername,_p_mcc_zone_behavior], true];

	} foreach _cargoGroups;
};

_timeOut = time + 80; // if chopper is still around after 1.2 minute just delete it
waituntil { sleep 1; ( ((_heli distance _away) < ((getPosATL _heli select 2) + 350)) || (time > _timeOut) ); };

{deleteVehicle _x} forEach (crew _heli);
deletegroup (group _heli);	//case we want to delete the whole shabang
deletevehicle _heli;