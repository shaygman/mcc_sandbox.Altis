//=================================================================MCC_fnc_rtsScanResources==============================================================================
//	Generate resources mission
//  Parameter(s):
//     	_side: SIDE
//		_dif: INTEGER - 10 basic 20 - advanced
//		_delete: BOOLEAN - if true then delete
//==============================================================================================================================================================================
private ["_side","_dif","_delete","_startLocation","_trg","_missionPos","_crateNumbers","_crateType","_crates","_missionItems","_object","_unitsArray","_enemyFaction","_enemySide","_counter","_totalPlayers","_scenario","_propObject","_missionText","_missionTittle","_effect"];

_side = param [0, west, [west]];
_dif = param [1, 10, [10]];
_delete = param [2, false, [false]];
_scenario = ["stash","car","heli"] call bis_fnc_selectRandom;

//Delete mission
if (_delete) exitWith {
	_missionItems = missionNamespace getVariable [format ['MCC_rtsMissionObjects_%1', _side],[]];
	{
		_object = _x;
		if (alive _object && (isNull attachedTo _object)) then {
			if (count (crew _object) >0) then {
				{
					deleteVehicle _x;
				} forEach crew _object;
				deleteVehicle _object;
			} else {
				{
					deleteVehicle _x
				} forEach (_object getVariable ["effects",[]]);
				deleteVehicle _object;
			}
		};
	} forEach _missionItems;

	//Delete Marker
	[2, "", "", "", "", "", "Resource Mission", []] call MCC_fnc_makeMarker;

	//Abort notice
	_missionText = "<img size='5' image='\a3\ui_f\data\gui\cfg\hints\Doors_ca.paa'/><br/><br/><t align='center' size='1.8' color='#FFCF11'> Resource Mission Aborted</t><br/>"
					+"____________________<br/>"
					+ "Your CO aborted the mission.<br/>"
					+ "____________________<br/><br/>";

	//Send hint
	[[_missionText,true],"MCC_fnc_globalHint",_side,false] spawn BIS_fnc_MP;
};

//Start mission
_missionTittle = if (_dif == 10) then {"Basic Resource Mission"} else {"Advanced Resource Mission"};

_missionText = format ["<img size='5' image='\a3\ui_f\data\gui\cfg\hints\Waypoints_ca.paa'/><br/><br/><t align='center' size='1.8' color='#FFCF11'> %1</t><br/>", _missionTittle];

switch (_scenario) do {
    case "stash": {
    	_propObject = "CamoNet_INDP_open_Curator_F";
    	_missionText = _missionText	+"____________________<br/>"
									+ "H.Q Found some enemy supply stash nearby.<br/>";
	};

	case "car": {
    	_propObject = ["Land_Wreck_HMMWV_F","Land_Wreck_Hunter_F","Land_Wreck_Offroad_F","Land_Wreck_Truck_dropside_F","Land_Wreck_Van_F"] call bis_fnc_selectRandom;
    	_missionText = _missionText	+"____________________<br/>"
									+ "H.Q Located wrecked vehicle that might hold some supplies.<br/>";
	};

	case "heli": {
    	_propObject = ["Land_Wreck_Heli_Attack_01_F","Land_Wreck_Plane_Transport_01_F","Land_Wreck_Heli_Attack_02_F"] call bis_fnc_selectRandom;
    	_missionText = _missionText	+"____________________<br/>"
									+ "H.Q spotted downed aircraft nearby. Its most likely still hold some supplies.<br/>";
	};
};

_missionText = _missionText + format ["The area is %1 guarded so it might prove as an opportunity for us.<br/>", if (_dif == 10) then {"lightly"} else {"well"}]
							+ "____________________<br/><br/>";

_totalPlayers = {side _x == _side} count allplayers;

//Start mission
_startLocation = call compile format ["MCC_START_%1",_side];

_crates = MCC_logisticsCrates_TypesWest;
_crates resize 3;
_enemyFaction = missionNamespace getVariable ["MCC_campaignEnemyFaction","OPF_F"];
_enemySide = [(getNumber (configfile >> "CfgFactionClasses" >> _enemyFaction >> "side"))] call BIS_fnc_sideType;

_missionItems = [];

//create Trigger
_trg = createTrigger ["EmptyDetector", _startLocation];
_trg setTriggerArea [600*_dif, 600*_dif, 0, false];

_missionPos = [];

//Find pos
while {count _missionPos == 0} do {
   _missionPos = [[_startLocation, _trg], "ground", ["water","out"], compile format ["_this distance %1 > 1500", _startLocation]] call BIS_fnc_randomPos;
	_missionPos = _missionPos findEmptyPosition [0,100];
	sleep 1;
};

//if its a car then find road
if (_scenario == "car") then {
	private ["_road"];
	_road = [_missionPos,300,[]] call bis_fnc_nearestRoad;
	if (!isNull _road) then {_missionPos = getpos _road};
};

//Create mission Markers
[0, "ColorRed",[], "", "", "mil_warning", "Resource Mission", _missionPos,0] call MCC_fnc_makeMarker;

//set the crates
_object = _propObject createVehicle _missionPos;
_object setDir (random 360);
_missionItems pushBack _object;

//Add effect
switch (_scenario) do {
    case "stash": {
    	_effect = "Campfire_burning_F" createVehicle (getpos _object);
    };

    default {
     	_effect = "test_EmptyObjectForSmoke" createVehicle (getpos _object);
    };
};
_effect setpos (getpos _object);
_missionItems pushBack _effect;

_crateNumbers = if (_dif == 10) then {(floor random 3)+1} else {(floor random 5)+1};
for "_i" from 1 to _crateNumbers do {
	_crateType = [_crates,[0.3,0.5,0.2]] call bis_fnc_selectRandomWeighted;
	_object = _crateType createVehicle _missionPos;
	_missionItems pushBack _object;
};

//Lets spawn some infantry
_unitsArray = [_enemyFaction ,"soldier"] call MCC_fnc_makeUnitsArray;

if (count _unitsArray > 0) then {

	if (count _unitsArray > 6) then {_unitsArray resize 6};

	private ["_units"];
	_units = [];

	_maxUnits = _totalPlayers * (_dif/4);
	while {_maxUnits > 0} do {
		_missionPos = [_missionPos,10,100,2,0,50,0] call BIS_fnc_findSafePos;

	    _counter = floor random 5;
		for "_i" from 1 to _counter do {
			_units pushBack ((_unitsArray call bis_fnc_selectRandom) select 0);
			_maxUnits = _maxUnits -2;
		};

		_group = [_missionPos, _units, 1, _enemySide, false, false] call MCC_fnc_groupSpawn;
		{
			_missionItems pushBack _x;
		} forEach units _group;

		if (random 1 > 0.2) then {
			[_group, _missionPos, 150] call BIS_fnc_taskPatrol;
		} else {
			[_group, _missionPos] call bis_fnc_taskDefend;
		};
	};
};

//Lets spawn some vehicles
_unitsArray = [_enemyFaction ,"carx"] call MCC_fnc_makeUnitsArray;

if (count _unitsArray > 0) then {
	_units = [];
	_maxUnits = if (_dif > 10) then {random _totalPlayers/5} else {floor random 2};

	while {_maxUnits > 0} do {
		_missionPos = [_missionPos,10,100,2,0,50,0] call BIS_fnc_findSafePos;

	    _units pushBack ((_unitsArray call bis_fnc_selectRandom) select 0);
		_maxUnits = _maxUnits -1;

		_group = [_missionPos, _units, 1, _enemySide, false, false] call MCC_fnc_groupSpawn;
		_missionItems pushBack (vehicle leader _group);

		[_group, _missionPos, 250] call BIS_fnc_taskPatrol;
	};
};

//broadcast mission objects
missionNamespace setVariable [format ['MCC_rtsMissionObjects_%1', _side],_missionItems];
publicVariable format ['MCC_rtsMissionOn_%1', _side];

//Send hint
[[_missionText,true],"MCC_fnc_globalHint",_side,false] spawn BIS_fnc_MP;

//Cleanup
deleteVehicle _trg;
