//==============================================================================XEH================================================================================================
MCC_3D_PLACER = compile preProcessFileLineNumbers format["%1mcc\pop_menu\3rd_placer.sqf",MCC_path];

MCC_fnc_makeMarker = {[(_this select 0), (_this select 1), (_this select 2), (_this select 3), (_this select 4), (_this select 5), (_this select 6), (_this select 7), (_this select 8)] execVM MCC_path + "mcc\pop_menu\markers_add.sqf"};
MCC_fnc_makeBriefing = {[(_this select 0), (_this select 1)] execVM MCC_path + "mcc\pop_menu\briefing_add.sqf"};
MCC_fnc_makeTaks = {[(_this select 0), (_this select 1), (_this select 2), (_this select 3), (_this select 4)] execVM MCC_path + "mcc\pop_menu\tasks_add.sqf"};
MCC_fnc_MusicTrigger = {[(_this select 0), (_this select 1), (_this select 2), (_this select 3), (_this select 4), (_this select 5), (_this select 6), (_this select 7)] execVM MCC_path + "mcc\general_scripts\jukebox\jukebox_execute.sqf"};
/*
sf_para = compile preProcessFileLineNumbers format["%1mcc\general_scripts\paradrop\parastart.sqf",MCC_path];
uav = compile preProcessFileLineNumbers format["%1mcc\general_scripts\uav\create_uav_site.sqf",MCC_path];
["sf_para", {[(_this select 0)] spawn sf_para}] call CBA_fnc_addEventHandler; 
["LHD_spawn", {[(_this select 0)] execVM MCC_path + "mcc\general_scripts\LHD\CreateLHD.sqf";}] call CBA_fnc_addEventHandler;
*/

//------------------------------- SERVER FUNCTIONS------------------------------------------
if ( (isServer) || (MCC_isLocalHC) ) then 
{
	//mcc_patrol_switch = compile preProcessFileLineNumbers format["%1mcc\pop_menu\patrol_switch.sqf",MCC_path];
	mcc_fps_running = false;
	MCC_fnc_simpleSpawn = {[(_this select 0), (_this select 1), (_this select 2), (_this select 3), (_this select 4), (_this select 5), (_this select 6), (_this select 7), (_this select 8)] execVM MCC_path + "mcc\pop_menu\simple_spawn.sqf"};
	MCC_fnc_FPS = {[(_this select 0)] execVM MCC_path + "mcc\pop_menu\fps_benchmark.sqf";};
	MCC_fnc_airDrop = {[(_this select 0), (_this select 1), (_this select 2), (_this select 3), (_this select 4), (_this select 5)] execVM MCC_path + "mcc\general_scripts\cas\cas_execute.sqf"};
	MCC_fnc_deleteBrush = {[(_this select 0), (_this select 1), (_this select 2)] execVM MCC_path + "mcc\general_scripts\delete\delete_exec.sqf"};
};


if (isServer) then
{	
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
	
//===================================================================MCC_fnc_artillery======================================================================================
// Create an artillery shell above the location
// Example:[[_pos, shelltype, shellspread, nshell,simulate],"MCC_fnc_artillery",true,false] spawn BIS_fnc_MP;
// Params: 
// 	_pos: array, position
// 	shelltype: string, vehicleClass ["GrenadeHand","Sh_120_HE","Cluster_120mm_AMOS","Mo_cluster_AP","Mine_120mm_AMOS_range","Sh_120mm_AMOS_LG","Sh_82mm_AMOS","Fire_82mm_AMOS","Smoke_120mm_AMOS_White","Smoke_82mm_AMOS_White","G_40mm_SmokeGreen","G_40mm_SmokeRed","F_40mm_White""F_40mm_Green","F_40mm_Red"];
//	shellspread: number, 1st: weapon class 2nd: ammount [["weaponClass1","weaponClass2"],[1,5]]
//	nshell: number, ammount of artillery per salvo
//	simulate: number, shell simulation 0-DPICM, 1- bomb, 2 - flare, 3 - laser guided
//==============================================================================================================================================================================
	MCC_fnc_artillery = {[(_this select 0), (_this select 1), (_this select 2), (_this select 3), (_this select 4), (_this select 5)] execVM MCC_path + "mcc\general_scripts\artillery\artillery_fire.sqf";};

//===================================================================MCC_fnc_evacMove======================================================================================
// Move a vehicle across selected WP
// Example:[[[wp1,wp2,wp3], flyInHight, insertion, [netid vehicle,vehicle],assignedCargo  _evac],"MCC_fnc_evacMove",true,false] spawn BIS_fnc_MP;
// Params: 
// 	[wp1,wp2,wp3]: array, waypoint positions
// 	flyInHight: number, if evac is a chopper flight hight, set to 5000 for land or sea vehicle
//	insertion: number, for vehicles: 0 - engine on, 1 - engine off. For helicopters: 0 - engine on, 1 - engine off, 2 - hover, 3 - Helocasting, 4 - Smoke, 5 - Fast Rope
//	vehicle: object, the evac vehicle
//==============================================================================================================================================================================
	MCC_fnc_evacMove = 
	{
		private "_dummy";
		_dummy = if (((_this select 3) select 0)=="") then {(_this select 3) select 1} else {objectFromNetId ((_this select 3) select 0)};
		[(_this select 0), (_this select 1),(_this select 2),_dummy,(_this select 4)] execVM MCC_path + "mcc\general_scripts\evac\evac_move.sqf";
	};
	
//===================================================================MCC_fnc_evacDelete======================================================================================
// Delete the given vehicle or it's driver
// Example:[[option, evac],"MCC_fnc_evacDelete",true,false] spawn BIS_fnc_MP;
// Params: 
// 	option number, 0- delete driver, 1 - spawn driver, 2- delete vehicle, driver and gunners. 
// 	evac: object, the evac vehicle
//==============================================================================================================================================================================
	MCC_fnc_evacDelete = {
		private "_dummy";
		_dummy = if (((_this select 1) select 0)=="") then {(_this select 1) select 1} else {objectFromNetId ((_this select 1) select 0)};
		[(_this select 0),_dummy] execVM MCC_path + "mcc\general_scripts\evac\delete_heli_server.sqf"
		};
	
//===================================================================MCC_fnc_evacSpawn======================================================================================
// Spawn a vehicle with crew and gunners, mark it as an evac vehicle
// Example:[[vehicleClass, position],"MCC_fnc_evacSpawn",true,false] spawn BIS_fnc_MP;
// Params: 
// 	vehicleClass: string, vehicleClass to spawn
// 	position: array, spawn position
//==============================================================================================================================================================================
	MCC_fnc_evacSpawn = {[(_this select 0),(_this select 1)] execVM MCC_path + "mcc\general_scripts\evac\spawn_heli.sqf"};
	
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
	
//===================================================================MCC_fnc_mineSingle======================================================================================
// Create a mine field
//Example:[[IEDkind,IEDMarkerName,centerPos,minefieldSize],"MCC_fnc_mineSingle",true,false] call BIS_fnc_MP;
// Params: 
// 	IEDkind: string, minefield type: "apv" - AP minefield with warining signs, "ap" - AP minefield without warining signs. "apbv" -  AP bouncing minefield with warining signs, "apb"-  AP bouncing minefield without warining signs, "atv" - AT minefield with warining signs, "at"-  AT minefield without warining signs
//	IEDMarkerName: string, custom marker name for the minefield
// 	centerPos: array, position center of the minefield
//	minefieldSize: array, [x,y] size of the minefield in meters
//==============================================================================================================================================================================
	MCC_fnc_mineSingle = {[(_this select 0), (_this select 1), (_this select 2), (_this select 3)] execVM MCC_path + "mcc\general_scripts\traps\put_mine.sqf"};

//===================================================================MCC_fnc_SBSingle======================================================================================
// Create a suiside bombers  that will randomly run ove and explode himself on target faction's units
//Example:[[pos,vehicleClass,explosionSize,explosionType,side,markerName],"MCC_fnc_SBSingle",true,false] call BIS_fnc_MP;
// Params: 
// 	pos: array, armerd civilian position.
//	vehicleClass: string, unit vehicle class
//	explodionSize:  stirng, explosion radius - "small","medium","large"
//	explosionType:  number, explosion type: 0-deadly, 1 - disabling (will cripple vehicles and soldiers but will not kill) 2 - Fake, will not or lightly wound soldiers.  
//	side: side, [west, east, resistance, civilian]
//	markerName: string, the name of the marker that will be deleted once the unit will die
//==============================================================================================================================================================================	
	MCC_fnc_SBSingle = {[(_this select 0), (_this select 1), (_this select 2), (_this select 3), (_this select 4), (_this select 5)] execVM MCC_path + "mcc\general_scripts\traps\put_sb.sqf"};

//===================================================================MCC_fnc_iedSync======================================================================================
//Note to be used outside MCC
//==============================================================================================================================================================================
	MCC_fnc_iedSync = {[(_this select 0), (_this select 1), (_this select 2)] execVM MCC_path + "mcc\general_scripts\traps\ied_sync.sqf"};
	
	/*	
	["uav", {[(_this select 0), (_this select 1), (_this select 2)] spawn uav}] call CBA_fnc_addEventHandler;
	["gita", {[(_this select 0), (_this select 1), (_this select 2), (_this select 3), (_this select 4)] execVM MCC_path + "mcc\general_scripts\gita\gita_server.sqf";}] call CBA_fnc_addEventHandler;
	["modules", {[(_this select 0), (_this select 1)] execVM MCC_path + "mcc\general_scripts\gita\modules_server.sqf";}] call CBA_fnc_addEventHandler;
	["battlefield", {[(_this select 0), (_this select 1)] execVM MCC_path + "mcc\general_scripts\gita\battlefield_server.sqf";}] call CBA_fnc_addEventHandler;
	["delete", {[(_this select 0), (_this select 1), (_this select 2)] execVM MCC_path + "mcc\general_scripts\delete\delete_exec.sqf";}] call CBA_fnc_addEventHandler;
	["coin", {[(_this select 0), (_this select 1), (_this select 2)] execVM MCC_path + "mcc\general_scripts\coin\coin_spawn.sqf";}] call CBA_fnc_addEventHandler;
	["boxGenerator", {[(_this select 0), (_this select 1), (_this select 2), (_this select 3)] execVM MCC_path + "mcc\general_scripts\boxGen\box_spawn.sqf";}] call CBA_fnc_addEventHandler;
	["mobileSpawn", {[(_this select 0), (_this select 1), (_this select 2)] execVM MCC_path + "mcc\general_scripts\mobileSpawn\mobileSpawn_execute.sqf";}] call CBA_fnc_addEventHandler;
	["paradrop", {[(_this select 0), (_this select 1), (_this select 2), (_this select 3), (_this select 4), (_this select 5)] execVM MCC_path + "mcc\general_scripts\unitManage\paradrop.sqf";}] call CBA_fnc_addEventHandler;
	*/
};