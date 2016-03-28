private ["_disp","_comboBox","_index","_displayname","_array","_class","_pic","_sideID","_startLoad","_isHeli","_cargoBoxesType","_maxCounter","_className","_maxLoad"];
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

_sideID = playerside call BIS_fnc_sideID;
_startLoad = player getVariable ["mcc_logTruck_screenStart",false];

_isHeli = (vehicle player isKindOf "helicopter");
MCC_logisticsCrates_Types = MCC_logisticsCrates_TypesWest;

//Are we next to the HQ?
if (_startLoad) then {

	//If heli
	if (vehicle player isKindOf "helicopter") then {
		{_x ctrlShow false} foreach [MCC_loadTruckOutpot,MCC_loadTruckOutpot3];

		//Are we using the Tarou
		if (typeof vehicle player == "O_Heli_Transport_04_F") then {
			MCC_logisticsCrates_Types = MCC_logisticsCrates_TypesEast;
		};

		_maxLoad = getNumber(configfile >> "CfgVehicles" >> typeof vehicle player >> "maximumLoad");

		//Limit heavy boxes for small helicopters
		_maxCounter = if (_maxLoad < 4500) then {2} else {(count MCC_logisticsCrates_Types)-1};
	} else {
		_maxCounter = 2;
		_maxLoad = 9999;
	};

	//Start filling the list
	_comboBox = MCC_loadTruckC1;
	lbClear _comboBox;

	for "_i" from 0 to _maxCounter do {
		_className = MCC_logisticsCrates_Types select _i;
		_class = configName(configFile >> "CfgVehicles">> _className);

		if ((_i <3) && ! MCC_isMode) then {
			_displayname = ["Ammo Crate - 200 Res","Supply Crate - 200 Res","Fuel Crate - 200 Res"] select _i;
		} else {
			_displayname = (getText(configFile >> "CfgVehicles">> _className >> "displayname")) + (if (_i <3) then {" - 200 Res"} else {" - 800 Res"});
		};

		_comboBox lbAdd _displayname;
		_comboBox lbSetData [_i, _class];
	};
	_comboBox lbSetCurSel 0;

	//If + or - pressed
	(_disp displayCtrl 1000) ctrlAddEventHandler ["ButtonClick",format ["[false, %1, _this, %2] call MCC_fnc_logTruckAdd",_startLoad, _isHeli]];
	(_disp displayCtrl 1001) ctrlAddEventHandler ["ButtonClick",format ["[true, %1, _this, %2] call MCC_fnc_logTruckAdd",_startLoad, _isHeli]];
};

//If not empty truck
[_isHeli] spawn MCC_fnc_logTruckRefresh;

//Load available resources
while {dialog} do {
	_array = call compile format ["MCC_res%1",playerside];
	MCC_loadTruckSupplies ctrlSetText str floor (_array select 1);
	MCC_loadTruckRepair ctrlSetText str floor (_array select 0);
	MCC_loadTruckFuel ctrlSetText str floor (_array select 2);
	sleep 0.1;
};