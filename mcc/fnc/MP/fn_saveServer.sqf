/*==================================================================MCC_fnc_saveServer===============================================================================================
	Save persistent data about the server to the server - must run on the server init

	EXAMPLE:
		["MCC_SERVER_SURVIVAL",10,false,false,true,false,false,false,false,false,false] spawn MCC_fnc_saveServer;

	<IN>
		0		: STRING file name - MCC will always add world name
		1		: INTEGER wait time between each save
		2		: BOOLEAN save tiles usualy for campaign
		3		: BOOLEAN save tickets for each side
		4		: BOOLEAN Save resources
		5		: BOOLEAN Save civilian relation
		6		: BOOLEAN Save commander's CAS
		7		: BOOLEAN Save commander's air drop
		8		: BOOLEAN Save commander's artillery
		9		: BOOLEAN Save Start locations
		10		: BOOLEAN Save RTS Buildings

	<OUT>

		Nothing

//==================================================================================================================================================================================*/

#define BASE_ANCHOR "UserTexture10m_F"

private ["_allTiles","_yBorder","_yTiles","_xBorder","_selectedTile","_markersEast","_markersWest","_markersGuer","_tempArray","_side","_lastTime","_waitTime","_saveTiles","_fileName","_saveTickets","_saveResources","_saveCivRelation","_saveCAS","_saveAirDrop","_saveArtillery","_saveStartLoc","_saveRTSBuildngs"];

_fileName = param [0, "mission", [""]];
_waitTime = param [1, 10, []];
_saveTiles = param [2, false, [false]];
_saveTickets = param [3, true, [false]];
_saveResources = param [4, true, [false]];
_saveCivRelation = param [5, true, [false]];
_saveCAS = param [6, true, [false]];
_saveAirDrop = param [7, true, [false]];
_saveArtillery = param [8, true, [false]];
_saveStartLoc = param [9, true, [false]];
_saveRTSBuildngs = param [10, true, [false]];

if (!isServer) exitWith {};

//Don't allow more then one instanse of server monitoring
if (missionNamespace getVariable ["MCC_fnc_saveServerIsrunning",false]) exitWith {};
missionNamespace setVariable ["MCC_fnc_saveServerIsrunning",true];

while {true} do {

	sleep _waitTime;


	//save tiles usualy for campaign
	if (_saveTiles) then {
		_markersEast = [];
		_markersWest = [];
		_markersGuer = [];

		//create tiles
		_allTiles = missionNamespace getVariable ["mcc_markersZonesExc",[]];

		//create boxes
		_yBorder = (count _allTiles)-1;

		for "_y" from 0 to _yBorder step 1 do {
			_yTiles = _allTiles select _y;
			_xBorder = (count _yTiles)-1;

			for "_x" from 0 to (count _yTiles)-1 step 1 do {

				//categorize to sides
				_selectedTile = _yTiles select _x;

				switch (markerColor _selectedTile) do {
					case "ColorWEST": {_markersWest pushBack markerPos _selectedTile};
					case "ColorEAST": {_markersEast pushBack markerPos _selectedTile};
					case "ColorGUER": {_markersGuer pushBack markerPos _selectedTile};
				};
			};
		};

		{
			[format ["MCC_campaign_%1",worldname], "CAMPAIGN_MARKERS", str (_x select 0), "write",(_x select 1),true] call MCC_fnc_handleDB;
		} forEach [[east,_markersEast],[west,_markersWest],[resistance,[_markersGuer]]];
	};

	//Save stuff for each side
	{
		_side = _x;

		//Save tickets
		if (_saveTickets) then {
			if (([_side] call BIS_fnc_respawnTickets) >= 0) then {
				[format ["%1_%2",_fileName, worldname], "TICKETS", str _side, "write",([_side] call BIS_fnc_respawnTickets),true] call MCC_fnc_handleDB;
			};
		};

		//Save resources
		if (_saveResources) then {
			_tempArray = missionNameSpace getVariable [format ["MCC_res%1",_side],[1500,500,200,200,200]];
			[format ["%1_%2",_fileName, worldname], "RESOURCES", str _side, "write",_tempArray,true] call MCC_fnc_handleDB;
		};

		//Save civilian relation
		if (_saveCivRelation) then {
			[format ["%1_%2",_fileName, worldname], "CIV_RELATION", str _side, "write",(missionNamespace getvariable [format ["MCC_civRelations_%1",_side],0.5]),true] call MCC_fnc_handleDB;
		};


		//Save CAS
		if (_saveCAS) then {
			[format ["%1_%2",_fileName, worldname], "CAS", str _side, "write",(missionNamespace getvariable [format ["MCC_CASConsoleArray%1",_side],[]]),true] call MCC_fnc_handleDB;
		};

		//Save air drop
		if (_saveAirDrop) then {
			[format ["%1_%2",_fileName, worldname], "AIR_DROP", str _side, "write",(missionNamespace getvariable [format ["MCC_ConsoleAirdropArray%1",_side],[]]),true] call MCC_fnc_handleDB;
		};

		//Save artillery
		if (_saveArtillery) then {
			[format ["%1_%2",_fileName, worldname], "ARTILLERY", str _side, "write",(missionNamespace getvariable [format ["Arti_%1_shellsleft",_side],0]),true] call MCC_fnc_handleDB;
		};

		//Save start locations
		if (_saveStartLoc) then {
			_tempArray = [];
			{
				if (tolower (_x getVariable ["type",""]) in ["hq","fob"]) then {
					_tempArray pushBack [position _x,
					 					direction _x,
					 					str (_x getvariable ["side",sideUnknown]),
					 					_x getvariable ["type",sideUnknown],
					 					(tolower (_x getVariable ["type",""]) == "fob"),
					 					false,
					 					false,
					 					_x getvariable ["teleport",sideUnknown]];
				};
			} forEach ([_side] call BIS_fnc_getRespawnPositions);

			[format ["%1_%2",_fileName, worldname], "SPAWN_POINTS", str _side, "write",_tempArray,true] call MCC_fnc_handleDB;
		};

	} forEach [east,west,resistance];

	//Arty type
	[format ["%1_%2",_fileName, worldname], "ARTILLERY", "TYPE", "write",(missionNamespace getvariable ["HW_arti_types",[["HE Laser-guided","Bo_GBU12_LGB",3,50],["HE 82mm","Sh_82mm_AMOS",1,75]]]),true] call MCC_fnc_handleDB;

	//Save RTS constuct - every few minutes heavy on resources
	if (_saveRTSBuildngs) then {
		if (time - (missionNamespace getVariable ["MCC_lastBuildngsSaveTime",0]) > 60) then {
			missionNamespace setVariable ["MCC_lastBuildngsSaveTime",time];

			_tempArray = [];
			{
				if (tolower (_x getVariable ["mcc_constructionItemType",""]) != "") then {
					_tempArray pushBack [position _x,
					 					direction _x,
					 					_x getvariable ["cfgClass",""],
					 					0,
					 					str (_x getvariable ["mcc_side",sideUnknown])
					 					];
				};
			} foreach (allMissionObjects BASE_ANCHOR);
			[format ["%1_%2",_fileName, worldname], "BUILDINGS", "BUILDINGS", "write",_tempArray,true] call MCC_fnc_handleDB;
		};
	};
};