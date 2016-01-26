/*=================================================================MCC_fnc_surviveInit==================================================================================
  initilize survival mode on clients
*/
//waitUntil {missionNamespace getVariable ["MCC_initDone",false]};

//============= Start items dialog ===========================
if ((missionNamespace getVariable ["MCC_isLocalHC",false]) || !hasInterface) exitWith {};

if !(missionNamespace getVariable ["MCC_surviveMod",false]) exitWith {};

disableSerialization;

MCC_fnc_surviveItemClicked = {
	private ["_ctrl","_index"];
	disableSerialization;
	_itemClass = _this select 1;
	_ctrl = (_this select 0) select 0;
	_index = (_this select 0) select 1;

	call compile format ["_itemClass = '%1'; _ctrlIDC = %3; %2",_itemClass,(_ctrl lbData _index),ctrlIDC _ctrl];
	_ctrl ctrlShow false;

	sleep 1;
	_ctrl = (uiNameSpace getVariable "mcc_rscSurviveStats") displayCtrl 1;
	_ctrl progressSetPosition ((player getVariable ["MCC_calories",4000])/4000);

	_ctrl = (uiNameSpace getVariable "mcc_rscSurviveStats") displayCtrl 2;
	_ctrl progressSetPosition ((player getVariable ["MCC_water",200])/200);
};

MCC_fnc_handleInventoryClick = {
	private ["_ctrl","_ctrlIDC","_index","_itemClass","_display","_ctrlNew","_ctrlPos","_cfgClass","_itemName","_array","_cfg","_cfgAction","_condition","_cfgClasses","_displayname"];
	disableSerialization;
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
};

0 spawn {
	while {(missionNamespace getVariable ["MCC_surviveMod",false])} do 	{
		private ["_calories","_water","_speedFactor","_lastCheck","_ratio","_caloriesBurn","_waterBurn","_batteryLevel","_light"];
		_lastCheck = player getVariable ["MCC_survivalLastCheckTime",time - 10];

		if (time - _lastCheck >= 10) then {
			//---------Head Torch Battery ------------------
			_light = player getVariable ["MCC_headTorch",objNull];
			if !(isNull _light) then {
				_batteryLevel = player getVariable ["MCC_headTorchBattery",100];
				_batteryLevel = (_batteryLevel - 0.2) max 0;
				player setVariable ["MCC_headTorchBattery",_batteryLevel];
				if (_batteryLevel <= 0) then {
					deleteVehicle _light;
				};
			};


			_calories = player getVariable ["MCC_calories",4000];
			_water = player getVariable ["MCC_water",200];

			_speedFactor = if (vehicle player == player) then {
								if (speed player < 6) then {1} else {
									if (speed player < 14) then {1.5} else {2}};
							} else {0.8};
			_caloriesBurn = (missionNamespace getVariable ["MCC_survivalCaloriesPerHour",1000])/360;
			_waterBurn = (missionNamespace getVariable ["MCC_survivalWaterPerHour",100])/360;
			_calories = (_calories - (_caloriesBurn * _speedFactor)) max 0;
			_water = (_water - ((1-overcast) * _waterBurn*_speedFactor)) max 0;

			//---------Hunger/thirst effects ------------------
			if (isnil "MCC_medicHungerPPEffectColor") then {
				MCC_medicHungerPPEffectColor = ppEffectCreate ["ColorCorrections", 1522];
				MCC_medicHungerPPEffectColor ppEffectForceInNVG True;

				MCC_medicHungerPPEffectBlur = ppEffectCreate ["DynamicBlur", 440];
				MCC_medicHungerPPEffectBlur ppEffectForceInNVG True;
			};


			_ratio = ((_calories/4000) min (_water/200));

			//Sick
			if (player getVariable ["MCC_surviveIsSick",false]) then {_ratio = _ratio *0.5};

			if (_ratio < 0.7) then {
				_ratio = _ratio +0.1;
				MCC_medicHungerPPEffectColor ppEffectEnable TRUE;
				MCC_medicHungerPPEffectBlur ppEffectEnable TRUE;

				if (random 1 < 0.05 && _ratio <0.5) then {
					MCC_medicHungerPPEffectColor ppEffectAdjust [0.8,0.8,0, [0,0,0,0], [0,0,0,_ratio], [0.8,0.8,0.8,1]];
					MCC_medicHungerPPEffectColor ppEffectCommit 0.05;
					if (getFatigue player < _ratio) then {player setFatigue _ratio};
					sleep 0.05;
				};

				MCC_medicHungerPPEffectColor ppEffectAdjust [1, 1, 0, [1, 1, 1, 0], [1, 1, 1, _ratio], [0.75, 0.25, 0, 1.0]];
				MCC_medicHungerPPEffectColor ppEffectCommit 1;

				MCC_medicHungerPPEffectBlur ppEffectAdjust [(1 - _ratio) min 0.3];
				MCC_medicHungerPPEffectBlur ppEffectCommit 1;

				if (_ratio < 0.3) then {
					[_ratio * 100] spawn BIS_fnc_bloodEffect;
					[[[netid player,player], format ["WoundedGuyA_0%1",(floor (random 8))+1]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
				};
			} else {
				MCC_medicHungerPPEffectColor ppEffectEnable false;
				MCC_medicHungerPPEffectBlur ppEffectEnable false;
			};

			player setVariable ["MCC_calories",_calories];
			player setVariable ["MCC_water",_water];
			player setVariable ["MCC_survivalLastCheckTime",time];
		};

		sleep 1;
	};
};

0 spawn {
	while {(missionNamespace getVariable ["MCC_surviveMod",false])} do 	{

		waitUntil {time > 10};
		waituntil {!(isnull (finddisplay 602))};

		//Create progress bar
		(["mcc_rscSurviveStats"] call BIS_fnc_rscLayer) cutRsc ["mcc_rscSurviveStats", "PLAIN"];

		_ctrl = (uiNameSpace getVariable "mcc_rscSurviveStats") displayCtrl 1;
		_ctrl progressSetPosition ((player getVariable ["MCC_calories",4000])/4000);

		_ctrl = (uiNameSpace getVariable "mcc_rscSurviveStats") displayCtrl 2;
		_ctrl progressSetPosition ((player getVariable ["MCC_water",200])/200);

		//Is sick
		if (player getVariable ["MCC_surviveIsSick",false]) then {((uiNameSpace getVariable "mcc_rscSurviveStats") displayCtrl 3) ctrlSetText "Sick"};

		if (missionNamespace getVariable ["MCC_surviveMod",false]) then {

			{
				((findDisplay 602) displayCtrl _x) ctrlSetEventHandler ["LBDblClick", "_this call MCC_fnc_handleInventoryClick"];
			} forEach [638,633,619,640];

			{
				((findDisplay 602) displayCtrl _x) ctrlSetEventHandler ["MouseButtonDblClick", "_this call MCC_fnc_handleInventoryClick"];
			} forEach [6191,6238,6216,612,630,628,629,6240,610,622,620,621,641,611,6331,6381,6217];
		};

		waituntil {isnull (finddisplay 602)};
		//Close bars
		(["mcc_rscSurviveStats"] call BIS_fnc_rscLayer) cutText ["", "PLAIN"];


		sleep 1;
	};
};
