private ["_disp","_comboBox","_index","_displayname","_wepArray","_weapon","_array","_class","_pic","_optics","_sideID"];
disableSerialization;

_disp = _this select 0;
uiNamespace setVariable ["MCC_LOGISTICS_LOAD_TRUCK", _disp];
uiNamespace setVariable ["MCC_loadTruckC1", _disp displayCtrl 0];

uiNamespace setVariable ["MCC_loadTruckSupplies", _disp displayCtrl 1];
uiNamespace setVariable ["MCC_loadTruckRepair", _disp displayCtrl 2];
uiNamespace setVariable ["MCC_loadTruckFuel", _disp displayCtrl 3];

uiNamespace setVariable ["MCC_loadTruckLoadButton", _disp displayCtrl 4];
uiNamespace setVariable ["MCC_loadTruckOutpot", _disp displayCtrl 5];


#define MCC_LOGISTICS_LOAD_TRUCK (uiNamespace getVariable "MCC_LOGISTICS_LOAD_TRUCK")
#define MCC_loadTruckC1 (uiNamespace getVariable "MCC_loadTruckC1")

#define MCC_loadTruckSupplies (uiNamespace getVariable "MCC_loadTruckSupplies")
#define MCC_loadTruckRepair (uiNamespace getVariable "MCC_loadTruckRepair")
#define MCC_loadTruckFuel (uiNamespace getVariable "MCC_loadTruckFuel")

#define MCC_loadTruckLoadButton (uiNamespace getVariable "MCC_loadTruckLoadButton")
#define MCC_loadTruckOutpot (uiNamespace getVariable "MCC_loadTruckOutpot")

_sideID = playerside call BIS_fnc_sideID;

//Load available resources
MCC_loadTruckSupplies ctrlSetText str (MCC_sideAmmo select _sideID); 
MCC_loadTruckRepair ctrlSetText str (MCC_sideRepair select _sideID); 
MCC_loadTruckFuel ctrlSetText str (MCC_sideFuel select _sideID); 

_array = ["Box_NATO_AmmoVeh_F","Land_PaperBox_closed_F"];	//TODO --> move to init file
_comboBox = MCC_loadTruckC1; 

lbClear _comboBox;
{
	_class			= configName(configFile >> "CfgVehicles">> _x);
	_displayname 	= getText(configFile >> "CfgVehicles">> _x >> "displayname");
	//_pic 			= getText(configFile >> "CfgVehicles">> _x >> "picture");
	_index = _comboBox lbAdd _displayname;
	//_comboBox lbSetPicture [_index, _pic];
	_comboBox lbSetData [_index, _class];
} foreach _array;
_comboBox lbSetCurSel CP_opticsIndex;

/*
CP_respawnPanelOpen = false;
CP_gearPanelOpen	= false; 

//Disable Esc while respawn is on
CP_disableEsc = CP_ACCESPANEL_IDD displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"]; 

_weapon = primaryWeapon player;  
_wepArray = call compile format ["CP_%1",_weapon]; 

//Load Optics
_optics = _wepArray select 0;
_array = [];
for [{_i = 0},{_i < count _optics},{_i = _i+1}] do 
	{
		if (CP_currentLevel >= (_optics select _i)select 0) then {
			_array set [count _array, (_optics select _i) select 1];
		};
	};
_comboBox = CP_accessoriesPanelOptics; 
lbClear _comboBox;
	{
		_class			= configName(configFile >> "CfgWeapons">> _x);
		_displayname 	= getText(configFile >> "CfgWeapons">> _x >> "displayname");
		_pic 			= getText(configFile >> "CfgWeapons">> _x >> "picture");
		_index = _comboBox lbAdd _displayname;
		_comboBox lbSetPicture [_index, _pic];
		_comboBox lbSetData [_index, _class];
	} foreach _array;
_comboBox lbSetCurSel CP_opticsIndex;

//Load Barrel
_optics = _wepArray select 1;
_array = [];
for [{_i = 0},{_i < count _optics},{_i = _i+1}] do 
	{
		if (CP_currentLevel >= (_optics select _i)select 0) then {
			_array set [count _array, (_optics select _i) select 1];
		};
	};
_comboBox = CP_accessoriesPanelBarrel; 
lbClear _comboBox;
	{
		_class			= configName(configFile >> "CfgWeapons">> _x);
		_displayname 	= getText(configFile >> "CfgWeapons">> _x >> "displayname");
		_pic 			= getText(configFile >> "CfgWeapons">> _x >> "picture");
		_index = _comboBox lbAdd _displayname;
		_comboBox lbSetPicture [_index, _pic];
		_comboBox lbSetData [_index, _class];
	} foreach _array;
_comboBox lbSetCurSel CP_barrelIndex;

//Load Attachments
_optics = _wepArray select 2;
_array = [];
for [{_i = 0},{_i < count _optics},{_i = _i+1}] do 
	{
		if (CP_currentLevel >= (_optics select _i)select 0) then {
			_array set [count _array, (_optics select _i) select 1];
		};
	};
_comboBox = CP_accessoriesPanelAttachment; 
lbClear _comboBox;
	{
		_class			= configName(configFile >> "CfgWeapons">> _x);
		_displayname 	= getText(configFile >> "CfgWeapons">> _x >> "displayname");
		_pic 			= getText(configFile >> "CfgWeapons">> _x >> "picture");
		_index = _comboBox lbAdd _displayname;
		_comboBox lbSetPicture [_index, _pic];
		_comboBox lbSetData [_index, _class];
	} foreach _array;
_comboBox lbSetCurSel CP_attachsIndex;

CP_InfoText ctrlSetPosition [0.1 * safezoneW + safezoneX, 0.225107 * safezoneH + safezoneY, 0.161476 * safezoneW, 0.544025 * safezoneH];
CP_InfoText ctrlCommit 1;