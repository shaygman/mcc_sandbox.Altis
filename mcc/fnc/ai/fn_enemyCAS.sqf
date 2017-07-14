//======================================================MCC_fnc_enemyCAS================================================================================================
// Create CAS in zone while radio tower is available
// Example:[_tower] spawn MCC_fnc_enemyCAS;
// _tower 	OBJECT  while object alive
// Return - nothing
//=======================================================================================================================================================================
private ["_tower","_sideEnemy","_factionEnemy","_sidePlayer","_casArray","_heliArray","_spawnPos","_casGroup","_IsCAS","_vehicleClass","_casType","_cas","_casVehicle","_casPilot","_ClosestZone","_totalCASActive","_tempArray"];
_tower = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_sideEnemy = [_this, 1, east] call BIS_fnc_param;
_factionEnemy = [_this, 2, "OPF_F", [""]] call BIS_fnc_param;
_sidePlayer = [_this, 3, west] call BIS_fnc_param;

_totalCASActive = missionNamespace getVariable ["MCC_totalCASActive",0];
if (_totalCASActive > 0) exitWith {};
_totalCASActive = _totalCASActive +1;
missionNamespace setVariable ["MCC_totalCASActive",_totalCASActive];

_casArray = [];
{
	if (((getNumber(configFile >> "CfgVehicles" >> _x select 1 >> "isUav")) !=1) && count (getArray(configfile >> "CfgVehicles" >> _x select 1 >> "magazines")) >1) then {_casArray pushBack _x};
} foreach MCC_MWunitsArrayAir;

_heliArray = [];
{
	if (((getNumber(configFile >> "CfgVehicles" >> _x select 1 >> "isUav")) !=1) && count (getArray(configfile >> "CfgVehicles" >> _x select 1 >> "magazines")) >1) then {_heliArray pushBack _x};
} foreach MCC_MWunitsArrayHeli;

//No CAS to this faction
if (count _casArray == 0 && count _heliArray == 0) exitWith {};

_IsCAS = (random 1 > 0.5 && (count _casArray > 0 || count _heliArray == 0));
_spawnPos = [_tower, 5000, random 360] call BIS_fnc_relPos;
_casType = if (_IsCAS) then {(_casArray call bis_fnc_selectRandom)} else {(_heliArray call bis_fnc_selectRandom)};
_vehicleClass = _casType select 1;

_cas = [_spawnPos,([_spawnPos, _tower] call BIS_fnc_dirTo), _vehicleClass, _sideEnemy] call BIS_fnc_spawnVehicle;

_casVehicle = _cas select 0;
_casPilot = driver _casVehicle;
_casGroup = _cas select 2;

_casVehicle allowCrewInImmobile TRUE;
_casVehicle lock 2;
{_x addCuratorEditableObjects [[_casVehicle],true]} forEach allCurators;


if (_IsCAS) then {
	//Cas
	_casVehicle flyInHeight 1000;
	_casGroup setCombatMode "RED";
	_casGroup setBehaviour "COMBAT";
	_casGroup setSpeedMode "FULL";

	[_casGroup,getpos _tower] call BIS_fnc_taskAttack;

} else {
	//Heli

	//GAIA refuse to work
	_tempArray = [];
	{
		if (_forEachIndex != 0) then {_tempArray pushBack [_x distance _tower, str _forEachIndex]};
	} forEach mcc_zone_pos;
	_tempArray sort true;
	_ClosestZone = (_tempArray select 0)select 1;

	//Give to GAIA
	_casGroup setVariable ["GAIA_ZONE_INTEND",[_ClosestZone,"MOVE"], true];
	/*
	_casGroup setCombatMode "RED";
	_casGroup setBehaviour "COMBAT";
	_casGroup setSpeedMode "FULL";

	[_casGroup,getpos _tower] call BIS_fnc_taskAttack;
	*/
};

[_casVehicle,_casPilot,_IsCAS,_sidePlayer] spawn {
		private ["_casVehicle","_targetList","_casPilot","_IsCAS","_totalCASActive","_sidePlayer"];
		_casVehicle = _this select 0;
		_casPilot = _this select 1;
		_IsCAS = _this select 2;
		_sidePlayer = _this select 3;

		[["MCCNotificationBad",["CAS","Enemy CAS approaching",""]], "bis_fnc_showNotification", _sidePlayer, false] spawn BIS_fnc_MP;

		while {(alive _casVehicle)} do {
			_casVehicle setVehicleAmmo 1;
			_casVehicle setFuel 1;
			if (_IsCAS) then {
				_targetList = (getPosATL _casVehicle) nearEntities [["Air"],7500];
				{_casVehicle reveal [_x,4];} count _targetList;
			};
			sleep 60;
		};

		[["MCCNotificationGood",["CAS","Enemy CAS down",""]], "bis_fnc_showNotification", _sidePlayer, false] spawn BIS_fnc_MP;

		sleep 30;
		if (!isNull _casVehicle) then {deleteVehicle _casVehicle;};
		if (!isNull _casPilot) then {deleteVehicle _casPilot;};
		_totalCASActive = missionNamespace getVariable ["MCC_totalCASActive",0];

		missionNamespace setVariable ["MCC_totalCASActive",(_totalCASActive-1)];
};