private ["_targets","_null","_selected","_waitTime","_objects","_dir","_target","_vehiclePlayer","_airports","_counter","_searchArray","_sides"];
_waitTime = 1;

//Do not fire while inside a dialog 
if (dialog) exitWith {}; 

//If we are busy quit
if (uiNameSpace getVariable ["MCC_interactionActive",false]) exitWith {};
uiNameSpace setVariable ["MCC_interactionActive",true];   

//Outside of vehicle
if (vehicle player == player) then
{
	_objects = player nearObjects [MCC_dummy,10];
	_targets = player nearEntities ["CAManBase", 20];
	
	//Handle Objects
	if (count _objects > 0) exitWith
	{
		_selected = _objects select 0;
		
		//IED
		if (((_selected getVariable ["MCC_IEDtype",""]) == "ied") && !(_selected getVariable ["MCC_isInteracted",false])) then
		{
			_null= [player,_selected] execVM format ["%1mcc\general_scripts\traps\ied_disarm.sqf",MCC_path];
		};
		
		sleep _waitTime; 
		uiNameSpace setVariable ["MCC_interactionActive",false];  
	};

	//Handle civilians/enemies
	for "_i" from 0 to ((count _targets)-1) do 
	{
		_target = _targets select _i;
		_dir	= [player, _target] call BIS_fnc_relativeDirTo;
		if (isplayer _target) then {_targets set [_i,-1]}; 
		if (_dir<340 && _dir > 20) then {_targets set [_i,-1]}
	};
	_targets = _targets - [-1];

	if (count _targets > 0) exitWith
	{
		_selected = ([_targets,[],{player distance _x},"ASCEND"] call BIS_fnc_sortBy) select 0;
		_null= [_selected, player] execVM format ["%1mcc\general_scripts\traps\neutralize.sqf",MCC_path];
		sleep _waitTime; 
		uiNameSpace setVariable ["MCC_interactionActive",false];  
	};

	//Shout around if no interaction found
	[[[netid player,player], format ["dontmove%1",floor (random 20)]], "MCC_fnc_globalSay3D", true, false] spawn BIS_fnc_MP;
	sleep _waitTime; 
	uiNameSpace setVariable ["MCC_interactionActive",false];  
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

uiNameSpace setVariable ["MCC_interactionActive",false]; 