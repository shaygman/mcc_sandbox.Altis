//==================================================================MCC_fnc_handleAddaction===============================================================================================
// handle add action 
// Examp: [] call MCC_fnc_handleAddaction; 
// <in> Nothing
//<out> Nothing
//==============================================================================================================================================================================	
private ["_string","_respawnItems","_airports","_counter","_searchArray"];

//IED
_string = format ["(({_dir= [_this, _x] call BIS_fnc_relativeDirTo; if (_dir>320 || _dir < 40) then {true} else {false}} count (_this nearObjects ['%1',5]))>0) && !(uiNameSpace getVariable ['MCC_isIEDDisarming',false]); ",MCC_dummy]; 
_null = player addaction ["<t color=""#FFCC00"">- Disarm IED -</t>", MCC_path + "mcc\general_scripts\traps\ied_disarm.sqf",[],-1,true,true,"teamSwitch",_string];
	
//Add MCC respawn tent string
if (MCC_isMode) then
{
	_respawnItems = ["MCC_TentDome","MCC_TentA"];	//respawn items
	_string = format ["secondaryWeapon _target in %1 && (vehicle _target == vehicle _this) && (leader _this == _this)",_respawnItems]; 
	_null = player addaction ["<t color=""#FFCC00"">Assemble respawn tent</t>", MCC_path + "mcc\general_scripts\respawnTents\DeployRespawnTents.sqf",[],-1,false,true,"teamSwitch",_string];
};

//Add MCC Comander
_string = format ["((MCC_server getVariable ['CP_commander%1','']) == getPlayerUID _this )&& (vehicle _target == vehicle _this) && MCC_allowConsole",side player]; 
_null = player addaction ["<t color=""#FFCC01"">Commander - Console</t>", MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf",[nil,nil,nil,nil,1],-1,false,true,"teamSwitch",_string];

//Add MCC Squad leader PDA
_string = format ["(count units _this > 1) && (leader _this == _this) && ('ItemGPS' in (assignedItems _this)) && (vehicle _target == vehicle _this) && MCC_allowsqlPDA",side player]; 
_null = player addaction ["<t color=""#FFCC01"">Squad Leader - PDA</t>", MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf",[nil,nil,nil,nil,3],-1,false,true,"teamSwitch",_string];

//Add MCC supply truck
_string = format ["(_this == driver vehicle _this) && (typeof vehicle _this in %1) && speed vehicle _this ==0 && MCC_allowlogistics",MCC_supplyTracks]; 
_null = player addaction ["<t color=""#0134ff"">Load Truck</t>", MCC_path + "mcc\general_scripts\logistics\load.sqf",[nil,nil,nil,nil,3],-1,false,true,"teamSwitch",_string];

//Add MCC ILS
_airports = []; 
_counter = 0;
_searchArray = if (MCC_isMode) then {allMissionObjects "mcc_sandbox_moduleILS"} else {allMissionObjects "logic"}; 

{
	_sides = _x getVariable ["MCC_runwaySide",-1];
	_sides = if (_sides == -1) then {[east,west,resistance,civilian]} else {[_sides call bis_fnc_sideType]}; 
	if (((_x getVariable ["MCC_runwayDis",0])>0) && (playerside in _sides))then
	{
		_airports set [_counter,[_x,(_x getVariable ["MCC_runwayName","Runway"]),(_x getVariable ["MCC_runwayDis",0]),(_x getVariable ["MCC_runwayAG",false])]]; 
		_counter = _counter +1;
	};
} foreach _searchArray;

if (count _airports > 0) then
{
	_string = "(vehicle _this isKindOf 'Plane') && (_this == Driver vehicle _this)";
	_null = player addaction ["<t color=""#01ffcc"">ILS</t>", {_this call MCC_fnc_ilsMain},[],-1,false,true,"teamSwitch",_string];
};

// Add MCC to the action menu
if (getplayerUID player in MCC_allowedPlayers || "all" in MCC_allowedPlayers || serverCommandAvailable "#logout" || isServer || (player getvariable ["MCC_allowed",false])) then 
{
	mcc_actionInedx = player addaction ["<t color=""#99FF00"">--= MCC =--</t>", MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf",[nil,nil,nil,nil,0], 0,false, false, "teamSwitch","vehicle _target == vehicle _this"];
	player setvariable ["MCC_allowed",true,true];
};