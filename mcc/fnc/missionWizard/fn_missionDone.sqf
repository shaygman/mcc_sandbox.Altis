//====================================================MCC_fnc_missionDone=================================================================================================
// Mission Done and allocate resources
// Example:[_faction] call MCC_fnc_missionDone;
// 	_faction		STRING faction string
// Return - nothing
//=============================================================================================================================================================================
//Calculate reources
private ["_resources","_penalty","_baseResource","_succeedObjectives","_sumResource","_CompleteText","_sidePlayer","_resourceGain","_allocationRatio","_allocatedResources","_randomAsset","_totalShells","_sumTickets"];
_mission =  [_this, 0, "Main", [""]] call BIS_fnc_param;
_activeObjectives = [_this, 1, 0, [0]] call BIS_fnc_param;
_failedObjectives = [_this, 2, 0, [0]] call BIS_fnc_param;
_sidePlayer = [_this, 3, west] call BIS_fnc_param;
_totalPlayers = [_this, 4, 10, [0]] call BIS_fnc_param;
_difficulty = [_this, 5, 10, [0]] call BIS_fnc_param;
_baseResource = [_this, 6, 50, [0]] call BIS_fnc_param;
_allocationRatio = [_this, 7, [0.3,0.3,0.2,0.15,0.05], [[]]] call BIS_fnc_param;
_sumTickets =  ([_this, 8, 0, [0]] call BIS_fnc_param) max 0;

//How many resources we get
_succeedObjectives = _activeObjectives - _failedObjectives;
_resources = missionNamespace getvariable [format ["MCC_res%1",_sidePlayer],[500,500,200,200,100]];

if (_mission == "Main") then {
	_penalty = floor (_baseResource*((missionNamespace getvariable [format ["MCC_civiliansKilled_%1",_sidePlayer],0])*3 min 10));
	_resourceGain = floor (_baseResource*_difficulty*((_totalPlayers/5) max 1))*_succeedObjectives;
	} else {
		_penalty = 0;
		_resourceGain = floor (_baseResource*_difficulty*((_totalPlayers/5) max 1))*_failedObjectives;
		_resourceGain = _resourceGain + (floor (_sumTickets*_difficulty) max 1);
	};

_sumResource = _resourceGain - _penalty;

_allocatedResources = [];
{
	_allocatedResources set [_foreachIndex, floor (_resourceGain * _x)];
} forEach _allocationRatio;

//Generate summary
if (_mission != "side") then {
	_CompleteText =         format ["<t align='center' size='1.8' color='#FFCF11'>%1 Mission Completed</t><br/>",_mission]
							+"____________________<br/>"
							+ format ["Total Objectives: %1<br/>",_activeObjectives]
							+ format ["Objectives Succeed: <t color='#2CC916'>%1</t><br/>", _succeedObjectives]
							+ format ["Objectives Failed: <t color='#FF0000'>%1</t><br/>", _failedObjectives]
							+ "____________________<br/>"
							+ format ["Resource Gained: <t color='#2CC916'>%1</t><br/>",_resourceGain]
							+ format ["Collateral Damage Penalty: <t color='#FF0000'>%1</t><br/>", _penalty]
							+ format ["Total Resource gained: %1<br/>",_sumResource]
							+ "____________________<br/><br/>"
							+ "<t align='center' size='1.2' color='#FFCF11'>Assets Gained:</t><br/>";
} else {
	_CompleteText =         "<t align='center' size='1.8' color='#FFCF11'>Enemy Have Completed A Mission</t><br/>"
							+"____________________<br/>"
							+ format ["Total Objectives: %1<br/>",_activeObjectives]
							+ format ["Objectives Succeed: <t color='#FF0000'>%1</t><br/>", _succeedObjectives]
							+ format ["Objectives Failed: <t color='#2CC916'>%1</t><br/>", _failedObjectives]
							+ "____________________<br/>"
							+ format ["Enemy Casualties: <t color='#2CC916'>%1</t><br/>", _sumTickets]
							+ format ["Resource Gained: <t color='#2CC916'>%1</t><br/>",_resourceGain]
							+ "____________________<br/><br/>"
							+ "<t align='center' size='1.2' color='#FFCF11'>Assets Gained:</t><br/>";
};


for "_i" from 0 to 4 do {
	_resources set [_i,(_resources select _i)+(_allocatedResources select _i)];
};

missionNamespace setvariable [format ["MCC_res%1",_sidePlayer],_resources];
publicVariable format ["MCC_res%1",_sidePlayer];

//Reset penalty
missionNamespace setvariable [format ["MCC_civiliansKilled_%1",_sidePlayer],0];
publicVariable format ["MCC_civiliansKilled_%1",_sidePlayer];

private ["_counter","_totalShells","_startPos"];
//Assets if succeed
_totalShells = 0;


_counter = if (_mission != "side") then {_succeedObjectives} else {_failedObjectives};

_startPos = call compile format ["MCC_START_%1",_sidePlayer];

for "_i" from 1 to _counter do {
 	_randomAsset = random 1;

	//Add Supply drop
	if (_randomAsset > 0.2 &&  ([["hq",2], _startPos, 200] call MCC_fnc_CheckBuildings)) then {
		private ["_arrayName","_spawnKind","_planeType","_isParachute","_tempArray","_boxArray","_displayName"];
		_boxArray = [];
		_tempArray = if (_sidePlayer == east) then {MCC_logisticsCrates_TypesEast} else {MCC_logisticsCrates_TypesWest};
		_isParachute = random 1 > 0.5;
		for "_x" from 0 to 2 do {
			_boxArray pushBack (_tempArray select _x);
		};

		switch (floor random 6) do {
		    case 0: {
			    _displayName = "Supply";
			    _spawnKind = [_boxArray select 1];
			};

			case 1: {
			    _displayName = "Fuel";
			    _spawnKind = [_boxArray select 2];
			};

		    default {
			    _displayName = "Ammo";
			    _spawnKind = [_boxArray select 0];
		    };
		};

		_planeType = ["I_Heli_Transport_02_F"];
		_arrayName = format ["MCC_ConsoleAirdropArray%1",_sidePlayer];
		_array = missionNameSpace getVariable [_arrayName,[]];
		_array pushBack [[_spawnKind], _planeType,_isParachute];
		missionNameSpace setVariable [_arrayName,_array];
		publicvariable _arrayName;

		_CompleteText = _CompleteText + format ["1 X %1 Box Drop <br/>",_displayName];
	};

	//Aritllery add
	if (_randomAsset > 0.4) then {

		private ["_nshell"];
		_nshell = ((floor random 3) +1) * 10;
		_totalShells = _totalShells + _nshell;
		HW_arti_number_shells_per_hour = (missionNamespace getvariable ["HW_arti_number_shells_per_hour",0]) + _nshell;
		publicVariable "HW_arti_number_shells_per_hour";

		switch (_sidePlayer) do {
			case west : {MCC_server setVariable ["Arti_WEST_shellsleft",HW_arti_number_shells_per_hour,true]};
			case east : {MCC_server setVariable ["Arti_EAST_shellsleft",HW_arti_number_shells_per_hour,true]};
			case resistance : {MCC_server setVariable ["Arti_GUER_shellsleft",HW_arti_number_shells_per_hour,true]};
			default {MCC_server setVariable ["Arti_CIV_shellsleft",HW_arti_number_shells_per_hour,true]};
		};
	};

	//CAS
	if (_randomAsset > 0.6 && ([["hq",3], _startPos, 200] call MCC_fnc_CheckBuildings)) then {
		private ["_arrayName","_spawnKind","_planeType"];
		_spawnKind = ["Gun-run (Zeus)","Rockets-run (Zeus)","CAS-run (Zeus)","SnD","Rockets-run","AA run","JDAM","LGB","Bombing-run"] call bis_fnc_selectRandom;
		_planeType = switch (_sidePlayer) do {
						case west : {["B_Plane_CAS_01_F"]};
						case east : {["O_Plane_CAS_02_F"]};
						default {["I_Plane_Fighter_03_CAS_F"]};
					};
		_arrayName		= format ["MCC_CASConsoleArray%1",_sidePlayer];
		_array = missionNameSpace getVariable [_arrayName,[]];
		_array pushBack [[_spawnKind], _planeType];
		missionNameSpace setVariable [_arrayName,_array];
		publicvariable _arrayName;

		_CompleteText = _CompleteText + format ["1 X %1 CAS <br/>",_spawnKind];
	};
};

//If we got artillery rounds
if (_totalShells > 0) then {
	_CompleteText = _CompleteText + format ["%1 X Artillery Shells <br/>",_totalShells];
};

//Generate resources
_CompleteText = _CompleteText  	+ "____________________<br/><br/>"
								+ "<t align='center' size='1.2' color='#FFCF11'>Resources Allocation:</t><br/><br/>"
								+ format ["<t align='center'><img image='%2data\IconAmmo.paa'/> Ammo: %1</t><br/><br/>",_allocatedResources select 0,MCC_path]
								+ format ["<t align='center'><img image='%2data\IconRepair.paa'/> Supply: %1</t><br/><br/>",_allocatedResources select 1,MCC_path]
								+ format ["<t align='center'><img image='%2data\IconFuel.paa'/> Fuel: %1</t><br/><br/>",_allocatedResources select 2,MCC_path]
								+ format ["<t align='center'><img image='%2data\IconFood.paa'/> Food: %1</t><br/><br/>",_allocatedResources select 3,MCC_path]
								+ format ["<t align='center'><img image='%2data\IconMed.paa'/> Meds: %1</t><br/><br/>",_allocatedResources select 4,MCC_path];

//Send hint
[[_CompleteText,true],"MCC_fnc_globalHint",_sidePlayer,false] spawn BIS_fnc_MP;



