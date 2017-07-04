/*
ToDo:

for heli
_exp = "(1 + meadows) * (1 - houses) * (1 - forest) * (1 - hills)";

_bestplace = selectBestPlaces [_pos,_radius,_exp,10,1];

_isFlat = (position _preview) isflatempty [
		(sizeof typeof _preview) / 2,	//--- Minimal distance from another object
		0,				//--- If 0, just check position. If >0, select new one
		0.7,				//--- Max gradient
		(sizeof typeof _preview),	//--- Gradient area
		0,				//--- 0 for restricted water, 2 for required water,
		false,				//--- True if some water can be in 25m radius
		_preview			//--- Ignored object
	];

*/

//Initialize
private ["_away","_p_mcc_zone_markername","_heli","_heliCrew""_helocargo","_pos","_paraSide", "_paraType", "_helitype",
         "_heli_pilot","_spawn","_heliPilot","_gunnersGroup","_type","_entry","_turrets","_path", "_timeOut",
		 "_unit", "_side", "_spawnParaGroup", "_paraGroupArray", "_paraGroup", "_paraMode", "_heliCrewCount",
		 "_p_mcc_spawnfaction", "_p_mcc_zone_behavior", "_p_mcc_awareness", "_newParaGroup", "_rampOutPos", "_flyHeight",
		 "_dropPos", "_rope", "_ropes"
		 ];

_pos 					= _this select 0;
_paraSide				= _this select 1;
_paraType 				=  if (TypeName  (_this select 2) == "STRING") then {call compile (_this select 2)} else {(_this select 2)};
_p_mcc_zone_markername  = _this select 3;
_p_mcc_zone_behavior	= _this select 4;
_p_mcc_awareness		= _this select 5;
_p_mcc_spawnfaction		= _this select 6;
_startPosDir			= _this select 7;

if ( isNil "_startPosDir" ) then
{
	_spawn = [(_pos select 0)+1000,_pos select 1,(_pos select 2) + 100];
	_away  = [(_pos select 0)-2000,_pos select 1,(_pos select 2) + 100];
}
else
{
	_spawndir = [_pos, _startPosDir] call BIS_fnc_dirTo;
	_spawn = [_pos,2000,_spawndir] call BIS_fnc_relpos;
	_away  = [_pos,2000,_spawndir - 180] call BIS_fnc_relpos;
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
	if ( ((_x select 3) == "Rifle Squad") || ((_x select 3) == "Recon Team") ) then
	{
		_paraGroupArray set [count _paraGroupArray, format ["%1", ( _x select 2)]];
	};
} forEach ([_paraSide,_p_mcc_spawnfaction,"Infantry","LAND"] call mcc_make_array_grps);

if ( (count _paraGroupArray) == 0 ) then
{
	_customParaGroup = true;
	_unitsArray = [];

	//Let's build the faction unit's array
	{
		_unitsArray	set [ count _unitsArray, _x select 0];
	} foreach ( [_p_mcc_spawnfaction,"soldier"] call MCC_fnc_makeUnitsArray );

	//diag_log format ["MCC paradrop custom array: %1", _unitsArray];

	if ( (count _unitsArray) == 0 ) exitWith {};

	_paraGroupArray set [0, _unitsArray];

	//diag_log format ["MCC paradrop custom array: %1", count _paraGroupArray];
};

if ( (count _paraGroupArray) == 0 ) exitWith { diag_log format ["MCC Warning: no suitable paratrooper group found for %1", _this]; player groupChat format ["Error: no suitable paratrooper group for this Faction"]; };

switch (_paraSide) do
	{
		case "WEST":
		{
			_side = west;
			switch (_paraType % 3) do
			{
				case 0: // 0, 3, 6
				{
					_helitype = "B_Heli_Light_01_F";
					//_spawnParaGroup = _paraGroupArray select 1;
					_spawnParaGroup = _paraGroupArray select ((count _paraGroupArray) -1);
					_ropes = [[0.6,0.5,-25.9],[-0.8,0.5,-25.9]];
				};
				case 1: // 1, 4, 7
				{
					_helitype = "B_Heli_Transport_01_F";
					_spawnParaGroup = _paraGroupArray select ((count _paraGroupArray) -1);
					_ropes = [[-1.11,2.5,-24.7],[1.11,2.5,-24.7]];
				};
				case 2: // 2, 5, 8
				{
					_helitype = "I_Heli_Transport_02_F";
					_spawnParaGroup = _paraGroupArray select 0;
					_ropes = [[1,-5,-26],[-1,-5,-26]];
				};
			};
		};

		case "EAST":
		{
			_side = east;
			switch (_paraType % 3) do
			{
				case 0:
				{
					_helitype = "O_Heli_Attack_02_F";
					_spawnParaGroup = _paraGroupArray select ((count _paraGroupArray) - 1);
					_ropes = [[1.35,1.35,-24.95],[-1.45,1.35,-24.95]];
				};
				case 1:
				{
					_helitype = "O_Heli_Light_02_F";
					_spawnParaGroup = _paraGroupArray select ((count _paraGroupArray) -1);
					//_ropes = [[1.3,1.3,-25],[-1.3,1.3,-25]];
					_ropes = [[1.3,1.3,-25],[-1.3,1.3,-25]];
				};
				case 2:
				{
					_helitype = "I_Heli_Transport_02_F";
					_spawnParaGroup = _paraGroupArray select 0;
					_ropes = [[1,-5,-26],[-1,-5,-26]];
				};
			};
		};

		case "GUE":
		{
			_side = resistance;
			_helitype = "I_Heli_Transport_02_F";

			switch (_paraType % 3) do
			{
				case 0:
				{
					_helitype = "I_Heli_light_03_F";
					_spawnParaGroup = _paraGroupArray select ((count _paraGroupArray) -1);
					_ropes = [[1.3,1.3,-25],[-1.3,1.3,-25]];
				};
				case 1:
				{
					_helitype = "I_Heli_light_03_unarmed_F";
					_spawnParaGroup = _paraGroupArray select ((count _paraGroupArray) -1);
					_ropes = [[1.3,1.3,-25],[-1.3,1.3,-25]];
				};
				case 2:
				{
					_helitype = "I_Heli_Transport_02_F";
					_spawnParaGroup = _paraGroupArray select 0;
					_ropes = [[1,-5,-26],[-1,-5,-26]];
				};
			};
		};
	};


if ( isNil "_spawnParaGroup" ) exitWith { diag_log format ["MCC ERROR: no group found for %1", _this]; };


if ( _paraType < 3 ) then
{
	_paraMode = 0; // paradrop
	_flyHeight = 400;
}
else
{
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

_heli 				= [_heliType, _spawn, _pos, _flyHeight, false, _side] call MCC_fnc_createPlane;
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
if ( _paraMode > 0 ) then
{
	_away = _spawn;
	_heli flyInHeight _flyHeight;
	_heliPilot flyInHeight _flyHeight;
};

private ["_cargoNum","_unitsArray","_i","_type"];
//--------spawn the jumping group----------------------
_cargoNum = _heli emptyPositions "cargo"; //populate heli before kick off
_cargoUnits = [];
_cargoGroups = [];

if (_cargoNum > 0) then
{
	//_unitsArray	= [faction _heli,"soldier"] call MCC_fnc_makeUnitsArray;	//Let's build the faction unit's array
	_helocargo = creategroup side _heli;

	_cargoEmtpy = _cargoNum;

	// small
	if ( ( (_paraType % 3) == 0 ) && ( _cargoNum >= 6 ) ) then
	{
		_cargoEmtpy = 6;
	};
	// QRF
	if ( ( (_paraType % 3) == 1 ) && ( _cargoNum >= 12 ) ) then
	{
		_cargoEmtpy = 12;
	};


	While { true } do
	{
		if !( _customParaGroup ) then
		{
			_unitspawned=[[100,100,5000], _side, (call compile _spawnParaGroup),[],[],[0.1,(missionNamespace getVariable ["MCC_AI_Skill",0.5])],[],[_cargoEmtpy, 0]] call BIS_fnc_spawnGroup;
			sleep 0.1;
		}
		else
		{
			_newParaGroup = grpNull;
			_newParaGroup = createGroup _side;
			for [{_i=0},{_i<=12},{_i=_i+1}] do
			{
				if ( _cargoEmtpy > 0 ) then
				{
					//diag_log format ["MCC paradrop custom group array: %1", _spawnParaGroup];
					_type = _spawnParaGroup select round (random 4);
					_unit = _newParaGroup createUnit [_type, _spawn, [], 0.5, "NONE"];
				};
			};

			_unitspawned = _newParaGroup;
		};

		{
			_cargoUnits set [count _cargoUnits,_x];
		} forEach (units _unitspawned);

		_cargoGroups set [count _cargoGroups,_unitspawned];
		_cargoEmtpy = _cargoEmtpy - (count _cargoUnits);

		//diag_log format ["Spawned: %1 - %2 - %3 - %4", count (units _unitspawned), count _cargoUnits, _cargoEmtpy, (units _unitspawned)];

		// if only 1 or 2 seats left do not create a 1 or 2-man group but leave seat(s) empty
		if ( _cargoEmtpy < 3 ) exitWith {};  // { diag_log format ["Spawned: aborting: %1", _cargoEmtpy]; };
	};

	//diag_log format ["Paradrop: %1 - %2 - %3", _cargoNum, count _cargoUnits, _cargoUnits];

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
		removeBackpack _x;
		//_x addBackpack "B_Parachute";
	} forEach _cargoUnits;
};

_dropPos = _pos findEmptyPosition [10,150,_heliType];
if ( count _dropPos == 0 ) then { _dropPos = _pos; };

//Set waypoint
_heliCrew move _pos;
(driver _heli) move _pos;

_heli setSpeedMode "FULL";
_heli setDestination [_away, "VehiclePlanned", true];

waitUntil { sleep 1;(_heli distance _dropPos) < ((getPosATL _heli select 2) + 150)};  // include heli heigth else if flying higher then 250 m this wil be 'true'

_heli animateDoor ["door_R", 1];
_heli animateDoor ["door_L", 1];

if (typeOf _heli == "I_Heli_Transport_02_F") then
{
	_heli animate ["CargoRamp_Open", 0.5];
	sleep 2;
};

if ( _paraMode == 2 ) then  // toss ropes for fast-rope
{

	_heli flyInHeight 20;
	sleep 4;
	doStop (driver _heli);
	waitUntil { sleep 1; ( (abs(speed _heli) < 0.5) && ((getPosATL _heli select 2) < 25) ) };

	{
		_rope = createVehicle ["land_rope_f", [0,0,0], [], 0, "CAN_COLLIDE"];
		sleep 0.3;
		_rope allowDamage false;
		_rope disableCollisionWith _heli;
		_actualRopes set [count _actualRopes, _rope];
		_rope setdir (getdir _heli);
		_rope attachto [_heli, _x];

		sleep 0.5;
	} forEach _ropes;
};

{

	[_x, _heli, _p_mcc_zone_markername, _p_mcc_zone_behavior, _p_mcc_awareness, _paraMode, _paraType, _actualRopes, _forEachIndex, count _cargoGroups] spawn
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
					unassignVehicle _x;
					_x action ["EJECT",vehicle _x];
					//_x action ["GetOut",vehicle _x];

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
					unassignVehicle _x;
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
							_zc = 22;

							unassignVehicle _unit;
							_unit action ["eject", vehicle _unit];
							_unit switchmove "gunner_standup01";

							_unit setpos [(getpos _unit select 0), (getpos _unit select 1), 0 max ((getpos _unit select 2) - 3)];

							while { (alive _unit) && ( (getpos _unit select 2) > 1 ) && ( _zc > -24 ) } do
							{
								_unit attachTo [_rope, [0,0,_zc]];
								_zc = _zc - _zdelta;
								sleep 0.1;
							};

							_unit switchmove "";
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
	if ( _paraMode > 1 ) then
	{
		_timeOut = time + 40;
	}
	else
	{
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
	_heli flyInHeight _flyHeight;
	_heliPilot flyInHeight _flyHeight;
};


_heliPilot doMove _away;
_heli setSpeedMode "FULL";
_heli setBehaviour "CARELESS";

_heli setDestination [_away, "VehiclePlanned", true];


_heli animateDoor ["door_R", 0];
_heli animateDoor ["door_L", 0];
_heli animate ["CargoRamp_Open", 0];

// Allow chopper to leave else AI will board again :-/
sleep 5;

// activate UPSMON for each paragroup
if (_p_mcc_zone_behavior != "bis" && _p_mcc_zone_behavior != "bisd" && _p_mcc_zone_behavior != "bisp") then
{
	{
		private ["_paraGroup"];

		_paraGroup = _x;

		if ( _p_mcc_awareness == "Default" ) then // MM most likely forgot to set awareness - paratroopers are not default :-)
		{
			_p_mcc_awareness = "AWARE";
		};

		_null = [leader _paraGroup, _p_mcc_zone_markername,_p_mcc_zone_behavior,_p_mcc_awareness,"SHOWMARKER","spawned" ] spawn mcc_ups;

	} foreach _cargoGroups;
};

_timeOut = time + 80; // if chopper is still around after 1.2 minute just delete it
waituntil { sleep 1; ( ((_heli distance _away) < ((getPosATL _heli select 2) + 350)) || (time > _timeOut) ); };

{deleteVehicle _x} forEach (crew _heli);
deletegroup (group _heli);	//case we want to delete the whole shabang
deletevehicle _heli;
