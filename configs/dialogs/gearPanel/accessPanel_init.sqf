private ["_disp","_comboBox","_index","_displayname","_wepArray","_weapon","_array","_class","_pic","_optics"];
disableSerialization;

_disp = _this select 0;
uiNamespace setVariable ["CP_ACCESPANEL_IDD", _disp];
uiNamespace setVariable ["CP_accessoriesPanelOptics", _disp displayCtrl 0];
uiNamespace setVariable ["CP_accessoriesPanelBarrel", _disp displayCtrl 1];
uiNamespace setVariable ["CP_accessoriesPanelAttachment", _disp displayCtrl 2];
uiNamespace setVariable ["CP_InfoText", _disp displayCtrl 3];


#define CP_ACCESPANEL_IDD (uiNamespace getVariable "CP_ACCESPANEL_IDD")
#define CP_accessoriesPanelOptics (uiNamespace getVariable "CP_accessoriesPanelOptics")
#define CP_accessoriesPanelBarrel (uiNamespace getVariable "CP_accessoriesPanelBarrel")
#define CP_accessoriesPanelAttachment (uiNamespace getVariable "CP_accessoriesPanelAttachment")
#define CP_InfoText (uiNamespace getVariable "CP_InfoText")

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