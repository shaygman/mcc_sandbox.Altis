//===================================================================MCC_fnc_sync=========================================================================================
// Sync the player with the server
// Example: [] spawn MCC_fnc_sync;
// Params:
// 	NONE
//==============================================================================================================================================================================
private ["_ok","_briefings","_logics"];

/*
//No need to sync weather with server anymore
if !(missionNamespace getVariable ["MCC_isACE",false]) then {
	if (!isnil "MCC_Overcast") then {0 setOvercast MCC_Overcast};
	if (!isnil "MCC_WindForce") then {0 setWindForce MCC_WindForce};
	if (!isnil "MCC_Waves") then {0 setWaves MCC_Waves};
	if (!isnil "MCC_Rain") then {0 setRain MCC_Rain};
	if (!isnil "MCC_Lightnings") then {0 setLightnings MCC_Lightnings};
	if (!isnil "MCC_Fog") then {0 setFog MCC_Fog};

	// force weather change
	skipTime -24;
	sleep 2;
	skipTime 24;
};
*/
if (!isnil "MCC_date") then {setDate MCC_date};

if (!isnil "MCC_sync") then {
	_ok = [] spawn compile MCC_sync;
	waituntil {scriptdone _ok};
};

//Sync Briefings
_logics = allMissionObjects "logic";

{
	if ((_x getVariable ["missions",0]) > 0) then
	{
		_briefings = _x getVariable ["briefings",[]];
		if (count _briefings > 0) then
		{
			player createDiaryRecord ["diary", [_briefings select 0,(toString (_briefings select 2)) + str (_briefings select 1)]]
		};
	};
} foreach _logics;

if ((missionNameSpace getVariable ["MCC_ppEffect",""])!= "") then {
	[(missionNameSpace getVariable ["MCC_ppEffect","clear"]),true] spawn MCC_fnc_ppEffects;
};

publicvariable "MCC_sync";

// finalyze sync
mcc_sync_status = true;


