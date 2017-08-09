/*=================================================================MCC_fnc_surviveInit==================================================================================
  initilize survival mode on clients
*/
//waitUntil {missionNamespace getVariable ["MCC_initDone",false]};

//============= Start items dialog ===========================

0 spawn {

	if (missionNamespace getVariable ["MCC_surviveModinitialized",false]) exitWith {};
	missionNamespace setVariable ["MCC_surviveModinitialized",true];

	while {!(missionNamespace getVariable ["MCC_surviveMod",false])} do {sleep 1};

	//if no server get out
	if (hasInterface) then {

		//Food water consumption
		0 spawn MCC_fnc_foodWaterConsumption;

		//Progress bar UI
		0 spawn MCC_fnc_survivalProgressBars;

		//Load player
		[(missionNamespace getVariable ["MCC_surviveModPlayerPos",false]),
		(missionNamespace getVariable ["MCC_surviveModPlayerGear",false]),
		(missionNamespace getVariable ["MCC_surviveModPlayerStats",false])] spawn MCC_fnc_loadPlayer;

	};

	//Server side
	if (isServer) then {
		0 spawn {
			//Load stuff from DB
			["MCC_SERVER_SURVIVAL",false,true,false,false,false,false,false,false,false] call MCC_fnc_loadServer;

			sleep 5;

			//Save DB
			["MCC_SERVER_SURVIVAL",1200,false,false,true,false,false,false,false,false,false] spawn MCC_fnc_saveServer;

			//Save player
			[600,true,true,true] spawn MCC_fnc_savePlayer;
		};
	};
};