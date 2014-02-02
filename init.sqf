private ["_string","_null","_nul","_dummyGroup","_dummy","_name","_keyDown","_savesArray"];

MCC_isMode = isClass (configFile >> "CfgPatches" >> "mcc_sandbox");	//check if MCC is mod version
MCC_initDone = false;
MCC_GUI1initDone = false;  

//Debug
CP_debug = false; 
MW_debug = true; 

if (MCC_isMode) then {
	MCC_path = "\mcc_sandbox_mod\";
	CP_path	 = "\mcc_sandbox_mod\";
		} else {
			MCC_path = "";
			CP_path	 = "";
			[] execVM MCC_path +"init_mission.sqf";
			enableSaving [false, false];
			};

waituntil {!isnil "MCC_path"};

//Delete all units on SP mission
if (!isMultiplayer && !MCC_isMode) then 	
{					
	{
		if ((! isplayer _x) && !(_x in (units group player))) then {deletevehicle _x}
	} foreach allunits;  
}; 
	
//******************************************************************************************
//==========================================================================================
//=		 					Edit variables as you see fit. 
//=		 
//=							                Shay-Gman  (C)
//==========================================================================================
//******************************************************************************************

//--------------------- Who can access MCC leave "all" for everbody --------------------------------
//Should be MCC_allowedPlayers = ["12321","1321123"]; 
//Host or server admin will always have access
if (isnil "MCC_allowedPlayers") then {MCC_allowedPlayers = ["all"]};

//----------------------General settings---------------------------------------
//Default AI skill
if (isnil "MCC_AI_Skill") then {MCC_AI_Skill = 0.5}; 
if (isnil "MCC_AI_Aim") then {MCC_AI_Aim = 0.1}; 
if (isnil "MCC_AI_Spot") then {MCC_AI_Spot	= 0.3}; 
if (isnil "MCC_AI_Command") then {MCC_AI_Command = 0.5}; 

//---------------------Name Tags---------------------------------------------------
// Show friendly name tags and vhicles' crew info - default - off
if (isnil "MCC_nameTags") then {MCC_nameTags = false}; 

//-----------------------BTC Revive - --------------------------------------------
//disable this line if you don't want it in the mission version - will not work on the mod version by default
if (!MCC_isMode) then
	{
		waituntil {!isnil "f_var_BTCRevive"};
		if ((f_var_BTCRevive == 1)) then {call compile preprocessFile "=BTC=_revive\=BTC=_revive_init.sqf"};
	};

//----------------------IED settings---------------------------------------------
// IED types the first one is display name the second is the classname [displayName, ClassName]
MCC_ied_small = [["Plastic Crates","Land_CratesPlastic_F"],["Plastic Canister","Land_CanisterPlastic_F"],["Sack","Land_Sack_F"],["Road Cone","RoadCone"],["Tyre","Land_Tyre_F"],["Radio","Land_SurvivalRadio_F"],["Suitcase","Land_Suitcase_F"],["Grinder","Land_Grinder_F"],
				 ["MultiMeter","Land_MultiMeter_F"],["Plastic Bottle","Land_BottlePlastic_V1_F"],["Fuel Canister","Land_CanisterFuel_F"],["FM Radio","Land_FMradio_F"],["Camera","Land_HandyCam_F"],["Laptop","Land_Laptop_F"],["Mobile Phone","Land_MobilePhone_old_F"]
				 ,["Smart Phone","Land_MobilePhone_smart_F"],["Longrange Radio","Land_PortableLongRangeRadio_F"],["Satellite Phone","Land_SatellitePhone_F"],["Money","Land_Money_F"]];
MCC_ied_medium = [["Wheel Cart","Land_WheelCart_F"],["Metal Barrel","Land_MetalBarrel_F"],["Plastic Barrel","Land_BarrelSand_F"],["Pipes","Land_Pipes_small_F"],["Wooden Crates","Land_CratesShabby_F"],["Wooden Box","Land_WoodenBox_F"],["Cinder Blocks","Land_Ytong_F"],
				  ["Sacks Heap","Land_Sacks_heap_F"], ["Water Barrel","Land_WaterBarrel_F"],["Water Tank","Land_WaterTank_F"]];
MCC_ied_wrecks = [["Car Wreck","Land_Wreck_Car3_F"],["BRDM Wreck","Land_Wreck_BRDM2_F"],["Offroad Wreck","Land_Wreck_Offroad_F"],["Truck Wreck","Land_Wreck_Truck_FWreck"]];
MCC_ied_mine = [["Mine Field AP - Visable","apv"], ["Mine Field AP - Hidden","ap"],["Mine Field AP Bounding - Visable","apbv"],["Mine Field AP Bounding- Hidden","apb"], ["Mine Field AT - Visable","atv"], ["Mine Field AT - Hidden","at"]];
MCC_ied_hidden = [["Dirt Small","IEDLandSmall_Remote_Ammo"],["Dirt Big","IEDLandBig_Remote_Ammo"],["Urban Small","IEDUrbanSmall_Remote_Ammo"],["Urban Big","IEDUrbanBig_Remote_Ammo"]];

//------------------------Convoy settings----------------------------------------
MCC_convoyHVT = [["None","0"],["B.Officer","B_officer_F"],["B. Pilot","B_Helipilot_F"],["O. Officer","O_officer_F"],["O. Pilot","O_helipilot_F"],["I.Commander","I_officer_F"],["Citizen","C_man_polo_1_F"],
				 ["C.Pilot","C_man_pilot_F"],["Orestes","C_Orestes"],["Nikos","C_Nikos"],["Hunter","C_man_hunter_1_F"],["Kerry","I_G_Story_Protagonist_F"]];
MCC_convoyHVTcar = [["Hunter","B_Hunter_F"],["MRAP","I_MRAP_03_F"],["Quadbike","B_Quadbike_F"],["Ifrit","O_Ifrit_F"],["Offroad","C_Offroad_01_F"],["SUV","C_SUV_01_F"],["Hatchback","C_Hatchback_01_F"]];

//------------------------MCC Console--------------------------------------------
//AC-130 amo count by array [20mm,40mm,105mm]
if (isnil "MCC_ConsoleOnlyShowUnitsWithGPS") then {MCC_ConsoleACAmmo = [500,80,20]}; 

//Group markers 
if (isnil "MCC_ConsoleOnlyShowUnitsWithGPS") then {MCC_ConsoleOnlyShowUnitsWithGPS = true}; 				//Show only units were the group leader have a GPS  or inside vehicle
if (isnil "MCC_ConsoleDrawWP") then {MCC_ConsoleDrawWP = true}; 											//Draw group's WP on the console	
if (isnil "MCC_ConsoleLiveFeedHelmetsOnly") then {MCC_ConsoleLiveFeedHelmetsOnly = false};					//Allow live feed to vehicles only and units wearing one of the specific helmets types defined in MCC_ConsoleLiveFeedHelmets 
if (isnil "MCC_ConsoleLiveFeedHelmets") then {MCC_ConsoleLiveFeedHelmets = ["H_HelmetB","H_HelmetB_paint","H_HelmetB_light","H_HelmetO_ocamo","H_HelmetLeaderO_ocamo","H_HelmetSpecO_ocamo","H_HelmetSpecO_blk"]};
if (isnil "MCC_ConsoleCanCommandAI") then {MCC_ConsoleCanCommandAI = true}; 								//If set to false the console can only command non-AI groups
if (isnil "MCC_ConsolePlayersCanSeeWPonMap") then {MCC_ConsolePlayersCanSeeWPonMap = false};					//If set to true players with GPS or UAVTerminal or MCC conosle can see WP assigned to them on the map

//string that must return true inorder to open the MCC Console - str "MCC_Console" + "in (assignedItems player)"; 
if (MCC_isMode) then 
{
	MCC_consoleString = str "MCC_Console" + "in (assignedItems _this) && (vehicle _target == vehicle _this)"; 
}
else 
{
	MCC_consoleString = str "B_UavTerminal" + "in (assignedItems _this) && (vehicle _target == vehicle _this)"; 
};
//------------------------Artillery---------------------------------------------------
MCC_artilleryTypeArray = [["DPICM","GrenadeHand",0],["HE 120mm","Sh_120mm_HE_Tracer_Red",1], ["HE 155mm","Sh_155mm_AMOS",1], ["Cluster AP","Mo_cluster_AP",1],["Mines 120mm","Mine_155mm_AMOS_range",3],
						["HE Laser-guided","Bo_GBU12_LGB",3],["HE 82mm","Sh_82mm_AMOS",1], ["Incendiary 82mm","Fire_82mm_AMOS",1],
						["Smoke White 120mm","Smoke_120mm_AMOS_White",1],["Smoke White 82mm","Smoke_82mm_AMOS_White",1],["Smoke Green 40mm","G_40mm_SmokeGreen",1], ["Smoke Red 40mm","G_40mm_SmokeRed",1],
						["Flare White","F_40mm_White",2], ["Flare Green","F_40mm_Green",2], ["Flare Red","F_40mm_Red",2]];
MCC_artillerySpreadArray = [["On-target",0], ["Precise",50], ["Tight",100], ["Wide",200]]; //Name and spread in meters
MCC_artilleryNumberArray = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30];

//-------------------------MCC Convoy presets---------------------------------------------
//The Type of units, drivers and escort in the HVT car
MCCConvoyWestEscort = "B_Soldier_F"; MCCConvoyWestDriver = "B_Soldier_SL_F";
MCCConvoyEastEscort = "O_Soldier_F"; MCCConvoyEastDriver = "O_Soldier_SL_F";
MCCConvoyGueEscort = "GUE_Soldier_1"; MCCConvoyGueDriver = "GUE_Soldier_CO";
MCCConvoyCivEscort = "C_man_1_1_F"; MCCConvoyCivDriver = "C_man_1_1_F";

//----------------------------Presets---------------------------------------------------------
mccPresets = [ 
		 ['======= Artillery =======','']
		,['AI Artillery - Cannon', '[_this,1,2000,100,12,5,"Sh_82mm_AMOS",20] execVM "'+MCC_path+'scripts\UPSMON\MON_artillery_add.sqf";']
		,['AI Artillery - Rockets', '[_this,6,5000,150,4,2,"Sh_82mm_AMOS",120] execVM "'+MCC_path+'scripts\UPSMON\MON_artillery_add.sqf";']
		,['Ambient Artillery - Cannon', '[0,_this] execVM "'+MCC_path+'mcc\general_scripts\ambient\amb_art.sqf";']
		,['Ambient Artillery - Rockets', '[1,_this] execVM "'+MCC_path+'mcc\general_scripts\ambient\amb_art.sqf";']
		,['Forward Observer Artillery', '[0,_this] execVM "'+MCC_path+'mcc\general_scripts\artillery\bon_art.sqf";']
		,['Ambient AA - Cannon/Rockets', '[2,_this] execVM "'+MCC_path+'mcc\general_scripts\ambient\amb_art.sqf";']
		,['Ambient AA - Search Light', '[3,_this] execVM "'+MCC_path+'mcc\general_scripts\ambient\amb_art.sqf";']
		,['======= Units =======','']
		,['Recruitable', '_this addAction [format ["Recruit %1", name _this], "'+MCC_path+'mcc\general_scripts\hostages\hostage.sqf",[2],6,false,true];']
		,['Make Hostage', '_this execVM "'+MCC_path+'mcc\general_scripts\hostages\create_hostage.sqf";']
		,['Join player', '[_this] join (group player);']
		,['Set Renegade', '_this addrating -2001;']
		,['Stand Up', '_this setUnitPos "UP";']
		,['Kneel', '_this setUnitPos "Middle";']
		,['Prone', '_this setUnitPos "DOWN";']
		,['Can be controled using MCC Console', '(group _this) setvariable ["MCC_canbecontrolled",true,true];']
		,['======= Vehicles =======','']
		,['Set Empty (Fuel)', '_this setfuel 0;']
		,['Set Empty (Ammo)', '_this setvehicleammo 0;']
		,['Set Empty (Cargo)', 'clearMagazineCargoGlobal _this; clearWeaponCargoGlobal _this; clearItemCargoGlobal _this;']
		,['Set Locked', '_this setVehicleLock "LOCKED";']
		,['Add Crew (UAV)','createVehicleCrew _this;group _this setvariable ["MCC_canbecontrolled",true,true];']
		,['ECM - can jamm IED','if (isServer) then {_this setvariable ["MCC_ECM",true,true]};']
		,['======= Objects =======','']
		,['Pickable Object','_this call MCC_fnc_pickItem;']
		,['Virtual Ammobox System (VAS)', '_this addAction ["Virtual Ammobox", "'+MCC_path+'VAS\open.sqf"];']
		,['Destroyable by satchels only', '_this addEventHandler ["handledamage", {if ((_this select 4) in ["SatchelCharge_Remote_Ammo","DemoCharge_Remote_Ammo"]) then {(_this select 0) setdamage 1} else {0}}];']
		,['Destroy Object', '_this setdamage 1;']
		,['Flip Object', '[_this ,0, 90] call bis_fnc_setpitchbank;']
		,['======= Effects =======','']
		,['Sandstorm','[_this] call BIS_fnc_sandstorm;']
		,['Flies','[getposatl _this] call BIS_fnc_flies;']
		,['Smoke','if (isServer) then {_effect = "test_EmptyObjectForSmoke" createVehicle (getpos _this); _effect attachto [_this,[0,0,0]];};']
		,['Fire','if (isServer) then {_effect = "test_EmptyObjectForFireBig" createVehicle (getpos _this); _effect attachto [_this,[0,0,0]];};']
		,['======= Misc =======','']
		,['Create Local Marker', '_this execVM "'+MCC_path+'mcc\general_scripts\create_local_marker.sqf";']
	];


//**********************************************************************************************************************
//====================================================================================================================
//=		 				DO NOT EDIT BENEATH THIS LINE
//====================================================================================================================
//*********************************************************************************************************************
//-----------------------Bon artillery --------------------------------------------
_nul = [] execVM MCC_path +"bon_artillery\bon_arti_init.sqf";

// HEADLESS CLIENT CHECK
if (isNil "MCC_isHC" ) then 
{ 
	MCC_isHC = false; 
};
if (isNil "MCC_isLocalHC" ) then 
{ 
	MCC_isLocalHC = false;
};

		
if ( !(isServer) ) then 
{
	_hc = ppEffectCreate ["filmGrain", 2005];
	if (_hc == -1) then // is HC
	{
		MCC_isHC = true;
		MCC_isLocalHC = true;
		MCC_ownerHC = owner player;
		publicVariable "MCC_isHC";
		publicVariable "MCC_ownerHC";
	}
	else 
	{
		ppEffectDestroy _hc;
	};
};


// define if tracking is enabled or disabled
MCC_trackMarker = false; 
// use mcc logic module to set to true to always allow to teleport to team, e.g. in case of training mission or respawn enabled mission
if (isnil "MCC_alwaysAllowTeleport") then {MCC_alwaysAllowTeleport = false};
// use mcc logic module to set to false to disable auto teleport to mcc start location 
if (isnil "MCC_teleportAtStart") then {MCC_teleportAtStart = true};

// use mcc logic module to set to false to disable Suunto and/or auto viewdistance adjust
MCC_HALOviewDistance = true;
MCC_HALOviewAltimeter = true;

//define stuff for popup menu
MCC_mouseButtonDown = false; //Mouse state
MCC_mouseButtonUp = true; 
if (isnil "MCC_sync") then {MCC_sync= ""};
MCC_unitInit = "";
MCC_unitName = "";
MCC_capture_state = false;
MCC_capture_var = "";
MCC_zones_numbers = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40];
MCC_zones_x = [[10],[25],[50],[100],[200],[300],[400],[500],[600],[700],[800],[900],[1000],[1500],[2000],[2500],[3000],[4000],[5000],[6000],[7000],[8000],[9000],[10000]];
MCC_zone_drawing = false;
// NEW
MCC_ZoneType = [["regular",0],["respawn",1],["patrol",2],["reinforcement",3]];
MCC_ZoneType_nr1 = [["rectangle",0],["rectangle 45",1],["rectangle 30",2]]; //regular
MCC_ZoneType_nr2 = [["unlimited",0],["1",1],["2",2],["3",3],["4",4],["5",5],["6",6],["7",7],["8",8],["9",9],["10",10]]; // respawn
MCC_ZoneType_nr3 = [["2",0],["3",1],["4",2],["5",3],["6",4],["7",5],["8",6],["9",7],["10",8]]; // patrol
MCC_ZoneType_nr4 = [["specific - 1",0],["specific - 2",1],["specific - 3",2],["anyware",3]]; // reinforcement
MCC_Marker_type = "RECTANGLE";
MCC_Marker_dir = 0;
MCC_MarkerZoneColor = "ColorYellow";
MCC_MarkerZoneType = "join";
mcc_patrol_wps = [];

MCC_ZoneLocation = [["Server", 0], ["Headless Client", 1]]; //NEW
mcc_hc = 0; // 0 = UPSMON target is server, 1 = UPSMON target is HeadlessClient
mcc_spawn_dir = [0,0,0];
MCC_trackdetail_units = false; 

// end NEW
MCC_unit_array_ready=true; 
MCC_faction_index = 0; 
MCC_type_index = 0; 
MCC_beanch_index = 0; 
MCC_class_index = 0; 
MCC_zone_index = 0; 
MCC_zoneX_index = 0; 
MCC_ZoneType_index = 0; //NEW
MCC_ZoneType_nr_index = 0; //NEW
MCC_zoneY_index = 0; 
MCC_mcc_screen = 0;
MCC_tasks =[];
MCC_triggers = [];
MCC_drawTriggers = false; 
MCC_markerarray = [];
MCC_brushesarray = [];
MCC_musicTracks_array = [];
MCC_soundTracks_array = [];
MCC_musicTracks_index = 0;
MCC_brush_drawing = false; 
if (isnil "MCC_jukeboxMusic") then {MCC_jukeboxMusic = true};
MCC_musicActivateby_array = ["NONE","EAST","WEST","GUER","CIV","LOGIC","ANY","ALPHA","BRAVO","CHARLIE","DELTA","ECHO","FOXTROT","GOLF","HOTEL","INDIA","JULIET","STATIC","VEHICLE","GROUP","LEADER","MEMBER","WEST SEIZED","EAST  SEIZED","GUER  SEIZED"];
MCC_musicCond_array = ["PRESENT","NOT PRESENT","WEST D","EAST D","GUER D","CIV D"];
MCC_angle_array = [0,45,90,135,180,225,270,315];
MCC_shapeMarker = ["RECTANGLE","ELLIPSE"];
MCC_colorsarray = [["Black","ColorBlack"],["White","ColorWhite"],["Red","ColorRed"],["Green","ColorGreen"],["Blue","ColorBlue"],["Yellow","ColorYellow"]];

MCC_spawn_empty =[["No",true],["Yes",false]];
MCC_spawn_behavior = [
                      ["Agressive", "MOVE","AI will patrol the zone and pursuit known enemies outside the zone"],
					  ["Defensive","NOFOLLOW","AI will patrol the zone but will not pursuit known enemies outside the zone"],
					  ["Passive", "NOMOVE","AI will not patrol the zone but after being engaged he will acquire agressive behavior"],
					  ["Fortify","FORTIFY","AI will look for empty building and static weapons and dig inside"],
					  ["Ambush","AMBUSH","AI will look for roads, place mines and wait in ambush position"],
					  ["On-Road Offensive","ONROADO","Like Offensive but most likely AI will stay on road"],
					  ["On-Road Defensive","ONROADD","Like Defensive but most likely AI will stay on road"],
					  ["BIS Default","bis","Regular ArmA AI behavior"],
					  ["BIS Defence","bisd","AI sit down some will patrol around"],
					  ["BIS Patrol","bisp","AI will patrol around"]
					  ];
MCC_spawn_awereness = [["Default", "default"],["Aware","Aware"],["Combat", "Combat"],["Stealth","stealth"],["Careless","Careless"]];
MCC_empty_index = 0;
MCC_behavior_index = 0;
MCC_awereness_index = 0;

MCC_enable_respawn = true; 

MCC_months_array = [["January", 1],["February",2],["March", 3],["April",4],["May",5],["June", 6],["July",7],["August", 8],["September",9],["October",10],["November",11],["December",12]];
MCC_days_array =[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31];
MCC_minutes_array =[00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59];
MCC_hours_array = [["00:00",0],["01:00",1],["02:00",2],["03:00",3],["04:00",4],["05:00",5],["06:00",6],["07:00",7],["08:00",8],["09:00",9],["10:00",10],["11:00",11],["12:00",12],["13:00",13],["14:00",14],["15:00",15],["16:00",16],["17:00",17],["18:00",18],["19:00",19],["20:00",20],["21:00",21],["22:00",22],["23:00",23]];
MCC_weather_array = [["Clear",[0, 0, 0, 0, 0]], ["Clouded",[0.5, 0.5, 0.5, 0.5, 0.5]],["Rainy",[0.8, 0.8, 0.8, 0.8, 0.8]],["Storm",[1, 1, 1,1,1]]];
MCC_fog_array = [["None",0], [1,0.1], [2,0.2], [3,0.3], [4,0.4], [5,0.5], [6,0.6], [7,0.7], [8,0.8], [9,0.9], ["Full",1]];
MCC_months_index=0;
MCC_day_index=0;
MCC_hours_index=0;
MCC_minutes_index=0;
MCC_weather_index=0;
MCC_fog_index=0;

MCC_grass_array = [["No grass",50],["Medium grass",25], ["High grass",12.5]];
MCC_view_array = [1000,2000,3000,4000,5000,6000,7000,8000,9000,10000];
MCC_grass_index = 2;

MCC_ied_proxArray = [3,5,10,15,20,25,30,35,45,50];
MCC_ied_targetArray = [west, east, resistance, civilian];
MCC_IEDDisarmTimeArray = [10, 20, 30, 40, 50, 60, 120, 180, 240, 300];
MCC_IEDCount = 0;
MCC_IEDLineCount = 0;
MCC_IEDisSpotter = 0;

//Draw Stuff triggers
MCC_ambushPlacing = false;
MCC_natureIsRuning = false;
MCC_drawGunIsRuning =  false; 
MCC_drawMinefield = false; 
MCC_delete_drawing = false; 

MCC_deleteTypes = ["Man", "Car", "Tank", "Helicopter", "Plane", "ReammoBox", "All"];

MCC_trapvolume = [];
MCC_selectedUnits = [];

MCC_convoyCar1Index = 0;
MCC_convoyCar2Index = 0;
MCC_convoyCar3Index = 0;
MCC_convoyCar4Index = 0;
MCC_convoyCar5Index = 0;
MCC_convoyHVTIndex = 0;
MCC_convoyHVTCarIndex = 0;

MCC_mccFunctionDone = true; //define function is runing. 
MCC_lastSpawn = []; //For Undo.

MCC_uavSiteArray = [["Console's AC-130",0]];
MCC_ConsoleUAVMouseButtonDown = false;
MCC_ConsoleUAVCameraMod = 0;
MCC_ConsoleUAVmissiles = 0; 
MCC_ConsoleUAVvision = "VIDEO"; 
MCC_ConsoleOperator = ""; 
MCC_ConsoleRuler = false; 
MCC_ConsoleRulerData = [0,0];
MCC_ConsoleGroups1 = [];
MCC_ConsoleGroups2 = [];
MCC_ConsoleGroups3 = [];
MCC_ConsoleGroups4 = [];
MCC_ConsoleGroups5 = [];
MCC_ConsoleGroups6 = [];
MCC_ConsoleGroups7 = [];
MCC_ConsoleGroups8 = [];
MCC_ConsoleGroups9 = [];
MCC_ConsoleGroups10 = [];

MCC_ACConsoleUp = false;
MCC_ConsoleACvision = "VIDEO"; 
MCC_ConsoleACCameraMod = 0;
MCC_uavConsoleACFirstTime = true;
MCC_ConsoleACweaponSelected = 0;
MCC_ConsoleACMouseButtonDown  = false;
MCC_consoleACgunReady1 = true;
MCC_consoleACgunReady2 = true;
MCC_consoleACgunReady3 = true;
MCC_consoleACmousebuttonUp = true; 

MCC_airDropArray = []; 
MCC_CASBombs = ["Gun-run short","Gun-run long","S&D","Rockets-run","AT run","AA run","JDAM","LGB","Bombing-run"];
MCC_GunRunBusy = [0,0,0,0,0,0,0];
MCC_CASrequestMarker = false;
MCC_CASConsoleArray	= []; 
MCC_CASConsoleFirstTime = true; 
MCC_ConsoleAirdropArray	= []; 

MCC_evacFlyInHight_array = [["50m",50],["100m",100],["150m",150],["200m",200],["300m",300],["400m",400],["500m",500]];
MCC_evacFlyInHight_index = 1;
MCC_evacVehicles = [];
MCC_evacVehicles_index = 0;
MCC_evacVehicles_last = 0;

MCCFirstOpenUI= true;

MCC_UMunitsNames = [];
MCC_UMstatus = 0;
MCC_UMUnit = 0;
MCC_gearDialogClassIndex = 0;
MCC_UMParadropRequestMarker = false; 
MCC_UMPIPView = 0;
MCC_isBroadcasting = false;
MCC_UMisJoining = false;

MCC_align3D 		= false; //Align to surface in 3D editor? 
MCC_smooth3D		= false; //Smooth placing
MCC_align3DText 	= "Enabled";
MCC_smooth3DText	= "Disabled";
MCC_clientFPS 	= 0;
MCC_serverFPS 	= 0;
MCC_hcFPS		= 0;

mcc_active_zone 		= 1; 

MCC_groupFormation	= ["COLUMN","STAG COLUMN","WEDGE","ECH LEFT","ECH RIGHT","VEE","LINE","FILE","DIAMOND"];	//Group formations
MCC_planeNameCount	= 0;

//Mission Settings Index
HW_arti_number_shells_per_hourIndex		= 0;
MCC_resistanceHostileIndex				= 0;
MCC_aiSkillIndex						= 5;
MCC_aiAimIndex							= 0;
MCC_aiSpotIndex							= 3;
MCC_aiCommandIndex						= 5;
MCC_t2tIndex							= 1;

MCC_groupGenCurrenGroupArray = []; 
MCC_groupGenGroupArray = []; 
	
MCC_groupGenGroupcount = 0; 		//group spawned
MCC_groupGenGroupselectedIndex = 0;
MCC_groupGenTempWP = [];
MCC_groupGenTempWPLines = [];

//Bon artillery
MCC_bonCannons = []; 

//MCC Save
MCC_saveIndex = 0;

// Mission Wizard
MCC_MWmaxPlayers = 100;
MCC_MWDifficulty = ["Easy","Medium","Hard"];
MCC_MWMissionType = ["None","Random","Secure HVT","Kill HVT","Destroy Object","Aquire Intel","Clear Area","Disarm IED"];
MCC_MWObjectiveMarkers = []; 
MCC_MWmissionsCenter = []; 
MCC_MWHVT = ["B_officer_F","O_officer_F","I_officer_F","C_Nikos"]; 
MCC_MWHVTCamps = ["c_campSite","o_campSIte","b_campSIte","c_slums"]; 
MCC_MWFuelDeop = ["Land_dp_smallTank_F","Land_ReservoirTank_V1_F","Land_dp_bigTank_F"];
MCC_MWRadio = ["Land_TTowerBig_1_F","Land_TTowerBig_2_F"];
MCC_MWTanks = ["B_MBT_01_cannon_F","O_MBT_02_cannon_F"];
MCC_MWAAB = ["B_APC_Tracked_01_AA_F"];
MCC_MWAAO = ["O_APC_Tracked_02_AA_F"];
MCC_MWAAI = ["I_APC_Wheeled_03_cannon_F"];
MCC_MWArtilleryB = ["B_MBT_01_arty_F","B_MBT_01_mlrs_F"];
MCC_MWArtilleryO = ["O_MBT_02_arty_F","O_Mortar_01_F"];
MCC_MWArtilleryI = ["I_Mortar_01_F"];
MCC_MWAir = ["O_Heli_Attack_02_F","O_Heli_Attack_02_black_F","O_UAV_02_F","O_UAV_02_CAS_F","B_Heli_Attack_01_F","I_Plane_Fighter_03_CAS_F","I_Plane_Fighter_03_AA_F"];
MCC_MWcache = ["Box_East_AmmoVeh_F"];
MCC_MWradar = ["Land_Radar_Small_F"];
MCC_MWIntelObjects = ["Land_File2_F","Land_FilePhotos_F","Land_Laptop_unfolded_F","Land_SatellitePhone_F","Land_Suitcase_F"]; //s2 setPos (s3 modelToWorld [0,0,0.41]); 
MCC_MWIED = ["IEDLandSmall_Remote_Ammo","IEDLandBig_Remote_Ammo","IEDUrbanSmall_Remote_Ammo","IEDUrbanBig_Remote_Ammo"];

//StratigicMap
MCC_MWObjectivesNames	= []; 	//placeHolder for objectives
MCC_MWMissions			= []; 	//Store all the mission objectives = (MCC_MWMissions select 0) select 1 - will select the 2nd objective from the 1st mission

//====================================================================================MCC Engine Init============================================================================================================================

if (!isDedicated && !MCC_isLocalHC) then 
{
	// Disable Respawn & Organise start on death location 
	_null=[] execVM MCC_path + "mcc\general_scripts\mcc_player_disableRespawn.sqf";

	// Initialize and load the pop up menu
	_null=[] execVM MCC_path + "mcc\pop_menu\mcc_init_menu.sqf";
};

mcc_spawntype   		= "";
mcc_classtype   		= "";
mcc_isnewzone   		= false;
mcc_spawnwithcrew 		= true;
mcc_spawnname     		= "";
mcc_spawnfaction  		= "";
mcc_spawndisplayname    = "";
mcc_zoneinform    		= "NOTHING";
mcc_zone_number			= 1; 		
mcc_zone_markername 	= '1'; 	
mcc_zone_markposition   = []; 	
mcc_markerposition      = [];	
mcc_zone_marker_X   	= 200;		
mcc_zone_marker_Y		= 200;		
mcc_spawnbehavior       = "MOVE";	
mcc_awareness			= "DEFAULT";
mcc_zone_pos  		= 	[];
mcc_zone_size 		= 	[];
mcc_zone_types		= 	[];
mcc_zone_locations	= 	[];
mcc_grouptype			= "";
mcc_track_units			= false;
mcc_safe				= "";
mcc_load				= "";
mcc_isloading			= false;
mcc_request				= 0;
mcc_resetmissionmaker	= false;
if (isnil "mcc_missionmaker") then {mcc_missionmaker = ""};
mcc_firstTime			= true; //First time runing?
mcc_pickitem 			= false; 

// Objects
U_AMMO					= [];
U_ACE_AMMO				= [];
U_FORT 					= [];
U_DEAD_BODIES 			= [];
U_FURNITURE 			= [];
U_MARKET				= [];
U_MISC					= [];
U_SIGHNS				= [];
U_FLAGS					= [];
U_MILITARY				= [];
U_WARFARE				= [];
U_WRECKS				= [];
U_SUBMERGED				= [];
U_TENTS					= [];
U_GARBAGE				= [];
U_LAMPS					= [];
U_CONTAINER				= [];
U_SMALL_ITEMS			= [];
U_STRUCTERS				= [];
U_HELPERS				= [];
U_TRAINING				= [];
U_MINES					= [];
U_ANIMALS				= [];

//Weapons
W_AR					= [];
W_BINOS					= [];
W_ITEMS					= [];
W_LAUNCHERS				= [];
W_MG					= [];
W_PISTOLS				= [];
W_RIFLES				= [];
W_SNIPER				= [];
W_RUCKS					= [];
U_MAGAZINES				= [];
U_UNDERBARREL			= [];
U_GRENADE				= [];
U_EXPLOSIVE				= [];
U_UNIFORM				= [];
U_GLASSES				= [];

MCC_3Dobjects			= [];		//Place holder for 3D objects
MCC_3DobjectsCounter	= -1;

//Lets create our MCC subject in the diary
_index = player createDiarySubject ["MCCZones","MCC Zones"];

if ( isServer ) then 
{
	//Initialize UPSMON script
	_null=[] execVM MCC_path + "scripts\Init_UPSMON.sqf";
	
	//Make sure about who is at war with who or it will be a very peacefull game 
	_SideHQ_East   = createCenter east;
	_SideHQ_Resist = createCenter resistance;
	_SideHQ_west   = createCenter west;

	//create logics
	//server
	_dummyGroup = creategroup civilian; 
	_dummy = _dummyGroup createunit ["Logic", [0, 90, 90],[],0.5,"NONE"];	//Logic Server
	_name = "server";
	call compile (_name + " = _dummy");
	publicVariable _name;
	
	//west
	_dummy = _dummyGroup createunit ["SideBLUFOR_F", [0, 90, 90],[],0.5,"NONE"];	//Logic Server
	_name = "MCC_sideWest";
	call compile (_name + " = _dummy");
	publicVariable _name;
	
	//East
	_dummy = _dummyGroup createunit ["SideOPFOR_F", [0, 90, 90],[],0.5,"NONE"];	//Logic Server
	_name = "MCC_sideEast";
	call compile (_name + " = _dummy");
	publicVariable _name;
	
	//Resistance
	_dummy = _dummyGroup createunit ["SideResistance_F", [0, 90, 90],[],0.5,"NONE"];	//Logic Server
	_name = "MCC_sideResistance";
	call compile (_name + " = _dummy");
	publicVariable _name;
	
	
	//create group for dead players
	MCC_deadGroup = creategroup civilian; 
	
	//Handle if mission maker DC 
	MCC_missionMakerDC = 
	{
		if (_name == mcc_missionmaker) then 
		{
			mcc_missionmaker="";
			publicVariable "mcc_missionmaker";
		}; 
	};

	private "_id";
	_id = ["BIS_id", "onPlayerDisconnected", "MCC_missionMakerDC"] call BIS_fnc_addStackedEventHandler;
	
	//Create a center to stand on while respawn is off
	private "_dummyObject";
	_dummyObject = "Land_Pier_F" createvehicle [-9999, -9999, -1];
	_dummyObject setpos [-9999, -9999, -1];
};


// Handler code for the server for MP purpose
_null=[] execVM MCC_path + "mcc\pv_handling\mcc_pv_handler.sqf";
_null=[] execVM MCC_path + "mcc\pv_handling\mcc_extras_pv_handler.sqf";

diag_log format ["%1 - MCC Headless Client available: %2", time, MCC_isHC];
diag_log format ["%1 - MCC Local Headless Client: %2", time, MCC_isLocalHC];


//******************************************************************************************************************************
//											CP Stuff
//******************************************************************************************************************************	

//---------------------------------------------
//		General
//---------------------------------------------
CP_maxPlayers		= 100; 
CP_maxSquads		= 20; 
CP_westSpawnPoints 	= [];
CP_eastSpawnPoints	= [];
CP_guarSpawnPoints	= [];

CP_dialogInitDone = true; 				//define if dialog is been initialize
CP_weaponAttachments = ["","",""];	
CP_defaultLevel = [1,0];

CP_activated = false; 			//CP activated on MCC mode

//---------------------------------------------
//		Index
//---------------------------------------------
CP_respawnPointsIndex 	= 0;
CP_squadListIndex		= 0;
CP_classesIndex 		= 0; 
CP_NVIndex 				= 0;
CP_headgearIndex 		= 0;
CP_gogglesIndex 		= 0;
CP_vestIndex 			= 0;
CP_backpackIndex 		= 0;
CP_uniformsIndex 		= 0;
CP_currentItems1Index 	= 0;
CP_currentItems2Index 	= 0;
CP_currentItems3Index 	= 0;
CP_opticsIndex			= 0;
CP_barrelIndex			= 0;
CP_attachsIndex			= 0;

//---------------------------------------------
//		numbers of roles
//---------------------------------------------
CP_availablePilots 				= 100;
CP_availableCrew 				= 100; 

CP_officerPerGroup				= 1; 
CP_officerMinPlayersInGroup		= 1; 

CP_ARPerGroup					= 2; 
CP_ARMinPlayersInGroup			= 3; 

CP_riflemanPerGroup				= 30; 
CP_riflemanMinPlayersInGroup	= 0; 

CP_ATPerGroup					= 2; 
CP_ATMinPlayersInGroup			= 4; 

CP_CorpsmanPerGroup				= 2; 
CP_CorpsmanMinPlayersInGroup	= 3; 

CP_MarksmanPerGroup				= 1; 
CP_MarksmanMinPlayersInGroup	= 5; 

CP_SpecialistPerGroup			= 2; 
CP_SpecialistMinPlayersInGroup	= 4; 
		
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
CP_fnc_setVariable		= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_setVariable.sqf");
CP_fnc_allowedDrivers	= compileFinal preprocessFileLineNumbers (CP_path + "scripts\functions\CP_fnc_allowedDrivers.sqf");

//---------------------------------------------
//		Server Init
//---------------------------------------------
if (isServer || isdedicated) then 
{
	_null=[] execVM CP_path + "scripts\server\server_init.sqf";
};

//---------------------------------------------
//		public Variables
//---------------------------------------------
"CP_westGroups" addPublicVariableEventHandler {
		{
			(_x select 0) setGroupId [(_x select 1),"GroupColor0"];
		} foreach CP_westGroups;
	};	
	
"CP_eastGroups" addPublicVariableEventHandler {
		{
			(_x select 0) setGroupId [(_x select 1),"GroupColor0"];
		} foreach CP_eastGroups;
	};
	
"CP_guarGroups" addPublicVariableEventHandler {
		{
			(_x select 0) setGroupId [(_x select 1),"GroupColor0"];
		} foreach CP_guarGroups;
	};

//---------------------------------------------
//		Global CP Defines
//---------------------------------------------

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


//******************************************************************************************************************************
//											CP Stuff Ended
//******************************************************************************************************************************

//=============================Sync with server when JIP======================
waituntil {alive player};

MCC_groupGenGroupStatus = side player; 	

if (!isServer && !(MCC_isLocalHC)) then
	{
		private ["_html","_loop"];
		waituntil {!(IsNull (findDisplay 46))};
		sleep 2; 
		waituntil {! isnil "MCC_fnc_countDownLine"}; 
		mcc_sync_status = false; 
		[] spawn MCC_fnc_sync;
		_loop = 20; 
		for [{_x=1},{_x<=_loop},{_x=_x+1}]  do //Create progress bar
		{
			_footer = [_x,_loop] call MCC_fnc_countDownLine;
			//add header
			_html = "<t color='#818960' size='1.2' shadow='0' align='left' underline='true'>" + "Synchronizing with server" + "</t><br/><br/>";
			//add _text
			_html = _html + "<t color='#a9b08e' size='1' shadow='0' shadowColor='#312100' align='left'>" + "Wait a moment, Synchronizing with the server" + "</t>";
			//add _footer
			_html = _html + "<br/><br/><t color='#818960' size='0.85' shadow='0' align='right'>" + _footer + "</t>";
			hintsilent parseText(_html);
			sleep 0.1;
			if (!mcc_sync_status) then {sleep 3}; 
		};
		Hint "Synchronizing Done";	
	};

if ( !( isDedicated) && !(MCC_isLocalHC) ) then
{
	waituntil {!(IsNull (findDisplay 46))};
	//Opening status radio
	_keyDown = (findDisplay 46) displayAddEventHandler  ["KeyDown", "if (((_this select 1) == 2) && (commandingMenu == 'RscCallSupport') && (leader player == player)) then {(group player) setvariable ['MCC_support',['(Need Medic)',time],true]}"];
	_keyDown = (findDisplay 46) displayAddEventHandler  ["KeyDown", "if (((_this select 1) == 3) && (commandingMenu == 'RscCallSupport') && (leader player == player)) then {(group player) setvariable ['MCC_support',['(Need Medevac)',time],true]}"];
	_keyDown = (findDisplay 46) displayAddEventHandler  ["KeyDown", "if (((_this select 1) == 4) && (commandingMenu == 'RscCallSupport') && (leader player == player)) then {(group player) setvariable ['MCC_support',['(Need Repair)',time],true]}"];
	_keyDown = (findDisplay 46) displayAddEventHandler  ["KeyDown", "if (((_this select 1) == 5) && (commandingMenu == 'RscCallSupport') && (leader player == player)) then {(group player) setvariable ['MCC_support',['(Need Ammo)',time],true]}"];
	_keyDown = (findDisplay 46) displayAddEventHandler  ["KeyDown", "if (((_this select 1) == 6) && (commandingMenu == 'RscCallSupport') && (leader player == player)) then {(group player) setvariable ['MCC_support',['(Need Fuel)',time],true]}"];
	_keyDown = (findDisplay 46) displayAddEventHandler  ["KeyDown", "if (((_this select 1) == 7) && (commandingMenu == 'RscCallSupport') && (leader player == player)) then {(group player) setvariable ['MCC_support',['',time],true]}"];

	// Teleport to team on Alt + T
	MCC_teleportToTeam = true;
	_keyDown = (findDisplay 46) displayAddEventHandler ["KeyDown", "if ((_this select 1)==20 && (_this select 4)) then {player execVM '"+MCC_path+"mcc\general_scripts\mcc_SpawnToPosition.sqf';true}"];

	// Add to the action menu
	if (getplayerUID player in MCC_allowedPlayers || "all" in MCC_allowedPlayers || serverCommandAvailable "#logout" || isServer) then 
	{
		mcc_actionInedx = player addaction ["<t color=""#99FF00"">--= Mission generator =--</t>", MCC_path + "mcc\dialogs\mcc_PopupMenu.sqf",[], 0,false, false, "teamSwitch","vehicle _target == vehicle _this"];
		player setvariable ["MCC_allowed",true,true];
	};
	
	//Add MCC Console action menu
	_null = player addaction ["<t color=""#FFCC00"">Open MCC Console</t>", MCC_path + "mcc\general_scripts\console\conoleOpenMenu.sqf",[0],-1,false,true,"teamSwitch",MCC_consoleString];
		
	//Save gear EH
	if(local player) then {player addEventHandler ["killed",{player execVM MCC_path + "mcc\general_scripts\save_gear.sqf";}];};
	
	//Handle Heal
	if(local player) then {player addEventHandler ["HandleHeal",{if (isplayer (_this select 1) && ("Medikit" in (items(_this select 1)))) then {(_this select 1) addrating 200; false}}];};
};

//========= player Loops (for saving gear/name tag exc)=================================
MCC_CPplayerLoop = compile preprocessFile format ["%1mcc\general_scripts\loops\mcc_CPplayerLoop.sqf",MCC_path];
MCC_NameTagsPlayerLoop = compile preprocessFile format ["%1mcc\general_scripts\loops\MCC_NameTagsPlayerLoop.sqf",MCC_path];

if ( !( isDedicated) && !(MCC_isLocalHC) ) then 
{
	MCC_groupLocalWP = [];
	MCC_groupLocalWPLines = []; 
	
	//Handle CP stuff
	[] spawn MCC_CPplayerLoop;
	
	//Handle Name Tags
	[] spawn MCC_NameTagsPlayerLoop;
};
		
//===============Delete Groups (server and HC client only)====================
if (isServer || MCC_isLocalHC) then 
{
	[] spawn 
	{
		while {true && !CP_activated} do
		{
			{if (({alive _x} count units _x) == 0) then {deleteGroup _x}} foreach allGroups;
			sleep 60; 
		};
	};
};

//============== Namspace saves=================
MCC_saveNames = profileNamespace getVariable "MCC_save";
if (isnil "MCC_saveNames") then {
	MCC_saveNames = ["save 1","save 2","save 3","save 4","save 5","save 6","save 7","save 8","save 9","save 10",
				   "save 11","save 12","save 13","save 14","save 15","save 16","save 17","save 18","save 19","save 20"];
	profileNamespace setVariable ["MCC_save", MCC_saveNames];
	};
	
MCC_saveFiles = profileNamespace getVariable "MCC_saveFiles";
if (isnil "MCC_saveFiles") then {	
MCC_saveFiles = [["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""],["",""]];
	profileNamespace setVariable ["MCC_saveFiles", MCC_saveFiles];
		};

MCC_3DCompSaveNames = profileNamespace getVariable "MCC_3DCompSaveNames";
if (isnil "MCC_3DCompSaveNames") then {
	MCC_3DCompSaveNames = ["Comp 1","Comp 2","Comp 3","Comp 4","Comp 5","Comp 6","Comp 7","Comp 8","Comp 9","Comp 10",
				   "Comp 11","Comp 12","Comp 13","Comp 14","Comp 15","Comp 16","Comp 17","Comp 18","Comp 19","Comp 20"];
	profileNamespace setVariable ["MCC_3DCompSaveNames", MCC_3DCompSaveNames];
	};
	
MCC_3DCompSaveFiles = profileNamespace getVariable "MCC_3DCompSaveFiles";
if (isnil "MCC_3DCompSaveFiles") then {	
MCC_3DCompSaveFiles = ["","","","","","","","","","","","","","","","","","","",""];
	profileNamespace setVariable ["MCC_3DCompSaveFiles", MCC_3DCompSaveFiles];
		};
		
//============ engineer data ========================
if (getNumber(configFile >> "CfgVehicles" >> typeOf player >> "canDeactivateMines") == 1) then	//Check if is engineer
{	
	["<t font='TahomaB'>You have just been assigned as Engineer/EOD</t>
		<br/><img size='8' img image='\a3\missions_f\data\img\mp_coop_m01_overview_ca.paa' />
		<br/>You can disarm mines and improvised explosive devices (IED).
		<br/>To make sure the IED isn't Radio Controlled IED (RCIED), scan for enemy's spotters that can trigger the IED and neutralize them first.
		<br/>Approach the IED carefully (no faster then a slow crawl), once you get close to it you either have the option to disarm it. Or you can place a demo charge to set off a controlled explosion.
		<br/>You can use Electronic Countermeasure Vehicles (ECM) to block RCIEDs","MCC Engineer/EOD",nil,false] spawn BIS_fnc_guiMessage;	
};		
		
//============= Init MCC done===========================
MCC_initDone = true; 
finishMissionInit;
