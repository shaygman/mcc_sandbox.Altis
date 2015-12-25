private ["_disp","_comboBox","_index","_displayname","_array","_pic","_class","_ctrl","_ctrlPos"];
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

//We came here from an item and we want to change the kit
if (isnil "CP_gearCam") then {
	["CP_WEAPONSPANEL_IDD"] call MCC_fnc_createCameraOnPlayer;
} else {
	//Disable Esc while respawn is on
	CP_disableEsc = CP_WEAPONSPANEL_IDD displayAddEventHandler ["KeyDown", "if ((_this select 1) == 1) then { true }"];
};

_fnc_getDisplay = {
	private ["_var","_cfgName","_return"];
	_cfgName = _this select 0;
	_var = _this select 1;
	_return = "";

	if (isClass(configFile >> "CfgWeapons">> _cfgName)) then {
		_return = getText(configFile >> "CfgWeapons">> _cfgName >> _var);
	} else {
		_return = getText(configFile >> "CfgMagazines">> _cfgName >> _var);
	};

	_return
};

_fnc_setComboBox = {
	private ["_array","_comboBox","_indexCel"];
	_comboBox = _this select 0;
	_array = _this select 1;
	_indexCel = _this select 2;

	lbClear _comboBox;
	{
		_class			= configName(configFile >> "CfgWeapons">> _x);
		_displayname 	= [_x,"displayname"] call _fnc_getDisplay;
		_pic 			= [_x,"picture"] call _fnc_getDisplay;
		_index = _comboBox lbAdd _displayname;
		_comboBox lbSetPicture [_index, _pic];
		_comboBox lbSetData [_index, _class];
	} foreach _array;
	_comboBox lbSetCurSel _indexCel;
};

//Load primary weapons
_array = [];
for [{_i = 0},{_i < count CP_currentWeaponArray},{_i = _i+1}] do {
	if (CP_currentLevel >= (CP_currentWeaponArray select _i)select 0) then {
		_array set [count _array, (CP_currentWeaponArray select _i) select 1];
	};
};
_null = [CP_weaponsPanelPrimary,_array,CP_currentWeaponIndex] call _fnc_setComboBox;


//Load Secondary weapons
_array = [];
for [{_i = 0},{_i < count CP_currentWeaponSecArray},{_i = _i+1}] do {
	if (CP_currentLevel >= (CP_currentWeaponSecArray select _i)select 0) then {
		_array set [count _array, (CP_currentWeaponSecArray select _i) select 1];
	};
};
_null = [CP_weaponsPanelSecondary,_array,CP_currentSecWeaponIndex] call _fnc_setComboBox;

//Load Handguns
_array = [];
for [{_i = 0},{_i < count CP_handguns},{_i = _i+1}] do {
	if (CP_currentLevel >= (CP_handguns select _i)select 0) then {
		_array set [count _array, (CP_handguns select _i) select 1];
	};
};
_null = [CP_weaponsPanelHandgun,_array,CP_currentHandgunsIndex] call _fnc_setComboBox;

//Load Items1
_array = [];
for [{_i = 0},{_i < count CP_currentItmes1},{_i = _i+1}] do {
	if (CP_currentLevel >= (CP_currentItmes1 select _i)select 0) then {
		_array set [count _array, (CP_currentItmes1 select _i) select 1];
	};
};
_null = [CP_weaponsPanelItem1,_array,CP_currentItems1Index] call _fnc_setComboBox;

//Load Items2
_array = [];
for [{_i = 0},{_i < count CP_currentItmes2},{_i = _i+1}] do {
	if (CP_currentLevel >= (CP_currentItmes2 select _i)select 0) then {
		_array set [count _array, (CP_currentItmes2 select _i) select 1];
	};
};
_null = [CP_weaponsPanelItem2,_array,CP_currentItems2Index] call _fnc_setComboBox;

//Load Items3
_array = [];
for [{_i = 0},{_i < count CP_currentItmes3},{_i = _i+1}] do {
	if (CP_currentLevel >= (CP_currentItmes3 select _i)select 0) then {
		_array set [count _array, (CP_currentItmes3 select _i) select 1];
	};
};
_null = [CP_weaponsPanelItem3,_array,CP_currentItems3Index] call _fnc_setComboBox;

CP_InfoText ctrlSetPosition [0.1 * safezoneW + safezoneX, 0.225107 * safezoneH + safezoneY, 0.161476 * safezoneW, 0.544025 * safezoneH];
CP_InfoText ctrlCommit 1;

//set gear stats position
_ctrl = _disp displayCtrl 200;
_ctrlPos= ctrlPosition _ctrl;
_ctrl ctrlSetPosition [0.72 * safezoneW + safezoneX, _ctrlPos select 1,_ctrlPos select 2,_ctrlPos select 3];
_ctrl ctrlCommit 0;

[_disp] call MCC_fnc_playerStats;