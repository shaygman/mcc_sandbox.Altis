/*==================================================================MCC_fnc_clearPersistentData============================================================================================
	Clear all data from saved files

	EXAMPLE
		[] spawn MCC_fnc_clearPersistentData;

	<IN>
		Nothing


	<OUT>

		Nothing

//==================================================================================================================================================================================*/
private ["_side","_fileName"];
_fileName = "MCC_campaign";

//Save stuff for each side
{
	_side = _x;

	//Tiles
	[format ["%1_%2",_fileName, worldname], "CAMPAIGN_MARKERS", str _x, "write",[],true] call MCC_fnc_handleDB;

	//tickets
	[format ["%1_%2",_fileName, worldname], "TICKETS", str _side, "write",([_side] call BIS_fnc_respawnTickets),true] call MCC_fnc_handleDB;

	//resources
	[format ["%1_%2",_fileName, worldname], "RESOURCES", str _side, "write",[1500,500,200,200,200],true] call MCC_fnc_handleDB;

	//civilian relation
	[format ["%1_%2",_fileName, worldname], "CIV_RELATION", str _side, "write",0.5,true] call MCC_fnc_handleDB;


	//CAS
	[format ["%1_%2",_fileName, worldname], "CAS", str _side, "write",[],true] call MCC_fnc_handleDB;

	//air drop
	[format ["%1_%2",_fileName, worldname], "AIR_DROP", str _side, "write",[],true] call MCC_fnc_handleDB;

	//artillery
	[format ["%1_%2",_fileName, worldname], "ARTILLERY", str _side, "write",0,true] call MCC_fnc_handleDB;

	//start locations
	[format ["%1_%2",_fileName, worldname], "SPAWN_POINTS", str _side, "write",[],true] call MCC_fnc_handleDB;;

} forEach [east,west,resistance];

//Arty type
[format ["%1_%2",_fileName, worldname], "ARTILLERY", "TYPE", "write",[],true] call MCC_fnc_handleDB;

//Save RTS constuct - every few minutes heavy on resources
[format ["%1_%2",_fileName, worldname], "BUILDINGS", "BUILDINGS", "write",[],true] call MCC_fnc_handleDB;