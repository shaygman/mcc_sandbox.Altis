//=================================================================MCC_fnc_rtsUnloadResources==============================================================================
//	Opens logistics dialog
//  Parameter(s):
//     	_ctrl: CONTROL
//==============================================================================================================================================================================
private ["_ctrl","_truck","_cratesType","_attachPoint","_loadedCrates","_res","_unload","_maxLoad","_startPos","_nearByCrates","_crate"];
#define CRATE_COST 200
#define ANCHOR_POINT_WEST [0,-0.2,0]
#define ANCHOR_POINT_EAST [0,-0.9,0]
#define ANCHOR_POINT_GUER [0,+0.5,0]

disableSerialization;
_ctrl = _this select 0;

if (count MCC_ConsoleGroupSelected <=0) exitWith {};

_truck = vehicle leader (MCC_ConsoleGroupSelected select 0);
_cratesType = missionNamespace getVariable ["MCC_logisticsCrates_TypesWest",[]];

_attachPoint = switch ((missionNamespace getVariable ["MCC_supplyTracks",[]]) find typeof _truck) do {
					case 0: {ANCHOR_POINT_WEST};
					case 1: {ANCHOR_POINT_EAST};
					case 2: {ANCHOR_POINT_GUER};
					default {[0,0,0]};
				};
if (str _attachPoint == "[0,0,0]") exitWith {};

_loadedCrates = _truck getVariable ["mcc_supplyTruckCurrentLoad",[]];

_res = call compile format ["MCC_res%1",playerside];
_unload	= false;
_maxLoad =3;

//Are we near start location
_startPos = call compile format ["MCC_START_%1",playerside];
if (isnil "_startPos") then {_startPos = [0,0,0]};
_startLoad = _startPos distance _truck <= 50;

if (count _loadedCrates <_maxLoad) then {
	_nearByCrates = [];

	{
		if (isNull attachedTo _x) then {
			_nearByCrates pushBack _x;
		};
	} foreach (nearestObjects [getposATL _truck, _cratesType ,50]);

	if (count _nearByCrates >0) then {
		_crate = _nearByCrates select 0;
		_attachPoint set [1, (_attachPoint select 1)- (count _loadedCrates*1.6)];
		_crate attachTo [_truck, _attachPoint];
		_loadedCrates set [count _loadedCrates, typeof _crate];
		_truck setVariable ["mcc_supplyTruckCurrentLoad",_loadedCrates, true];
	};
};