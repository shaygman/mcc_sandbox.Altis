//==============================================================================XEH================================================================================================
MCC_3D_PLACER = compile preProcessFileLineNumbers format["%1mcc\pop_menu\3rd_placer.sqf",MCC_path];

MCC_fnc_makeTaks = {[(_this select 0), (_this select 1), (_this select 2), (_this select 3), (_this select 4)] execVM MCC_path + "mcc\pop_menu\tasks_add.sqf"};
/*
sf_para = compile preProcessFileLineNumbers format["%1mcc\general_scripts\paradrop\parastart.sqf",MCC_path];
uav = compile preProcessFileLineNumbers format["%1mcc\general_scripts\uav\create_uav_site.sqf",MCC_path];
["sf_para", {[(_this select 0)] spawn sf_para}] call CBA_fnc_addEventHandler;
["LHD_spawn", {[(_this select 0)] execVM MCC_path + "mcc\general_scripts\LHD\CreateLHD.sqf";}] call CBA_fnc_addEventHandler;
*/

//------------------------------- SERVER FUNCTIONS------------------------------------------
if ( (isServer) || (MCC_isLocalHC) ) then {
	//mcc_patrol_switch = compile preProcessFileLineNumbers format["%1mcc\pop_menu\patrol_switch.sqf",MCC_path];
	mcc_fps_running = false;
	MCC_fnc_simpleSpawn = {[(_this select 0), (_this select 1), (_this select 2), (_this select 3), (_this select 4), (_this select 5), (_this select 6), (_this select 7), (_this select 8)] execVM MCC_path + "mcc\pop_menu\simple_spawn.sqf"};
	MCC_fnc_FPS = {[(_this select 0)] execVM MCC_path + "mcc\pop_menu\fps_benchmark.sqf";};
};


if (isServer) then {
//===================================================================MCC_fnc_highCommand======================================================================================
// Create a suiside bombers  that will randomly run ove and explode himself on target faction's units
//Example:[[netID _commander,_commander],_action],"MCC_fnc_highCommand",true,false] call BIS_fnc_MP;
// Params:
// 	_commander: object, unit that is the commander
// 	_action: integer, 0 - make new commander, 1 - remove all groups from the commander, 2 - add group to the commander
//==============================================================================================================================================================================
	MCC_fnc_highCommand = {[(_this select 0), (_this select 1)] execVM MCC_path + "mcc\general_scripts\unitManage\hc_server.sqf"};

//===================================================================MCC_fnc_boxGenerator======================================================================================
// Create an empty box with the given weapons and items
// Example: [[_pos, _dir, _weapons, _magazines,_items,_rucks],"MCC_fnc_boxGenerator",true,false] spawn BIS_fnc_MP;
// Params:
// 	_pos: array position
// 	_dir: number - direction
//	_weapons: array 1st: weapon class 2nd: ammount [["weaponClass1","weaponClass2"],[1,5]]
//	_magazines: array 1st: magazine class 2nd: ammount [["magazineClass1","magazineClass2"],[5,5]]
// 	_items:  array 1st: item class 2nd: ammount [["itemClass1","itemClass2"],[5,5]]
// 	_rucks: array 1st: ruck class 2nd: ammount [["ruckClass1","ruckClass2"],[5,5]]
//==============================================================================================================================================================================
	MCC_fnc_boxGenerator = {[(_this select 0), (_this select 1), (_this select 2), (_this select 3), (_this select 4)] execVM MCC_path + "mcc\general_scripts\boxGen\box_spawn.sqf";};

//===================================================================MCC_fnc_placeConvoy======================================================================================
// Place a convoy up to 5 cars facing the direction stated with ot without an HVT
// Example:[[vehicle1, vehicle2, vehicle3, vehicle4, vehicle5,start, heading, side,VIPcalss,VIPcar],'MCC_fnc_placeConvoy',true,false] spawn BIS_fnc_MP;
// Params:
// 	vehicle1, vehicle2, vehicle3, vehicle4, vehicle5: string, vehicle class leave "" to not spawn a vehicle
// 	start: array, position, start location
//	heading: array, position, where the convoy is heading
//	side: string, convoy side "west", "east", "guar", "civ"
// 	VIPcalss: string, vip class if none "0"
//	VIPcar: string, vehicle class if VIPclass = "0" will be ignored
//==============================================================================================================================================================================
	MCC_fnc_placeConvoy = {[(_this select 0), (_this select 1), (_this select 2), (_this select 3) , (_this select 4), (_this select 5), (_this select 6), (_this select 7), (_this select 8), (_this select 9)] execVM MCC_path + "mcc\general_scripts\convoy\place_convoy.sqf"};

//===================================================================MCC_fnc_startConvoy======================================================================================
// Make the convoy drive through the specific waypoints
// Example:[[[wp1, wp2, wp3], isVIP],'MCC_fnc_startConvoy',true,false] call BIS_fnc_MP;
// Params:
// 	[wp1, wp2, wp3]: array, waypoints positions
// 	isVIP: string, if = "0" no vip else there is a vip
//==============================================================================================================================================================================
	MCC_fnc_startConvoy = {[(_this select 0), (_this select 1)] execVM MCC_path + "mcc\general_scripts\convoy\start_convoy_execute.sqf"};
};