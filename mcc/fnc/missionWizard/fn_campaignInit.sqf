//======================================================MCC_fnc_campaignInit=================================================================================================
//Init campaign - SERVER ONLY
// _sidePlayer		SIDE - player side
// _sideEnemy		SIDE - enemy side
// _factionCiv		STRING - faction civilians
// _factionEnemy	STRING - faction enemy
//_missionMax		INTEGER - max amount of missions before mission over
//==============================================================================================================================================================================
private ["_sidePlayer","_sideEnemy","_factionCiv","_center","_arrayAssets","_locations","_pos","_temploc","_AOlocation","_missionDone","_missionMax","_AOSize","_factionPlayer","_difficulty","_totalPlayers","_sidePlayer2","_tickets"];

//wait for MCC
waitUntil {!isnil "MCC_initDone"};
waitUntil {MCC_initDone};

_sidePlayer	= [_this, 0, west] call BIS_fnc_param;
_factionPlayer	= [_this, 1, "BLU_F"] call BIS_fnc_param;
_sideEnemy	= [_this, 2, east] call BIS_fnc_param;
_factionEnemy = [_this, 3, "OPF_F"] call BIS_fnc_param;
_factionCiv	= [_this, 4, "CIV_F"] call BIS_fnc_param;
_missionMax  = [_this, 5, 10] call BIS_fnc_param;
_difficulty  = [_this, 6, 20] call BIS_fnc_param;
_sidePlayer2= [_this, 7, sideLogic] call BIS_fnc_param;
_tickets = [_this, 8, 100] call BIS_fnc_param;

_totalPlayers = ((playersNumber _sidePlayer)+1);
_AOSize = (20*_totalPlayers) max 300;

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

//Build the faction's unitsArrays and send it to the server.
_check = [_factionEnemy, _sideEnemy] call MCC_fnc_MWCreateUnitsArray;
waituntil {_check};

[_factionEnemy] call MCC_fnc_createConfigs;

//Search the map for locations
private ["_worldPath","_mapSize","_mapCenter"];

if (isnil "hsim_worldArea") then
{
	_worldPath = configfile >> "cfgworlds" >> worldname;
	_mapSize = getnumber (_worldPath >> "mapSize");
	if (_mapSize == 0) then {_mapSize = 10000};

	_mapSize = _mapSize / 2;
	_mapCenter = [_mapSize,_mapSize];

	hsim_worldArea = createtrigger ["emptydetector",_mapCenter];
	hsim_worldArea settriggerarea [_mapSize,_mapSize,0,true];
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
	_pos = getpos hsim_worldArea;
	{
		_temploc = [_pos,15000,_x] call MCC_fnc_MWbuildLocations;
		{
			_locations pushBack [getpos (_x select 0), _x select 1];
		} forEach _temploc;
	} forEach ["city","mil","nature"]; //,"mil","hill","nature","marine"
};

//Still no location go bruth force
if (count _locations == 0) then {
	for "_i" from 1 to 100  do {
		_temploc = [[getpos hsim_worldArea, hsim_worldArea], "ground", ["water","out"],{}] call BIS_fnc_randomPos;
		_locations pushBack [_temploc, ""];
	};
};

//Pick first location
_missionDone = 0;

//main mission loop
private ["_goodLocation","_AOlocationPos","_AOlocationName","_index"];
_index = floor random count _locations;
_AOlocation = _locations select _index;
_AOlocationPos = _AOlocation select 0;
_AOlocationName = _AOlocation select 1;
_locations set [_index,-1];
_locations = _locations - [-1];

//Sort locations by distance from the first location
_locations = [_locations,[_AOlocationPos],{_input0 distance (_x select 0)},"ASCEND"] call BIS_fnc_sortBy;

//Start the campaign missions?
if (_missionMax == 0) exitWith {};

while {count _locations > 0 && _missionDone <= _missionMax} do {

	_goodLocation = false;
	while {! _goodLocation && count _locations > 0} do {

		_goodLocation = true;

	    //if inside MCC zone black list him
	    private ["_xPosWest","_xPosEast","_yPosNorth","_yPosSouth","_zoneSize"];
		{
			_xPosWest = [(_AOlocationPos select 0)-_AOSize*2,_AOlocationPos select 1,_AOlocationPos select 2];
			_xPosEast = [(_AOlocationPos select 0)+_AOSize*2,_AOlocationPos select 1,_AOlocationPos select 2];
			_yPosNorth = [_AOlocationPos select 0,(_AOlocationPos select 1)+_AOSize*2,_AOlocationPos select 2];
			_yPosSouth = [_AOlocationPos select 0,(_AOlocationPos select 1)-_AOSize*2,_AOlocationPos select 2];

			if (_foreachindex > 0) then {
				_zoneSize = mcc_zone_size select _foreachindex;
				if ([_x, _zoneSize,_xPosWest] call BIS_fnc_isInsideArea ||
					[_x, _zoneSize,_xPosEast] call BIS_fnc_isInsideArea ||
					[_x, _zoneSize,_yPosNorth] call BIS_fnc_isInsideArea ||
					[_x, _zoneSize,_yPosSouth] call BIS_fnc_isInsideArea) exitWith {_goodLocation = false};
			};
		} forEach mcc_zone_pos;
		if (_AOlocationPos distance (getMarkerPos "RESPAWN_WEST")< 2000) then {_goodLocation = false};
		if (_AOlocationPos distance (getMarkerPos "RESPAWN_EAST")< 2000) then {_goodLocation = false};
		if (_AOlocationPos distance (getMarkerPos "RESPAWN_GUERRILA")< 2000) then {_goodLocation = false};

		if (!_goodLocation && (count _locations > 0)) then {
			//get a new location
			_AOlocation = _locations select 0;
			_AOlocationPos = _AOlocation select 0;
			_AOlocationName = _AOlocation select 1;
			_locations set [0,-1];
			_locations = _locations - [-1];
		};
		sleep 0.5;
	};



	//No locations? mission won
	if (count _locations == 0) exitWith {};

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
	_isAS = random 1 > 0.6;
	_isSB = random 1 > 0.8;
	_reinforcement =if (random 100 < (_difficulty)*2) then {[1,1,1,1,2] call BIS_fnc_selectRandom} else {0};
	_obj1 = if (random 1 > 0.5) then {["Clear Area","Secure HVT","Kill HVT","Destroy Vehicle","Destroy AA","Destroy Artillery","Destroy Weapon Cahce","Destroy Fuel Depot","Aquire Intel"] call BIS_fnc_selectRandom} else {"Clear Area"};

	_obj2 = if (random 100 < _difficulty) then {"Destroy Radar/Radio"} else {"None"};
	_obj3 = if (random 100 < _difficulty) then {["Secure HVT","Kill HVT","Destroy Vehicle","Destroy AA","Destroy Artillery","Destroy Weapon Cahce","Destroy Fuel Depot","Aquire Intel","Disarm IED"] call BIS_fnc_selectRandom} else {"None"};
	_stealth = false;
	_weatherChange = 0;
	_playMusic = 1;
	_preciseMarkers = false;

	sleep 5;
	[
		[_AOlocation, _totalEnemyUnits,  100, _AOSize, _weatherChange, _preciseMarkers, _playMusic],
		[_sideEnemy, _factionEnemy, _sidePlayer, _factionPlayer, _factionCiv],
		[_obj1, _obj2, _obj3],
		[_isCQB, _isCiv, _armor, _vehicles, _stealth, _isIED, _isAS, _isSB, _isRoadblocks, _animals],
		[_reinforcement, _artillery]
	] spawn MCC_fnc_MWinitMission;

	//Create mission Markers
	[1, "ColorRed",[_AOSize*3,_AOSize*3], "ELLIPSE", "Border", "Empty", "MCC_campaignMarker", _AOlocationPos] call MCC_fnc_makeMarker;

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

	sleep 5;
	_ticketsEnd = [_sidePlayer] call BIS_fnc_respawnTickets;
	_sumTickets = _ticketsStart - _ticketsEnd;

	["Main",_activeObjectives,_failedObjectives,_sidePlayer,_totalPlayers,_difficulty,60,[0.2,0.4,0.2,0.15,0.05]] call MCC_fnc_missionDone;

	//if we have another side give him some credit
	if (_sidePlayer2 != sideLogic) then {
		["side",_activeObjectives,_failedObjectives,_sidePlayer2,_totalPlayers,_difficulty,60,[0.2,0.4,0.2,0.15,0.05],_sumTickets] call MCC_fnc_missionDone;
	};

	sleep 5;
	//clean up
	[_AOlocationPos,_AOSize*4] spawn {sleep 1200; [_this select 0,_this select 1,0] call MCC_fnc_deleteBrush};
	[2, "", "", "", "", "", "MCC_campaignMarker", []] call MCC_fnc_makeMarker;

	//Mark area as captured
	private ["_markerName","_markerColor"];
	_markerName = format ["MCC_capturedMarker_%1_%2", _sidePlayer, [format ["MCC_capturedMarker_%1_Counter",_sidePlayer],1] call bis_fnc_counter];
	publicVariable format ["MCC_capturedMarker_%1_Counter",_sidePlayer];

	_markerColor = switch (_sidePlayer) do {
		    case west: {"ColorWEST"};
		    case east: {"ColorEAST"};
		    default {"ColorGUER"};
		};
	[1, _markerColor,[_AOSize*2,_AOSize*2], "RECTANGLE", "Solid", "Empty", _markerName, _AOlocationPos] call MCC_fnc_makeMarker;
};

//Mission won outro
[["everyonewon"], "BIS_fnc_endMissionServer", false, false] spawn BIS_fnc_MP
