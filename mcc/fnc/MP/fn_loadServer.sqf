/*==================================================================MCC_fnc_loadServer===============================================================================================
	Load persistent data about the server to the server  - must run on the server init

	EXAMPLE
		["MCC_SERVER_SURVIVAL",false,true,false,false,false,false,false,false,false] call MCC_fnc_loadServer;

	<IN>
		0		: STRING file name - MCC will always add world name
		1		: BOOLEAN Load tickets for each side
		2		: BOOLEAN Load resources
		3		: BOOLEAN Load civilian relation
		4		: BOOLEAN Load commander's CAS
		5		: BOOLEAN Load commander's air drop
		6		: BOOLEAN Load commander's artillery
		7		: BOOLEAN Load Start locations
		8		: BOOLEAN Load RTS Buildings
		9		: BOOLEAN Load Arty types

	<OUT>

		Nothing

//========================================================================================================================================*/

#define BASE_ANCHOR "UserTexture10m_F"

private ["_tempVar","_fileName","_loadTickets","_loadResources","_loadCivRelation","_loadCAS","_loadAirDrop","_loadArtillery","_loadStartLoc","_loadRTSBuildngs","_loadArtilleryTypes"];

_fileName = param [0, "mission", [""]];
_loadTickets = param [1, true, [false]];
_loadResources = param [2, true, [false]];
_loadCivRelation = param [3, true, [false]];
_loadCAS = param [4, true, [false]];
_loadAirDrop = param [5, true, [false]];
_loadArtillery = param [6, true, [false]];
_loadStartLoc = param [7, true, [false]];
_loadRTSBuildngs = param [8, true, [false]];
_loadArtilleryTypes = param [9, false, [false]];

if (!isServer) exitWith {};

{
	//Load Tickets
	if (_loadTickets) then {
		_tempVar = [format ["%1_%2_%3",_fileName, worldname,missionName], "TICKETS", str _x, "read",100, true] call MCC_fnc_handleDB;
		if (([_x] call BIS_fnc_respawnTickets) < _tempVar && _x != sideLogic) then {[_x, _tempVar] call BIS_fnc_respawnTickets};
	};

	//Load Resources
	if (_loadResources) then {
		_tempVar = [format ["%1_%2_%3",_fileName, worldname,missionName], "RESOURCES", str _x, "read",(missionNameSpace getVariable [format ["MCC_res%1",_x],[1500,500,200,200,200]]),true] call MCC_fnc_handleDB;
		missionNameSpace setVariable [format ["MCC_res%1",_x],_tempVar];
		publicVariable format ["MCC_res%1",_x];
	};

	//Load civilian relation
	if (_loadCivRelation) then {
		_tempVar = [format ["%1_%2_%3",_fileName, worldname,missionName], "CIV_RELATION", str _x, "read",(missionNamespace getvariable [format ["MCC_civRelations_%1",_x],0.5]),true] call MCC_fnc_handleDB;
		missionNameSpace setVariable [format ["MCC_civRelations_%1",_x],_tempVar];
		publicVariable format ["MCC_civRelations_%1",_x];
	};

	//Load CAS
	if (_loadCAS) then {
		_tempVar = [format ["%1_%2_%3",_fileName, worldname,missionName], "CAS", str _x, "read",(missionNamespace getvariable [format ["MCC_CASConsoleArray%1",_x],[]]),true] call MCC_fnc_handleDB;
		missionNameSpace setVariable [format ["MCC_CASConsoleArray%1",_x],_tempVar];
		publicVariable format ["MCC_CASConsoleArray%1",_x];
	};

	//Load air drop
	if (_loadAirDrop) then {
		_tempVar = [format ["%1_%2_%3",_fileName, worldname,missionName], "AIR_DROP", str _x, "read",(missionNamespace getvariable [format ["MCC_ConsoleAirdropArray%1",_x],[]]),true] call MCC_fnc_handleDB;
		missionNameSpace setVariable [format ["MCC_ConsoleAirdropArray%1",_x],_tempVar];
		publicVariable format ["MCC_ConsoleAirdropArray%1",_x];
	};

	//Load artillery
	if (_loadTickets) then {
		_tempVar = [format ["%1_%2_%3",_fileName, worldname,missionName], "ARTILLERY", str _x, "read",(missionNamespace getvariable [format ["Arti_%1_shellsleft",_x],0]),true] call MCC_fnc_handleDB;
		missionNameSpace setVariable [format ["Arti_%1_shellsleft",_x],_tempVar];
		publicVariable format ["Arti_%1_shellsleft",_x];
	};

	//Load start locations
	if (_loadStartLoc) then {
		_tempVar = [format ["%1_%2_%3",_fileName, worldname,missionName], "SPAWN_POINTS", str _x, "read",[],true] call MCC_fnc_handleDB;

		{_x spawn MCC_fnc_buildSpawnPoint} forEach _tempVar;
	};

} forEach [east,west,resistance];


//Load RTS constuct
if (_loadRTSBuildngs) then {
	_tempVar = [format ["%1_%2_%3",_fileName, worldname,missionName], "BUILDINGS", "BUILDINGS", "read",[],true] call MCC_fnc_handleDB;
	if (count _tempVar > 0) then {
		//first delete all the buildings available
		{
			[_X, false] call MCC_fnc_rtsClearBuilding;
		} foreach (allMissionObjects BASE_ANCHOR);

		//Now load the new one
		{
			_x spawn MCC_fnc_construct_base
		} forEach _tempVar;
	};
};

//Load Arty types
if (_loadArtilleryTypes) then {
	_tempVar = [format ["%1_%2_%3",_fileName, worldname,missionName], "ARTILLERY", "TYPE", "read",(missionNamespace getvariable ["HW_arti_types",[["HE Laser-guided","Bo_GBU12_LGB",3,50],["HE 82mm","Sh_82mm_AMOS",1,75]]]),true] call MCC_fnc_handleDB;
	missionNamespace setVariable ["HW_arti_types",_tempVar];
	publicVariable "HW_arti_types";
};
