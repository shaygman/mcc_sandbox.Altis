/*============================================================MCC_fnc_ambientBirdsSpawnInit==============================================================================
// Init birds spawn on server
// <IN> Nothing
// <OUT> Nothing
//==================================================================================================================================================================*/

//If we came here from Zeus run on the server
if (!isnull curatorcamera) then {
	_str = "<t size='0.8' t font = 'puristaLight' color='#FFFFFF'>" + "Ambient Birds Enabled" + "</t>";
	_null = [_str,0,1.1,2,0.1,0.0] spawn bis_fnc_dynamictext;
	if (!isServer) then {[] remoteExec ["MCC_fnc_ambientBirdsSpawnInit", 2]};
	deleteVehicle (param [0,objNull,[objNull]]);
};

if  (!isServer || (missionNamespace getVariable ["MCC_fnc_ambientBirdsSpawnInitRuning",false])) exitWith {};
missionNamespace setVariable ["MCC_fnc_ambientBirdsSpawnInitRuning",true];

private ["_unit"];
while {(missionNamespace getVariable ["MCC_fnc_ambientBirdsSpawnInitRuning",false])} do {
	{
		IF (count units _x > 0) then {
			_unit = [units _x] call BIS_fnc_selectRandom;

			if (typeName _unit isEqualTo typeName objNull) then {
				if ((_unit getVariable ["MCC_fnc_ambientBirdsNextTime",time]) <= time &&
				    !(vehicle _unit isKindOf "air")) then {

					if ((random (speed _unit) min 9) > 4.3) then {
						_unit setVariable ["MCC_fnc_ambientBirdsNextTime",time+(random 200)];
						[vehicle _unit] spawn MCC_fnc_ambientBirdsSpawn;
					};
				};
			};
		};
	} forEach allGroups;

	sleep (random 200);
};
