// By: Shay_gman
// Version: 1.1 (April 2012)
#define groupGen_IDD 2994
#define MCC_MINIMAP 9000

#define MCC_FACTION 8008
#define UNIT_TYPE 3010
#define UNIT_CLASS 3011
#define MCC_GGUNIT_TYPE 3012
#define MCC_GGUNIT_BEHAVIOR 3030
#define MCC_GroupGenCurrentGroup_IDD 9003
	
#define MCC_GroupGenInfoText_IDC 9013
#define MCC_GroupGenWPBckgr_IDC 9014
#define MCC_GroupGenWPCombo_IDC 9015
#define MCC_GroupGenWPformationCombo_IDC 9016
#define MCC_GroupGenWPspeedCombo_IDC 9017
#define MCC_GroupGenWPbehaviorCombo_IDC 9018
#define MCC_GroupGenWPAdd_IDC 9019
#define MCC_GroupGenWPReplace_IDC 9020
#define MCC_GroupGenWPClear_IDC 9021

#define MCC_GGListBoxIDC 3013
#define MCC_GGADDIDC 3014
#define MCC_GGCLEARIDC 3015
#define MCC_GGUNIT_EMPTY 3016
#define MCC_GGUNIT_EMPTYTITLE 3017
#define mcc_groupGen_CurrentgroupNameTittle_IDC 3018
#define mcc_groupGen_CurrentgroupNameText_IDC 3019
#define MCC_GGSAVE_GROUPIDC 3020

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
		mcc_groupGen_CurrentgroupListBoxFrame,
		MCC_mapBackground,
		MCC_map
	};


	//---------------------------------------------
	objects[] = 
	{ 
	};
  
	class controls
	{
		#include "mcc_groupGenLeftButtons.hpp"
		#include "mcc_groupGenRightButtons.hpp"
		
		#include "mcc_groupGenSpawn.hpp"
		#include "mcc_groupGenWeather.hpp"
		#include "mcc_groupGenTime.hpp"
		#include "mcc_groupGenRespawn.hpp"
		#include "mcc_groupGenDebug.hpp"
		#include "mcc_groupGenCAS.hpp"
		#include "mcc_groupGenArtillery.hpp"			
		#include "mcc_groupGenEvac.hpp"
		#include "mcc_groupGenIED.hpp"
		#include "mcc_groupGenConvoy.hpp"
		
		//========================================= Controls========================================
		//Tittle
		
		//Faction
		class mcc_groupGen_factionTittle: MCC_RscText 
		{
			idc = -1;
			
			text = "Faction:";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			
			x = 0.121875 * safezoneW + safezoneX;
			y = 0.57697 * safezoneH + safezoneY;
			w = 0.045 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		
		class mcc_groupGen_factionComboBox: MCC_RscCombo 
		{
			idc = MCC_FACTION;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			onLBSelChanged = __EVAL("[5] execVM '"+MCCPATH+"mcc\pop_menu\faction.sqf'");
				
			x = 0.173438 * safezoneW + safezoneX;
			y = 0.57697 * safezoneH + safezoneY;
			w = 0.120313 * safezoneW;
			h = 0.0260715 * safezoneH;
		};
		
		
		class closeGeneratorButton: MCC_RscButtonMenu
		{
			idc = -1;
			
			text = "Close";
			action = "MCC_mcc_screen=0; closeDialog 0; {deletemarkerlocal _x;} foreach MCC_groupGenTempWP;{deletemarkerlocal _x;} foreach MCC_groupGenTempWPLines;";
			
			x = 0.838021 * safezoneW + safezoneX;
			y = 0.796884 * safezoneH + safezoneY;
			w = 0.0916667 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
		
		
	
		
		//=================================Waypoints=================================
		//InfoText
		class MCC_GroupGenInfoText: MCC_RscStructuredText
		{
			idc = MCC_GroupGenInfoText_IDC;
			x = 0.1 * safezoneW + safezoneX;
			y = 0.1 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.5)";
			colorBackground[] = {0,0,0,0.9};
		};
		class MCC_GroupGenWPBckgr: MCC_RscStructuredText
		{
			idc = MCC_GroupGenWPBckgr_IDC;
			x = 0.1 * safezoneW + safezoneX;
			y = 0.1 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.5)";
			colorBackground[] = {0,0,0,0.8};
		};
		class MCC_GroupGenWPCombo: MCC_RscCombo
		{
			idc = MCC_GroupGenWPCombo_IDC;
			x = 0.1 * safezoneW + safezoneX;
			y = 0.1 * safezoneH + safezoneY;
			w = 0.105 * safezoneW;
			h = 0.0280062 * safezoneH;
		};
		class MCC_GroupGenWPformationCombo: MCC_RscCombo
		{
			idc = MCC_GroupGenWPformationCombo_IDC;
			x = 0.1 * safezoneW + safezoneX;
			y = 0.1 * safezoneH + safezoneY;
			w = 0.105 * safezoneW;
			h = 0.0280062 * safezoneH;
		};
		class MCC_GroupGenWPspeedCombo: MCC_RscCombo
		{
			idc = MCC_GroupGenWPspeedCombo_IDC;
			x = 0.1 * safezoneW + safezoneX;
			y = 0.1 * safezoneH + safezoneY;
			w = 0.105 * safezoneW;
			h = 0.0280062 * safezoneH;
		};
		class MCC_GroupGenWPbehaviorCombo: MCC_RscCombo
		{
			idc = MCC_GroupGenWPbehaviorCombo_IDC;
			x = 0.1 * safezoneW + safezoneX;
			y = 0.1 * safezoneH + safezoneY;
			w = 0.105 * safezoneW;
			h = 0.0280062 * safezoneH;
		};
		class MCC_GroupGenWPAdd: MCC_RscButton {
			idc = MCC_GroupGenWPAdd_IDC;
			text = "ADD";
			x = 0.1 * safezoneW + safezoneX;
			y = 0.1 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "Add a waypoint to all selected groups"; 
			onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\manageWP.sqf'");
		};
		class MCC_GroupGenWPReplace: MCC_RscButton {
			idc = MCC_GroupGenWPReplace_IDC;
			text = "Replace";
			x = 0.1 * safezoneW + safezoneX;
			y = 0.1 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "Remove all waypoints from any selected groups and add a new waypoint"; 
			onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\manageWP.sqf'");
		};
		class MCC_GroupGenWPClear: MCC_RscButton {
			idc = MCC_GroupGenWPClear_IDC;
			text = "Clear";
			x = 0.1 * safezoneW + safezoneX;
			y = 0.1 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			tooltip = "Remove all waypoints from any selected groups"; 
			onButtonClick = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\manageWP.sqf'");
		};
		 
		//Map
		class mcc_groupGen_WestButton: MCC_RscButton 
		{
			idc = -1;
			tooltip = "Show only West's side units"; 
			text = "West";
			colorText[] = {0,0,1,1};
			onButtonClick = __EVAL("[west] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_manage.sqf'");
			
			x = 0.666146 * safezoneW + safezoneX;
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
			
			x = 0.717708 * safezoneW + safezoneX;
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
			
			x = 0.769271 * safezoneW + safezoneX;
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
			
			x = 0.820833 * safezoneW + safezoneX;
			y = 0.565974 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
		class mcc_groupGen_AllButton: MCC_RscButton
		{
			idc = -1;
			tooltip = "Show all units"; 
			onButtonClick = __EVAL("[west,east,resistance,civilian] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_manage.sqf'");

			text = "All"; //--- ToDo: Localize;
			x = 0.614583 * safezoneW + safezoneX;
			y = 0.565974 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
	//---------------------- ZONES --------------------------------	
		class MCC_zoneTittle: MCC_RscText 
		{
			idc = -1;	
			text = "Zone:";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";

			x = 0.184896 * safezoneW + safezoneX;
			y = 0.0601715 * safezoneH + safezoneY;
			w = 0.0401042 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		
		class MCC_zone: MCC_RscCombo 
		{
			idc = 1023;	
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			onLBSelChanged = __EVAL("[0,0,0] execVM '"+MCCPATH+"mcc\pop_menu\zones.sqf'");
			
			x = 0.236458 * safezoneW + safezoneX;
			y = 0.0601715 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0219914 * safezoneH;		
		};
		
		class MCC_zoneUpdate: MCC_RscButton 
		{
			idc = -1;	
			text = "Update Zone"; 
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
			tooltip = "Click and drag on the minimap to make a zone"; 
			onButtonClick = "if (mcc_missionmaker == (name player)) then {MCC_zone_drawing= true;} else {player globalchat 'Access Denied'};";
			
			x = 0.299479 * safezoneW + safezoneX;
			y = 0.0601715 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0219914 * safezoneH;		
		};
		
		class MCC_gaiaBehaviorTittle: MCC_RscText
		{
			idc = -1;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			text = "Behavior:"; //--- ToDo: Localize;
					
			x = 0.184896 * safezoneW + safezoneX;
			y = 0.0271844 * safezoneH + safezoneY;
			w = 0.045 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		
		class MCC_gaiaBehaviorCombo: MCC_RscCombo
		{
			idc = 1;
			onLBSelChanged = "MCC_behavior_index = (lbcurSel (_this select 0))";

			x = 0.236458 * safezoneW + safezoneX;
			y = 0.0271844 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
		};
		
		class MCC_gaiaBehaviorButton: MCC_RscButton
		{
			idc = -1;
			onButtonClick = "if (!isnil 'MCC_GroupGenGroupSelected') then {if (count MCC_GroupGenGroupSelected > 0) then {{_x setVariable ['GAIA_ZONE_INTEND',[mcc_zone_markername,((MCC_spawn_behaviors select MCC_behavior_index) select 1)], true]}foreach MCC_GroupGenGroupSelected}};";

			text = "Give to Gaia"; //--- ToDo: Localize;
			x = 0.299479 * safezoneW + safezoneX;
			y = 0.0271844 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Give the selected groups to GAIA control with the selected zone and behavior"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
		};
		//---------------------------------------- BENCHMARK ----------------------------------------
		class MCC_MissionMakerTittle: MCC_RscText 
		{
			idc = -1; 
			text = "Mission Maker:"; 
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
			
			x = 0.388765 * safezoneW + safezoneX;
			y = 0.0195682 * safezoneH + safezoneY;
			w = 0.056 * safezoneW;
			h = 0.0219914 * safezoneH;	
		};
		
		class MCC_MissionMakerName: MCC_RscText 
		{
			idc = MCCMISSIONMAKERNAME;	
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
			
			x = 0.45 * safezoneW + safezoneX;
			y = 0.0195682 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0219914 * safezoneH;	
		};
		
		class MCC_clientFPSTittle: MCC_RscText 
		{	
			idc = -1;	
			text = "Client FPS:"; 
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
			
			x = 0.503349 * safezoneW + safezoneX;
			y = 0.0195682 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		
		class MCC_ServerFPSTittle: MCC_RscText 
		{	
			idc = -1;	
			text = "Server FPS:";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
			
			x = 0.600148 * safezoneW + safezoneX;
			y = 0.0195682 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0219914 * safezoneH;	
		};
		
		class MCC_clientFPS: MCC_RscText 
		{
			idc = MCCCLIENTFPS; 
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
			
			x = 0.556101 * safezoneW + safezoneX;
			y = 0.0195682 * safezoneH + safezoneY;
			w = 0.034375 * safezoneW;
			h = 0.0219914 * safezoneH;		
		};
		
		class MCC_ServerFPS: MCC_RscText 
		{
			idc = MCCSERVERFPS;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
			
			x = 0.652307 * safezoneW + safezoneX;
			y = 0.0195682 * safezoneH + safezoneY;
			w = 0.034375 * safezoneW;
			h = 0.0219914 * safezoneH;		
		};
		
		//---------------------------------------- BUTTONS ------------------------------------------
		class MCC_stopCapture: MCC_RscButton 
		{
			idc = MCCSTOPCAPTURE;
			text = "Stop Capturing"; 
			x = 0.827594 * safezoneW + safezoneX;
			y = 0.0172882 * safezoneH + safezoneY;
			w = 0.108854 * safezoneW;
			h = 0.0659743 * safezoneH;
			onButtonClick = "ctrlEnable [1014,false];MCC_capture_state=false;";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		
		class MCC_saveLoad: MCC_RscButtonMenu 
		{
			idc = -1; 
			text = "Save/Load"; 
			x = 0.742229 * safezoneW + safezoneX;
			y = 0.796884 * safezoneH + safezoneY;
			w = 0.0916667 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			onButtonClick = "if (mcc_missionmaker == (name player)) then {createDialog 'MCC_SaveLoadScreen';} else {player globalchat 'Access Denied'};";
		};
		
		class MCC_login: MCC_RscButtonMenu 
		{
			idc = -1; 
			text = "Login/Logout"; 
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
			onButtonClick = "if (mcc_missionmaker == (name player)) then{if (captive player) then {player setcaptive false; [['Mission maker is no longer cheating'],'MCC_fnc_globalHint',true,false] call BIS_fnc_MP;} else {player setcaptive true; [['Mission maker is cheating'],'MCC_fnc_globalHint',true,false] spawn BIS_fnc_MP;}} else {player globalchat 'Access Denied'};";
			
			x = 0.425521 * safezoneW + safezoneX;
			y = 0.0491758 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_spectator: MCC_RscButton
		{
			idc = -1;
			text = "Spectator"; 
			tooltip = "Open spectator camera"; 
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			onButtonClick = __EVAL("[4] execVM '"+MCCPATH+"mcc\Pop_menu\mission_settings.sqf'");
			
			x = 0.5 * safezoneW + safezoneX;
			y = 0.0491758 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_Teleport: MCC_RscButton 
		{
			idc = -1;
			text = "Teleport"; 
			tooltip = "Teleport the mission maker and any vehicle he is in to a new location"; 
			onButtonClick = "if (mcc_missionmaker == (name player)) then {hint 'Click on the map';onMapSingleClick 'vehicle player setPos _pos;onMapSingleClick '''';true;'} else {player globalchat 'Access Denied'};";
			
			x = 0.574479 * safezoneW + safezoneX;
			y = 0.0491758 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
	};
	
 //========================================= Background========================================
	class mcc_groupGenPic: MCC_RscText	
	{
		idc = -1;
		text = "";
		colorBackground[] = { 0, 0, 0,0.8};
		
		x = 0.0989583 * safezoneW + safezoneX;
		y = 0.0161887 * safezoneH + safezoneY;
		w = 0.842188 * safezoneW;
		h = 0.824678 * safezoneH;
	};
	class mcc_groupGen_groupsframe: MCC_RscFrame 
	{
		idc = -1;
		
		x = 0.104687 * safezoneW + safezoneX;
		y = 0.0381804 * safezoneH + safezoneY;
		w = 0.836458 * safezoneW;
		h = 0.802687 * safezoneH;
	};
	
	class mcc_groupGen_CurrentgroupListBoxFrame: MCC_RscText 
	{
		idc = MCC_GGListBoxIDC;
		
		x = 0.373958 * safezoneW + safezoneX;
		y = 0.620953 * safezoneH + safezoneY;
		w = 0.0973958 * safezoneW;
		h = 0.120953 * safezoneH;
			
		colorBackground[] = { 0, 0, 0, 0.6 };
		colorText[] = { 1, 1, 1, 1 };
		text = "";
	};
//===========================================Map==============================================
	class MCC_mapBackground : MCC_RscText 
	{
		idc = -1;
		
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.093159 * safezoneH + safezoneY;
		w = 0.676042 * safezoneW;
		h = 0.472816 * safezoneH;
		
		colorBackground[] = { 1, 1, 1, 1}; 
		colorText[] = { 1, 1, 1, 0};
		text = "";
	};
		
	class MCC_map : MCC_RscMapControl 
	{
		idc = MCC_MINIMAP; 
		
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.0931586 * safezoneH + safezoneY;
		w = 0.676042 * safezoneW;
		h = 0.472816 * safezoneH;
		
		text = "";
		onMouseButtonDown = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\mouseDown.sqf'");
		onMouseButtonUp = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\mouseUp.sqf'");
		onMouseButtonDblClick = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\mouseDblClick.sqf'");
		onMouseMoving = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\mouseMoving.sqf'");
	};
 
};
