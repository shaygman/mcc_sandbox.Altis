/*======================================================MCC_fnc_campaignInit===========================================================================================
	Init campaign - SERVER ONLY
	_sidePlayer			SIDE - player side
	_factionPlayer		STRNG - faction player- defult "BLU_F"
	_sideEnemy			SIDE - enemy side
	_factionEnemy		STRING - faction enemy default "OPF_F"
	_factionCiv			STRING - faction civilians
	_missionMax			INTEGER - max amount of missions before mission over
	_difficulty			INTEGER - difficulty between 10-40 default is 20
	_sidePlayer2		SIDE - Side of the rival players faction
	_tickets			INTEGER - starting respawn tickets for each side
	_missionRotation	INTEGER - max missions in the same area
	_tileSize			INTEGER - Size of the tile while portfiling the map
	_loadDB				INTEGER - Should we load the last saved data base
//=====================================================================================================================================================================*/
private ["_sidePlayer","_sideEnemy","_factionCiv","_center","_arrayAssets","_locations","_pos","_temploc","_AOlocation","_missionDone","_missionMax","_AOSize","_factionPlayer","_difficulty","_totalPlayers","_sidePlayer2","_tickets","_missionRotation","_basePos","_tileSize","_reconMission","_tempVar","_loadDb"];

//wait for MCC
waitUntil {!isnil "MCC_initDone"};
waitUntil {MCC_initDone};

_sidePlayer	= param [0, west];
_factionPlayer	= param [1, "BLU_F"];
_sideEnemy	= param [2, east];
_factionEnemy = param [3, "OPF_F"];
_factionCiv	= param [4, "CIV_F"];
_missionMax  = param [5, 10];
_difficulty  = param [6, 20];
_sidePlayer2=  param [7, sideLogic];
_tickets = param [8, 100];
_missionRotation = param [9, 4,[0]];
_tileSize = param [10, 400,[0]];
_loadDb = param [11, false,[false]];

_totalPlayers = ((playersNumber _sidePlayer)+1);
_AOSize = 300;

if (!isServer) exitWith {diag_log "MCC_fnc_campaignInit : Error not running on server"};

//Set campaign var
missionNamespace setVariable ["MCC_isCampaignRuning",true];
publicVariable "MCC_isCampaignRuning";

missionNamespace setVariable ["MCC_campaignEnemyFaction",_factionEnemy];
publicVariable "MCC_campaignEnemyFaction";

//Time Multuplier
if (timeMultiplier < 12) then {setTimeMultiplier 12};

//Load stuff from DB
if (_loadDb) then {
	["MCC_campaign",true,true,true,true,true,true,true,true,true] call MCC_fnc_loadServer;
};


//Build the faction's unitsArrays and send it to the server.
_check = [_factionEnemy, _sideEnemy] call MCC_fnc_MWCreateUnitsArray;
waituntil {_check};

[_factionEnemy] call MCC_fnc_createConfigs;

//Search the map for locations
private ["_worldPath","_mapSize","_mapCenter"];

if (isnil "MCC_worldArea") then {
	_worldPath = configfile >> "cfgworlds" >> worldname;
	_mapSize = getnumber (_worldPath >> "mapSize");
	if (_mapSize == 0) then {_mapSize = 10000};

	_mapSize = _mapSize / 2;
	_mapCenter = [_mapSize,_mapSize];

	MCC_worldArea = createtrigger ["emptydetector",_mapCenter];
	MCC_worldArea settriggerarea [_mapSize,_mapSize,0,true];
};

//Build Locations
_locations = [];

//Any user defined locations?
{
	if (markerType _x == "Empty") then {
		if (["ao",_x] call bis_fnc_inString) then {_locations pushBack [getMarkerPos _x, markerText _x]};
	};
} forEach allMapMarkers;

//If no user defined locations lets find map locations.
if (count _locations == 0) then {
	_pos = getpos MCC_worldArea;
	{
		_temploc = [_pos,15000,_x] call MCC_fnc_MWbuildLocations;
		{
			if (((missionNamespace getVariable ["MCC_START_WEST",[0,0,0]]) distance (getpos (_x select 0)) >700) &&
				((missionNamespace getVariable ["MCC_START_EAST",[0,0,0]]) distance (getpos (_x select 0)) >700) &&
				((missionNamespace getVariable ["MCC_START_GUER",[0,0,0]]) distance (getpos (_x select 0)) >700)) then {

				_locations pushBack [getpos (_x select 0), _x select 1];
			};

		} forEach _temploc;
	} forEach ["city","mil","nature"]; //,"mil","hill","nature","marine"
};

//Still no location go bruth force
if (count _locations == 0) then {
	for "_i" from 1 to 100  do {
		_temploc = [[getpos MCC_worldArea, MCC_worldArea], "ground", ["water","out"],{}] call BIS_fnc_randomPos;
		_locations pushBack [_temploc, ""];
	};
};

//init map markers
[_sideEnemy,_tileSize,0.2,_locations,400,0.4] call MCC_fnc_campaignInitMap;

//Mark the starting bases
{
	_basePos = switch (_x) do
				{
					case east: {missionNamespace getVariable ["MCC_START_EAST",[0,0,0]]};
					case west: {missionNamespace getVariable ["MCC_START_WEST",[0,0,0]]};
					case resistance: {missionNamespace getVariable ["MCC_START_GUER",[0,0,0]]};
					default	{[0,0,0]};
				};
	if !(_basePos isEqualTo [0,0,0]) then {
		[_basePos,1000,_x,0.2] spawn MCC_fnc_campaignPaintMarkers;
	};
} forEach [_sidePlayer,_sidePlayer2];

//Spawn enemy ambient patrols
[500,18,_factionEnemy] spawn MCC_fnc_campaignSpawnAIInit;


//Pick first location
_missionDone = 0;

/*
//Mark all the locations as hot spots
{
	[(_x select 0),400,_sideEnemy,0.4,[_sidePlayer,_sidePlayer2]] spawn MCC_fnc_campaignPaintMarkers;
	sleep 0.1;
} forEach _locations;
*/

//main mission loop
private ["_AOlocationPos","_AOlocationName","_index","_goodLocation"];

//Sort locations by distance from the players base
_basePos = switch (_sidePlayer) do
			{
				case east: {missionNamespace getVariable ["MCC_START_EAST",[0,0,0]]};
				case west: {missionNamespace getVariable ["MCC_START_WEST",[0,0,0]]};
				case resistance: {missionNamespace getVariable ["MCC_START_GUER",[0,0,0]]};
				default	{[0,0,0]};
			};
_locations = [_locations,[_basePos],{_input0 distance (_x select 0)},"ASCEND"] call BIS_fnc_sortBy;


//Start the campaign missions?
if (_missionMax == 0) exitWith {};

//Save DB every 20 minutes
["MCC_campaign",1200,true] spawn MCC_fnc_saveServer;

while { count _locations > 0 &&
		_missionDone <= _missionMax
	  } do {

	//update borders
	{
		_x setMarkerAlpha 0.4
	} forEach ([_sideEnemy] call MCC_fnc_campaignGetBorders);

	//Find mission location
	_goodLocation = false;
	_reconMission = random 1 <= 0.2;

	while {count _locations > 0 && !_goodLocation} do {
		//_index = floor random count _locations;
		_index = if (_reconMission) then {floor random count _locations} else {0} ;
		_AOlocation = _locations select _index;
		_AOlocationPos = _AOlocation select 0;
		_AOlocationName = _AOlocation select 1;
		_locations set [_index,-1];
		_locations = _locations - [-1];

		_goodLocation = ([_AOlocationPos] call MCC_fnc_campaignGetNearestTile) select 1 == _sideEnemy;

		sleep 0.5;
	};



	//No locations? mission won
	if (count _locations == 0) exitWith {
		//Mission won outro
		[["everyonewon"], "BIS_fnc_endMissionServer", false, false] spawn BIS_fnc_MP
	};

	private ["_totalEnemyUnits","_isCQB","_isCiv","_animals","_vehicles","_armor","_artillery","_isRoadblocks","_isIED","_isAS","_isSB","_reinforcement","_obj1","_obj2","_obj3","_weatherChange","_preciseMarkers"];
	_aoPos = getMarkerpos _AOlocationName;
	_totalEnemyUnits = (_totalPlayers/2)*_difficulty;
	_isCQB =  (count (nearestObjects  [_aoPos,["House","Ruins","Church","FuelStation","Strategic"],200])) > 2;
	_isCiv = false;
	_animals = random 1 > 0.5;
	_vehicles = (random 100 < (_difficulty)*2) && (_missionDone >= 3); //No vehicles in the first 3 missions
	_armor = (random 100 < (_difficulty)) && (_missionDone >= 4); //No armor in the first 4 missions;
	_artillery = if ((random 100 < (_difficulty)*2) && (_missionDone >= 3)) then {[1,1,1,1,2] call BIS_fnc_selectRandom} else {0}; //No armor in the first 3 missions;
	_isRoadblocks = random 1 > 0.5;
	_isIED = random 1 > 0.7;
	_isAS = random 1 > (missionNamespace getvariable [format ["MCC_civRelations_%1",_sidePlayer],0.5]);
	_isSB = random 1 > (missionNamespace getvariable [format ["MCC_civRelations_%1",_sidePlayer],0.5]);
	_reinforcement =if (random 100 < (_difficulty)*2 || _reconMission) then {[1,1,1,1,2] call BIS_fnc_selectRandom} else {0};
	_obj1 = if (_reconMission) then {["Destroy Vehicle","Destroy AA","Destroy Artillery","Destroy Weapon Cahce","Destroy Fuel Depot","Secure HVT","Kill HVT","Aquire Intel"] call BIS_fnc_selectRandom} else {["Destroy Vehicle","Destroy AA","Destroy Artillery","Destroy Weapon Cahce","Destroy Fuel Depot","Secure HVT","Kill HVT","Aquire Intel","Clear Area","Clear Area","Clear Area","Clear Area"] call BIS_fnc_selectRandom};

	_obj2 = if (random 80 < _difficulty) then {"Destroy Radar/Radio"} else {"None"};
	_obj3 = if (random 80 < _difficulty) then {["Destroy Vehicle","Destroy AA","Destroy Artillery","Destroy Weapon Cahce","Destroy Fuel Depot","Secure HVT","Kill HVT","Aquire Intel","Disarm IED"] call BIS_fnc_selectRandom} else {"None"};

	_weatherChange = 0;
	_playMusic = 0;
	_preciseMarkers = false;

	sleep 5;
	[
		[_AOlocation, _totalEnemyUnits,  100, _AOSize, _weatherChange, _preciseMarkers, _playMusic],
		[_sideEnemy, _factionEnemy, _sidePlayer, _factionPlayer, _factionCiv],
		[_obj1, _obj2, _obj3],
		[_isCQB, _isCiv, _armor, _vehicles, _reconMission, _isIED, _isAS, _isSB, _isRoadblocks, _animals],
		[_reinforcement, _artillery]
	] spawn MCC_fnc_MWinitMission;


	//Wait untill mission wizard mission is runing
	waitUntil {missionNamespace getVariable ["MCC_MWMissionRuning",false]};

	//CAS
	if (_obj2 == "Destroy Radar/Radio") then {
		private ["_tower"];
		_tower = _AOlocationPos nearObjects [MCC_MWRadio select 0, (_AOSize*2.5)];
		if (count _tower > 0) then {
			_tower = _tower select 0;
			[_tower,_sideEnemy, _factionEnemy, _sidePlayer]spawn {
				private ["_tower","_sideEnemy","_factionEnemy","_sidePlayer"];
				_tower = _this select 0;
				_sideEnemy = _this select 1;
				_factionEnemy = _this select 2;
				_sidePlayer = _this select 3;

				sleep (60 + (random 120));
				if (alive _tower) then {
					while {(alive _tower)} do {
						[_tower,_sideEnemy, _factionEnemy, _sidePlayer] call MCC_fnc_enemyCAS;
						sleep (480 + (random 480));
					};
				};
			};
		};
	};

	//If night mission remove NV from AI and add falshlight to build atmoshphere
	if (sunOrMoon < 1) then {
		private ["_nearObjects","_unit"];
		_nearObjects = _AOlocationPos nearObjects ["Man", _AOSize*4];

		{
			_unit = _x;
			if !(isPlayer _unit) then {
				{
					_unit unassignItem _x;
					_unit removeItem _x;
				} foreach ["NVGoggles","NVGoggles_OPFOR","NVGoggles_INDEP"];

				if !("acc_flashlight" in primaryWeaponItems _x) then {
							_x addPrimaryWeaponItem "acc_flashlight";
				};
				_x enablegunlights "forceOn";
			};
		} foreach _nearObjects;
	};

	//Wait for mission end
	private ["_ticketsStart","_activeObjectivesSide1","_activeObjectivesSide2","_failedObjectivesSide1","_failedObjectivesSide2"];

	_ticketsStart = [_sidePlayer] call BIS_fnc_respawnTickets;

	//Wait untill mission is complete
	waitUntil {!(missionNamespace getVariable ["MCC_MWMissionRuning",true])};

	_activeObjectivesSide1 = missionNamespace getVariable [format ["MCC_campaignMissionsStatus_%1_total",_sidePlayer],0];
	_activeObjectivesSide2 = missionNamespace getVariable [format ["MCC_campaignMissionsStatus_%1_total",_sidePlayer2],0];

	_failedObjectivesSide1 = missionNamespace getVariable [format ["MCC_campaignMissionsStatus_%1_failed",_sidePlayer],0];
	_failedObjectivesSide2 = missionNamespace getVariable [format ["MCC_campaignMissionsStatus_%1_failed",_sidePlayer2],0];
	sleep 2;
	_ticketsEnd = [_sidePlayer] call BIS_fnc_respawnTickets;
	_sumTickets = _ticketsStart - _ticketsEnd;

	if (_sidePlayer != sideLogic) then {
		["Main",_activeObjectivesSide1,_failedObjectivesSide1,_sidePlayer,_totalPlayers,_difficulty,50,[0.2,0.4,0.2,0.15,0.05],_sumTickets] spawn MCC_fnc_missionDone;
	};

	if (_sidePlayer2 != sideLogic) then {
		["Main",_activeObjectivesSide2,_failedObjectivesSide2,_sidePlayer2,_totalPlayers,_difficulty,50,[0.2,0.4,0.2,0.15,0.05]] spawn MCC_fnc_missionDone;
	};

	//Reset objectives coutners
	{
		missionNamespace setVariable [format ["MCC_campaignMissionsStatus_%1_total",_X],0];
		missionNamespace setVariable [format ["MCC_campaignMissionsStatus_%1_failed",_X],0];
		missionNamespace setVariable [format ["MCC_campaignMissionsStatus_%1_succeed",_X],0];
	} forEach [_sidePlayer,_sidePlayer2];


	//if we have another side give him some credit
	/*
	if (_sidePlayer2 != sideLogic) then {
		["side",_activeObjectivesSide2,_failedObjectivesSide2,_sidePlayer2,_totalPlayers,_difficulty,40,[0.2,0.4,0.2,0.15,0.05],_sumTickets] call MCC_fnc_missionDone;
	};
	*/

	//clean up
	[_AOlocationPos,_AOSize*2] spawn {
		params [["_AOlocationPos",[0,0,0],[[],objNull]],
				["_AOSize",200,[0]]
			   ];

		while {{_x distance2D _AOlocationPos < _AOSize} count (allPlayers - entities "HeadlessClient_F") > 0} do {sleep 10};
		[_this select 0,_this select 1,0] call MCC_fnc_deleteBrush
	};

	/*
	//Mark area as captured
	if !(_reconMission) then {
		//if main mission capture it
		[_AOlocationPos,_AOSize*3,_sidePlayer,0.2,[]] spawn MCC_fnc_campaignPaintMarkers;
	} else {
		//if recon mission then increase influance
		private _markerColor = switch (_sidePlayer) do
								{
									case west: {"ColorWEST"};
									case resistance: {"ColorGUER"};
									case east: {"ColorEAST"};
									default	{""};
								};
		{
			_x setMarkerColor _markerColor;
			_x setMarkerAlpha 0.2;
		} foreach ([_sideEnemy] call MCC_fnc_campaignGetBorders);
	};
	*/
	_missionDone = _missionDone + 1;
	_difficulty = (_difficulty * 1.1) min 60;

	sleep 5;
};

//Mission won outro
["sidetickets"] call  BIS_fnc_endMissionServer;
