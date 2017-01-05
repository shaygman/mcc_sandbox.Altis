/*============================================================MCC_fnc_ambientBirdsSpawnInit==============================================================================
// Init birds spawn on server
// <IN> Nothing
// <OUT> Nothing
//==================================================================================================================================================================*/

//If we came here from Zeus run on the server
if !(isnull curatorcamera) exitWith {
	[] remoteExec ["MCC_fnc_ambientBirdsSpawnInit", 2];
};

if  (!isServer || (missionNamespace getVariable ["MCC_fnc_ambientBirdsSpawnInitRuning",false])) exitWith {};
missionNamespace setVariable ["MCC_fnc_ambientBirdsSpawnInitRuning",true];

private ["_unit"];
while {(missionNamespace getVariable ["MCC_fnc_ambientBirdsSpawnInitRuning",false])} do {
	{
		_unit = leader _x;
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
