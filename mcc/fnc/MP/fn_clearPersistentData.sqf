/*==================================================================MCC_fnc_clearPersistentData=========================================================================
	Clear all data from saved files

	EXAMPLE
		[] spawn MCC_fnc_clearPersistentData;

	<IN>
		Nothing


	<OUT>

		Nothing

//==============================================================================================================================================*/
private ["_side","_fileName"];
_fileName = "MCC_campaign";

//Clear Save stuff for each side
{
	_side = _x;

	//Tiles
	0 spawn {
		for "_y" from 0 to 100 step 1 do {
			[format ["MCC_campaign_%1_%2",worldname,missionName], "CAMPAIGN_MARKERS", format ["row_%1", _y], "write",[],true] call MCC_fnc_handleDB;
		};
	};

	//tickets
	[format ["%1_%2_%3",_fileName, worldname,missionName], "TICKETS", str _side, "write",([_side] call BIS_fnc_respawnTickets),true] call MCC_fnc_handleDB;

	//resources
	[format ["%1_%2_%3",_fileName, worldname,missionName], "RESOURCES", str _side, "write",[1500,500,200,200,200],true] call MCC_fnc_handleDB;

	//civilian relation
	[format ["%1_%2_%3",_fileName, worldname,missionName], "CIV_RELATION", str _side, "write",0.5,true] call MCC_fnc_handleDB;


	//CAS
	[format ["%1_%2_%3",_fileName, worldname,missionName], "CAS", str _side, "write",[],true] call MCC_fnc_handleDB;

	//air drop
	[format ["%1_%2_%3",_fileName, worldname,missionName], "AIR_DROP", str _side, "write",[],true] call MCC_fnc_handleDB;

	//artillery
	[format ["%1_%2_%3",_fileName, worldname,missionName], "ARTILLERY", str _side, "write",0,true] call MCC_fnc_handleDB;

	//start locations
	[format ["%1_%2_%3",_fileName, worldname,missionName], "SPAWN_POINTS", str _side, "write",[],true] call MCC_fnc_handleDB;

} forEach [east,west,resistance];

//Arty type
[format ["%1_%2_%3",_fileName, worldname,missionName], "ARTILLERY", "TYPE", "write",[],true] call MCC_fnc_handleDB;

//Save RTS constuct - every few minutes heavy on resources
[format ["%1_%2_%3",_fileName, worldname,missionName], "BUILDINGS", "BUILDINGS", "write",[],true] call MCC_fnc_handleDB;

//Clear survival stuff
//resources
[format ["%1_%2_%3","MCC_SERVER_SURVIVAL", worldname,missionName], "RESOURCES", str _side, "write",[1500,500,200,200,200],true] call MCC_fnc_handleDB;