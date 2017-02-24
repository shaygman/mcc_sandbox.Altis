private ["_heliType","_pos", "_dummy", "_dir","_gunNum","_type","_entry","_side","_gunnersGroup","_evac","_evac_p","_turretPath","_isCargo","_index"];

_heliType 	= _this select 0; 	//Type of heli
_pos 		= _this select 1;

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
if (surfaceIsWater _pos) then
{
	_evac setposasl _pos;
}
else
{
	_evac setposatl _pos;
};

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
_index = 0;

while {_i < (count _turrets)} do
{
	private ["_turretIndex", "_thisTurret"];
	_turretIndex = _turrets select _i;
	_thisTurret = _path + [_turretIndex];
	_turretPath = configName ((configFile >> "CfgVehicles" >> _type >> "turrets") Select _index);

	_isCargo = ["cargo",tolower _turretPath] call BIS_fnc_inString;
	if (isNull (_evac turretUnit _thisTurret) && !_isCargo) then
	{
		_unit = _gunnersGroup createUnit [evac_p_type, _pos, [], 0, "NONE"]; //Spawn unit into this turret, if empty.
		_unit moveInTurret [_evac, _thisTurret];
	};
	_i = _i + 2;
	_index = _index + 1;
};

_evac setVariable ["MCC_evacStartPos", getposATL _evac, true];
MCC_evacVehicles set [count MCC_evacVehicles, _evac];
publicvariable "MCC_evacVehicles";

{_x addCuratorEditableObjects [[_evac],false]} forEach allCurators;