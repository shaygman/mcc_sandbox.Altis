private ["_disp","_comboBox","_index","_displayname","_array","_pic","_class"];
disableSerialization;

_disp = _this select 0;
uiNamespace setVariable ["CP_WEAPONSPANEL_IDD", _disp];
uiNamespace setVariable ["CP_weaponsPanelPrimary", _disp displayCtrl 0];
uiNamespace setVariable ["CP_weaponsPanelSecondary", _disp displayCtrl 1];
uiNamespace setVariable ["CP_weaponsPanelHandgun", _disp displayCtrl 2];
uiNamespace setVariable ["CP_weaponsPanelItem1", _disp displayCtrl 3];
uiNamespace setVariable ["CP_weaponsPanelItem2", _disp displayCtrl 4];
uiNamespace setVariable ["CP_weaponsPanelItem3", _disp displayCtrl 5];
uiNamespace setVariable ["CP_InfoText", _disp displayCtrl 6];

#define CP_WEAPONSPANEL_IDD (uiNamespace getVariable "CP_WEAPONSPANEL_IDD")
#define CP_weaponsPanelPrimary (uiNamespace getVariable "CP_weaponsPanelPrimary")
#define CP_weaponsPanelSecondary (uiNamespace getVariable "CP_weaponsPanelSecondary")
#define CP_weaponsPanelHandgun (uiNamespace getVariable "CP_weaponsPanelHandgun")
#define CP_weaponsPanelItem1 (uiNamespace getVariable "CP_weaponsPanelItem1")
#define CP_weaponsPanelItem2 (uiNamespace getVariable "CP_weaponsPanelItem2")
#define CP_weaponsPanelItem3 (uiNamespace getVariable "CP_weaponsPanelItem3")
#define CP_InfoText (uiNamespace getVariable "CP_InfoText")

//Disable Esc while respawn is on
CP_disableEsc = CP_WEAPONSPANEL_IDD displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"]; 

//Load primary weapons 
_array = [];
for [{_i = 0},{_i < count CP_currentWeaponArray},{_i = _i+1}] do 
	{
		if (CP_currentLevel >= (CP_currentWeaponArray select _i)select 0) then {
			_array set [count _array, (CP_currentWeaponArray select _i) select 1];
		};
	};
_comboBox = CP_weaponsPanelPrimary; 
lbClear _comboBox;
	{
		_class			= configName(configFile >> "CfgWeapons">> _x);
		_displayname 	= getText(configFile >> "CfgWeapons">> _x >> "displayname");
		_pic 			= getText(configFile >> "CfgWeapons">> _x >> "picture");
		_index = _comboBox lbAdd _displayname;
		_comboBox lbSetPicture [_index, _pic];
		_comboBox lbSetData [_index, _class];
	} foreach _array;
_comboBox lbSetCurSel CP_currentWeaponIndex;

//Load Secondary weapons 
_array = [];
for [{_i = 0},{_i < count CP_currentWeaponSecArray},{_i = _i+1}] do 
	{
		if (CP_currentLevel >= (CP_currentWeaponSecArray select _i)select 0) then {
			_array set [count _array, (CP_currentWeaponSecArray select _i) select 1];
		};
	};
_comboBox = CP_weaponsPanelSecondary; 
lbClear _comboBox;
	{
		_class			= configName(configFile >> "CfgWeapons">> _x);
		_displayname 	= getText(configFile >> "CfgWeapons">> _x >> "displayname");
		_pic 			= getText(configFile >> "CfgWeapons">> _x >> "picture");
		_index = _comboBox lbAdd _displayname;
		_comboBox lbSetPicture [_index, _pic];
		_comboBox lbSetData [_index, _class];
	} foreach _array;
_comboBox lbSetCurSel CP_currentSecWeaponIndex;

//Load Handguns
_array = [];
for [{_i = 0},{_i < count CP_handguns},{_i = _i+1}] do 
	{
		if (CP_currentLevel >= (CP_handguns select _i)select 0) then 
		{
			_array set [count _array, (CP_handguns select _i) select 1];
		};
	};
_comboBox = CP_weaponsPanelHandgun; 
lbClear _comboBox;
	{
		_class			= configName(configFile >> "CfgWeapons">> _x);
		_displayname 	= getText(configFile >> "CfgWeapons">> _x >> "displayname");
		_pic 			= getText(configFile >> "CfgWeapons">> _x >> "picture");
		_index = _comboBox lbAdd _displayname;
		_comboBox lbSetPicture [_index, _pic];
		_comboBox lbSetData [_index, _class];
	} foreach _array;
_comboBox lbSetCurSel CP_currentHandgunsIndex;

//Load Items1
_array = [];
for [{_i = 0},{_i < count CP_currentItmes1},{_i = _i+1}] do 
	{
		if (CP_currentLevel >= (CP_currentItmes1 select _i)select 0) then {
			_array set [count _array, (CP_currentItmes1 select _i) select 1];
		};
	};
_comboBox = CP_weaponsPanelItem1; 
lbClear _comboBox;
	{
		_class			= configName(configFile >> "CfgWeapons">> _x);
		_displayname 	= getText(configFile >> "CfgWeapons">> _x >> "displayname");
		_pic 			= getText(configFile >> "CfgWeapons">> _x >> "picture");
		_index = _comboBox lbAdd _displayname;
		_comboBox lbSetPicture [_index, _pic];
		_comboBox lbSetData [_index, _class];
	} foreach _array;
_comboBox lbSetCurSel CP_currentItems1Index;

//Load Items2
_array = [];
for [{_i = 0},{_i < count CP_currentItmes2},{_i = _i+1}] do 
	{
		if (CP_currentLevel >= (CP_currentItmes2 select _i)select 0) then {
			_array set [count _array, (CP_currentItmes2 select _i) select 1];
		};
	};
_comboBox = CP_weaponsPanelItem2; 
lbClear _comboBox;
	{
		_class			= configName(configFile >> "CfgMagazines">> _x);
		_displayname 	= getText(configFile >> "CfgMagazines">> _x >> "displayname");
		_pic 			= getText(configFile >> "CfgMagazines">> _x >> "picture");
		_index = _comboBox lbAdd _displayname;
		_comboBox lbSetPicture [_index, _pic];
		_comboBox lbSetData [_index, _class];
	} foreach _array;
_comboBox lbSetCurSel CP_currentItems2Index;

//Load Items3
_array = [];
for [{_i = 0},{_i < count CP_currentItmes3},{_i = _i+1}] do 
	{
		if (CP_currentLevel >= (CP_currentItmes3 select _i)select 0) then {
			_array set [count _array, (CP_currentItmes3 select _i) select 1];
		};
	};
_comboBox = CP_weaponsPanelItem3; 
lbClear _comboBox;
	{
		_class			= configName(configFile >> "CfgMagazines">> _x);
		_displayname 	= getText(configFile >> "CfgMagazines">> _x >> "displayname");
		_pic 			= getText(configFile >> "CfgMagazines">> _x >> "picture");
		_index = _comboBox lbAdd _displayname;
		_comboBox lbSetPicture [_index, _pic];
		_comboBox lbSetData [_index, _class];
	} foreach _array;
_comboBox lbSetCurSel CP_currentItems3Index;

CP_InfoText ctrlSetPosition [0.1 * safezoneW + safezoneX, 0.225107 * safezoneH + safezoneY, 0.161476 * safezoneW, 0.544025 * safezoneH];
CP_InfoText ctrlCommit 1;
