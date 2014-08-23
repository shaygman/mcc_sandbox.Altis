class CfgPatches {

	class mcc_sandbox 
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.00;
		requiredAddons[] = {};
		author[] = {"shay_gman"};
		versionDesc = "MCC Sandbox 4";
		version = "1";
	};
	
	class A3_Modules_F_Curator_Objectives
	{
		requiredAddons[] = {"A3_Modules_F_Curator"};
		units[] = {"ModuleObjective_F","ModuleObjectiveSector_MCC","ModuleObjectiveMove_F","ModuleObjectiveSector_F","ModuleObjectiveAttackDefend_F","ModuleObjectiveNeutralize_F","ModuleObjectiveProtect_F","ModuleObjectiveGetIn_F"};
		weapons[] = {};
		requiredVersion = 1;
	};
};	

class CfgFactionClasses
{
	class MCC
	{
		displayName = "MCC";
		priority = 8;
		side = 7;
	};
};

class CfgMissions 
{

	class MPMissions 
	{
		class MP_COOP_MCC_SANDBOX_STRATIS
		{
			directory = "mcc_sandbox_mod\sampleMissions\MCC_Template.Stratis";		
		};	

		class MP_COOP_MCC_SANDBOX_ALTIS 
		{
			directory = "mcc_sandbox_mod\sampleMissions\MCC_Template.Altis";		
		};
		
		class MP_COOP_MCC_SANDBOX_Chernarus 
		{
			directory = "mcc_sandbox_mod\sampleMissions\MCC_Template.Chernarus";		
		};
		
		class MP_COOP_MCC_SANDBOX_Takistan 
		{
			directory = "mcc_sandbox_mod\sampleMissions\MCC_Template.Takistan";		
		};
		
		class MP_COOP_MCC_SANDBOX_Zargabad
		{
			directory = "mcc_sandbox_mod\sampleMissions\MCC_Template.Zargabad";		
		};
	};
};

#include "\mcc_sandbox_mod\definesMod.hpp"

class RscMapControl;
class RscText;
class RscControlsGroup;
class RscControlsGroupNoScrollbars;
class RscButtonMenu;
class RscAttributeText;
class RscAttributeOwners;
class RscCombo;
class RscCheckBox;

class TabSide;
class BLUFOR;
class OPFOR;
class Independent;
class Civilian;
class GroupList;
class UnitList;

class RscAttributeAreaSize;
class RscAttributeName;						

class MCC_RscDisplayAttributes
{
	idd = -1;
	movingenable = 0;
	onLoad = "[""onLoad"",_this,""MCC_RscDisplayAttributes"",'CuratorDisplays'] call compile preprocessfilelinenumbers ""A3\ui_f\scripts\initDisplay.sqf""";
	onUnload = "[""onUnload"",_this,""MCC_RscDisplayAttributes"",'CuratorDisplays'] call compile preprocessfilelinenumbers ""A3\ui_f\scripts\initDisplay.sqf""";
	class ControlsBackground
	{
		class Map: RscMapControl
		{
			idc = 50;
			x = "safezoneXAbs";
			y = "safezoneY";
			w = "safezoneWAbs";
			h = "safezoneH";
			class CustomMark
			{
				icon = "#(argb,8,8,3)color(0,0,0,0)";
				color[] = {0,0,0,0};
				size = 0;
				importance = 0;
				coefMin = 0;
				coefMax = 0;
			};
		};
	};
	class Controls
	{
		class Background: RscText
		{
			colorBackground[] = {0,0,0,0.7};
			idc = 10001;
			x = "6.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
			y = "9.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "27 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "6.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class Title: RscText
		{
			colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.5])","(profilenamespace getvariable ['GUI_BCG_RGB_A',0.8])"};
			idc = 10002;
			text = "$STR_A3_RscDisplayAttributes_Title";
			x = "6.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
			y = "8.4 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "27 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class Content: RscControlsGroup
		{
			idc = 10003;
			x = "7 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
			y = "10 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "26 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "5.5 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class controls{};
		};
		class ButtonOK: RscButtonMenuOK
		{
			x = "28.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
			y = "16.1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class ButtonCustom: RscButtonMenu
		{
			idc = 10006;
			x = "23.4 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
			y = "16.1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
		class ButtonCancel: RscButtonMenuCancel
		{
			x = "6.5 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
			y = "16.1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "5 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
	};
};

class MCC_RscCuratorCombo: RscControlsGroupNoScrollbars
{
	idc = 115002;
	x = "7 * 			(			((safezoneW / safezoneH) min 1.2) / 40) + 			(safezoneX)";
	y = "10 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 			(safezoneY + safezoneH - 			(			((safezoneW / safezoneH) min 1.2) / 1.2))";
	w = "26 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
	h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	class controls
	{
		class Title: RscText
		{
			idc = -1;
			text = "";
			x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "10 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.5};
		};
		class Value: RscCombo
		{
			idc = 115003;
			wholeHeight = 0.3;
			x = "10.1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "15.9 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
	};
};

class MCC_RscCuratorCheckBox: RscControlsGroupNoScrollbars
{
	idc = 115004;
	x = "7 * 			(			((safezoneW / safezoneH) min 1.2) / 40) + 			(safezoneX)";
	y = "10 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 			(safezoneY + safezoneH - 			(			((safezoneW / safezoneH) min 1.2) / 1.2))";
	w = "26 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
	h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
	class controls
	{
		class Title: RscText
		{
			idc = -1;
			text = "";
			x = "0 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "10 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			colorBackground[] = {0,0,0,0.5};
		};
		class Value: RscCheckBox
		{
			idc = 115005;
			wholeHeight = 0.3;
			x = "10.1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			y = "0 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			w = "2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
		};
	};
};

class cfgVehicles
{
	class Logic;
	class Module_F;
	
	class mcc_sandbox_module : Module_F
	{
		category = "MCC";
		author = "shay_gman";
		displayName = "Access Rights";
		icon = "\mcc_sandbox_mod\data\mcc_access.paa";
		picture = "\mcc_sandbox_mod\data\mcc_access.paa";
		vehicleClass = "Modules";
		function = "MCC_fnc_accessRights";
		scope = 2;
		isGlobal = 1;
		
		class Arguments
		{
			class names
			{
				displayName = "MCC Operators";
				description = "Enter the player's UID of the players that will have access to MCC. Example ['123213',12312321','1322131231']";
				defaultValue = "[]";
			};
		};
	};
	
	class mcc_sandbox_moduleSF : Module_F
	{
		category = "MCC";
		author = "shay_gman";
		displayName = "Special Forces";
		icon = "\mcc_sandbox_mod\data\mcc_sf.paa";
		picture = "\mcc_sandbox_mod\data\mcc_sf.paa";
		vehicleClass = "Modules";
		function = "MCC_fnc_SF";
		scope = 2;
		isGlobal = 1;
		
		class Arguments
		{
			class hcam_goggles
			{
				displayName = "Display Goggles";
				description = "Goggles needed to watch the live feed camera by defaul 'G_Tactical_Clear'. enter as array ['G_Tactical_Clear',G_Tactical_Clear2'...]";
				defaultValue = "[]";
			};
			
			class hcam_headgear
			{
				displayName = "Headger Needed";
				description = "Headger needed to broadcast the live feed camera by live empty to all or enter as array ['H_Cap_red',H_HelmetB'...]";
				defaultValue = "[]";
			};
		};
	};
	
	class mcc_sandbox_moduleRestrictedZone : Module_F
	{
		category = "MCC";
		author = "shay_gman";
		displayName = "Restricted zones";
		function = "MCC_fnc_createRestrictedZones";
		scope = 2;
		isGlobal = 1;
		isTriggerActivated = 1;
		
		class Arguments
		{
			class markerNames
			{
				displayName = "Restricted Markers";
				description = "Enter the markers' names controled by this module as array ['marker1',marker2'...]";
				defaultValue = "[]";
			};
			
			class sides
			{
				displayName = "Restricted Sides";
				description = "Enter the restricted sides as array [west,east,resistance,civlian]";
				class values
				{
					class All
					{
						name = "All";
						value = -1;
						default = 1;
					};
					class BLUFOR
					{
						name = "$STR_WEST";
						value = 1;
					};
					class OPFOR
					{
						name = "$STR_EAST";
						value = 0;
					};
					class Independent
					{
						name = "$STR_GUERRILA";
						value = 2;
					};
					class Civilian
					{
						name = "$STR_CIVILIAN";
						value = 3;
					};
				};
			};
			
			class time
			{
				displayName = "Time Before Punishment";
				description = "How much time in seconds should elapsed before the player will be punished";
				defaultValue = "10";
			};
			
			class inside
			{
				displayName = "Punished inside the zone";
				description = "Should the players be punished for staying inside the zone or outside";
				class values
				{
					class Enabled
					{
						name = "Inside";
						value = 0;
						default = 1;
					};
					class Disabled
					{
						name = "Outside";
						value = 1;
					};
				};
			};
			
			class air
			{
				displayName = "Air Vehicles";
				description = "Should air vehicles be punished";
				class values
				{
					class Enabled
					{
						name = "Yes";
						value = 0;
						default = 1;
					};
					class Disabled
					{
						name = "No";
						value = 1;
					};
				};
			};
			
			class hide
			{
				displayName = "Hide markers";
				description = "Hide markers after mission init";
				class values
				{
					class Disabled
					{
						name = "No";
						value = 0;
						default = 1;
					};
					class Enabled
					{
						name = "Yes";
						value = 1;
					};
				};
			};
		};
	};
};


class cfgWeapons
{
	class Default;
	
	class itemCore;
	
	class B_UavTerminal;
	
	class MCC_Console : B_UavTerminal 
	{
	displayName = "MCC Tactical Commander Console (M-Tac)";
	picture = "\mcc_sandbox_mod\data\console_small.paa";
	descriptionShort = "Tactical PDA";
	scope = 2;
	};
};