//==================================================================MCC_fnc_coverInit================================================================================
//Init Cover System
//==================================================================================================================================================================
//Not a client
0 spawn {
	if (!hasInterface || isDedicated) exitWith {};

	waituntil {!(IsNull (findDisplay 46))};

	while {true} do {

		if (missionNameSpace getVariable ["MCC_cover",false]) then {
			[] call MCC_fnc_cover;
		};

		sleep 0.1;
	};
};