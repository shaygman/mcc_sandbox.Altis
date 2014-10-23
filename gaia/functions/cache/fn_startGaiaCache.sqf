/*
    Description:
    GAIA cache main Thread.
    Can only be executed by server.

    Parameter(s):
    #0 NUMBER - Idle duration

    Returns:
    nil
*/

if (!isServer) exitWith {};

private ["_idleDuration"];

_idleDuration = [_this, 0, 0.5, [0]] call BIS_fnc_param;

while {true} do
{
	{
		private ["_group"];
		_group = _x;
		if ((count units _group) > 0 && alive leader _group) then
		{
			call {
				private ["_gaiaCachedStage1", "_isClose", "_behaviour", "_gaiaZoneIntend", "_gaiaPortfolio"];
				_gaiaCachedStage1 = _x getVariable ["GAIA_CACHED_STAGE_1", false];
				_isClose = [getPosATL leader _group, GAIA_CACHE_STAGE_1] call GAIA_fnc_isNearPlayer;
				_behaviour = behaviour leader _group;
				_gaiaZoneIntend = _group getVariable ["GAIA_zone_intend", []];
				_gaiaPortfolio = _group getVariable ["GAIA_Portfolio", []];

				if (!_gaiaCachedStage1 && !_isClose && _behaviour != "COMBAT" && ((count _gaiaZoneIntend > 1 && !("DoMortar" in _gaiaPortfolio) && !("DoArtillery" in _gaiaPortfolio)) || count _gaiaZoneIntend == 0))
					exitWith {_group spawn GAIA_fnc_cache};
				if (_gaiaCachedStage1 && _isClose)
					exitWith {_group spawn GAIA_fnc_uncache};
				if (_gaiaCachedStage1 && _behaviour == "COMBAT")
					exitWith {_group spawn GAIA_fnc_uncache};
				_group spawn GAIA_fnc_syncCachedGroup;
			};

			if (!([getPosATL leader _group, GAIA_CACHE_STAGE_2] call GAIA_fnc_isNearPlayer)) then {[_group] call GAIA_fnc_cacheFar};
		};
		sleep 0.1;
	} forEach ([allGroups, {_x getVariable ["mcc_gaia_cache", false]}] call BIS_fnc_conditionalSelect);

	{
		if ([_x, GAIA_CACHE_STAGE_2] call GAIA_fnc_isNearPlayer) then
		{
			[missionNamespace getVariable [format ["GAIA_CACHE_%1", str _x], [0, 0, 0]]] call GAIA_fnc_uncacheFar;
			MCC_GAIA_CACHE_STAGE2 set [_forEachIndex, objNull];
		};
	} forEach MCC_GAIA_CACHE_STAGE2;

	MCC_GAIA_CACHE_STAGE2 = MCC_GAIA_CACHE_STAGE2 - [objNull];

	{
		if ([_x, GAIA_CACHE_STAGE_2] call GAIA_fnc_isNearPlayer) then
		{
			private ["_delayed"];
			_delayed = missionNamespace getVariable [format ["MCC_DELAY%1", str _x], [0, 0, 0]];
			_delayed set [27, false];
			[_delayed, "mcc_setup", false, false] spawn BIS_fnc_MP;
			MCC_DELAYED_SPAWNS set [_forEachIndex, objNull];
		};
	} forEach MCC_DELAYED_SPAWNS;

	MCC_DELAYED_SPAWNS = MCC_DELAYED_SPAWNS - [objNull];

	sleep _idleDuration;
};
