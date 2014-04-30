//-----------------------Revive - --------------------------------------------
//disable this line if you don't want it in the mission version - will not work on the mod version by default
waituntil {!isnil "MCC_isMode"};

if (!MCC_isMode) then
{
	if (!isDedicated) then 
	{
		TCB_AIS_PATH = "ais_injury\";
		{[_x] call compile preprocessFile (TCB_AIS_PATH+"init_ais.sqf")} forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});		// execute for every playable unit
	};
};