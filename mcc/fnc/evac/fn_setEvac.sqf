//===================================================================MCC_fnc_setEvac======================================================================================
//	Sets an empty ot AI vehicle into an ecav for a specific side
// Example:[[_object, _side, _addGunners,_campaignEvac],"MCC_fnc_setEvac",false,false] spawn BIS_fnc_MP;
// Params:
//	_object:		OBJECT the evac vehicle can be empty
// 	_side: 			SIDE, Evac Side
// 	_addGunners: 	BOOLEAN, if true will spawn gunners to available vehicle's turrets
//	_campaignEvac: 	BOOLEAN if set to true the evac will respawn every day while the MCC campaign is running
//==============================================================================================================================================================================
private ["_gunnersGroup","_side","_type","_entry","_turrets","_path","_pilotClass","_evacVehicles","_addGunners","_object","_pos"];
_object =  [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_side =  [_this, 1, west] call BIS_fnc_param;
_addGunners =  [_this, 2, true, [true]] call BIS_fnc_param;
_campaignEvac = [_this, 3, false, [false]] call BIS_fnc_param;

_pos = getpos _object;
_gunnersGroup = creategroup _side;											 //Create gunners group
_gunnersGroup setbehaviour "AWARE";										//Make the gunners aggresive
_gunnersGroup setcombatmode "red";
_type = typeOf _object;														//Find turrets
_entry = configFile >> "CfgVehicles" >> _type;
_pilotClass = getText (configFile >> "CfgVehicles" >> _type >> "crew");
_turrets = [_entry >> "turrets"] call BIS_fnc_returnVehicleTurrets;			//All turrets were found, now spawn crew for them
_path = [];

private ["_i","_index","_turretIndex", "_thisTurret","_isCargo","_turretPath","_unit"];
_i = 0;
_index = 0;

//spawn driver if needed
if (isnull (driver _object)) then {
	_unit = (creategroup _side) createUnit [_pilotClass, _pos, [], 0, "NONE"];
	_unit assignAsDriver _object;
	_unit moveInDriver _object;
	(group _unit) setbehaviour "CARELESS";
	(group _unit) setcombatmode "yellow";
	_unit setSkill 1;
};

if (_addGunners) then {
	while {_i < (count _turrets)} do {
		_turretIndex = _turrets select _i;
		_thisTurret = _path + [_turretIndex];
		_turretPath = configName ((configFile >> "CfgVehicles" >> _type >> "turrets") Select _index);

		_isCargo = ["cargo",tolower _turretPath] call BIS_fnc_inString;
		if (isNull (_object turretUnit _thisTurret) && !_isCargo) then
		{
			_unit = _gunnersGroup createUnit [_pilotClass, _pos, [], 0, "NONE"]; //Spawn unit into this turret, if empty.
			_unit assignAsGunner _object;
			_unit moveInTurret [_object, _thisTurret];
			_unit setSkill 1;
		};
		_i = _i + 2;
		_index = _index + 1;
	};
};

_object setVariable ["MCC_evacStartPos", getposATL _object, true];

_evacVehicles = missionNamespace getvariable [format ["MCC_evacVehicles_%1",_side],[]];

//remove dead evac
{
	if (!(alive _x) || !(alive driver _x) || isNull _x) then {
		_evacVehicles set [_foreachIndex, -1];
	};
} forEach _evacVehicles;

_evacVehicles = _evacVehicles - [-1];
_evacVehicles pushBack _object;

missionNamespace setvariable ([format ["MCC_evacVehicles_%1",_side],_evacVehicles]);
publicvariable (format ["MCC_evacVehicles_%1",_side]);

MCC_curator addCuratorEditableObjects [[_object],true];

//If campaignEvac then spawn evac every day
if (_campaignEvac) then {
	private ["_varName"];
	_varName = format ["MCC_campaignEvac_%1", _side];
	_evacVehicles = missionNamespace getVariable [_varName,[]];
	_evacVehicles pushBack [_object,_type,_pos];
	missionNamespace setVariable [_varName,_evacVehicles];

	[_object] spawn {
	private ["_evac","_side","_displayName"];
		_evac = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
		_side = [_this, 1, west] call BIS_fnc_param;
		_displayName = getText(configFile >> "CfgVehicles">> typeof _evac >> "displayname");
		while {(alive _evac && (alive driver _evac))} do {sleep 10};

		[["MCCNotificationBad",["Evac",format ["%1 Evac is down",_displayName],""]], "bis_fnc_showNotification", _side, false] spawn BIS_fnc_MP;
	};
};

