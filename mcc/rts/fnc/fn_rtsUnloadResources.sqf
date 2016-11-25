//=================================================================MCC_fnc_rtsLoadResources==============================================================================
//	Opens logistics dialog
//  Parameter(s):
//     	_ctrl: CONTROL
//==============================================================================================================================================================================
private ["_ctrl","_truck","_cratesType","_attachPoint","_loadedCrates","_res","_unload","_maxLoad","_startPos","_nearByCrates","_crate","_resLevel","_attachedObjects","_position","_factor"];
#define CRATE_COST 200
#define ANCHOR_POINT_WEST [0,-0.2,0]
#define ANCHOR_POINT_EAST [0,-0.9,0]
#define ANCHOR_POINT_GUER [0,+0.5,0]

disableSerialization;
_ctrl = _this select 0;

if (count MCC_ConsoleGroupSelected <=0) exitWith {};

_truck = vehicle leader (MCC_ConsoleGroupSelected select 0);
_cratesType = missionNamespace getVariable ["MCC_logisticsCrates_TypesWest",[]];

_attachPoint = switch (getnumber(configfile >> "CfgVehicles" >> typeof _truck >> "side" )) do
				{
					case 0: {ANCHOR_POINT_EAST};
					case 1: {ANCHOR_POINT_WEST};
					default {ANCHOR_POINT_GUER};
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

if (count _loadedCrates >0) then {
	//get type of crate and resources
	_crateType = _loadedCrates select (count _loadedCrates -1);
	_index = _cratesType find _crateType;
	_resLevel = _res select _index;


	//remove from truck
	_attachedObjects = attachedObjects _truck;
	_crate =  (_attachedObjects select (count _attachedObjects)-1);
	_crate disableCollisionWith _truck;

	if (_startLoad) then {
		detach _crate;
		_factor = if (MCC_isMode) then {
						switch (_index) do
						{
							case 0 : {getAmmoCargo _crate};
							case 1 : {getRepairCargo _crate};
							case 2 : {getFuelCargo _crate};
						};
					} else {1};
		deleteVehicle _crate;
		_unload		= true;
	} else {

		_position = ATLtoASL(_truck modelToworld [0,(-12 + (count _loadedCrates*1.6)),0]);

		while {!lineIntersects [_position, [_position select 0, _position select 1, (_position select 2) + 1]] && _position select 2 > getTerrainHeightASL _position} do {
			_position set [2, (_position select 2) - 0.1];
		};

		if (_position select 2 < getTerrainHeightASL _position) then {
			_position set [2, getTerrainHeightASL _position];
		};

		while {lineIntersects [_position, [_position select 0, _position select 1, (_position select 2) + 1]]} do {
			_position set [2, (_position select 2) + 0.01];
		};

		_obj = lineIntersectsObjs [_position, getpos _truck, _truck, _truck, true, 32];

		_position = ASLtoATL _position;

		if (!(lineIntersects [getPosASL _truck, _position]) && count _obj == 0) then {
			detach _crate;
			_crate setposATL _position;
			_unload		= true;
		} else {
			systemchat "There is not enough space to unload cargo";
		};
	};

	if (_unload) then {
		waituntil {count ( attachedObjects _truck) != count _attachedObjects};

		_loadedCrates set [(count _loadedCrates)-1, -1];
		_loadedCrates = _loadedCrates - [-1];
		_truck setVariable ["mcc_supplyTruckCurrentLoad",_loadedCrates, true];

		if (_startLoad) then {
			//refund cost
			_res set [_index, _resLevel + (CRATE_COST*_factor)];
			missionNamespace setVariable [format ["MCC_res%1",playerside],_res];
			publicVariable format ["MCC_res%1",playerside];
		};
	};
};