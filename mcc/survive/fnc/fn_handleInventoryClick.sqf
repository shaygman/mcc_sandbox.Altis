/*=================================================================MCC_fnc_handleInventoryClick===============================================================================
	Handles clicking on item in the inventory and calling the function
*/
if ((missionNamespace getVariable ["MCC_isLocalHC",false]) || !hasInterface) exitWith {};

disableSerialization;

private ["_ctrl","_ctrlIDC","_index","_itemClass","_display","_ctrlNew","_ctrlPos","_cfgClass","_itemName","_array","_cfg","_cfgAction","_condition","_cfgClasses","_displayname"];

_ctrl = _this select 0;
_index = param [1,0,[0]];

_ctrlIDC = ctrlIDC _ctrl;

if (ctrlType _ctrl == 5) then {
	_itemClass = lbData [_ctrlIDC, _index];
	_displayname = lbText [_ctrlIDC, _index];
} else {
	_index = 0;
	_itemClass =switch (_ctrlIDC) do {
				    case 6191: {backpack player};
				    case 6238: {binocular player};
				    case 6216: {goggles player};
				    case 612: {handgunWeapon player};
				    case 630: {(handgunItems player) select 1};
				    case 628: {(handgunItems player) select 0};
				    case 629: {(handgunItems player) select 2};
				    case 6240: {headgear player};
				    case 610: {primaryWeapon player};
				    case 622: {(primaryWeaponItems player) select 1};
				    case 620: {(primaryWeaponItems player) select 0};
				    case 621: {(primaryWeaponItems player) select 2};
				    case 641: {(primaryWeaponItems player) select 2};
				    case 611: {secondaryWeapon player};
				    case 6331: {uniform player};
				    case 6381: {vest player};
				    case 6217: {hmd player};
				    default {""};
				};
};

//No Item class....demn you BI we'll have to use BRUTH FORCE
if (_itemClass == "") then {
	{
		if (_itemClass != "") exitWith {};
		_cfgClasses = configFile >> _x ;
		for "_i" from 1 to (count _cfgClasses - 1) do {
			_cfgClass = _cfgClasses select _i;

			if (getText(_cfgClass >> "displayName") == _displayname) exitWith {
				_itemClass = (configName (_cfgClass));
			};
		};
	} forEach ["CfgWeapons","CfgGlasses","CfgMagazines"];
};

switch (true) do {
				case (isClass (configFile >> "CfgMagazines" >> _itemClass)) : {_cfgClass =  "CfgMagazines"};
				case (isClass (configFile >> "CfgWeapons" >> _itemClass)) : {_cfgClass =  "CfgWeapons"};
				case (isClass (configFile >> "CfgGlasses" >> _itemClass)) : {_cfgClass = "CfgGlasses"};
			};

_itemName = getText (configFile >> _cfgClass >> _itemClass >> "displayName");

_array = [["",format ["-= %1 =-",_itemName],""]];

//Search cfg for actions first in mission files then in mod files
if (isClass (missionconfigFile >> "CfgMCCitemsActions" >> _itemClass)) then {
	_cfg = missionconfigFile >> "CfgMCCitemsActions" >> _itemClass ;
} else {
	if (isClass (configFile >> "CfgMCCitemsActions" >> _itemClass)) then {
		_cfg = configFile >> "CfgMCCitemsActions" >> _itemClass ;
	};
};

//get the actions
if (isClass _cfg) then {
	for "_i" from 0 to (count _cfg - 1) do {
		_cfgAction = _cfg select _i;
		if (isClass _cfgAction) then {
			_condition = getText(_cfgAction >> "condition");
			_condition =  if (_condition == "") then {true} else {call compile _condition};
			if (_condition) then {
				_array pushBack [getText(_cfgAction >> "function"),getText(_cfgAction >> "displayName"),getText(_cfgAction >> "icon")];
			};
		};
	};
};

//Build the control
if (count _array > 1) then {
	_array pushBack ["ctrlShow [_ctrlIDC,false];","Close","\A3\ui_f\data\map\markers\handdrawn\pickup_CA.paa"];
	_display = ctrlParent _ctrl;
	_ctrlPos = ctrlposition _ctrl;
	_ctrlPos set [0,(_ctrlPos select 0)+(_ctrlPos select 2)];
	_ctrlPos set [1,(_ctrlPos select 1)+(0.05*(safezoneW / safezoneH)*(_index min 4))];
	_ctrlPos set [2,0.4];
	_ctrlPos set [3,(0.035*(safezoneW / safezoneH)*(count _array))];

	if (isNull (_display displayCtrl 11223312)) then {
		_ctrlNew = _display ctrlCreate ["RscListbox", 11223312];
	} else {
		_ctrlNew = (_display displayCtrl 11223312);
	};

	_ctrlNew ctrlShow true;
	_ctrlNew ctrlSetPosition _ctrlPos;
	_ctrlNew ctrlSetBackgroundColor [0,0,0,0.8];
	_ctrlNew ctrlCommit 0;

	_ctrlNew ctrlRemoveAllEventHandlers "LBSelChanged";

	lbClear _ctrlNew;
	{
		_class			= _x select 0;
		_displayname 	= _x select 1;
		_pic 			= _x select 2;
		_index 			= _ctrlNew lbAdd _displayname;
		_ctrlNew lbSetPicture [_index, _pic];
		_ctrlNew lbSetData [_index, _class];
	} foreach _array;
	_ctrlNew lbSetCurSel 0;

	_ctrlNew ctrlAddEventHandler ["LBSelChanged",format ["[_this,'%1'] spawn MCC_fnc_surviveItemClicked",_itemClass]];
	ctrlSetFocus _ctrlNew;
};