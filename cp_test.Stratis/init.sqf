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
//HandGuns
CP_handguns	=	[[0,"hgun_Rook40_F",["16Rnd_9x21_Mag",3]],
			    [10,"hgun_P07_F",["16Rnd_9x21_Mag",3]],
			    [20,"hgun_ACPC2_F",["9Rnd_45ACP_Mag",3]]]; 

//------------------------------------------------------------------------------Officer---------------------------------------------------------------------------
//primary
CP_officerWeaponWest =[[0,"arifle_TRG21_GL_F",["30Rnd_556x45_Stanag",10,"1Rnd_HE_Grenade_shell",6]],
					   [10,"arifle_Mk20_GL_F",["30Rnd_556x45_Stanag",10,"1Rnd_HE_Grenade_shell",6]],
					   [20,"arifle_MX_GL_F",["30Rnd_65x39_caseless_mag",10,"1Rnd_HE_Grenade_shell",6]]
					   ]; 
CP_officerWeaponEast =[[0,"arifle_Katiba_GL_F",["30Rnd_65x39_caseless_green",10,"1Rnd_HE_Grenade_shell",6]],
					   [10,"arifle_Mk20_GL_F",["30Rnd_556x45_Stanag",10,"1Rnd_HE_Grenade_shell",6]],
					   [20,"arifle_MX_GL_F",["30Rnd_65x39_caseless_mag",10,"1Rnd_HE_Grenade_shell",6]]
					   ]; 
CP_officerWeaponGuer =[[0,"arifle_Mk20_GL_F",["30Rnd_556x45_Stanag",10,"1Rnd_HE_Grenade_shell",6]],
					   [10,"arifle_Mk20_GL_F",["30Rnd_556x45_Stanag",10,"1Rnd_HE_Grenade_shell",6]],
					   [20,"arifle_MX_GL_F",["30Rnd_65x39_caseless_mag",10,"1Rnd_HE_Grenade_shell",6]]
					   ]; 
					   
//Secondery					   
CP_officerWeaponSecWest 	=[[0,"launch_NLAW_F",["NLAW_F",2]],
							  [10,"launch_B_Titan_F",["Titan_AA",2]],
							  [20,"launch_B_Titan_short_F",["Titan_AT",2]]];
CP_officerWeaponSecEast 	=[[0,"launch_RPG32_F",["RPG32_F",2]],
							  [10,"launch_B_Titan_F",["Titan_AA",2]],
							  [20,"launch_B_Titan_short_F",["Titan_AT",2]]];
CP_officerWeaponSecGuer 	=[[0,"launch_NLAW_F",["NLAW_F",2]],
							  [10,"launch_B_Titan_F",["Titan_AA",2]],
							  [20,"launch_B_Titan_short_F",["Titan_AT",2]]];
							  
//Items
CP_officerItmes1			= [[0,"Binocular", []],
							   [10,"Rangefinder", []],
							   [20,"Laserdesignator", ["Laserbatteries",2]]];


/*"1Rnd_HE_Grenade_shell",3
"1Rnd_Smoke_Grenade_shell",3
"1Rnd_SmokeRed_Grenade_shell",3
"1Rnd_SmokeGreen_Grenade_shell",3
"UGL_FlareWhite_F",3
"UGL_FlareCIR_F",3

"SmokeShell",3
"SmokeShellRed",3
SmokeShellGreen,3*/

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
CP_fnc_addWeapon		= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_addWeapon.sqf");

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