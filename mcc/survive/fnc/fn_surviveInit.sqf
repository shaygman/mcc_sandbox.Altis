/*=================================================================MCC_fnc_surviveInit==================================================================================
  initilize survival mode on clients
*/
//waitUntil {missionNamespace getVariable ["MCC_initDone",false]};

//============= Start items dialog ===========================

if (missionNamespace getVariable ["MCC_surviveModinitialized",false]) exitWith {};
missionNamespace setVariable ["MCC_surviveModinitialized",true];

waitUntil {missionNamespace getVariable ["MCC_surviveMod",false]};

//Spawn crates in houses
if (isServer) then {
	0 spawn {
		/*
		private ["_worldPath","_mapSize","_mapCenter","_index","_buildings","_availablePos","_buildingPos"];
		_worldPath = configfile >> "cfgworlds" >> worldname;
		_mapSize = getnumber (_worldPath >> "mapSize");
		if (_mapSize == 0) then {_mapSize = 10000};

		_mapSize = _mapSize / 2;
		_mapCenter = [_mapSize,_mapSize];

		_buildings = _mapCenter nearObjects ["House",10000];
		_index = 0;
	    {
	    	_availablePos = [];

			for "_i" from 0 to 20 do {
			    _buildingPos = _x buildingpos _i;
			    if (str _buildingPos == "[0,0,0]") exitwith {};
			    _availablePos pushBack _buildingPos;
			};

			{
				if (random 100 < 1) then {
					_object = (["Land_Sack_F","Land_MetalBarrel_F","Land_MetalCase_01_small_F","Land_PlasticCase_01_small_F"] call BIS_fnc_selectRandom) createVehicle _x;
					_object setPos _x;
					_object setDir (random 360);
					_index = _index +1;
					_eib_marker = createMarkerlocal [format ["itemMarker_%1", _index],_x];
					_eib_marker setMarkerTypelocal "mil_dot";
					_eib_marker setMarkerColorlocal "ColorRed";
				};
			} forEach _availablePos;
	    } foreach _buildings;

	    systemChat format ["Total of %1 items created", _index];


		{
			_temploc = [_mapCenter,5000,_x] call MCC_fnc_MWbuildLocations;
			{
				_buildings = (getpos (_x select 0)) nearObjects ["House",500];

			    {
			    	_availablePos = [];

					for "_i" from 0 to 20 do {
					    _buildingPos = _x buildingpos _i;
					    if (str _buildingPos == "[0,0,0]") exitwith {};
					    _availablePos pushBack _buildingPos;
					};

					{
						if (random 100 < 3) then {
							_object = (["Land_Sack_F","Land_MetalBarrel_F","Land_MetalCase_01_small_F","Land_PlasticCase_01_small_F"] call BIS_fnc_selectRandom) createVehicle _x;
							_object setPos _x;
							_object setDir (random 360);
						};
					} forEach _availablePos;
			    } foreach _buildings;
			} forEach _temploc;
		} forEach ["city","mil","nature"];

		addMissionEventHandler ["HandleDisconnect",{
				private ["_tempArray","_player"];
				_player = _this select 0;

				[format ["%1_playerPos",worldname], [_this select 2,_this select 3],position _player, "ARRAY"] remoteExec ["MCC_fnc_setVariable", 2];

				//Gear
				_tempArray = [goggles _player,
							  headgear _player,
							  uniform _player,
							  vest _player,
							  backpack _player,
							  backpackItems _player,
							  primaryWeaponMagazine _player,
							  secondaryWeaponMagazine _player,
							  handgunMagazine _player,
							  items _player,
							  assignedItems _player,
							  uniformItems _player,
							  vestItems _player,
							  primaryWeapon _player,
							  secondaryWeapon _player,
							  handgunWeapon _player,
							  magazines _player,
							  primaryWeaponItems _player,
							  secondaryWeaponItems _player,
							  handgunItems _player];

				[format ["%1_playerGear",worldname], [_this select 2,_this select 3],_tempArray, "ARRAY"] remoteExec ["MCC_fnc_setVariable", 2];

				diag_log "we finished" + str _this;
			}];
		*/

		private ["_player","_tempArray"];

		//Set resources once start
		{
			_tempArray = [format ["%1_SERVER_SURVIVAL",worldname], "SURVIVAL", format ["%1_resources",_x], "read",[1500,500,200,200,200],format ["%1_SERVER_SURVIVAL",worldname]] call MCC_fnc_handleDB;

			missionNameSpace setVariable [format ["MCC_res%1",_x],_tempArray,true];
		} forEach [west,east,resistance];


		while {true} do {
			sleep 5;
			{
				_player = _x;
				//Position
				[format ["%1_playerPos",worldname], _player,position _player, "ARRAY"] call MCC_fnc_setVariable;

				//Gear
				_tempArray = [goggles _player,
							  headgear _player,
							  uniform _player,
							  vest _player,
							  backpack _player,
							  backpackItems _player,
							  primaryWeaponMagazine _player,
							  secondaryWeaponMagazine _player,
							  handgunMagazine _player,
							  assignedItems _player,
							  uniformItems _player,
							  vestItems _player,
							  primaryWeapon _player,
							  secondaryWeapon _player,
							  handgunWeapon _player,
							  primaryWeaponItems _player,
							  secondaryWeaponItems _player,
							  handgunItems _player];

				[format ["%1_playerGear",worldname], _player,_tempArray, "ARRAY"] call MCC_fnc_setVariable;

				//health and stats
				_tempArray = [damage _player,
							  _player getVariable ["MCC_valorPoints",50],
							  _player getVariable ["MCC_calories",4000],
							  _player getVariable ["MCC_water",200],
							  _player getVariable ["MCC_surviveIsSick",false]
							 ];

				[format ["%1_playerStats",worldname], _player,_tempArray, "ARRAY"] call MCC_fnc_setVariable;

			} forEach (if (isMultiplayer) then {playableUnits} else {[player]});

			//Set resources
			{
				_tempArray = missionNameSpace getVariable [format ["MCC_res%1",_x],[1500,500,200,200,200]];
				[format ["%1_SERVER_SURVIVAL",worldname], "SURVIVAL", format ["%1_resources",_x], "write",_tempArray,format ["%1_SERVER_SURVIVAL",worldname]] call MCC_fnc_handleDB;
			} forEach [west,east,resistance];
		};
	};
};


if ((missionNamespace getVariable ["MCC_isLocalHC",false]) || !hasInterface) exitWith {};

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

			player setVariable ["MCC_calories",_calories, true];
			player setVariable ["MCC_water",_water, true];
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

0 spawn {
	private ["_varName","_var"];
	waituntil {alive player &&
				time > 0 &&
				!dialog &&
				!(IsNull (findDisplay 46)) &&
				((missionNameSpace getvariable ["playerDeploy",false]) || !(missionNameSpace getvariable ["CP_activated",false]))
			  };

	//Get player location
	_varName = format ["%1_playerPos",worldname];
	[_varName, player,position player, "ARRAY"] remoteExec ["MCC_fnc_getVariable", 2];
	waitUntil {!isNil _varName};
	player setpos (missionNameSpace getVariable [_varName,position player]);

	//Set Gear
	_varName = format ["%1_playerGear",worldname];
	[_varName, player,[   goggles player,
						  headgear player,
						  uniform player,
						  vest player,
						  backpack player,
						  backpackItems player,
						  primaryWeaponMagazine player,
						  secondaryWeaponMagazine player,
						  handgunMagazine player,
						  assignedItems player,
						  uniformItems player,
						  vestItems player,
						  primaryWeapon player,
						  secondaryWeapon player,
						  handgunWeapon player,
						  primaryWeaponItems player,
						  secondaryWeaponItems player,
						  handgunItems player], "ARRAY"] remoteExec ["MCC_fnc_getVariable", 2];
	waitUntil {!isNil _varName};
	(missionNameSpace getVariable [_varName,[]]) call MCC_fnc_loadGear;

	//Set player stats
	_varName = format ["%1_playerStats",worldname];
	[_varName, player,[], "ARRAY"] remoteExec ["MCC_fnc_getVariable", 2];
	waitUntil {!isNil _varName};
	_var = missionNameSpace getVariable [_varName,[]];

	player setDamage (_var param [0,0]);
	player setVariable ["MCC_valorPoints",(_var param [1,50]),true];
	player setVariable ["MCC_calories",(_var param [2,4000]),true];
	player setVariable ["MCC_water",(_var param [3,200]),true];
	player setVariable ["MCC_surviveIsSick",(_var param [4,false]),true];
};