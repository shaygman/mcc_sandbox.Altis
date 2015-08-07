//=================================================================MCC_fnc_baseSelected==============================================================================
//	What happendes when we select a base building
//  Parameter(s):
//     _obj: OBJECTS base selected
//==============================================================================================================================================================================
private ["_obj","_constType","_cfgtext","_text","_disp","_availableActions","_availableUpgrades","_availableBuildings","_elec","_fnc","_cnd","_elecOn","_online","_showDisabled","_cfgName","_cfgActionsName","_ctrl"];

{
	disableSerialization;
	_obj  = if (typename _x == typeName grpNull) then {vehicle leader _x} else {_x};
	_disp = uiNamespace getVariable "MCC_LOGISTICS_BASE_BUILD";

	_availableUpgrades 	= [];
	_availableActions 	= [];
	_availableBuildings = [];

	switch (true) do {
		case (_obj iskindof "logic"): {
			_cfgName = "cfgRtsBuildings";
			_cfgActionsName = "CfgRtsActions";
			_constType 	= format ["MCC_rts_%1%2",(_obj getVariable ["mcc_constructionItemType",""]),(_obj getVariable ["mcc_constructionItemTypeLevel",1])];
		};

		case ((_obj iskindof "Car" ||
		       _obj iskindof "Motorcycle" ||
		       _obj iskindof "Tank" ||
		       _obj iskindof "Ship" ||
		        _obj iskindof "StaticWeapon"
		       ) && (count crew _obj > 0)): {
			_cfgName = "cfgRtsNonBuildingsActions";
			_cfgActionsName = "cfgRtsVehiclesActions";
			_constType 	= "MCC_rts_vehicle_notEmpty";
		};

		/*
		case ( _x isKindOf "Man" ):{
		_mkname setMarkerTypeLocal "b_inf";};
		case ( _x isKindOf "Car" )					: {_mkname setMarkerTypeLocal "c_car";};
		case ( _x isKindOf "Motorcycle" )		: {_mkname setMarkerTypeLocal "b_car";};
		case ( _x isKindOf "Tank" )					: {_mkname setMarkerTypeLocal "b_armor";};
		case ( _x isKindOf "Air" )					: {_mkname setMarkerTypeLocal "b_air";};
		case ( _x isKindOf "Ship" )					: {_mkname setMarkerTypeLocal "b_naval";};
		case ( _x isKindOf "StaticWeapon" )	: {_mkname setMarkerTypeLocal "b_installation";};
		*/
		default {
			_cfgName = "cfgRtsNonBuildingsActions";
			_cfgActionsName = "cfgRtsVehiclesActions";
			_constType 	= "MCC_rts_car";
		};
	};

	if (MCC_isMode) then
	{
		_cfgtext = [getText (configFile >> _cfgName >> _constType >> "displayName"),getText (configFile >> _cfgName >> _constType >> "descriptionShort")];
		_availableUpgrades = getArray (configFile >> _cfgName >> _constType >> "upgradeTo");
		_availableBuildings = getArray (configFile >> _cfgName >> _constType >> "buildings");
		_availableActions = getArray (configFile >> _cfgName >> _constType >> "actions");
		_elec = getNumber (configFile >> _cfgName >> _constType >> "needelectricity");
	}
	else
	{
		_cfgtext = [getText (missionconfigFile >> _cfgName >> _constType >> "displayName"),getText (missionconfigFile >> _cfgName >> _constType >> "descriptionShort")];
		_availableUpgrades = getArray (missionconfigFile >> _cfgName >> _constType >> "upgradeTo");
		_availableBuildings = getArray (missionconfigFile >> _cfgName >> _constType >> "buildings");
		_availableActions = getArray (missionconfigFile >> _cfgName >> _constType >> "actions");
		_elec = getNumber (missionconfigFile >> _cfgName >> _constType >> "needelectricity");
	};

	//if it isn't logic get cfg name
	if !(_obj iskindof "logic") then {
		_cfgtext = if (_obj isKindOf "man") then {
			[(group _obj) getVariable ["name",groupID _x],format ["Leader: %1",name leader group _obj]];
		} else {
			[getText (configFile >> "cfgVehicles" >> typeOf _obj >> "displayName"),format ["Driver: %1",name driver _obj]];
		};
	};

	//diable actions/upgrades while under construction
	if ((_obj getVariable ["mcc_constructionStartTime",time]) + (_obj getVariable ["mcc_constructionendTime",0])> time) then
	{
		_availableUpgrades 	= [];
		_availableActions 	= [];
		_availableBuildings = [];
	};

	private ["_available","_resToCheck","_pic","_res","_req","_var","_level","_facility","_buildings"];

	//Add text
	if !(isnil "_cfgtext") then
	{
		_text = format ["<t color='#ff0000' underline='true'>%1</t><br />%2",(_cfgtext select 0),(_cfgtext select 1)];
		(_disp displayCtrl 9999) ctrlSetStructuredText parseText _text;
	} else {
		(_disp displayCtrl 9999) ctrlSetStructuredText parseText "";
	};

	//electricity
	disableSerialization;
	_ctrl = (_disp displayCtrl 950);
	_elecOn = missionNamespace getVariable [format ["MCC_rtsElecOn_%1", playerSide],false];
	if (_elec == 1) then {
		if (_elecOn) then {
			_online = true;
			_ctrl ctrlSetText "Online";
			_ctrl ctrlSetTextColor [1, 1, 1, 1];
		} else {
			_online = false;
			_ctrl ctrlSetText "Offline";
			_ctrl ctrlSetTextColor[1, 0, 0, 1];

		}} else {
		_online = true;
		_ctrl ctrlSetText "Online";
		_ctrl ctrlSetTextColor [1, 1, 1, 1];
	};

	//remove controls
	for "_i" from 9101 to 9112 do {(_disp displayCtrl _i) ctrlShow false};
	for "_i" from 9160 to 9162 do {(_disp displayCtrl _i) ctrlShow false};

	//Populate upgrades
	for "_i" from 9160 to 9162 do
	{
		_ctrl = (_disp displayCtrl _i);
		if (count _availableUpgrades > 0) then
		{
			//Resize array
			_action = _availableUpgrades select 0;
			_availableUpgrades set [0,-1];
			_availableUpgrades = _availableUpgrades - [-1];

			//Get CFG
			if (MCC_isMode) then
			{
				_constType = getText (configFile >> _cfgName >> _action >> "constType");
				_pic = getText (configFile >> _cfgName >> _action >> "picture");
				_res = getArray (configFile >> _cfgName >> _action >> "resources");
				_req = getArray (configFile >> _cfgName >> _action >> "requiredBuildings");
			}
			else
			{
				_constType = getText (missionconfigFile >> _cfgName >> _action >> "constType");
				_pic = getText (missionconfigFile >> _cfgName >> _action >> "picture");
				_res = getArray (missionconfigFile >> _cfgName >> _action >> "resources");
				_req = getArray (missionconfigFile >> _cfgName >> _action >> "requiredBuildings");
			};

			_ctrl ctrlShow true;
			_ctrl ctrlSetText _pic;
			missionNamespace setVariable [format ["MCC_ctrlData_%1", ctrlIDC _ctrl],_action];

			//Now let see if we enable the contorl
			_available = true;
			{
				_available = [_x, _obj, 200] call MCC_fnc_CheckBuildings;
				if (!_available) exitWith {};
			} foreach _req;

			//Do we have the resources
			if (_available) then
			{
				{
					_available = [playerSide, _x] call MCC_fnc_checkRes;
					if (!_available) exitWith {};
				} foreach _res;
			};

			if (_available && _online) then
			{
				_ctrl ctrlSetTextColor [1, 1, 1, 1];
			}
			else
			{
				_ctrl ctrlSetTextColor [1, 1, 1, 0.4];
			};

			//remove
			_ctrl ctrlRemoveAllEventHandlers "MouseButtonClick";
			_ctrl ctrlRemoveAllEventHandlers "MouseHolding";
			_ctrl ctrlRemoveAllEventHandlers "MouseExit";

			//add EH
			if (_available && _online) then {
				_ctrl ctrlAddEventHandler ["MouseButtonClick",format ["[_this select 0, %1, '%2'] spawn MCC_fnc_rtsUpgrade",_res,_action]];
			};
			_ctrl ctrlAddEventHandler ["MouseHolding",format ["[_this,'%1'] call MCC_fnc_baseActionEntered",_action]];
			_ctrl ctrlAddEventHandler ["MouseExit",format ["[_this,'%1'] call MCC_fnc_baseActionExit",_action]];
		} else {
			_ctrl ctrlShow false;
		};
	};

	//Populate actions
	for "_i" from 9101 to 9112 do
	{
		_ctrl = (_disp displayCtrl _i);
		if (count _availableActions > 0) then
		{
			//Resize array
			_action = _availableActions select 0;
			_availableActions set [0,-1];
			_availableActions = _availableActions - [-1];

			//Get CFG
			if (MCC_isMode) then
			{
				_pic = getText (configFile >> _cfgActionsName >> _action >> "picture");
				_res = getArray (configFile >> _cfgActionsName >> _action >> "resources");
				_req = getArray (configFile >> _cfgActionsName >> _action >> "requiredBuildings");
				_elec = getNumber (configFile >> _cfgActionsName >> _action >> "needelectricity");
				_fnc = getText (configFile >> _cfgActionsName >> _action >> "actionFNC");
				_cnd = getText (configFile >> _cfgActionsName >> _action >> "condition");
				_showDisabled = (getnumber (configFile >> _cfgActionsName >> _action >> "dontShowDisabled"))==1;
			}
			else
			{
				_pic = getText (missionconfigFile >> _cfgActionsName >> _action >> "picture");
				_res = getArray (missionconfigFile >> _cfgActionsName >> _action >> "resources");
				_req = getArray (missionconfigFile >> _cfgActionsName >> _action >> "requiredBuildings");
				_elec = getNumber (missionconfigFile >> _cfgActionsName >> _action >> "needelectricity");
				_fnc = getText (missionconfigFile >> _cfgActionsName >> _action >> "actionFNC");
				_cnd = getText (missionconfigFile >> _cfgActionsName >> _action >> "condition");
				_showDisabled = (getnumber (missionconfigFile >> _cfgActionsName >> _action >> "dontShowDisabled"))==1;
			};

			//Now let see if we enable the contorl

			_available = true;

			{
				_available = [_x, _obj, 300] call MCC_fnc_CheckBuildings;
				if (!_available) exitWith {};
			} foreach _req;

			//condition
			if (_available && _cnd !="") then {
				missionNamespace setVariable ["MCC_selectedRtsObject",_obj];
				_cnd = format ["_target = missionNamespace getVariable ['MCC_selectedRtsObject',objNull]; %1",_cnd];
				_available = call compile _cnd;
			};

			//Do we have the resources
			if (_available) then {
				{
					_available = [playerSide, _x] call MCC_fnc_checkRes;
					if (!_available) exitWith {};
				} foreach _res;
			};

			if (_available && _online) then {
				_ctrl ctrlSetTextColor [1, 1, 1, 1];
			} else {
				_ctrl ctrlSetTextColor [1, 1, 1, 0.4];
			};

			//remove
			_ctrl ctrlRemoveAllEventHandlers "MouseButtonClick";
			_ctrl ctrlRemoveAllEventHandlers "MouseHolding";
			_ctrl ctrlRemoveAllEventHandlers "MouseExit";

			//add EH
			if !(_showDisabled && !_available) then {
				_ctrl ctrlShow true;
				_ctrl ctrlSetText _pic;
				missionNamespace setVariable [format ["MCC_ctrlData_%1", ctrlIDC _ctrl],_action];

				if (_available && _online) then {_ctrl ctrlAddEventHandler ["MouseButtonClick",format ['[_this select 0, %2] spawn %1',_fnc,_res]]};
				_ctrl ctrlAddEventHandler ["MouseHolding",format ["[_this,'%1'] call MCC_fnc_baseActionEntered",_action]];
				_ctrl ctrlAddEventHandler ["MouseExit",format ["[_this,'%1'] call MCC_fnc_baseActionExit",_action]];
			};
		}
		else
		{
			_ctrl ctrlShow false;
		};
	};
} foreach (_this select 0);