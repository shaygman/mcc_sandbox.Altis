//======================================================MCC_fnc_campaignInit===========================================================================================
//Init campaign - SERVER ONLY
// _sidePlayer		SIDE - player side
// _sideEnemy		SIDE - enemy side
// _factionCiv		STRING - faction civilians
// _factionEnemy	STRING - faction enemy
//_missionMax		INTEGER - max amount of missions before mission over
//_missionRotation	INTEGER - max missions in the same area
//_tileSize			INTEGER - Size of the tile while portfiling the map
//=======================================================================================================================================================================
private ["_sidePlayer","_sideEnemy","_factionCiv","_center","_arrayAssets","_locations","_pos","_temploc","_AOlocation","_missionDone","_missionMax","_AOSize","_factionPlayer","_difficulty","_totalPlayers","_sidePlayer2","_tickets","_missionRotation","_basePos","_tileSize","_reconMission"];

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
_tileSize = param [10, 250,[0]];

_totalPlayers = ((playersNumber _sidePlayer)+1);
_AOSize = 300;

//Set campaign var
missionNamespace setVariable ["MCC_isCampaignRuning",true];
publicVariable "MCC_isCampaignRuning";

missionNamespace setVariable ["MCC_campaignEnemyFaction",_factionEnemy];
publicVariable "MCC_campaignEnemyFaction";

//Time Multuplier
if (timeMultiplier < 12) then {setTimeMultiplier 12};

//Tickets
if (([_sidePlayer] call BIS_fnc_respawnTickets)<_tickets) then {[_sidePlayer, _tickets] call BIS_fnc_respawnTickets};
if (([_sidePlayer2] call BIS_fnc_respawnTickets)<_tickets && _sidePlayer2 != sideLogic) then {[_sidePlayer2, _tickets] call BIS_fnc_respawnTickets};

//init map
[_sideEnemy,_tileSize,0.2] call MCC_fnc_campaignInitMap;

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

//Spawn enemy ambient patrols
[500,18,_factionEnemy] spawn MCC_fnc_campaignSpawnAIInit;


//Pick first location
_missionDone = 0;

//Mark all the locations as hot spots
{
	[(_x select 0),400,_sideEnemy,0.4,[_sidePlayer,_sidePlayer2]] spawn MCC_fnc_campaignPaintMarkers;
	sleep 0.1;
} forEach _locations;

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


while {count _locations > 0 && _missionDone <= _missionMax } do {

	//update borders
	{
		_x setMarkerAlpha 0.4
	} forEach ([_sideEnemy] call MCC_fnc_campaignGetBorders);

	//Find mission location
	_goodLocation = false;
	_reconMission = random 1 <= _missionRotation;

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
	_vehicles = random 100 < (_difficulty)*2;
	_armor = random 100 < (_difficulty);
	_artillery = if (random 100 < (_difficulty)*2) then {[1,1,1,1,2] call BIS_fnc_selectRandom} else {0};
	_isRoadblocks = random 1 > 0.5;
	_isIED = random 1 > 0.7;
	_isAS = random 1 > (missionNamespace getvariable [format ["MCC_civRelations_%1",_sidePlayer],0.5]);
	_isSB = random 1 > (missionNamespace getvariable [format ["MCC_civRelations_%1",_sidePlayer],0.5]);
	_reinforcement =if (random 100 < (_difficulty)*2 || _reconMission) then {[1,1,1,1,2] call BIS_fnc_selectRandom} else {0};
	_obj1 = if (_reconMission) then {["Destroy Vehicle","Destroy AA","Destroy Artillery","Destroy Weapon Cahce","Destroy Fuel Depot","Secure HVT","Kill HVT","Aquire Intel"] call BIS_fnc_selectRandom} else {"Clear Area"};

	_obj2 = if (random 80 < _difficulty) then {"Destroy Radar/Radio"} else {"None"};
	_obj3 = if (random 80 < _difficulty) then {["Destroy Vehicle","Destroy AA","Destroy Artillery","Destroy Weapon Cahce","Destroy Fuel Depot","Secure HVT","Kill HVT","Aquire Intel","Disarm IED"] call BIS_fnc_selectRandom} else {"None"};
	_stealth = _reconMission;
	_weatherChange = 0;
	_playMusic = 0;
	_preciseMarkers = false;

	sleep 5;
	[
		[_AOlocation, _totalEnemyUnits,  100, _AOSize, _weatherChange, _preciseMarkers, _playMusic],
		[_sideEnemy, _factionEnemy, _sidePlayer, _factionPlayer, _factionCiv],
		[_obj1, _obj2, _obj3],
		[_isCQB, _isCiv, _armor, _vehicles, _stealth, _isIED, _isAS, _isSB, _isRoadblocks, _animals],
		[_reinforcement, _artillery]
	] spawn MCC_fnc_MWinitMission;

	private ["_activeObjectives","_failedObjectives","_totalObjectives","_tower"];
	sleep 60;

	//CAS
	if (_obj2 == "Destroy Radar/Radio") then {
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
	private ["_ticketsStart"];
	_totalObjectives =  _AOlocationPos nearObjects ["ModuleObjective_F", (_AOSize*2.5)];
	_activeObjectives = count _totalObjectives;
	_failedObjectives = {(_x getvariable ["RscAttributeTaskState",""])=="Failed"} count _totalObjectives;
	_ticketsStart = [_sidePlayer] call BIS_fnc_respawnTickets;

	while {count _totalObjectives >0} do {
		_failedObjectives = {(_x getvariable ["RscAttributeTaskState",""])=="Failed"} count _totalObjectives;
		_totalObjectives =  _AOlocationPos nearObjects ["ModuleObjective_F", (_AOSize*2.5)];
		sleep 5;
	};

	sleep 2;
	_ticketsEnd = [_sidePlayer] call BIS_fnc_respawnTickets;
	_sumTickets = _ticketsStart - _ticketsEnd;

	["Main",_activeObjectives,_failedObjectives,_sidePlayer,_totalPlayers,_difficulty,40,[0.2,0.4,0.2,0.15,0.05]] call MCC_fnc_missionDone;

	//if we have another side give him some credit
	if (_sidePlayer2 != sideLogic) then {
		["side",_activeObjectives,_failedObjectives,_sidePlayer2,_totalPlayers,_difficulty,40,[0.2,0.4,0.2,0.15,0.05],_sumTickets] call MCC_fnc_missionDone;
	};

	//clean up
	[_AOlocationPos,_AOSize*4] spawn {sleep 1200; [_this select 0,_this select 1,0] call MCC_fnc_deleteBrush};

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

	_missionDone = _missionDone + 1;
	_difficulty = (_difficulty * 1.1) min 60;

	sleep 5;
};

//Mission won outro
[["everyonewon"], "BIS_fnc_endMissionServer", false, false] spawn BIS_fnc_MP
