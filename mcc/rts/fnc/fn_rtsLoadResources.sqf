//=================================================================MCC_fnc_rtsloadResources==============================================================================
//	Opens logistics dialog
//  Parameter(s):
//     	_ctrl: CONTROL
//==============================================================================================================================================================================
private ["_resource","_truck","_cratesType","_attachPoint","_loadedCrates","_res","_maxLoad","_nearByCrates","_crate","_fncLoadCrate"];
#define CRATE_COST 200
#define ANCHOR_POINT_WEST [0,-0.2,0]
#define ANCHOR_POINT_EAST [0,-0.9,0]
#define ANCHOR_POINT_GUER [0,+0.5,0]

disableSerialization;
_resource = param [0,"",[controlNull,""]];

if (count MCC_ConsoleGroupSelected <=0) exitWith {};

_truck = vehicle leader (MCC_ConsoleGroupSelected select 0);

//Find crates types
_cratesType = missionNamespace getVariable ["MCC_logisticsCrates_TypesWest",[]];
if (count _cratesType <=0) exitWith {diag_log "MCC Logistics: Error MCC_logisticsCrates_TypesWest not defined"};

_attachPoint =switch (getnumber(configfile >> "CfgVehicles" >> typeof _truck >> "side" )) do
				{
					case 0: {ANCHOR_POINT_EAST};
					case 1: {ANCHOR_POINT_WEST};
					default {ANCHOR_POINT_GUER};
				};
if (str _attachPoint == "[0,0,0]") exitWith {};

_loadedCrates = _truck getVariable ["mcc_supplyTruckCurrentLoad",[]];

_res = call compile format ["MCC_res%1",playerside];
_maxLoad =3;

_fncLoadCrate = {
	_crate = (_cratesType select _this) createVehicle [0,0,0];

	//Set ammo count and helper
	_crate setVariable ["ammoLeft",100,true];
	[_crate, "Hold %1 to resupply"] remoteExec ["MCC_fnc_createHelper",0,true];
	_crate setVariable ["MCC_loadedBy", getplayeruid player, true];

	_attachPoint set [1, (_attachPoint select 1)- (count _loadedCrates*1.6)];
	_crate attachTo [_truck, _attachPoint];

	_loadedCrates pushBack (typeof _crate);
	_truck setVariable ["mcc_supplyTruckCurrentLoad",_loadedCrates, true];

	//reduce cost
	_res set [_this, (_res select _this) - CRATE_COST];
	missionNamespace setVariable [format ["MCC_res%1",playerside],_res];
	publicVariable format ["MCC_res%1",playerside];
};

if (count _loadedCrates >=_maxLoad) exitWith {[9989,"Maximum Load Reached",5,true] call MCC_fnc_setIDCText;false};
switch (true) do
{
	//Withdraw Ammo
	case (_resource isEqualTo "ammo"):
	{
		if ((_res select 0) >= CRATE_COST) then {
			0 call _fncLoadCrate;
		} else {
			[9989,"Not Enough Resources",5,true] call MCC_fnc_setIDCText;
		};
	};

	//Withdraw Supply
	case (_resource isEqualTo "supply"):
	{
		if ((_res select 1) >= CRATE_COST) then {
			1 call _fncLoadCrate;
		} else {
			[9989,"Not Enough Resources",5,true] call MCC_fnc_setIDCText;
		};
	};

	//Withdraw Fuel
	case (_resource isEqualTo "fuel"):
	{
		if ((_res select 2) >= CRATE_COST) then {
			2 call _fncLoadCrate;
		} else {
			[9989,"Not Enough Resources",5,true] call MCC_fnc_setIDCText;
		};
	};

	//Find nearby crates
	default
	{
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
			_loadedCrates pushBack (typeof _crate);
			_truck setVariable ["mcc_supplyTruckCurrentLoad",_loadedCrates, true];
		};
	};
};
