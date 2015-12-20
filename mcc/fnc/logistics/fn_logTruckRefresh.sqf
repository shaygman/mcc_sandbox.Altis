//==================================================================MCC_fnc_logTruckRefresh======================================================================================
// Refresh the logistics dialog
//===============================================================================================================================================================================
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

private ["_loadedCrates","_loadedCratesIDC","_ctrl","_displayname","_truck","_isHeli","_startLoad","_pos"];
disableSerialization;
_isHeli = param [0,false,[false]];
_truck = vehicle player;
_startLoad = player getVariable ["mcc_logTruck_screenStart",false];

//If not next to HQ center UI
if (!_startLoad) then {
	MCC_loadTruckC1 ctrlShow false;
	{
		_pos = ctrlPosition _x;
		_pos set [1,0.4];
		_x ctrlSetPosition _pos;
		_x ctrlCommit 0;
		_x ctrlRemoveAllEventHandlers "ButtonClick";
		_x ctrlAddEventHandler ["ButtonClick",format ["[%3, %1, _this, %2] call MCC_fnc_logTruckAdd",_startLoad, _isHeli, ctrlText _x == ""]];
	} foreach [MCC_loadTruckOutpot,MCC_loadTruckOutpot2,MCC_loadTruckOutpot3];
};

//clear
sleep 0.1;
MCC_loadTruckOutpot2 ctrlsetText "";

if (_isHeli && !(isnull getSlingLoad _truck)) then {
	{
		_displayname 	= getText(configFile >> "CfgVehicles">> typeof _x >> "displayname");
		MCC_loadTruckOutpot2 ctrlsetText _displayname;
	} foreach [getSlingLoad _truck];
} else {
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


