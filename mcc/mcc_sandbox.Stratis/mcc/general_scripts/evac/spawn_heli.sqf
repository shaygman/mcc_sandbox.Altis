private ["_heliType","_pos", "_dummy", "_dir","_gunNum","_type","_entry","_side","_gunnersGroup","_evac","_evac_p"];

_heliType 	= _this select 0; 	//Type of heli
_pos 		= _this select 1;

{deleteVehicle _x} forEach (crew _evac);	//Delete previous _evac chopper
deletegroup evac_group;	
deletevehicle _evac;
deletevehicle _evac_p;

evac_p_type = getText (configFile >> "CfgVehicles" >> _heliType >> "crew");
_side =  getNumber (configFile >> "CfgVehicles" >> _heliType >> "side");
switch (_side) do	{
	case 0:					//east
		{ 
			_side = east;
		};
		
	case 1:					//west
		{ 
			_side = west;
		};
		
	case 2:					//GUR
		{ 
			_side = resistance;
		};
		
	case 3:					//Civilian
		{ 
			_side = civilian;
		};
	};

_evac = _heliType createVehicle [_pos select 0, _pos select 1, 500]; 				//spawn heli
_evac setposatl _pos;
/*
if ((_pos distance getmarkerpos "pos4")<20) then {									//Spawn oh LHD or on position
	_evac setposasl [_pos select 0, _pos select 1, 17];
	if (((getdir deck) + 180) > 360) then {_dir = (getdir deck + 180)- 360;} else {_dir = getdir deck + 180};
	_evac setdir _dir;
} else	{_evac setposatl _pos};*/
	
clearMagazineCargoGlobal _evac;
if (ACEIsEnabled) then {_evac addMagazineCargoGlobal ["ACE_Rope_M_120",2]};	//ACE: Adde rope 
evac_group = creategroup _side; 											//Create side for the pilot's group
_evac_p = evac_group createUnit [evac_p_type, _pos, [], 0, "NONE"];			//spawn pilot
evac_group setbehaviour "stealth";
evac_group setcombatmode "yellow";
_evac_p assignAsDriver _evac; 												//Move the pilot in
_evac_p moveindriver _evac;
group _evac setBehaviour "CARELESS";
_gunnersGroup = creategroup _side;											 //Create gunners group
_gunnersGroup setbehaviour "combat";										//Make the gunners aggresive
_gunnersGroup setcombatmode "yellow";
_type = typeOf _evac;														//Find turrets
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
	if (isNull (_evac turretUnit _thisTurret)) then 
	{
		_unit = _gunnersGroup createUnit [evac_p_type, _pos, [], 0, "NONE"]; //Spawn unit into this turret, if empty.
		_unit moveInTurret [_evac, _thisTurret];
	};
	_i = _i + 2;
};

MCC_evacVehicles set [count MCC_evacVehicles, _evac];
publicvariable "MCC_evacVehicles"; 