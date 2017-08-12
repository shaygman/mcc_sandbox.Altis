//=================================================================MCC_fnc_rtsFortUIContainer==============================================================================
//	Upgrad building
//  Parameter(s):
//     	_ctrl: CONTROL
//		_res: resources Needed
//==============================================================================================================================================================================
private ["_ctrl","_obj","_consType","_constLevel","_availableActions","_disp","_action","_pic","_res","_req","_elec","_fnc","_cnd","_online","_elecOn","_class"];
disableSerialization;
_ctrl = _this select 0;
_disp = ctrlParent _ctrl;

if (count MCC_ConsoleGroupSelected <=0) exitWith {};
_obj = MCC_ConsoleGroupSelected select 0;

_consType = _obj getVariable ["mcc_constructionItemType","hq"];
_constLevel = _obj getVariable ["mcc_constructionItemTypeLevel",1];
_availableActions = [];

//electricity
_elecOn = missionNamespace getVariable [format ["MCC_rtsElecOn_%1", playerSide],false];

_constType 	= format ["MCC_rts_%1%2",_consType,_constLevel];

if (isClass (missionconfigFile >> "cfgRtsBuildings")) then {
	_availableActions = getArray (missionconfigFile >> "cfgRtsBuildings" >> _constType >> "fortifications");
} else {
	_availableActions = getArray (configFile >> "cfgRtsBuildings" >> _constType >> "fortifications");
};


//Add back button
for "_i" from 0 to 11 do {
	if (count _availableActions <= _i) then {_availableActions set [_i,""]};
};
_availableActions set [11,"MCC_rts_rtsBuildUIContainerBack"];

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
		if (isClass (missionconfigFile >> "cfgRtsActions")) then {
			_pic = getText (missionconfigFile >> "cfgRtsActions" >> _action >> "picture");
			_res = getArray (missionconfigFile >> "cfgRtsActions" >> _action >> "resources");
			_req = getArray (missionconfigFile >> "cfgRtsActions" >> _action >> "requiredBuildings");
			_elec = getNumber (missionconfigFile >> "cfgRtsActions" >> _action >> "needelectricity");
			_fnc = getText (missionconfigFile >> "cfgRtsActions" >> _action >> "actionFNC");
			_cnd = getText (missionconfigFile >> "cfgRtsActions" >> _action >> "condition");
			_class =  getText (missionconfigFile >> "cfgRtsActions" >> _action >> "fortClass");
		} else {
			_pic = getText (configFile >> "cfgRtsActions" >> _action >> "picture");
			_res = getArray (configFile >> "cfgRtsActions" >> _action >> "resources");
			_req = getArray (configFile >> "cfgRtsActions" >> _action >> "requiredBuildings");
			_elec = getNumber (configFile >> "cfgRtsActions" >> _action >> "needelectricity");
			_fnc = getText (configFile >> "cfgRtsActions" >> _action >> "actionFNC");
			_cnd = getText (configFile >> "cfgRtsActions" >> _action >> "condition");
			_class =  getText (configFile >> "cfgRtsActions" >> _action >> "fortClass");
		};

		_ctrl ctrlShow true;
		_ctrl ctrlSetText _pic;
		missionNamespace setVariable [format ["MCC_ctrlData_%1", ctrlIDC _ctrl],_action];

		//Now let see if we enable the contorl
		_available = true;
		{
			_available = [_x, _obj, 300] call MCC_fnc_CheckBuildings;
			if (!_available) exitWith {};
		} foreach _req;

		//condition
		if (_available && _cnd !="") then {
			_available = call compile _cnd;
		};

		//Do we have the resources
		if (_available) then
		{
			{
				_available = [playerSide, _x] call MCC_fnc_checkRes;
				if (!_available) exitWith {};
			} foreach _res;
		};

		_online = true;
		if (_elec == 1 && ! _elecOn) then {_online = false};

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
		if (_available && _online) then {_ctrl ctrlAddEventHandler ["MouseButtonClick",format ['[_this select 0, %2, "%3"] spawn %1',_fnc,_res,_class]]};
		_ctrl ctrlAddEventHandler ["MouseHolding","[_this,'cfgRtsActions'] call MCC_fnc_baseActionEntered"];
		_ctrl ctrlAddEventHandler ["MouseExit",format ["[_this,'%1'] call MCC_fnc_baseActionExit",_action]];
	}
	else
	{
		_ctrl ctrlShow false;
	};
};


