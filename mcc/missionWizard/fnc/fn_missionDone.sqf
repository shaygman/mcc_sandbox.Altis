//====================================================MCC_fnc_missionDone=================================================================================================
// Mission Done and allocate resources
// Example:[_faction] call MCC_fnc_missionDone;
// 	_faction		STRING faction string
// Return - nothing
//=============================================================================================================================================================================
//Calculate reources
private ["_resources","_penalty","_baseResource","_succeedObjectives","_sumResource","_CompleteText","_sidePlayer","_resourceGain","_allocationRatio","_allocatedResources","_randomAsset","_totalShells","_sumTickets","_maxResources","_storagePenalty","_res"];
_mission =  param [ 0, "Main", [""]];
_activeObjectives =  param [ 1, 0, [0]];
_failedObjectives =  param [ 2, 0, [0]];
_sidePlayer =  param [ 3, west];
_totalPlayers =  param [ 4, 10, [0]];
_difficulty =  param [ 5, 10, [0]];
_baseResource =  param [ 6, 50, [0]];
_allocationRatio =  param [ 7, [0.3,0.3,0.2,0.15,0.05], [[]]];
_sumTickets =  ( param [ 8, 0, [0]]) max 0;

//How many resources we get
_succeedObjectives = _activeObjectives - _failedObjectives;
_resources = missionNamespace getvariable [format ["MCC_res%1",_sidePlayer],[500,500,200,200,100]];

if (_mission == "Main") then {
	_penalty = floor (_baseResource*((missionNamespace getvariable [format ["MCC_civiliansKilled_%1",_sidePlayer],0])*3 min 10));
	_resourceGain = floor (_baseResource*_difficulty*((_totalPlayers/10) max 1))*_succeedObjectives;
	} else {
		_penalty = 0;
		_resourceGain = floor (_baseResource*_difficulty*((_totalPlayers/5) max 1))*_failedObjectives;
		_resourceGain = _resourceGain + (floor (_sumTickets*_difficulty) max 1);
	};

_allocatedResources = [];
{
	_allocatedResources set [_foreachIndex, floor (_resourceGain * _x)];
} forEach _allocationRatio;

//Make sure we are not giving more resources then storage areas
_maxResources = ["resources",_sidePlayer] call MCC_fnc_rtsCalculateResourceTreshold;
_sumResource = (_resourceGain - _penalty) max 0;

//Make sure we are not giving more resources then storage areas
_storagePenalty = 0;
for "_i" from 0 to 4 do {
	_res = (_resources select _i)+(_allocatedResources select _i);
	_storagePenalty = _storagePenalty + ((_res - _maxResources) max 0);
	_resources set [_i,(_resources select _i)+(_allocatedResources select _i) min _maxResources];
};

_sumResource = (_sumResource - _storagePenalty) max 0;

//Calculate resources allocation again this time from the sum resouces for the UI
_allocatedResources = [];
{
	_allocatedResources set [_foreachIndex, floor (_sumResource * _x)];
} forEach _allocationRatio;


//Generate summary
if (_mission != "side") then {
	_CompleteText =         format ["<t align='center' size='1.8' color='#FFCF11'>%1 Mission Completed</t><br/>",_mission]
							+"____________________<br/>"
							+ format ["Total Objectives: %1<br/>",_activeObjectives]
							+ format ["Objectives Succeed: <t color='#2CC916'>%1</t><br/>", _succeedObjectives]
							+ format ["Objectives Failed: <t color='#FF0000'>%1</t><br/>", _failedObjectives]
							+ "____________________<br/>"
							+ format ["Resource Gained: <t color='#2CC916'>%1</t><br/>",_resourceGain max 0]
							+ format ["Penalty - Collateral Damage: <t color='#FF0000'>%1</t><br/>", _penalty]
							+ format ["Penalty - No Storage: <t color='#FF0000'>%1</t><br/>", _storagePenalty]
							+ format ["Total Resource gained: <t color='#2CC916'>%1</t><br/>",_sumResource]
							+ "____________________<br/><br/>";
} else {
	_CompleteText =         "<t align='center' size='1.8' color='#FFCF11'>Enemy Have Completed A Mission</t><br/>"
							+"____________________<br/>"
							+ format ["Total Objectives: %1<br/>",_activeObjectives]
							+ format ["Objectives Succeed: <t color='#FF0000'>%1</t><br/>", _succeedObjectives]
							+ format ["Objectives Failed: <t color='#2CC916'>%1</t><br/>", _failedObjectives]
							+ "____________________<br/>"
							+ format ["Enemy Casualties: <t color='#2CC916'>%1</t><br/>", _sumTickets]
							+ "____________________<br/><br/>";

};




missionNamespace setvariable [format ["MCC_res%1",_sidePlayer],_resources];
publicVariable format ["MCC_res%1",_sidePlayer];

//--------------------------------------Civilians behavior---------------------------------
private _civRelations = missionNamespace getvariable [format ["MCC_civRelations_%1",_sidePlayer],0.5];

//penalty for killing civis
_civRelations = (_civRelations - ((missionNamespace getvariable [format ["MCC_civiliansKilled_%1",_sidePlayer],0])*0.1));

//Civ Relation
private _relationText = if (_civRelations > 0.9) then {"Excelent"} else {
					if (_civRelations > 0.75) then {"Very good"} else {
						if (_civRelations > 0.6) then {"Good"} else {
							if (_civRelations > 0.5) then {"Neutral "} else {
								if (_civRelations > 0.3) then {"Bad"} else {"Awful"};
							};
						};
					};
				};


_CompleteText = _CompleteText 	+  "<t align='center' size='1.2' color='#FFCF11'> Hearts and Minds</t><br/>"
								+ format ["Civilians Killed: <t color='#FF0000'>%1</t><br/>",(missionNamespace getvariable [format ["MCC_civiliansKilled_%1",_sidePlayer],0])]
								+ format ["The local population relation to you is:<br/> %1 <br/>",_relationText]
								+ "____________________<br/><br/>";

//penalty for failed objectives
_civRelations = (_civRelations + (_succeedObjectives - _failedObjectives)*0.1);

_civRelations = (_civRelations max 0) min 1;

missionNamespace setvariable [format ["MCC_civRelations_%1",_sidePlayer],_civRelations];
publicVariable format ["MCC_civRelations_%1",_sidePlayer];

//Reset penalty
missionNamespace setvariable [format ["MCC_civiliansKilled_%1",_sidePlayer],0];
publicVariable format ["MCC_civiliansKilled_%1",_sidePlayer];

private ["_counter","_totalShells","_startPos"];

//Assets if succeed
_totalShells = 0;
_counter = if (_mission != "side") then {_succeedObjectives} else {_failedObjectives};
_startPos = call compile format ["MCC_START_%1",_sidePlayer];

_CompleteText = _CompleteText + "<t align='center' size='1.2' color='#FFCF11'>Assets Gained:</t><br/>";
for "_i" from 1 to _counter do {
 	_randomAsset = random 1;

	//Add Supply drop
	if (_randomAsset > 0.2 &&  ([["hq",2], _sidePlayer, 200] call MCC_fnc_CheckBuildings)) then {
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
	if (_randomAsset > 0.6 && ([["hq",3], _sidePlayer, 200] call MCC_fnc_CheckBuildings)) then {
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



