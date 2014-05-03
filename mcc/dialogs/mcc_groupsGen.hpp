// By: Shay_gman
// Version: 1.1 (April 2012)
#define groupGen_IDD 2994
#define MCC_MINIMAP 9000
#define MCC_MINIMAPBACK 9001
#define MCC_BACK 9002
#define MCC_FACTION 8008

#define MCCMISSIONMAKERNAME 1020
#define MCCCLIENTFPS 1021
#define MCCSERVERFPS 1022

#define MCCSTOPCAPTURE 1014

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class mcc_groupGen 
{
	idd = groupGen_IDD;
	movingEnable = true;
	onLoad = __EVAL("_this execVM '"+MCCPATH+"mcc\dialogs\mcc_groupGen_init.sqf'"); 

	controlsBackground[] = 
	{
		mcc_groupGenPic,
		MCC_mapBackground,
		MCC_map,
		MCC_Logo,
		MCC_fram1
	};


	//---------------------------------------------
	objects[] = 
	{ 
	};
  
	class controls
	{
		//========================================= Controls========================================
		//Tittle
		
		//Faction
		class mcc_groupGen_factionTittle: MCC_RscText 
		{
			idc = -1;
			
			text = "Faction:";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			
			x = 0.184896 * safezoneW + safezoneX;
			y = 0.0601715 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		
		class mcc_groupGen_factionComboBox: MCC_RscCombo 
		{
			idc = MCC_FACTION;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			onLBSelChanged = __EVAL("[2] execVM '"+MCCPATH+"mcc\pop_menu\faction.sqf'");
				
			x = 0.236458 * safezoneW + safezoneX;
			y = 0.0601715 * safezoneH + safezoneY;
			w = 0.114583 * safezoneW;
			h = 0.0219914 * safezoneH;
		};		
		
		class closeGeneratorButton: MCC_RscButtonMenu
		{
			idc = -1;
			
			text = "Close";
			action = "closeDialog 0; {deletemarkerlocal _x;} foreach MCC_groupGenTempWP;{deletemarkerlocal _x;} foreach MCC_groupGenTempWPLines;";
			
			x = 0.84375 * safezoneW + safezoneX;
			y = 0.796884 * safezoneH + safezoneY;
			w = 0.0916667 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		 
		//Map
		class mcc_groupGen_WestButton: MCC_RscButton 
		{
			idc = -1;
			tooltip = "Show only West's side units"; 
			text = "West";
			colorText[] = {0,0,1,1};
			onButtonClick = __EVAL("[west] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_manage.sqf'");
			
			x = 0.654688 * safezoneW + safezoneX;
			y = 0.565974 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
		class mcc_groupGen_EastButton: MCC_RscButton 
		{
			idc = -1;
			tooltip = "Show only East's side units"; 
			text = "East";
			colorText[] = {1,0,0,1};
			onButtonClick = __EVAL("[east] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_manage.sqf'");
			
			x = 0.70625 * safezoneW + safezoneX;
			y = 0.565974 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
		class mcc_groupGen_GuerButton: MCC_RscButton 
		{
			idc = -1;
			tooltip = "Show only Guer's side units"; 
			text = "Guer";
			colorText[] = {0,1,0,1};
			onButtonClick = __EVAL("[resistance] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_manage.sqf'");
			
			x = 0.757813 * safezoneW + safezoneX;
			y = 0.565974 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
		class mcc_groupGen_CivButton: MCC_RscButton 
		{
			idc = -1;
			tooltip = "Show only civilian's side units"; 
			text = "Civ";
			onButtonClick = __EVAL("[civilian] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_manage.sqf'");
			
			x = 0.809375 * safezoneW + safezoneX;
			y = 0.565974 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
		class mcc_groupGen_PlayersButton: MCC_RscButton
		{
			idc = -1;
			tooltip = "Show players only"; 
			onButtonClick = __EVAL("['players'] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_manage.sqf'");

			text = "Players"; //--- ToDo: Localize;
			x = 0.603125 * safezoneW + safezoneX;
			y = 0.565974 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
		class mcc_groupGen_AllButton: MCC_RscButton
		{
			idc = -1;
			tooltip = "Show all units"; 
			onButtonClick = __EVAL("[west,east,resistance,civilian,'players'] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_manage.sqf'");

			text = "All"; //--- ToDo: Localize;
			x = 0.551562 * safezoneW + safezoneX;
			y = 0.565974 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
		
		
	//---------------------- ZONES --------------------------------	
		#include "mcc_groupGenZones.hpp"
		
	//---------------------------------------- BENCHMARK ----------------------------------------
		class MCC_MissionMakerTittle: MCC_RscText 
		{
			idc = -1; 
			text = "Mission Maker:"; 
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			
			x = 0.3625 * safezoneW + safezoneX;
			y = 0.0161887 * safezoneH + safezoneY;
			w = 0.056 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		
		class MCC_MissionMakerName: MCC_RscText 
		{
			idc = MCCMISSIONMAKERNAME;	
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			
			x = 0.419792 * safezoneW + safezoneX;
			y = 0.0161887 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		
		class MCC_clientFPSTittle: MCC_RscText 
		{	
			idc = -1;	
			text = "Client FPS:"; 
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			
			x = 0.488542 * safezoneW + safezoneX;
			y = 0.0161887 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		
		class MCC_ServerFPSTittle: MCC_RscText 
		{	
			idc = -1;	
			text = "Server FPS:";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			
			x = 0.585938 * safezoneW + safezoneX;
			y = 0.0161887 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		
		class MCC_clientFPS: MCC_RscText 
		{
			idc = MCCCLIENTFPS; 
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			
			x = 0.540104 * safezoneW + safezoneX;
			y = 0.0161887 * safezoneH + safezoneY;
			w = 0.034375 * safezoneW;
			h = 0.0219914 * safezoneH;		
		};
		
		class MCC_ServerFPS: MCC_RscText 
		{
			idc = MCCSERVERFPS;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			
			x = 0.6375 * safezoneW + safezoneX;
			y = 0.0161887 * safezoneH + safezoneY;
			w = 0.034375 * safezoneW;
			h = 0.0219914 * safezoneH;	
		};
		
		//---------------------------------------- BUTTONS ------------------------------------------
		class MCC_stopCapture: MCC_RscButton 
		{
			idc = MCCSTOPCAPTURE;
			text = "Stop Capturing"; 
			tooltip = "Once a trigger has been generated all the action done by MCC won't execute but will be saved to the trigger until this button is pressed";
			onButtonClick = "ctrlEnable [1014,false];MCC_capture_state=false;";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			
			x = 0.391146 * safezoneW + safezoneX;
			y = 0.72000 * safezoneH + safezoneY;
			w = 0.0744792 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
		class MCC_cacheButton: MCC_RscButton
		{
			idc = -1;
			onButtonClick = "if (!isnil 'MCC_GroupGenGroupSelected') then {if (count MCC_GroupGenGroupSelected > 0) then {{_x setVariable ['mcc_gaia_cache', !(_x getVariable ['mcc_gaia_cache',false]),true];}foreach MCC_GroupGenGroupSelected}};";
			tooltip = "Give the selected groups to caching system";
			text = "Cache Group"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			
			x = 0.391146 * safezoneW + safezoneX;
			y = 0.631949 * safezoneH + safezoneY;
			w = 0.0744792 * safezoneW;
			h = 0.0219914 * safezoneH;		
		};
		
		class MCC_saveLoad: MCC_RscButtonMenu 
		{
			idc = -1; 
			text = "Save/Load"; 
			x = 0.746354 * safezoneW + safezoneX;
			y = 0.796884 * safezoneH + safezoneY;
			w = 0.0916667 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			onButtonClick = "if (mcc_missionmaker == (name player)) then {createDialog 'MCC_SaveLoadScreen';} else {player globalchat 'Access Denied'};";
		};
		
		class MCC_login: MCC_RscButtonMenu 
		{
			idc = -1; 
			text = "Logout"; 
			x = 0.648958 * safezoneW + safezoneX;
			y = 0.796884 * safezoneH + safezoneY;
			w = 0.0916667 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			tooltip = "Login or logout as the mission maker"; 
			onButtonClick = __EVAL("nul=[0] execVM '"+MCCPATH+"mcc\pop_menu\mcc_login.sqf'");
		};
		
		class MCC_ghostMode: MCC_RscButton 
		{
			idc = -1;
			text = "Ghost Mode"; 
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			tooltip = "Make the mission maker invisible to enemies"; 
			onButtonClick = "if (mcc_missionmaker == (name player)) then {if (captive player) then {player setcaptive false;if (MCC_Chat) then {[['Mission maker is no longer cheating'],'MCC_fnc_globalHint',true,false] call BIS_fnc_MP;};} else {player setcaptive true; if (MCC_Chat) then {[['Mission maker is cheating'],'MCC_fnc_globalHint',true,false] spawn BIS_fnc_MP;}};} else {player globalchat 'Access Denied'};";			
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.0491758 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_spectator: MCC_RscButton
		{
			idc = -1;
			text = "Spectator"; 
			tooltip = "Open spectator camera"; 
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			onButtonClick = __EVAL("[4] execVM '"+MCCPATH+"mcc\Pop_menu\mission_settings.sqf'");
			
			x = 0.505729 * safezoneW + safezoneX;
			y = 0.0491758 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_Teleport: MCC_RscButton 
		{
			idc = -1;
			text = "Teleport"; 
			tooltip = "Teleport the mission maker and any vehicle he is in to a new location"; 
			onButtonClick = "if (mcc_missionmaker == (name player)) then {hint 'Click on the map';onMapSingleClick 'vehicle player setPos _pos;onMapSingleClick '''';true;'} else {player globalchat 'Access Denied'};";
			
			x = 0.563021 * safezoneW + safezoneX;
			y = 0.0491758 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
		class MCC_MissionWIn: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[5] execVM '"+MCCPATH+"mcc\pop_menu\tasks_req.sqf'");
			text = "Mission Won"; //--- ToDo: Localize;
			colorText[] = {0,1,0,0.8};
			tooltip = "End mission with - Mission Accomplished"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";

			x = 0.3625 * safezoneW + safezoneX;
			y = 0.0491758 * safezoneH + safezoneY;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
		class MCC_MissionLost: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[6] execVM '"+MCCPATH+"mcc\pop_menu\tasks_req.sqf'");
			text = "Mission Failed"; //--- ToDo: Localize;
			colorText[] = {1,0,0,0.8};
			tooltip = "End mission with - Mission Failed"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";

			x = 0.6375 * safezoneW + safezoneX;
			y = 0.0491758 * safezoneH + safezoneY;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
		class MCC_openMWButton: MCC_RscButton
		{
			idc = -1;
			onButtonClick = "createDialog 'MCCMWDialog'";
			text = "Mission Generator"; 
			tooltip = "Open mission wizard"; 			
			
			x = 0.43125 * safezoneW + safezoneX;
			y = 0.565974 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.0329871 * safezoneH;
			
		};
		
		class MCC_toolTipControls:MCC_RscControlsGroup
		{
			idc = -1;
			x = 0.190625 * safezoneW + safezoneX;
			y = 0.697923 * safezoneH + safezoneY;
			w = 0.194792 * safezoneW;
			h = 0.120953 * safezoneH;

			class Controls
			{
				class MCC_toolTip: MCC_RscStructuredText
				{
					idc = 303;
					w = 0.194792 * safezoneW;
					h = 0.35 * safezoneH;
				};
			};
		};
		
		//Left		
		#include "mcc_groupGenLeftButtons.hpp"
		#include "mcc_groupGenSpawn.hpp"
		#include "mcc_groupGenCAS.hpp"
		#include "mcc_groupGenArtillery.hpp"			
		#include "mcc_groupGenEvac.hpp"
		#include "mcc_groupGenIED.hpp"
		#include "mcc_groupGenConvoy.hpp"
		#include "mcc_groupGenAirdrop.hpp"
		#include "mcc_groupGenDelete.hpp"
		
		//Right
		#include "mcc_groupGenRightButtons.hpp"
		#include "mcc_groupGenWeather.hpp"
		#include "mcc_groupGenTime.hpp"
		#include "mcc_groupGenRespawn.hpp"
		#include "mcc_groupGenDebug.hpp"
		#include "mcc_groupGenMarkers.hpp"
		#include "mcc_groupGenBriefings.hpp"
		#include "mcc_groupGenTasks.hpp"
		#include "mcc_groupGenJukebox.hpp"	
		#include "mcc_groupGenTriggers.hpp"	
		#include "mcc_groupGenCS.hpp"			
		
		#include "mcc_groupGenUM.hpp"
		#include "mcc_groupGenWaypoints.hpp"
		#include "MCC_GroupGenInfo.hpp"
	};
	
 //========================================= Background========================================
	class mcc_groupGenPic: MCC_RscText	
	{
		idc = MCC_BACK;
		text = "";
		colorBackground[] = { 0.051, 0.051, 0.051,1};
		
		x = 0.0989583 * safezoneW + safezoneX;
		y = 0.0161887 * safezoneH + safezoneY;
		w = 0.845 * safezoneW;
		h = 0.824678 * safezoneH;
	};

//===========================================Map==============================================
	class MCC_mapBackground : MCC_RscText 
	{
		idc = MCC_MINIMAPBACK;
		
		x = 0.190625 * safezoneW + safezoneX;
		y = 0.0931586 * safezoneH + safezoneY;
		w = 0.664583 * safezoneW;
		h = 0.46182 * safezoneH;
		
		colorBackground[] = { 1, 1, 1, 1}; 
		colorText[] = { 1, 1, 1, 0};
		text = "";
	};
		
	class MCC_map : MCC_RscMapControl 
	{
		idc = MCC_MINIMAP; 
		
		x = 0.190625 * safezoneW + safezoneX;
		y = 0.0931586 * safezoneH + safezoneY;
		w = 0.664583 * safezoneW;
		h = 0.46182 * safezoneH;
		
		text = "";
		onMouseButtonDown = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\mouseDown.sqf'");
		onMouseButtonUp = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\mouseUp.sqf'");
		onMouseButtonDblClick = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\mouseDblClick.sqf'");
		onMouseMoving = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\mouseMoving.sqf'");
	};
	
	class MCC_Logo: MCC_RscPicture
	{
		idc = -1;
		text = __EVAL(MCCPATH +"data\mccLogo.paa");
		x = 0.104687 * safezoneW + safezoneX;
		y = 0.72 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.109957 * safezoneH;
	};
	
	class MCC_fram1: MCC_RscText
	{
		idc = -1;
		colorBackground[] = { 0.150, 0.150, 0.150,1};
		
		x = 0.435833 * safezoneW + safezoneX;
		y = 0.043458 * safezoneH + safezoneY;
		w = 0.189063 * safezoneW;
		h = 0.0439828 * safezoneH;
	};
};

