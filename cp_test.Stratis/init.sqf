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
CP_fnc_addItem			= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_addItem.sqf");
CP_fnc_setVehicleInit	= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_setVehicleInit.sqf");

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
		waituntil {alive player}; 
		player addEventHandler ["Respawn",{player execVM CP_path + "scripts\player\player_init.sqf";}];
		[["commanderLevel",getPlayerUID player,[1,0]], "CP_fnc_getVariable", false, true] spawn BIS_fnc_MP;
		waituntil {! isnil "commanderLevel"};
		if (CP_debug) then {player sidechat format ["commanderLevel : %1",commanderLevel]};

		[["arLevel",getPlayerUID player,[1,0]], "CP_fnc_getVariable", false, true] spawn BIS_fnc_MP;
		waituntil {! isnil "arLevel"};
		if (CP_debug) then {player sidechat format ["arLevel : %1",arLevel]};

		[["riflemanLevel",getPlayerUID player,[1,0]], "CP_fnc_getVariable", false, true] spawn BIS_fnc_MP;
		waituntil {! isnil "riflemanLevel"};
		if (CP_debug) then {player sidechat format ["riflemanLevel : %1",riflemanLevel]};

		[["ATLevel",getPlayerUID player,[1,0]], "CP_fnc_getVariable", false, true] spawn BIS_fnc_MP;
		waituntil {! isnil "ATLevel"};
		if (CP_debug) then {player sidechat format ["ATLevel : %1",ATLevel]};

		[["corpsmanLevel",getPlayerUID player,[1,0]], "CP_fnc_getVariable", false, true] spawn BIS_fnc_MP;
		waituntil {! isnil "corpsmanLevel"};
		if (CP_debug) then {player sidechat format ["corpsmanLevel : %1",corpsmanLevel]};

		[["marksmanLevel",getPlayerUID player,[1,0]], "CP_fnc_getVariable", false, true] spawn BIS_fnc_MP;
		waituntil {! isnil "marksmanLevel"};
		if (CP_debug) then {player sidechat format ["marksmanLevel : %1",marksmanLevel]};

		[["specialistLevel",getPlayerUID player,[1,0]], "CP_fnc_getVariable", false, true] spawn BIS_fnc_MP;
		waituntil {! isnil "specialistLevel"};
		if (CP_debug) then {player sidechat format ["specialistLevel : %1",specialistLevel]};

		[["crewLevel",getPlayerUID player,[1,0]], "CP_fnc_getVariable", false, true] spawn BIS_fnc_MP;
		waituntil {! isnil "crewLevel"};
		if (CP_debug) then {player sidechat format ["crewLevel : %1",crewLevel]};

		[["pilotLevel",getPlayerUID player,[1,0]], "CP_fnc_getVariable", false, true] spawn BIS_fnc_MP;
		waituntil {! isnil "pilotLevel"};
		if (CP_debug) then {player sidechat format ["pilotLevel : %1",pilotLevel]};
		
		_null=[] execVM CP_path + "scripts\player\player_init.sqf";
	};

//---------------------------------------------
//		Global CP Defines
//---------------------------------------------
CP_respawnPointsIndex 	= 0;
CP_squadListIndex		= 0;
CP_classes = ["Officer","AR","Rifleman","AT","Corpsman","Marksman","Specialist","Crew","Pilot"];
CP_classesPic = [	CP_path +"configs\data\Officer.paa",
					CP_path +"configs\data\AR.paa",
					CP_path +"configs\data\Rifleman.paa",
					CP_path +"configs\data\AT.paa",
					CP_path +"configs\data\Corpsman.paa",
					CP_path +"configs\data\Marksman.paa",
					CP_path +"configs\data\Specialist.paa",
					CP_path +"configs\data\Crew.paa",
					CP_path +"configs\data\Pilot.paa"
				];
CP_classesIndex = 0; 

CP_NVIndex 			= 0;
CP_headgearIndex 	= 0;
CP_gogglesIndex 	= 0;
CP_vestIndex 		= 0;
CP_backpackIndex 	= 0;
CP_uniformsIndex 	= 0;

CP_weaponAttachments 	= []; 
CP_currentItems1Index = 0;
CP_currentItems2Index = 0;
CP_currentItems3Index = 0;