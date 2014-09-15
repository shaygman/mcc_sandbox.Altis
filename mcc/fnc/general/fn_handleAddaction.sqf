//==================================================================MCC_fnc_handleAddaction===============================================================================================
// handle add action 
// Examp: [] call MCC_fnc_handleAddaction; 
// <in> Nothing
//<out> Nothing
//==============================================================================================================================================================================	
private ["_string","_respawnItems"];

//Add MCC respawn tent string
_respawnItems = ["MCC_TentDome","MCC_TentA"];	//respawn items
_string = format ["secondaryWeapon _target in %1 && (vehicle _target == vehicle _this)",_respawnItems]; 
_null = player addaction ["<t color=""#FFCC00"">Assemble respawn tent</t>", MCC_path + "mcc\general_scripts\respawnTents\DeployRespawnTents.sqf",[],-1,false,true,"teamSwitch",_string];

//Add MCC Comander
_string = format ["((MCC_server getVariable ['CP_commander%1','']) == getPlayerUID _this )&& (vehicle _target == vehicle _this)",side player]; 
_null = player addaction ["<t color=""#FFCC01"">Commander - Console</t>", MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf",[nil,nil,nil,nil,1],-1,false,true,"teamSwitch",_string];

//Add MCC Squad leader PDA  (count units _this > 1) &&
_string = format ["(leader _this == _this) && ('ItemGPS' in (assignedItems _this)) && (vehicle _target == vehicle _this)",side player]; 
_null = player addaction ["<t color=""#FFCC01"">Squad Leader - PDA</t>", MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf",[nil,nil,nil,nil,3],-1,false,true,"teamSwitch",_string];

//Add MCC supply truck
_string = format ["(_this == driver vehicle _this) && (typeof vehicle _this in %2) && ((vehicle _this distance MCC_START_%1) < 50) && speed vehicle _this ==0",side player,MCC_supplyTracks]; 
_null = player addaction ["<t color=""#0134ff"">Load Truck</t>", MCC_path + "mcc\general_scripts\logistics\load.sqf",[nil,nil,nil,nil,3],-1,false,true,"teamSwitch",_string];

// Add MCC to the action menu
if (getplayerUID player in MCC_allowedPlayers || "all" in MCC_allowedPlayers || serverCommandAvailable "#logout" || isServer || (player getvariable ["MCC_allowed",false])) then 
{
	mcc_actionInedx = player addaction ["<t color=""#99FF00"">--= MCC =--</t>", MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf",[nil,nil,nil,nil,0], 0,false, false, "teamSwitch","vehicle _target == vehicle _this"];
	player setvariable ["MCC_allowed",true,true];
};