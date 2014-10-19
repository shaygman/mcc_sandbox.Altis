private ["_targets","_null","_selected","_objects","_dir","_target","_vehiclePlayer","_airports","_counter","_searchArray","_sides",
		 "_positionStart","_positionEnd","_pointIntersect","_break","_interactiveObjects","_objArray","_keyName","_key","_text"];
#define MCC_barrels ["garbagebarrel","garbagebin","toiletbox","garbagecontainer","fieldtoilet","tabledesk","cashdesk"]
#define MCC_grave ["grave_forest","grave_dirt","grave_rocks"]
#define MCC_containers ["woodenbox","barreltrash","metalbarrel_f","cratesplastic","cargo20","cargo40","crates"]
#define MCC_food ["icebox","rack","shelves","sacks_goods","basket","sack_f"]
//#define MCC_water ["water_source"]
#define MCC_fuel ["watertank","waterbarrel","barrelwater","stallwater"]
//#define MCC_plantsFruit ["neriumo","ficusc"]
#define MCC_misc ["fishinggear","crabcages","rowboat","calvary","pipes_small","woodpile","pallets_stack","wheelcart"]
#define MCC_garbage ["garbagebags","junkpile","garbagepallet","tyres","garbagewashingmachine"]
#define MCC_wreck ["wreck_car","wreck_truck","wreck_offroad","wreck_van"]
#define MCC_wreckMil ["wreck_ural","wreck_uaz","wreck_hmmwv","wreck_heli","wreck_hunter","wreck_brdm","wreck_bmp","wreck_t72_hull","wreck_slammer"]
#define MCC_wreckSub ["uwreck"]
#define MCC_ammoBox ["wpnsbox","weaponsbox","itembox","ammobox","supplydrop"]

_break = false; 

//Find out the key
_key = MCC_keyBinds select 4;
_text = "";
if (_key select 0) then {_text = "Shift + "}; 
if (_key select 1) then {_text = _text + "Ctrl + "}; 
if (_key select 2) then {_text = _text + "Alt + "}; 
_textKey = 	[(_key select 3)] call MCC_fnc_keyToName;
_keyName = format ["%1%2",_text,_textKey];

//Do not fire while inside a dialog 
if (dialog) exitWith {}; 
sleep 0.3;
MCC_interactionKey_holding =  if (MCC_interactionKey_down) then {true} else {false};
//Fails safe if ui get stuck
if (time > (player getVariable ["MCC_interactionActiveTime",time-5])+20) then {player setVariable ["MCC_interactionActive",false]};

//If we are busy quit
if ((player getVariable ["MCC_interactionActive",false]) || (time < (player getVariable ["MCC_interactionActiveTime",time-5])+2)) exitWith {};
player setVariable ["MCC_interactionActive",true];   
player setVariable ["MCC_interactionActiveTime",time];

//Outside of vehicle
if (vehicle player == player) then
{
	//Handle man
	_target = cursorTarget;
	if (_target isKindof "CAManBase" && (player distance _target < 30)) exitWith
	{
		_null= [_target, player] call MCC_fnc_interactMan;
		//_null= [_target,player] execvm "mcc\fnc\interaction\fn_interactMan.sqf";
		player setVariable ["MCC_interactionActive",false];  
		_break = true;
	};
	
	if (_break) exitWith {}; 
	
	_objects = player nearObjects [MCC_dummy,10];
	
	//Handle IED
	if (count _objects > 0) then
	{
		_selected = ([_objects,[],{player distance _x},"ASCEND"] call BIS_fnc_sortBy) select 0;
		_dir	  = [player, _selected] call BIS_fnc_relativeDirTo;
		if (_dir>340 || _dir < 20) exitWith 
		{
			//IED
			if (((_selected getVariable ["MCC_IEDtype",""]) == "ied") && !(_selected getVariable ["MCC_isInteracted",false])) then
			{
				_null= [player,_selected] call MCC_fnc_interactIED;
				//_null= [player,_selected] execvm "mcc\fnc\interaction\fn_interactIED.sqf";
				_break = true; 
			};
		};
	};
	
	if (_break) exitWith {}; 
	
	//Not MCC object
	_positionStart 	= eyePos player;
	_positionEnd 	= ATLtoASL screenToWorld [0.5,0.5];
	_pointIntersect = lineIntersectsWith [_positionStart, _positionEnd, player, objNull, true];
	if (count _pointIntersect > 0 && MCC_surviveMod && MCC_iniDBenabled) then
	{
		_selected = _pointIntersect select ((count _pointIntersect)-1);
		if (player distance _selected < 5) exitWith
		{
			_objArray = MCC_barrels + MCC_grave + MCC_containers + MCC_food + MCC_fuel + MCC_misc + MCC_garbage + MCC_wreck + MCC_wreckMil + MCC_wreckSub + MCC_ammoBox;
			if ((({[_x , str _selected] call BIS_fnc_inString} count _objArray)>0) && (count attachedObjects _selected == 0)) exitWith
			{
				missionNameSpace setVariable ["MCC_interactionObjects", [[getpos _selected, format ["Hold %1 to search",_keyName]]]];
				//_null= [_selected] execvm "mcc\fnc\interaction\fn_interactObject.sqf";
				_null= [_selected] call MCC_fnc_interactObject;
				_break = true;
			};
		};
	};
	
	if (_break) exitWith {}; 
	
	//Handle house
	if (_target isKindof "house" || _target isKindof "AllVehicles") exitWith
	{
		//[_target] execvm "mcc\fnc\interaction\fn_interactDoor.sqf";
		_null= [_target] call MCC_fnc_interactDoor
	};
	
	/*
	//Shout around if no interaction found
	if (!MCC_interactionKey_holding) then
	{
		[[[netid player,player], format ["dontmove%1",floor (random 20)]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
		sleep _waitTime; 
		player setVariable ["MCC_interactionActive",false];  
	};
	*/
}
else
{
	_vehiclePlayer = vehicle player;
	
	//Logistics
	if ((typeof _vehiclePlayer in MCC_supplyTracks) && (player == driver _vehiclePlayer) && (speed _vehiclePlayer < 10) && MCC_allowlogistics) then
	{
		_null = [player] execVm format ["%1mcc\general_scripts\logistics\load.sqf",MCC_path];
	};
	
	//MCC ILS
	if ((_vehiclePlayer isKindOf "Plane") && (player == Driver _vehiclePlayer)) then
	{
		_airports = []; 
		_counter = 0;
		_searchArray = if (MCC_isMode) then {allMissionObjects "mcc_sandbox_moduleILS"} else {allMissionObjects "logic"}; 

		{
			_sides = _x getVariable ["MCC_runwaySide",-1];
			_sides = if (_sides == -1) then {[east,west,resistance,civilian]} else {[_sides call bis_fnc_sideType]}; 
			
			if (((_x getVariable ["MCC_runwayDis",0])>0) && (playerside in _sides)) then
			{
				_airports set [_counter,[_x,(_x getVariable ["MCC_runwayName","Runway"]),(_x getVariable ["MCC_runwayDis",0]),(_x getVariable ["MCC_runwayAG",false])]]; 
				_counter = _counter +1;
			};
		} foreach _searchArray;

		if (count _airports > 0) then
		{
			[player] call MCC_fnc_ilsMain;
		};
	};

};
if !(_break) then
{
	player setVariable ["MCC_interactionActive",false]; 
};