if (isDedicated || MCC_isLocalHC) exitWith {}; // not a player machine

[] spawn MCC_fnc_startLocations; 

// Basicly wait till mission start
while { (isnil ("MCC_TRAINING"))  } do {sleep 3};
while { true } do
{
	"RESPAWN_GUERRILA" setMarkerPosLocal [-9999, -9999, 0.5];
	"RESPAWN_EAST" setMarkerPosLocal [-9999, -9999, 0.5];
	"RESPAWN_WEST" setMarkerPosLocal [-9999, -9999, 0.5];
	"RESPAWN_CIVILIANS" setMarkerPosLocal [-9999, -9999, 0.5];
	while { (alive player) } do {sleep 1};

    waitUntil { (alive player) && (player isKindOf "CAManBase") };
	cutText ["You Died...","BLACK OUT",2];
	
	sleep 1;
	
	//if (side player == west) then {KEGsShownSides = [west];};
	//if (side player == east) then {KEGsShownSides = [east];};
	//if (side player == resistance) then {KEGsShownSides = [resistance];};
	//if (side player == civilian) then {KEGsShownSides = [civilian];};
	
	player setCaptive true;
	[player] join MCC_deadGroup;
	
	sleep 2;
	[] execVM MCC_path + "spectator\specta.sqf";
};
