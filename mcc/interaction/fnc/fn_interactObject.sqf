//==================================================================MCC_fnc_interactObject======================================================================================
// Interaction with containers object
// Example:[player,_object]  call MCC_fnc_interactObject;
//=============================================================================================================================================================================
private ["_object","_typeOfobject","_ctrl","_break","_searchTime","_animation","_phase","_doorTypes","_isHouse","_loadName","_waitTime","_array","_displayname",
         "_randomChance","_loot","_wepHolder","_class","_money","_rand","_wepArray","_randomAmmount"];
disableSerialization;
_object 	= _this select 0;
if (isNil "MCC_interactionKey_holding") then {MCC_interactionKey_holding = false};

if ((player distance _object < 7) && ((missionNamespace getVariable ["MCC_interactionKey_holding",false]) || (MCC_isACE && MCC_isMode)) && !(missionNameSpace getVariable [format ["MCC_isInteracted%1",getpos _object], false]) && (isNull attachedTo _object)) then {

	//Get what we can have in the loot from the server
	{
		if (isNil _x) then {
			if (isClass (missionconfigFile >> "CfgMCCspawnItems" >> _x)) then {
				missionNamespace setVariable [_x,getArray (missionconfigFile >> "CfgMCCspawnItems" >> _x >> "itemClasses")];
			} else {
				missionNamespace setVariable [_x,getArray (configFile >> "CfgMCCspawnItems" >> _x >> "itemClasses")];
			};
		};
	} forEach ["MCC_medItems","MCC_fuelItems","MCC_repairItems","MCC_foodItem","MCC_money","MCC_fruits","MCC_survivalWeapons","MCC_survivalMagazines","MCC_survivalAttachments"];

	//No user defined weapons use MCC defaults
	if (count (missionNamespace getVariable ["MCC_survivalWeapons",[]]) <= 0) then {
		missionNamespace setVariable ["MCC_survivalWeapons",W_BINOS + W_LAUNCHERS +W_MG + W_PISTOLS + W_RIFLES + W_SNIPER];
	};

	if (count (missionNamespace getVariable ["MCC_survivalMagazines",[]]) <= 0) then {
		missionNamespace setVariable ["MCC_survivalMagazines",U_MAGAZINES + U_UNDERBARREL +U_GRENADE + U_EXPLOSIVE];
	};

	if (count (missionNamespace getVariable ["MCC_survivalAttachments",[]]) <= 0) then {
		missionNamespace setVariable ["MCC_survivalAttachments",W_ATTACHMENTS];
	};

	missionNameSpace setVariable [format ["MCC_isInteracted%1",getpos _object], true];
	publicvariable format ["MCC_isInteracted%1",getpos _object];

	//Create progress bar
	_searchTime = if ((MCC_isACE && MCC_isMode)) then {3} else {10};
	_break		= false;
	(["MCC_interactionPB"] call BIS_fnc_rscLayer) cutRsc ["MCC_interactionPB", "PLAIN"];
	_ctrl = ((uiNameSpace getVariable "MCC_interactionPB") displayCtrl 2);
	_ctrl ctrlSetText "Searching";
	_ctrl = ((uiNameSpace getVariable "MCC_interactionPB") displayCtrl 1);

	for [{_x=1},{_x<_searchTime},{_x=_x+0.1}]  do {

		_ctrl progressSetPosition (_x/_searchTime);
		if ((MCC_isACE && MCC_isMode) && ((animationState player)!="AinvPknlMstpSlayWrflDnon_medic")) then {player playMoveNow "AinvPknlMstpSlayWrflDnon_medic"};
		if ((_object distance player) > 6 || (!(missionNamespace getVariable ["MCC_interactionKey_holding",false]) && !(MCC_isACE && MCC_isMode))) then {_x = _searchTime; _break = true;};
		sleep 0.1;
	};
	(["MCC_interactionPB"] call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
	//player playMoveNow "AmovPknlMstpSlowWrflDnon";

	//If moved to far from the IED
	if (_break) exitwith {};

	//Find out what object category is it
	//Weapon/ammo/med/fuel/repair/food/money
	private ["_varName"];
	_typeOfobject = "";
	{
		_varName = _x;
		if (_typeOfobject != "") exitWith {};
		{
			if ([_x , str _object] call BIS_fnc_inString) exitWith {_typeOfobject = _varName};
		} forEach (missionNamespace getVariable [_varName,[]]);
	} forEach ([false] call MCC_fnc_getSurvivalPlaceHolders);

	if (!isnil "_typeOfobject") then {
		_randomChance = [];
		_randomAmmount = [];
		{
			if (isClass (missionconfigFile >> "CfgMCCspawnObjects" >> _typeOfobject)) then {
				_randomChance pushBack (getNumber (missionconfigFile >> "CfgMCCspawnObjects" >> _typeOfobject >> format ["chance%1",_x]));
				_randomAmmount pushBack (getNumber (missionconfigFile >> "CfgMCCspawnObjects" >> _typeOfobject >> format ["max%1",_x]));
			} else {
				_randomChance pushBack (getNumber (configFile >> "CfgMCCspawnObjects" >> _typeOfobject >> format ["chance%1",_x]));
				_randomAmmount pushBack (getNumber (configFile >> "CfgMCCspawnObjects" >> _typeOfobject >> format ["max%1",_x]));
			};
		} forEach ["Weapon","Ammo","Med","Fuel","Repair","Food","Money","fruit"];

		//createvirtual wepholder
		_wepHolder = "GroundWeaponHolder" createVehiclelocal getpos player;
		_wepHolder setpos getpos player;
		_wepHolder hideobject true;
		player setVariable ["interactWith",_wepHolder];

		//create the random loot
		player setVariable ["MCC_readValue",nil];

		[[format ["SERVER_%1",toupper worldName], "Loot Positions", format ["Object_%1",(getpos _object)], "ARRAY",player,true,[]], "MCC_fnc_inidbGet", false, false] call BIS_fnc_MP;

		while {isnil "_loot"} do {sleep 0.1;_loot = player getVariable ["MCC_readValue",nil]};

		//If empty spawn check if it is time to respawn loot
		if (count _loot == 1) then {
			if ((dateToNumber date - (_loot select 0))> (0.00273973*MCC_surviveModRefresh)) then {
				_loot = [];
			};
		};

		if (count _loot == 0) then {
			//time stamp
			_loot set [0, dateToNumber date];
			private ["_max"];
			//Fruit
			{
				_array = [MCC_survivalWeapons + MCC_survivalAttachments,
				          MCC_survivalMagazines,
				          MCC_medItems,
				          MCC_fuelItems,
				          MCC_repairItems,
				          MCC_foodItem,
				          MCC_money,
				          MCC_fruits] select _foreachIndex;

				if (count _array > 0 && random 100 < _x) then {
					_max = (floor random (_randomAmmount select _foreachIndex)) +1;

					for "_i" from 0 to _max do {
						_loot pushBack ((_array call BIS_fnc_selectRandom) select 0);
					};
				};
			} forEach _randomChance;
		};

		for "_i" from 1 to (count _loot -1) do {
			_class = _loot select _i;
			if (_class in (MCC_foodItem + MCC_money + MCC_fruits + MCC_repairItems + MCC_fuelItems + MCC_medItems) || ({_x select 0 == _class} count W_ATTACHMENTS)>0) then {
				switch (true) do {
					case (isClass (configFile >> "CfgMagazines" >> _class)) : {_wepHolder addMagazineCargoGlobal [_class,1]};
					case (isClass (configFile >> "CfgWeapons" >> _class)) : {_wepHolder addWeaponCargoGlobal [_class,1]; if !(_class in weaponCargo _wepHolder) then {_wepHolder addItemCargoGlobal [_class,1]}};
				};
			} else {
				switch (true) do {
					case (isClass (configFile >> "CfgMagazines" >> _class)) : {_wepHolder addMagazineCargo [_class,1]};
					case (isClass (configFile >> "CfgWeapons" >> _class)) : {_wepHolder addWeaponCargo [_class,1]; if !(_class in weaponCargo _wepHolder) then {_wepHolder addItemCargo [_class,1]}};
				};
			};
		};

		player action ["OpenBag",_wepHolder];
		waituntil {dialog};
		waituntil {!dialog};


		//get what left
		_array = [];
		_array set [0,_loot select 0];	//time stamp
		_wepArray = (weaponCargo _wepHolder) + (itemCargo _wepHolder) + (magazineCargo _wepHolder);
		if (isNil "_wepArray") then {_wepArray = []};
		{
			_array set [count _array, _x];
		} foreach _wepArray;
		deleteVehicle _wepHolder;

		//Update server
		//[format ["SERVER_%1",toupper worldName], "Loot Positions", format ["Object_%1",(getpos _object)], "ARRAY",player,false,_array] call MCC_fnc_inidbGet;
		[[format ["SERVER_%1",toupper worldName], "Loot Positions", format ["Object_%1",(getpos _object)], "ARRAY",player,false,_array], "MCC_fnc_inidbGet", false, false] call BIS_fnc_MP;
	};

};
missionNameSpace setVariable [format ["MCC_isInteracted%1",getpos _object], false];
publicvariable format ["MCC_isInteracted%1",getpos _object];
player setVariable ["MCC_interactionActive",false];