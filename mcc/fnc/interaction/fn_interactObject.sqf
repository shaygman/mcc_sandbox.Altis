//==================================================================MCC_fnc_interactObject======================================================================================
// Interaction with containers object
// Example:[player,_object]  call MCC_fnc_interactObject;
//=============================================================================================================================================================================
#define MCC_barrels ["garbagebarrel","garbagebin","toiletbox","garbagecontainer","fieldtoilet","tabledesk","cashdesk"]
#define MCC_grave ["grave_forest","grave_dirt","grave_rocks"]
#define MCC_containers ["woodenbox","barreltrash","metalbarrel_f","cratesplastic","cargo20","cargo40","crates"]
#define MCC_food ["icebox","rack","shelves","sacks_goods","basket","sack_f"]
//#define MCC_water ["water_source"]
#define MCC_fuel ["watertank","waterbarrel","barrelwater","stallwater"]
#define MCC_plantsFruit ["neriumo","ficusc"]
#define MCC_misc ["fishinggear","crabcages","rowboat","calvary","pipes_small","woodpile","pallets_stack","wheelcart"]
#define MCC_garbage ["garbagebags","junkpile","garbagepallet","tyres","garbagewashingmachine","scrapheap"]
#define MCC_wreck ["wreck_car","wreck_truck","wreck_offroad","wreck_van"]
#define MCC_wreckMil ["wreck_ural","wreck_uaz","wreck_hmmwv","wreck_heli","wreck_hunter","wreck_brdm","wreck_bmp","wreck_t72_hull","wreck_slammer"]
#define MCC_wreckSub ["uwreck"]
#define MCC_ammoBox ["woodenbox","luggageheap","pallet_milboxes_f"]

#define MCC_medItems [["MCC_antibiotics"],["MCC_painkillers"],["MCC_bandage"],["MCC_vitamine"]]
#define MCC_fuelItems [["MCC_fuelCan"],["MCC_fuelbot"]]
#define MCC_repairItems [["MCC_ductTape"],["MCC_butanetorch"],["MCC_oilcan"],["MCC_metalwire"],["MCC_carBat"]]
#define MCC_foodItem [["MCC_foodcontainer"],["MCC_cerealbox"],["MCC_bacon"],["MCC_rice"]]
#define MCC_money [["MCC_waterpure"]]
#define MCC_fruits ["MCC_fruit1","MCC_fruit2"]

private ["_object","_typeOfobject","_ctrl","_break","_searchTime","_animation","_phase","_doorTypes","_isHouse","_loadName","_waitTime","_array","_displayname",
         "_randomChance","_loot","_wepHolder","_class","_money","_rand","_wepArray"];
disableSerialization;
_object 	= _this select 0;

if ((player distance _object < 3) && MCC_interactionKey_holding && !(missionNameSpace getVariable [format ["MCC_isInteracted%1",getpos _object], false]) && (isNull attachedTo _object)) then
{
	missionNameSpace setVariable [format ["MCC_isInteracted%1",getpos _object], true];
	publicvariable format ["MCC_isInteracted%1",getpos _object];
	//Create progress bar
	_searchTime = 10;
	_break		= false;
	(["MCC_interactionPB"] call BIS_fnc_rscLayer) cutRsc ["MCC_interactionPB", "PLAIN"];
	_ctrl = ((uiNameSpace getVariable "MCC_interactionPB") displayCtrl 2);
	_ctrl ctrlSetText "Searching";
	_ctrl = ((uiNameSpace getVariable "MCC_interactionPB") displayCtrl 1);

	for [{_x=1},{_x<_searchTime},{_x=_x+0.1}]  do
	{

		_ctrl progressSetPosition (_x/_searchTime);
		//if ((animationState player)!="AinvPknlMstpSlayWrflDnon_medic") then {player playMoveNow "AinvPknlMstpSlayWrflDnon_medic"};
		if ((_object distance player) > 5 || !MCC_interactionKey_holding) then {_x = _searchTime; _break = true;};
		sleep 0.1;
	};
	(["MCC_interactionPB"] call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
	//player playMoveNow "AmovPknlMstpSlowWrflDnon";

	//If moved to far from the IED
	if (_break) exitwith {};

	//Weapon/ammo/med/fuel/repair/food
	if (({[_x , str _object] call BIS_fnc_inString} count MCC_barrels)>0) then {_typeOfobject = "barrel"; _randomChance =[0.025,0.05,0.05,0.1,0.1,0.1,0.2]};
	if (({[_x , str _object] call BIS_fnc_inString} count MCC_grave)>0) then {_typeOfobject = "grave"; _randomChance =[0.1,0.2,0.05,0.05,0.15,0.05,0.2]};
	if (({[_x , str _object] call BIS_fnc_inString} count MCC_containers)>0) then {_typeOfobject = "container"; _randomChance =[0.05,0.15,0.15,0.05,0.1,0.15,0.15]};
	if (({[_x , str _object] call BIS_fnc_inString} count MCC_food)>0) then {_typeOfobject = "food"; _randomChance =[0.05,0.05,0.05,0.05,0.1,0.15,0.1]};
	//if (({[_x , str _object] call BIS_fnc_inString} count MCC_water)>0) then {_typeOfobject = "water"; _randomChance =[0.05,0.1,0.1,0.2,0.2,0.4]};
	if (({[_x , str _object] call BIS_fnc_inString} count MCC_fuel)>0) then {_typeOfobject = "fuel"; _randomChance =[0.05,0.05,0.05,0.15,0.1,0.05,0.15]};
	if (({[_x , str _object] call BIS_fnc_inString} count MCC_plantsFruit)>0) then {_typeOfobject = "fruit"};
	if (({[_x , str _object] call BIS_fnc_inString} count MCC_misc)>0) then {_typeOfobject = "misc"; _randomChance =[0.05,0.1,0.05,0.05,0.15,0.1,0.15]};
	if (({[_x , str _object] call BIS_fnc_inString} count MCC_garbage)>0) then {_typeOfobject = "garbage"; _randomChance =[0.05,0.1,0.05,0.05,0.15,0.05,0.05]};
	if (({[_x , str _object] call BIS_fnc_inString} count MCC_wreck)>0) then {_typeOfobject = "wreck"; _randomChance =[0.05,0.2,0.15,0.15,0.1,0.05,0.1]};
	if (({[_x , str _object] call BIS_fnc_inString} count MCC_wreckMil)>0) then {_typeOfobject = "mwreck"; _randomChance =[0.2,0.4,0.1,0.15,0.2,0.05,0.1]};
	if (({[_x , str _object] call BIS_fnc_inString} count MCC_wreckSub)>0) then {_typeOfobject = "uwreck"; _randomChance =[0.3,0.5,0.05,0.2,0.2,0.05,0.1]};
	if (({[_x , str _object] call BIS_fnc_inString} count MCC_ammoBox)>0) then {_typeOfobject = "ammobox"; _randomChance =[0.3,0.5,0.15,0.05,0.05,0.05,0.2]};
	if (!isnil "_typeOfobject") then
	{
		//createvirtual wepholder
		_wepHolder = "GroundWeaponHolder" createVehiclelocal getpos player;
		_wepHolder setpos getpos player;
		_wepHolder hideobject true;
		player setVariable ["interactWith",_wepHolder];

		//create the random loot
		player setVariable ["MCC_readValue",nil];

		//[format ["SERVER_%1",toupper worldName], "Loot Positions", format ["Object_%1",(getpos _object)], "ARRAY",player,true,[]] call MCC_fnc_inidbGet;
		[[format ["SERVER_%1",toupper worldName], "Loot Positions", format ["Object_%1",(getpos _object)], "ARRAY",player,true,[]], "MCC_fnc_inidbGet", false, false] call BIS_fnc_MP;

		while {isnil "_loot"} do {sleep 0.1;_loot = player getVariable ["MCC_readValue",nil]};

		//If empty spawn check if it is time to respawn loot
		if (count _loot == 1) then
		{
			if ((dateToNumber date - (_loot select 0))> (0.00273973*MCC_surviveModRefresh)) then
			{
				_loot = [];
			};
		};

		if (count _loot == 0) then
		{
			//time stamp
			_loot set [0, dateToNumber date];

			//Fruit
			if (_typeOfobject == "fruit") then
			{
				if (random 1 > 0.5) then
				{
					_array = [];
					{
						_array set [count _array,_x];
					} foreach MCC_fruits;

					_loot set [count _loot, _array call BIS_fnc_selectRandom];
				};
			}
			else
			{
				{
					_array = [W_BINOS + W_ATTACHMENTS + W_LAUNCHERS +W_MG + W_PISTOLS + W_RIFLES + W_SNIPER,
					          U_MAGAZINES + U_UNDERBARREL +U_GRENADE + U_EXPLOSIVE,
					          MCC_medItems,
					          MCC_fuelItems,
					          MCC_repairItems,
					          MCC_foodItem,
					          MCC_money] select _foreachIndex;

					if (count _array > 0) then
					{
						for "_i" from 0 to (_x/0.1) do
						{
							if (random 1 < _x) then {_loot set [count _loot, (_array call BIS_fnc_selectRandom) select 0]};
						};
					};
				} forEach _randomChance;
			};
		};

		for "_i" from 1 to (count _loot -1) do
		{
			_class = _loot select _i;
			if (_class in (MCC_foodItem + MCC_money + MCC_fruits + MCC_repairItems + MCC_fuelItems + MCC_medItems) || ({_x select 0 == _class} count W_ATTACHMENTS)>0) then
			{
				_wepHolder addMagazineCargoGlobal [_class,1]
			}
			else
			{
				switch (true) do
				{
					case (isClass (configFile >> "CfgMagazines" >> _class)) : {_wepHolder addMagazineCargo [_class,1]};
					case (isClass (configFile >> "CfgWeapons" >> _class)) : {_wepHolder addWeaponCargo [_class,1]};
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
		if (typeName "_wepArray" != "ARRAY") then {_wepArray = []};
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