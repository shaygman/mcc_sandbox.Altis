//=================================================================MCC_fnc_baseSelected==============================================================================
//	What happendes when we select a base building
//  Parameter(s):
//     _obj: OBJECTS base selected
//==============================================================================================================================================================================
private ["_obj","_constType","_cfgtext","_text","_disp","_availableActions","_availableUpgrades","_availableBuildings","_elec","_fnc","_cnd","_elecOn","_online","_showDisabled","_cfgName","_cfgActionsName","_ctrl","_grpType"];

{
	disableSerialization;
	_grpType = _x getVariable ["MCC_rtsGroupCfg",""];
	_obj  = if (typename _x == typeName grpNull) then {vehicle leader _x} else {_x};
	_disp = uiNamespace getVariable "MCC_LOGISTICS_BASE_BUILD";

	_availableUpgrades 	= [];
	_availableActions 	= [];
	_availableBuildings = [];

	switch (true) do {
		case (_obj iskindof "UserTexture10m_F"): {
			_cfgName = "cfgRtsBuildings";
			_cfgActionsName = "CfgRtsActions";
			_constType 	= format ["MCC_rts_%1%2",(_obj getVariable ["mcc_constructionItemType",""]),(_obj getVariable ["mcc_constructionItemTypeLevel",1])];
		};

		//Predefined group
		case (_grpType != ""): {
			_cfgName = "cfgMCCRtsGroups";
			_cfgActionsName = "cfgRtsVehiclesActions";
			_constType 	= _grpType;
		};

		case (_obj iskindof "Man"): {
			_cfgName = "cfgRtsNonBuildingsActions";
			_cfgActionsName = "cfgRtsVehiclesActions";
			_constType 	= "MCC_rts_vehicle_Man";
		};

		case (_obj iskindof "Car" && (count crew _obj > 0)): {
			_cfgName = "cfgRtsNonBuildingsActions";
			_cfgActionsName = "cfgRtsVehiclesActions";
			_constType 	= "MCC_rts_vehicle_car";
		};

		case (_obj iskindof "Motorcycle" && (count crew _obj > 0)): {
			_cfgName = "cfgRtsNonBuildingsActions";
			_cfgActionsName = "cfgRtsVehiclesActions";
			_constType 	= "MCC_rts_vehicle_Motorcycle";
		};

		case (_obj iskindof "Tank" && (count crew _obj > 0)): {
			_cfgName = "cfgRtsNonBuildingsActions";
			_cfgActionsName = "cfgRtsVehiclesActions";
			_constType 	= "MCC_rts_vehicle_Tank";
		};

		case (_obj iskindof "Ship" && (count crew _obj > 0)): {
			_cfgName = "cfgRtsNonBuildingsActions";
			_cfgActionsName = "cfgRtsVehiclesActions";
			_constType 	= "MCC_rts_vehicle_Ship";
		};

		case (_obj iskindof "StaticWeapon" && (count crew _obj > 0)): {
			_cfgName = "cfgRtsNonBuildingsActions";
			_cfgActionsName = "cfgRtsVehiclesActions";
			_constType 	= "MCC_rts_vehicle_StaticWeapon";
		};

		case ((_obj iskindof "helicopter") && (count crew _obj > 0)): {
			_cfgName = "cfgRtsNonBuildingsActions";
			_cfgActionsName = "cfgRtsVehiclesActions";
			_constType 	= "MCC_rts_helicopter";
		};

		default {
			_cfgName = "cfgRtsNonBuildingsActions";
			_cfgActionsName = "cfgRtsVehiclesActions";
			_constType 	= "MCC_rts_car";
		};
	};

	if (isClass(missionconfigFile >> _cfgName)) then
	{
		_cfgtext = [getText (missionconfigFile >> _cfgName >> _constType >> "displayName"),getText (missionconfigFile >> _cfgName >> _constType >> "descriptionShort")];
		_availableUpgrades = getArray (missionconfigFile >> _cfgName >> _constType >> "upgradeTo");
		_availableBuildings = getArray (missionconfigFile >> _cfgName >> _constType >> "buildings");
		_availableActions = getArray (missionconfigFile >> _cfgName >> _constType >> "actions");
		_elec = getNumber (missionconfigFile >> _cfgName >> _constType >> "needelectricity");
	} else {
		_cfgtext = [getText (configFile >> _cfgName >> _constType >> "displayName"),getText (configFile >> _cfgName >> _constType >> "descriptionShort")];
		_availableUpgrades = getArray (configFile >> _cfgName >> _constType >> "upgradeTo");
		_availableBuildings = getArray (configFile >> _cfgName >> _constType >> "buildings");
		_availableActions = getArray (configFile >> _cfgName >> _constType >> "actions");
		_elec = getNumber (configFile >> _cfgName >> _constType >> "needelectricity");
	};

	//Are we dealing with a group? get group info
	if (!(isNull group _obj) && !(_obj isKindOf "UserTexture10m_F")) then {
		private ["_rank","_group","_html","_info","_properCfg","_infCount"];
		_group = group _obj;
		_rank = [leader _group,"displayNameShort"] call BIS_fnc_rankParams;
		_properCfg = 8;

		_html = "";
		_info = [_group] call MCC_fnc_countGroupHC;
		if (_info select 0 == 0 && _info select 1 == 0 && _info select 2 == 0 && _info select 3 == 0 && _info select 4 == 0 && _info select 5 == 0 && _info select 6 == 0 && _info select 5 == 0) then {
			_info = [_group] call MCC_fnc_countGroup;
			_properCfg = 5;
		};

		_html = _html + "<t font='puristaMedium' color='#fefefe' size='0.9' shadow='1' align='left' underline='false'>" + _rank + " " + name leader _group + " - " + behaviour leader _group + " </t><br/>";

		//Infantry
		_infCount = if (_properCfg > 5) then {(_info select 0) + (_info select 5)} else {(_info select 0)};

		if (_infCount > 0) then {
			_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>Infantry: " + str (_info select 0) + " </t>";
			for [{_x = 0},{_x < (_info select 0)},{_x = _x+1}] do {
				_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>|</t>";
			};
			_html = _html +	"<br/>";
		};

		//Vehicles
		{
			if ((_info select (_foreachindex +1)) > 0) then {
				_html = _html + "<t color='#fefefe' size='0.8' shadow='1' align='left' underline='false'>"+ _x + ": " + str (_info select 1) + " </t>";
					{
						_html = _html + format ["<img size='0.7' color='#fefefe' image=%1/><t> </t>",str _x];
					} foreach ((_info select _properCfg) select 0);
				_html = _html +	"<br/>";
			};
		} foreach ["Motorized","Armored","Air","Naval"];

		_cfgtext = [_group getVariable ["name",groupID _group],_html];
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
	if !(isnil "_cfgtext") then {
		_text = format ["<t color='#ff0000' underline='true'>%1</t><br />%2",(_cfgtext select 0),(_cfgtext select 1)];
		(_disp displayCtrl 9999) ctrlSetStructuredText parseText _text;
	} else {
		(_disp displayCtrl 9999) ctrlSetStructuredText parseText "";
	};

	//electricity
	_elecOn = missionNamespace getVariable [format ["MCC_rtsElecOn_%1", playerSide],false];
	if (_elec == 1) then {
		if (_elecOn) then {
			_online = true;
			(_disp displayCtrl 950) ctrlSetText "Online";
			(_disp displayCtrl 950) ctrlSetTextColor [1, 1, 1, 1];
		} else {
			_online = false;
			(_disp displayCtrl 950) ctrlSetText "Offline";
			(_disp displayCtrl 950) ctrlSetTextColor[1, 0, 0, 1];

		}} else {
		_online = true;
		(_disp displayCtrl 950) ctrlSetText "Online";
		(_disp displayCtrl 950) ctrlSetTextColor [1, 1, 1, 1];
	};

	//remove controls
	for "_i" from 9101 to 9112 do {(_disp displayCtrl _i) ctrlShow false};
	for "_i" from 9160 to 9162 do {(_disp displayCtrl _i) ctrlShow false};

	//Populate upgrades
	for "_i" from 9160 to 9162 do
	{
		if (count _availableUpgrades > 0) then {
			//Resize array
			_action = _availableUpgrades select 0;
			_availableUpgrades set [0,-1];
			_availableUpgrades = _availableUpgrades - [-1];

			//Get CFG
			if (isClass (missionconfigFile >> _cfgName)) then {
				_constType = getText (missionconfigFile >> _cfgName >> _action >> "constType");
				_pic = getText (missionconfigFile >> _cfgName >> _action >> "picture");
				_res = getArray (missionconfigFile >> _cfgName >> _action >> "resources");
				_req = getArray (missionconfigFile >> _cfgName >> _action >> "requiredBuildings");
			} else {
				_constType = getText (configFile >> _cfgName >> _action >> "constType");
				_pic = getText (configFile >> _cfgName >> _action >> "picture");
				_res = getArray (configFile >> _cfgName >> _action >> "resources");
				_req = getArray (configFile >> _cfgName >> _action >> "requiredBuildings");
			};

			(_disp displayCtrl _i) ctrlShow true;
			(_disp displayCtrl _i) ctrlSetText _pic;
			missionNamespace setVariable [format ["MCC_ctrlData_%1", ctrlIDC (_disp displayCtrl _i)],_action];

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
				(_disp displayCtrl _i) ctrlSetTextColor [1, 1, 1, 1];
			} else {
				(_disp displayCtrl _i) ctrlSetTextColor [1, 1, 1, 0.4];
			};

			//remove
			(_disp displayCtrl _i) ctrlRemoveAllEventHandlers "MouseButtonClick";
			(_disp displayCtrl _i) ctrlRemoveAllEventHandlers "MouseHolding";
			(_disp displayCtrl _i) ctrlRemoveAllEventHandlers "MouseExit";

			//add EH
			if (_available && _online) then {
				(_disp displayCtrl _i) ctrlAddEventHandler ["MouseButtonClick",format ["[_this select 0, %1, '%2'] spawn MCC_fnc_rtsUpgrade",_res,_action]];
			};
			(_disp displayCtrl _i) ctrlAddEventHandler ["MouseHolding",format ['[_this,%1] call MCC_fnc_baseActionEntered',str _cfgName]];
			(_disp displayCtrl _i) ctrlAddEventHandler ["MouseExit",format ["[_this,'%1'] call MCC_fnc_baseActionExit",_action]];
		} else {
			(_disp displayCtrl _i) ctrlShow false;
		};
	};

	//Populate actions
	for "_i" from 9101 to 9112 do
	{
		if (count _availableActions > 0) then {
			//Resize array
			_action = _availableActions select 0;
			_availableActions set [0,-1];
			_availableActions = _availableActions - [-1];

			//Get CFG
			if (isClass(missionconfigFile >> _cfgActionsName)) then {
				_pic = getText (missionconfigFile >> _cfgActionsName >> _action >> "picture");
				_res = getArray (missionconfigFile >> _cfgActionsName >> _action >> "resources");
				_req = getArray (missionconfigFile >> _cfgActionsName >> _action >> "requiredBuildings");
				_elec = getNumber (missionconfigFile >> _cfgActionsName >> _action >> "needelectricity");
				_fnc = getText (missionconfigFile >> _cfgActionsName >> _action >> "actionFNC");
				_cnd = getText (missionconfigFile >> _cfgActionsName >> _action >> "condition");
				_showDisabled = (getnumber (missionconfigFile >> _cfgActionsName >> _action >> "dontShowDisabled"))==1;
			} else {
				_pic = getText (configFile >> _cfgActionsName >> _action >> "picture");
				_res = getArray (configFile >> _cfgActionsName >> _action >> "resources");
				_req = getArray (configFile >> _cfgActionsName >> _action >> "requiredBuildings");
				_elec = getNumber (configFile >> _cfgActionsName >> _action >> "needelectricity");
				_fnc = getText (configFile >> _cfgActionsName >> _action >> "actionFNC");
				_cnd = getText (configFile >> _cfgActionsName >> _action >> "condition");
				_showDisabled = (getnumber (configFile >> _cfgActionsName >> _action >> "dontShowDisabled"))==1;
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
				(_disp displayCtrl _i) ctrlSetTextColor [1, 1, 1, 1];
			} else {
				(_disp displayCtrl _i) ctrlSetTextColor [1, 1, 1, 0.4];
			};

			//remove
			(_disp displayCtrl _i) ctrlRemoveAllEventHandlers "MouseButtonClick";
			(_disp displayCtrl _i) ctrlRemoveAllEventHandlers "MouseHolding";
			(_disp displayCtrl _i) ctrlRemoveAllEventHandlers "MouseExit";

			//add EH
			if !(_showDisabled && !_available) then {
				(_disp displayCtrl _i) ctrlShow true;
				(_disp displayCtrl _i) ctrlSetText _pic;
				missionNamespace setVariable [format ["MCC_ctrlData_%1", ctrlIDC (_disp displayCtrl _i)],_action];

				if (_available && _online) then {(_disp displayCtrl _i) ctrlAddEventHandler ["MouseButtonClick",format ['[_this select 0, %2] spawn %1',_fnc,_res]]};
				(_disp displayCtrl _i) ctrlAddEventHandler ["MouseHolding",format ['[_this,"%1"] call MCC_fnc_baseActionEntered',_cfgActionsName]];
				(_disp displayCtrl _i) ctrlAddEventHandler ["MouseExit",format ["[_this,'%1'] call MCC_fnc_baseActionExit",_action]];
			};
		}
		else
		{
			(_disp displayCtrl _i) ctrlShow false;
		};
	};
} foreach (_this select 0);
