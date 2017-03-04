/*============================================================MCC_fnc_ambientBirdsSpawnInit==============================================================================
// Init birds spawn on server
// <IN> Nothing
// <OUT> Nothing
//==================================================================================================================================================================*/

//If we came here from Zeus run on the server
if !(isnull curatorcamera) exitWith {
	[] remoteExec ["MCC_fnc_ambientBirdsSpawnInit", 2];
	deleteVehicle (param [0,objNull,[objNull]]);
};

if  (!isServer || (missionNamespace getVariable ["MCC_fnc_ambientBirdsSpawnInitRuning",false])) exitWith {};
missionNamespace setVariable ["MCC_fnc_ambientBirdsSpawnInitRuning",true];

private ["_unit"];
while {(missionNamespace getVariable ["MCC_fnc_ambientBirdsSpawnInitRuning",false])} do {
	{
		_unit = [units _x] call BIS_fnc_selectRandom;
		if ((_unit getVariable ["MCC_fnc_ambientBirdsNextTime",time]) <= time &&
		    !(vehicle _unit isKindOf "air")) then {

			if ((random (speed _unit) min 9) > 4.3) then {
				_unit setVariable ["MCC_fnc_ambientBirdsNextTime",time+(random 200)];
				[vehicle _unit] spawn MCC_fnc_ambientBirdsSpawn;
			};
		};
	} forEach allGroups;

	sleep (random 200);
};
