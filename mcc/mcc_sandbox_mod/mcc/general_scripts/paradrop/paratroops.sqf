//Initialize
private ["_away","_p_mcc_zone_markername","_heli","_heliCrew""_helocargo","_pos","_a","_helitype",
         "_heli_pilot","_spawn","_heliPilot","_gunnersGroup","_type","_entry","_turrets","_path","_unit"];
		 
_pos 					= _this select 0;
_a 						= _this select 1;
_b 						= _this select 2;
_p_mcc_zone_markername  = _this select 3;  
_p_mcc_zone_behavior	= _this select 4;
_p_mcc_awareness		= _this select 5;

_spawn = [(_pos select 0)+1500,_pos select 1,(_pos select 2) + 800];
_away  = [(_pos select 0)-1500,_pos select 1,_pos select 2];

switch (_a) do {
		case 1:
			{
			_side = west;
			_helitype = if (_b=="2") then {"B_Heli_Transport_01_F"} else {"B_Heli_Light_01_F"};
			};
			
		case 2:
			{
			_side = east;
			_helitype = if (_b=="2") then {"O_Heli_Attack_02_F"} else {"O_Heli_Light_02_F"};
			};
				
		case 3:
			{
			_side = resistance;
			_helitype = if (_b=="2") then {"I_Heli_Transport_02_F"} else {"I_Heli_Transport_02_F"};
			};
		default
			{
			_side = resistance;
			_helitype = "I_Heli_Transport_02_F";
			};
		};

		
_heli 				= [_heliType, _spawn, _pos, 200, false] call MCC_fnc_createPlane;		
_heliCrew			= group _heli;
_heliPilot			= driver _heli;

_heliCrew setbehaviour "CARELESS";
group _heli setBehaviour "CARELESS";

/*
_gunnersGroup = creategroup _side;											 //Create gunners group
_gunnersGroup setbehaviour "combat";										//Make the gunners aggresive
_gunnersGroup setcombatmode "yellow";

//--------spawn the gunners group----------------------	
_type = typeOf _heli;														//Find turrets
_entry = configFile >> "CfgVehicles" >> _type;
_turrets = [_entry >> "turrets"] call BIS_fnc_returnVehicleTurrets;			//All turrets were found, now spawn crew for them
_path = [];
private ["_i"];
_i = 0;
while {_i < (count _turrets)} do
{
	private ["_turretIndex", "_thisTurret"];
	_turretIndex = _turrets select _i;
	_thisTurret = _path + [_turretIndex];
	if (isNull (_heli turretUnit _thisTurret)) then 
	{
		_unit = _gunnersGroup createUnit [_heli_pilot, _spawn, [], 0, "NONE"]; //Spawn unit into this turret, if empty.
		_unit moveInTurret [_heli, _thisTurret];
	};
	_i = _i + 2;
};		
*/

private ["_cargoNum","_unitsArray","_i","_type"];
//--------spawn the jumping group----------------------		
_cargoNum = _heli emptyPositions "cargo"; //populate heli before kick off
_cargoUnits = [];
if (_cargoNum > 0) then	{
	_unitsArray	= [faction _heli,"soldier"] call MCC_fnc_makeUnitsArray;	//Let's build the faction unit's array
	_helocargo = creategroup side _heli;
	for [{_i=1},{_i<=_cargoNum},{_i=_i+1}] do {
		_type = _unitsArray select round (random 4); 
		_unit = _helocargo createUnit [_type select 0,_spawn,[],0.5,"NONE"];
		_cargoUnits set  [count _cargoUnits,_unit];
		sleep 0.1;
	};
	{
		_x assignAsCargo _heli;
		_x moveInCargo _heli;
		_x setSkill ["aimingspeed", MCC_AI_Aim];
		_x setSkill ["spotdistance", MCC_AI_Spot];
		_x setSkill ["aimingaccuracy", MCC_AI_Aim];
		_x setSkill ["aimingshake", MCC_AI_Aim];
		_x setSkill ["spottime", MCC_AI_Spot];
		_x setSkill ["commanding", MCC_AI_Command];
		_x setSkill ["general", MCC_AI_Skill];
		
	} forEach _cargoUnits;
};

//Set waypoint
_heliCrew move _pos;

waitUntil {(_heli distance _pos) < 500};

[_cargoUnits] spawn {
		private ["_cargo","_chute"];
		_cargo 	= _this select 0;
		
		{
			unassignvehicle _x;    
            _x allowDamage false; 
            _x action ["EJECT", vehicle _x];
			sleep 1;
			_chute = createVehicle ["NonSteerable_Parachute_F", position _x, [], ((direction vehicle _x)-5+(random 10)), 'NONE'];
			_chute setPos (getPos _x);
			_x moveindriver _chute;
			sleep 1;
			_x allowDamage true;
		} foreach _cargo;
	};

if (! isnil "_helocargo") then {
	_null = [leader (_helocargo), _p_mcc_zone_markername,_p_mcc_zone_behavior,_p_mcc_awareness,"SHOWMARKER","spawned" ] spawn mcc_ups;
	};
	
_heliCrew move _away;
_heliPilot domove _away;
waituntil {(_heli distance _away) < 400};

{deleteVehicle _x} forEach (crew _heli);
deletegroup (group _heli);	//case we want to delete the whole shabang
deletevehicle _heli;