//===============================================================MCC_fnc_logTruckAdd==========================================================================================
// Add or remove crates from a log truck
//============================================================================================================================================================================
#define CRATE_COST 200
#define ANCHOR_POINT_WEST [0,-0.2,0]
#define ANCHOR_POINT_EAST [0,-0.9,0]
#define ANCHOR_POINT_GUER [0,+0.5,0]

#define MCC_LOGISTICS_LOAD_TRUCK (uiNamespace getVariable "MCC_LOGISTICS_LOAD_TRUCK")
#define MCC_loadTruckC1 (uiNamespace getVariable "MCC_loadTruckC1")

#define MCC_loadTruckSupplies (uiNamespace getVariable "MCC_loadTruckSupplies")
#define MCC_loadTruckRepair (uiNamespace getVariable "MCC_loadTruckRepair")
#define MCC_loadTruckFuel (uiNamespace getVariable "MCC_loadTruckFuel")

#define MCC_loadTruckOutpot (uiNamespace getVariable "MCC_loadTruckOutpot")
#define MCC_loadTruckOutpot2 (uiNamespace getVariable "MCC_loadTruckOutpot2")
#define MCC_loadTruckOutpot3 (uiNamespace getVariable "MCC_loadTruckOutpot3")


private ["_add","_loadedCrates","_truck","_crateType","_index","_array","_resLevel","_crate","_attachPoint","_attachedObjects","_startLoad","_nearByCrates",
	         "_position","_factor","_unload","_isHeli","_maxLoad","_pos","_costFactor"];
_add 		= _this select 0;
_startLoad	= _this select 1;
_ctrl		= (_this select 2) select 0;
_isHeli		= _this select 3;
_unload		= false;
_maxLoad = if (_isHeli) then {1} else {3};

if (uiNameSpace getVariable ["MCC_logisticLoadingPressed", false]) exitWith {};
uiNameSpace setVariable ["MCC_logisticLoadingPressed", true];
_truck = vehicle player;

if (typeof vehicle player == "O_Heli_Transport_04_F") then {
	MCC_logisticsCrates_Types = MCC_logisticsCrates_TypesEast;
} else {
	MCC_logisticsCrates_Types = MCC_logisticsCrates_TypesWest;
};

_attachPoint = switch (MCC_supplyTracks find typeof _truck) do
				{
					case 0: {ANCHOR_POINT_WEST};
					case 1: {ANCHOR_POINT_EAST};
					case 2: {ANCHOR_POINT_GUER};
					default {[0,0,0]};
				};
_loadedCrates = if (_isHeli) then {
					if !(isnull getSlingLoad _truck) then {[getSlingLoad _truck]} else {[]};
				} else {
					_truck getVariable ["mcc_supplyTruckCurrentLoad",[]];
				};

_array = call compile format ["MCC_res%1",playerside];

if (_add) then {
	if (count _loadedCrates <_maxLoad) then {

		//if near HQ get type of crate and resources the player want to get or remove
		if (_startLoad) then {
			_crateType = MCC_loadTruckC1 lbData (lbCurSel MCC_loadTruckC1);
			_index = MCC_logisticsCrates_Types find _crateType;
			if (_index > 5) then {
				_costFactor = 3;
				_index = 1;
			} else {
				_costFactor = if (_index > 2) then {4} else {1};
				_index = (_index % 3);
			};
			_resLevel = _array select _index;
		};

		//Is Heli
		if (_isHeli) then
		{
			if (_startLoad) then
			{
				if (_resLevel >= (CRATE_COST*_costFactor)) then
				{
					_crate = _crateType createVehicle [0,0,0];

					//Set ammo count and helper
					_crate setVariable ["ammoLeft",200*_costFactor,true];
					[[_crate, "Hold %1 to resupply"], "MCC_fnc_createHelper", false] call BIS_fnc_MP;

					_crate setVariable ["MCC_loadedBy", getplayeruid player, true];
					//Change mass
					if (_costFactor == 1) then {_crate setMass 500};

					//Change mass for the AAF heli
					if (_costFactor == 4) then {_crate setMass 4000};

					if (_truck canSlingLoad _crate) then
					{
						_pos = getpos _truck;
						_crate setpos [_pos select 0, _pos select 1, 0];
						_truck setSlingLoad _crate;

						_loadedCrates set [count _loadedCrates, _crateType];
						_truck setVariable ["mcc_supplyTruckCurrentLoad",_loadedCrates, true];

						//reduce cost
						_array set [_index, _resLevel - (CRATE_COST*_costFactor)];
						missionNamespace setVariable [format ["MCC_res%1",playerside],_array];
						publicVariable format ["MCC_res%1",playerside];
					}
					else
					{
						systemChat "Can't lift this";
						deleteVehicle _crate;
						[_isHeli] spawn MCC_fnc_logTruckRefresh;
						uiNameSpace setVariable ["MCC_logisticLoadingPressed", false];
					};
				};
			};
		}
		else
		{
			if (_startLoad) then
			{
				if (_resLevel >= CRATE_COST) then
				{

					_crate = _crateType createVehicle [0,0,0];

					//Set ammo count and helper
					_crate setVariable ["ammoLeft",100,true];
					[[_crate, "Hold %1 to resupply"], "MCC_fnc_createHelper", false] call BIS_fnc_MP;

					_crate setVariable ["MCC_loadedBy", getplayeruid player, true];

					//Change mass
					if (_costFactor == 1) then {_crate setMass 500};

					_attachPoint set [1, (_attachPoint select 1)- (count _loadedCrates*1.6)];
					_crate attachTo [_truck, _attachPoint];

					_loadedCrates set [count _loadedCrates, _crateType];
					_truck setVariable ["mcc_supplyTruckCurrentLoad",_loadedCrates, true];

					//reduce cost
					_array set [_index, _resLevel - CRATE_COST];
					missionNamespace setVariable [format ["MCC_res%1",playerside],_array];
					publicVariable format ["MCC_res%1",playerside];
				};
			}
			else
			{
				_nearByCrates = [];
				{
					if (isNull attachedTo _x) then
					{
						_nearByCrates set [count _nearByCrates, _x];
					};
				} foreach (nearestObjects [getposATL _truck, MCC_logisticsCrates_Types ,50]);

				if (count _nearByCrates >0) then
				{
					_crate = _nearByCrates select 0;
					_attachPoint set [1, (_attachPoint select 1)- (count _loadedCrates*1.6)];
					_crate attachTo [_truck, _attachPoint];
					_loadedCrates set [count _loadedCrates, typeof _crate];
					_truck setVariable ["mcc_supplyTruckCurrentLoad",_loadedCrates, true];
				}
				else
				{
					systemchat "No crate from this type found";
				};
			};
		};
	};
}
else
{
	if (_isHeli) then
	{
		_crate =  getSlingLoad _truck;
		_crateType = typeof _crate;
		if (_crateType in  MCC_logisticsCrates_Types && _startLoad) then
		{
			_index = MCC_logisticsCrates_Types find _crateType;
			if (_index > 5) then
			{
				_costFactor = 4;
				_index = 1;
			}
			else
			{
				_costFactor = if (_index > 2) then {4} else {1};
				_index = (_index % 3);
			};
			_resLevel = _array select _index;

			{ropeDestroy _x} foreach ropes _truck;
			_factor = if (MCC_isMode) then
						{
							switch (_index) do
							{
								case 0 : {getAmmoCargo _crate};
								case 1 : {getRepairCargo _crate};
								case 2 : {getFuelCargo _crate};
							};
						}
						else {1};
			deleteVehicle _crate;

			//refund cost
			_array set [_index, _resLevel + (CRATE_COST * _factor * _costFactor)];
			missionNamespace setVariable [format ["MCC_res%1",playerside],_array];
			publicVariable format ["MCC_res%1",playerside];
		};
	}
	else
	{
		if (count _loadedCrates >0) then
		{
			//get type of crate and resources
			_crateType = _loadedCrates select (count _loadedCrates -1);
			_index = MCC_logisticsCrates_Types find _crateType;
			_resLevel = _array select _index;


			//remove from truck
			_attachedObjects = attachedObjects _truck;
			_crate =  (_attachedObjects select (count _attachedObjects)-1);
			_crate disableCollisionWith _truck;

			if (_startLoad) then
			{
				detach _crate;
				_factor = if (MCC_isMode) then
							{
								switch (_index) do
								{
									case 0 : {getAmmoCargo _crate};
									case 1 : {getRepairCargo _crate};
									case 2 : {getFuelCargo _crate};
								};
							}
							else {1};
				deleteVehicle _crate;
				_unload		= true;
			}
			else
			{
				_position = ATLtoASL(_truck modelToworld [0,(-12 + (count _loadedCrates*1.6)),0]);

				while {!lineIntersects [_position, [_position select 0, _position select 1, (_position select 2) + 1]] && _position select 2 > getTerrainHeightASL _position} do
				{
					_position set [2, (_position select 2) - 0.1];
				};

				if (_position select 2 < getTerrainHeightASL _position) then
				{
					_position set [2, getTerrainHeightASL _position];
				};

				while {lineIntersects [_position, [_position select 0, _position select 1, (_position select 2) + 1]]} do
				{
					_position set [2, (_position select 2) + 0.01];
				};

				_obj = lineIntersectsObjs [_position, getpos _truck, _truck, _truck, true, 32];

				_position = ASLtoATL _position;

				if (!(lineIntersects [getPosASL _truck, _position]) && count _obj == 0) then
				{
					detach _crate;
					_crate setposATL _position;
					_unload		= true;
				}
				else
				{
					systemchat "There is not enough space to unload cargo";
				};
			};

			if (_unload) then
			{
				if !(_isheli) then {waituntil {count ( attachedObjects _truck) != count _attachedObjects}};

				_loadedCrates set [(count _loadedCrates)-1, -1];
				_loadedCrates = _loadedCrates - [-1];
				_truck setVariable ["mcc_supplyTruckCurrentLoad",_loadedCrates, true];

				if (_startLoad) then
				{
					//refund cost
					_array set [_index, _resLevel + (CRATE_COST*_factor)];
					missionNamespace setVariable [format ["MCC_res%1",playerside],_array];
					publicVariable format ["MCC_res%1",playerside];
				};
			};
		};
	};
};

[_isHeli] spawn MCC_fnc_logTruckRefresh;
uiNameSpace setVariable ["MCC_logisticLoadingPressed", false];



