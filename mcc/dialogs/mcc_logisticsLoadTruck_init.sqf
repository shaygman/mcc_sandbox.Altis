private ["_disp","_comboBox","_index","_displayname","_array","_class","_pic","_sideID","_startLoad"];
disableSerialization;

waituntil {dialog};

_disp = _this select 0;
uiNamespace setVariable ["MCC_LOGISTICS_LOAD_TRUCK", _disp];
uiNamespace setVariable ["MCC_loadTruckC1", _disp displayCtrl 0];

uiNamespace setVariable ["MCC_loadTruckSupplies", _disp displayCtrl 1];
uiNamespace setVariable ["MCC_loadTruckRepair", _disp displayCtrl 2];
uiNamespace setVariable ["MCC_loadTruckFuel", _disp displayCtrl 3];

uiNamespace setVariable ["MCC_loadTruckOutpot", _disp displayCtrl 4];
uiNamespace setVariable ["MCC_loadTruckOutpot2", _disp displayCtrl 5];
uiNamespace setVariable ["MCC_loadTruckOutpot3", _disp displayCtrl 6];
#define CRATE_COST 100
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

MCC_FNC_LOGTRUCK_REFRESH =
{
	private ["_loadedCrates","_loadedCratesIDC","_ctrl","_displayname","_truck"];
	_truck = vehicle player; 
	_loadedCrates = _truck getVariable ["mcc_supplyTruckCurrentLoad",[]];
	_loadedCratesIDC = [MCC_loadTruckOutpot,MCC_loadTruckOutpot2,MCC_loadTruckOutpot3]; 
	
	//clear
	{
		_x ctrlsetText "";
	} foreach _loadedCratesIDC;
	
	//load
	{
		_ctrl =  _loadedCratesIDC select _foreachIndex; 
		_displayname 	= getText(configFile >> "CfgVehicles">> _x >> "displayname");
		//_pic 			= getText(configFile >> "CfgVehicles">> _x >> "picture");
		_ctrl ctrlsetText _displayname;
	} foreach _loadedCrates;
};

MCC_FNC_LOGTRUCK_ADD = 
{
	private ["_add","_loadedCrates","_truck","_crateType","_index","_array","_resLevel","_crate","_attachPoint","_attachedObjects","_startLoad","_nearByCrates",
	         "_position","_factor","_unload"];
	_add 		= _this select 0;
	_startLoad	= _this select 1;
	_ctrl		= (_this select 2) select 0;
	_unload		= false; 
	if (uiNameSpace getVariable ["MCC_logisticLoadingPressed", false]) exitWith {}; 
	
	uiNameSpace setVariable ["MCC_logisticLoadingPressed", true];
	
	_truck = vehicle player; 
	_attachPoint = switch (MCC_supplyTracks find typeof _truck) do
					{
						case 0: {ANCHOR_POINT_WEST};
						case 1: {ANCHOR_POINT_EAST};
						case 2: {ANCHOR_POINT_GUER};
						default {[0,0,0]};
					};
	_loadedCrates = _truck getVariable ["mcc_supplyTruckCurrentLoad",[]];
	_array = call compile format ["MCC_res%1",playerside];
	
	
	if (_add) then
	{
		if (count _loadedCrates <3) then
		{
			//get type of crate and resources
			_crateType = MCC_loadTruckC1 lbData (lbCurSel MCC_loadTruckC1);
			_index = MCC_logisticsCrates_Types find _crateType;
			_resLevel = _array select _index; 
			
			if (_startLoad) then
			{
				if (_resLevel >= CRATE_COST) then
				{
					
					_crate = _crateType createVehicle [0,0,0];
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
					player sidechat "No crate from this type found"; 
				};
			};
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
					player sidechat "There is not enough space to unload cargo"; 
				};
			};
			
			if (_unload) then
			{
				waituntil {count ( attachedObjects _truck) != count _attachedObjects}; 
				
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
	
	[] call MCC_FNC_LOGTRUCK_REFRESH;
	uiNameSpace setVariable ["MCC_logisticLoadingPressed", false];
};

_sideID = playerside call BIS_fnc_sideID;
_startLoad = player getVariable ["mcc_logTruck_screenStart",false];

_comboBox = MCC_loadTruckC1; 
lbClear _comboBox;
{
	_class			= configName(configFile >> "CfgVehicles">> _x);
	_displayname 	= getText(configFile >> "CfgVehicles">> _x >> "displayname");
	//_pic 			= getText(configFile >> "CfgVehicles">> _x >> "picture");
	_comboBox lbAdd _displayname;
	
	//_comboBox lbSetPicture [_foreachIndex, _pic];
	_comboBox lbSetData [_foreachindex, _class];
} foreach MCC_logisticsCrates_Types;
lbSort [_comboBox, "ASC"];
_comboBox lbSetCurSel 0;

//If not empty truck
[] call MCC_FNC_LOGTRUCK_REFRESH;

//If + or - pressed
(_disp displayCtrl 1000) ctrlAddEventHandler ["ButtonClick",format ["[false, %1, _this] call MCC_FNC_LOGTRUCK_ADD",_startLoad]]; 
(_disp displayCtrl 1001) ctrlAddEventHandler ["ButtonClick",format ["[true, %1, _this] call MCC_FNC_LOGTRUCK_ADD",_startLoad]];

//Load available resources
while {dialog} do
{
	_array = call compile format ["MCC_res%1",playerside];
	MCC_loadTruckSupplies ctrlSetText str floor (_array select 1); 
	MCC_loadTruckRepair ctrlSetText str floor (_array select 0); 
	MCC_loadTruckFuel ctrlSetText str floor (_array select 2); 
	sleep 0.1;
};