private ["_null"];
//init started
CP_initDone = false; 

//Debug
CP_debug = true; 

//Check for mode and define path
CP_isMode = isClass (configFile >> "CfgPatches" >> "chock_point");	//check if MCC is mod version

if (CP_isMode) then {
	CP_path = "\chock_point\";
	[] execVM CP_path +"init_mod.sqf";
		} else {
			CP_path = ""; 
			enableSaving [false, false];
			};
			
//- TODO introduction dialog
//******************************************************************************************************************************
//											You can edit between this line and the next
//******************************************************************************************************************************
//---------------------------------------------
//		numbers of roles
//---------------------------------------------
CP_availablePilots 	= 1;
CP_availableCrew 	= 3; 

//---------------------------------------------
//		gears array
//---------------------------------------------
//Officer
CP_officerWeaponWest =[[10,"arifle_TRG21_GL_F",["30Rnd_556x45_Stanag",10,"1Rnd_HE_Grenade_shell",6]],
					   [20,"arifle_Mk20_GL_F",["30Rnd_65x39_caseless_green",10,"3Rnd_HE_Grenade_shell",6]]]; 
CP_officerWeaponEast =[[10,"arifle_Katiba_GL_F",["30Rnd_556x45_Stanag",10,"3Rnd_HE_Grenade_shell",6],
					   [20,"arifle_Mk20_GL_F",["30Rnd_65x39_caseless_green",10,"3Rnd_HE_Grenade_shell",6]]]]; 
CP_officerWeaponGuer =[[10,"arifle_TRG21_GL_F",["30Rnd_556x45_Stanag",10,"1Rnd_HE_Grenade_shell",6]],
					   [20,"arifle_Mk20_GL_F",["30Rnd_65x39_caseless_green",10,"3Rnd_HE_Grenade_shell",6]]]; 




//******************************************************************************************************************************
//											Stop Editing here
//******************************************************************************************************************************			
//---------------------------------------------
//		Handle functions
//---------------------------------------------
CP_fnc_globalExecute 	= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_globalExecute.sqf");
CP_fnc_setValue 		= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_setValue.sqf");
CP_fnc_getVariable 		= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_getVariable.sqf");
CP_fnc_buildSpawnPoint 	= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_buildSpawnPoint.sqf");
CP_fnc_setGroupID 		= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_setGroupID.sqf");
CP_fnc_getGroupID 		= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_getGroupID.sqf");
CP_fnc_setGear			= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_setGear.sqf");
CP_fnc_assignGear		= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_assignGear.sqf");

//---------------------------------------------
//		Server Init
//---------------------------------------------
if (isServer) then {
		_null=[] execVM CP_path + "scripts\server\server_init.sqf";
	};
	
CP_gotValueFromServer =false;

//---------------------------------------------
//		Player Init
//---------------------------------------------
if (!isDedicated) then {
		if(local player) then {player addEventHandler ["killed",{player execVM CP_path + "scripts\player\player_init.sqf";}];};
		_null=[] execVM CP_path + "scripts\player\player_init.sqf";
	};

//---------------------------------------------
//		Global CP Defines
//---------------------------------------------
CP_respawnPointsIndex 	= 0;
CP_squadListIndex		= 0;
CP_classes = ["Officer","Automatic-Rifleman","Rifleman","Anti-tank","Corpsman","Marksman","Specialist","Crew","Pilot"];
CP_classesIndex = 0; 