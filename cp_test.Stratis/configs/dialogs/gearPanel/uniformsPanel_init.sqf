private ["_disp","_comboBox","_index","_displayname","_array","_pic","_class","_items"];
disableSerialization;

_disp = _this select 0;
uiNamespace setVariable ["CP_UNIFORMSPANEL_IDD", _disp];
uiNamespace setVariable ["CP_uniformPanelNV", _disp displayCtrl 0];
uiNamespace setVariable ["CP_uniformPanelHead", _disp displayCtrl 1];
uiNamespace setVariable ["CP_uniformPanelGoggles", _disp displayCtrl 2];
uiNamespace setVariable ["CP_uniformPanelVest", _disp displayCtrl 3];
uiNamespace setVariable ["CP_uniformPanelBackpack", _disp displayCtrl 4];
uiNamespace setVariable ["CP_uniformPanelUniforms", _disp displayCtrl 5];
uiNamespace setVariable ["CP_InfoText", _disp displayCtrl 6];

#define CP_UNIFORMSPANEL_IDD (uiNamespace getVariable "CP_UNIFORMSPANEL_IDD")
#define CP_uniformPanelNV (uiNamespace getVariable "CP_uniformPanelNV")
#define CP_uniformPanelHead (uiNamespace getVariable "CP_uniformPanelHead")
#define CP_uniformPanelGoggles (uiNamespace getVariable "CP_uniformPanelGoggles")
#define CP_uniformPanelVest (uiNamespace getVariable "CP_uniformPanelVest")
#define CP_uniformPanelBackpack (uiNamespace getVariable "CP_uniformPanelBackpack")
#define CP_uniformPanelUniforms (uiNamespace getVariable "CP_uniformPanelUniforms")
#define CP_InfoText (uiNamespace getVariable "CP_InfoText")


//Disable Esc while respawn is on
CP_disableEsc = CP_UNIFORMSPANEL_IDD displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"]; 


//Load NV
_items = CP_currentUniforms select 0;  
_array = [];
for [{_i = 0},{_i < count _items},{_i = _i+1}] do 
	{
		if (CP_currentLevel >= (_items select _i)select 0) then {
			_array set [count _array, (_items select _i) select 1];
		};
	};
_comboBox = CP_uniformPanelNV; 
lbClear _comboBox;
	{
		_class			= configName(configFile >> "CfgWeapons">> _x);
		_displayname 	= getText(configFile >> "CfgWeapons">> _x >> "displayname");
		_pic 			= getText(configFile >> "CfgWeapons">> _x >> "picture");
		_index = _comboBox lbAdd _displayname;
		_comboBox lbSetPicture [_index, _pic];
		_comboBox lbSetData [_index, _class];
	} foreach _array;
_comboBox lbSetCurSel CP_NVIndex;

//Load Head gear
_items = CP_currentUniforms select 1;  
_array = [];
for [{_i = 0},{_i < count _items},{_i = _i+1}] do 
	{
		if (CP_currentLevel >= (_items select _i)select 0) then {
			_array set [count _array, (_items select _i) select 1];
		};
	};
_comboBox = CP_uniformPanelHead; 
lbClear _comboBox;
	{
		_class			= configName(configFile >> "CfgWeapons">> _x);
		_displayname 	= getText(configFile >> "CfgWeapons">> _x >> "displayname");
		_pic 			= getText(configFile >> "CfgWeapons">> _x >> "picture");
		_index = _comboBox lbAdd _displayname;
		_comboBox lbSetPicture [_index, _pic];
		_comboBox lbSetData [_index, _class];
	} foreach _array;
_comboBox lbSetCurSel CP_headgearIndex;

//Load Goggles
_items = CP_currentUniforms select 2;  
_array = [];
for [{_i = 0},{_i < count _items},{_i = _i+1}] do 
	{
		if (CP_currentLevel >= (_items select _i)select 0) then {
			_array set [count _array, (_items select _i) select 1];
		};
	};
_comboBox = CP_uniformPanelGoggles; 
lbClear _comboBox;
	{
		_class			= configName(configFile >> "CfgGlasses">> _x);
		_displayname 	= getText(configFile >> "CfgGlasses">> _x >> "displayname");
		_pic 			= getText(configFile >> "CfgGlasses">> _x >> "picture");
		_index = _comboBox lbAdd _displayname;
		_comboBox lbSetPicture [_index, _pic];
		_comboBox lbSetData [_index, _class];
	} foreach _array;
_comboBox lbSetCurSel CP_gogglesIndex;

//Load Vest
_items = CP_currentUniforms select 3;  
_array = [];
for [{_i = 0},{_i < count _items},{_i = _i+1}] do 
	{
		if (CP_currentLevel >= (_items select _i)select 0) then {
			_array set [count _array, (_items select _i) select 1];
		};
	};
_comboBox = CP_uniformPanelVest; 
lbClear _comboBox;
	{
		_class			= configName(configFile >> "CfgWeapons">> _x);
		_displayname 	= getText(configFile >> "CfgWeapons">> _x >> "displayname");
		_pic 			= getText(configFile >> "CfgWeapons">> _x >> "picture");
		_index = _comboBox lbAdd _displayname;
		_comboBox lbSetPicture [_index, _pic];
		_comboBox lbSetData [_index, _class];
	} foreach _array;
_comboBox lbSetCurSel CP_vestIndex;

//Load Backpack
_items = CP_currentUniforms select 4;  
_array = [];
for [{_i = 0},{_i < count _items},{_i = _i+1}] do 
	{
		if (CP_currentLevel >= (_items select _i)select 0) then {
			_array set [count _array, (_items select _i) select 1];
		};
	};
_comboBox = CP_uniformPanelBackpack; 
lbClear _comboBox;
	{
		_class			= configName(configFile >> "CfgVehicles">> _x);
		_displayname 	= getText(configFile >> "CfgVehicles">> _x >> "displayname");
		_pic 			= getText(configFile >> "CfgVehicles">> _x >> "picture");
		_index = _comboBox lbAdd _displayname;
		_comboBox lbSetPicture [_index, _pic];
		_comboBox lbSetData [_index, _class];
	} foreach _array;
_comboBox lbSetCurSel CP_backpackIndex;

//Load Uniforms
_items = CP_currentUniforms select 5;  
_array = [];
for [{_i = 0},{_i < count _items},{_i = _i+1}] do 
	{
		if (CP_currentLevel >= (_items select _i)select 0) then {
			_array set [count _array, (_items select _i) select 1];
		};
	};
_comboBox = CP_uniformPanelUniforms; 
lbClear _comboBox;
	{
		_class			= configName(configFile >> "CfgWeapons">> _x);
		_displayname 	= getText(configFile >> "CfgWeapons">> _x >> "displayname");
		_pic 			= getText(configFile >> "CfgWeapons">> _x >> "picture");
		_index = _comboBox lbAdd _displayname;
		_comboBox lbSetPicture [_index, _pic];
		_comboBox lbSetData [_index, _class];
	} foreach _array;
_comboBox lbSetCurSel CP_uniformsIndex;

