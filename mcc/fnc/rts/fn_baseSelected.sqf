//=================================================================MCC_fnc_baseSelected==============================================================================
//	What happendes when we select a base building
//  Parameter(s):
//     _obj: OBJECTS base selected
//==============================================================================================================================================================================
private ["_obj","_constType","_cfgtext","_text","_disp","_availableActions","_availableUpgrades","_availableBuildings","_elec"];
disableSerialization;
_obj  = _this select 0;
_disp = uiNamespace getVariable "MCC_LOGISTICS_BASE_BUILD";

_availableUpgrades 	= [];
_availableActions 	= [];
_availableBuildings = [];

if (_obj iskindof "logic") then
{
	_constType 	= format ["MCC_rts_%1%2",(_obj getVariable ["mcc_constructionItemType",""]),(_obj getVariable ["mcc_constructionItemTypeLevel",1])];

	if (MCC_isMode) then
	{
		_cfgtext = [getText (configFile >> "cfgRtsBuildings" >> _constType >> "displayName"),getText (configFile >> "cfgRtsBuildings" >> _constType >> "descriptionShort")];
		_availableUpgrades = getArray (configFile >> "cfgRtsBuildings" >> _constType >> "upgradeTo");
		_availableBuildings = getArray (configFile >> "cfgRtsBuildings" >> _constType >> "buildings");
		_availableActions = getArray (configFile >> "cfgRtsBuildings" >> _constType >> "actions");
	}
	else
	{
		_cfgtext = [getText (missionconfigFile >> "cfgRtsBuildings" >> _constType >> "displayName"),getText (missionconfigFile >> "cfgRtsBuildings" >> _constType >> "descriptionShort")];
		_availableUpgrades = getArray (missionconfigFile >> "cfgRtsBuildings" >> _constType >> "upgradeTo");
		_availableBuildings = getArray (missionconfigFile >> "cfgRtsBuildings" >> _constType >> "buildings");
		_availableActions = getArray (configFile >> "cfgRtsBuildings" >> _constType >> "actions");
	};

	//diable actions/upgrades while under construction
	if ((_obj getVariable ["mcc_constructionStartTime",time]) + (_obj getVariable ["mcc_constructionendTime",0])> time) then
	{
		_availableUpgrades 	= [];
		_availableActions 	= [];
		_availableBuildings = [];
	};

} else {
	_cfgtext = [getText (configFile >> "cfgVehicles" >> typeOf _obj >> "displayName"),getText (configFile >> "cfgVehicles" >> typeOf _obj >> "descriptionShort")];
	//Upgrade off road to armed
	if (typeOf _obj in ["B_G_Offroad_01_F","C_Offroad_01_F"]) then	{
		_availableActions = ["MCC_rts_mountGuns"];
	};
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

//Populate upgrades
for "_i" from 160 to 162 do
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
			_constType = getText (configFile >> "cfgRtsBuildings" >> _action >> "constType");
			_pic = getText (configFile >> "cfgRtsBuildings" >> _action >> "picture");
			_res = getArray (configFile >> "cfgRtsBuildings" >> _action >> "resources");
			_req = getArray (configFile >> "cfgRtsBuildings" >> _action >> "requiredBuildings");
		}
		else
		{
			_constType = getText (missionconfigFile >> "cfgRtsBuildings" >> _action >> "constType");
			_pic = getText (missionconfigFile >> "cfgRtsBuildings" >> _action >> "picture");
			_res = getArray (missionconfigFile >> "cfgRtsBuildings" >> _action >> "resources");
			_req = getArray (missionconfigFile >> "cfgRtsBuildings" >> _action >> "requiredBuildings");
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

		if (_available) then
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
		if (_available) then
		{
			_ctrl ctrlAddEventHandler ["MouseButtonClick",format ["[MCC_CONST_SELECTED, false] call MCC_fnc_rtsClearBuilding; [[getpos MCC_CONST_SELECTED, getdir MCC_CONST_SELECTED,'%1', 1, playerside],'MCC_fnc_construct_base',false] call bis_fnc_MP;",_action]];
		};
		_ctrl ctrlAddEventHandler ["MouseHolding",format ["[_this,'%1'] call MCC_fnc_baseActionEntered",_action]];
		_ctrl ctrlAddEventHandler ["MouseExit",format ["[_this,'%1'] call MCC_fnc_baseActionExit",_action]];
	}
	else
	{
		_ctrl ctrlShow false;
	};
};

//Populate buildings
for "_i" from 101 to 104 do
{
	_ctrl = (_disp displayCtrl _i);
	if (count _availableBuildings > 0) then
	{
		//Resize array
		_action = _availableBuildings select 0;
		_availableBuildings set [0,-1];
		_availableBuildings = _availableBuildings - [-1];

		//Get CFG
		if (MCC_isMode) then
		{
			_constType = getText (configFile >> "cfgRtsBuildings" >> _action >> "constType");
			_pic = getText (configFile >> "cfgRtsBuildings" >> _action >> "picture");
			_res = getArray (configFile >> "cfgRtsBuildings" >> _action >> "resources");
			_req = getArray (configFile >> "cfgRtsBuildings" >> _action >> "requiredBuildings");
		}
		else
		{
			_constType = getText (missionconfigFile >> "cfgRtsBuildings" >> _action >> "constType");
			_pic = getText (missionconfigFile >> "cfgRtsBuildings" >> _action >> "picture");
			_res = getArray (missionconfigFile >> "cfgRtsBuildings" >> _action >> "resources");
			_req = getArray (missionconfigFile >> "cfgRtsBuildings" >> _action >> "requiredBuildings");
		};

		_ctrl ctrlShow true;
		_ctrl ctrlSetText _pic;
		missionNamespace setVariable [format ["MCC_ctrlData_%1", ctrlIDC _ctrl],_action];

		//Now let see if we enable the contorl
		_available = false;
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

		if (_available) then
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
		if (_available) then {_ctrl ctrlAddEventHandler ["MouseButtonClick",format ["[_this select 0,'%1'] call MCC_fnc_baseActionClicked",_action]]};
		_ctrl ctrlAddEventHandler ["MouseHolding",format ["[_this,'%1'] call MCC_fnc_baseActionEntered",_action]];
		_ctrl ctrlAddEventHandler ["MouseExit",format ["[_this,'%1'] call MCC_fnc_baseActionExit",_action]];
	}
	else
	{
		_ctrl ctrlShow false;
	};
};

//Populate actions
for "_i" from 105 to 112 do
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
			_pic = getText (configFile >> "cfgRtsActions" >> _action >> "picture");
			_res = getArray (configFile >> "cfgRtsActions" >> _action >> "resources");
			_req = getArray (configFile >> "cfgRtsActions" >> _action >> "requiredBuildings");
			_elec = getArray (configFile >> "cfgRtsActions" >> _action >> "needelectricity");
		}
		else
		{
			_pic = getText (missionconfigFile >> "cfgRtsActions" >> _action >> "picture");
			_res = getArray (missionconfigFile >> "cfgRtsActions" >> _action >> "resources");
			_req = getArray (missionconfigFile >> "cfgRtsActions" >> _action >> "requiredBuildings");
			_elec = getArray (missionconfigFile >> "cfgRtsActions" >> _action >> "needelectricity");
		};

		_ctrl ctrlShow true;
		_ctrl ctrlSetText _pic;
		missionNamespace setVariable [format ["MCC_ctrlData_%1", ctrlIDC _ctrl],_action];

		//Now let see if we enable the contorl
		_available = false;
		{
			_available = [_x, _obj, 50] call MCC_fnc_CheckBuildings;
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

		if (_available) then
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
		if (_available) then {_ctrl ctrlAddEventHandler ["MouseButtonClick",format ["[_this select 0,'%1'] call MCC_fnc_baseActionClicked",_action]]};
		_ctrl ctrlAddEventHandler ["MouseHolding",format ["[_this,'%1'] call MCC_fnc_baseActionEntered",_action]];
		_ctrl ctrlAddEventHandler ["MouseExit",format ["[_this,'%1'] call MCC_fnc_baseActionExit",_action]];
	}
	else
	{
		_ctrl ctrlShow false;
	};
};