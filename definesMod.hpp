#define MCCPATH "\mcc_sandbox_mod\"
#define MCCVersion "0.1"
#define MCCMODE true

//--------------------------Dialogs----------------------------------------------------
#include "\mcc_sandbox_mod\mcc\dialogs\mcc_dialogs.hpp"

#include "\mcc_sandbox_mod\mcc\dialogs\mcc_saveLoadScreen.hpp"
#include "\mcc_sandbox_mod\mcc\dialogs\mcc_3d_dialog.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_boxGen.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_groupsGen.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_loginDialog.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_MWMainDialog.hpp"

//----Console-----------------
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_playerConsole.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\MCC_playerConsole2.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\MCC_playerConsole3.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_playerConsoleLoading.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_missionSettings.hpp"

//----PDA-----------------
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_SQLPDA.hpp"

//----Mission Wizard-----------------
#include "\mcc_sandbox_mod\mcc\Dialogs\MCCMW_briefingMap.hpp"

//----Curator-----------------
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_curatorInitDefines.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_curatorInit.hpp"

//----Logistics-----------------
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_logisticsLoadTruck.hpp"
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_logisticsBaseBuild.hpp"

//----Interaction-----------------
#include "\mcc_sandbox_mod\mcc\Dialogs\mcc_interactionMenu.hpp"

//--------------------------------CP------------------------------------------------
#define CPPATH "\mcc_sandbox_mod\"
#define CPVersion "0.1"

#include "\mcc_sandbox_mod\configs\dialogs\cp_dialogs.hpp"
#include "\mcc_sandbox_mod\configs\dialogs\gearPanel\respawnPanel.hpp"
#include "\mcc_sandbox_mod\configs\dialogs\gearPanel\squadsPanel.hpp"
#include "\mcc_sandbox_mod\configs\dialogs\gearPanel\gearPanel.hpp"
#include "\mcc_sandbox_mod\configs\dialogs\gearPanel\weaponsPanel.hpp"
#include "\mcc_sandbox_mod\configs\dialogs\gearPanel\accessoriesPanel.hpp"
#include "\mcc_sandbox_mod\configs\dialogs\gearPanel\uniformPanel.hpp"

//--------------------------Others----------------------------------------------------
#include "\mcc_sandbox_mod\bon_artillery\dialog\Artillery.hpp"
#include "\mcc_sandbox_mod\VAS\menu.hpp"
#include "\mcc_sandbox_mod\spectator\spectating.hpp"
#include "\mcc_sandbox_mod\hcam\hcam.hpp"

//--------------------------Cfg----------------------------------------------------
class CfgFunctions
{
	#include "\mcc_sandbox_mod\gaia\cfgFunctions.hpp"
	#include "\mcc_sandbox_mod\mcc\cfg\cfgFunctions.hpp"
	#include "\mcc_sandbox_mod\VAS\cfgFunctions.hpp"
	
	//super_flash
	#include "\mcc_sandbox_mod\super_flash\CfgFunctions.hpp"
};

class CfgObjectCompositions
{
	#include "\mcc_sandbox_mod\mcc\cfg\CfgObjectCompositions.hpp"
};

class CfgMusic
{
	#include "\mcc_sandbox_mod\mcc\cfg\CfgMusic.hpp"
	
	//super_flash
	#include "\mcc_sandbox_mod\super_flash\music\CfgMusic.hpp"
};

class CfgSounds
{
	#include "\mcc_sandbox_mod\mcc\cfg\CfgSounds.hpp"
	
	//super_flash
	#include "\mcc_sandbox_mod\super_flash\sounds\CfgSounds.hpp"
};

class CfgCloudlets
{
	//super_flash
	class Default;
	#include "\mcc_sandbox_mod\super_flash\CfgCloudlets.hpp"
};

class CfgLights
{
	//super_flash
	#include "\mcc_sandbox_mod\super_flash\CfgLights.hpp"
};

class CfgNotifications
{
	#include "\mcc_sandbox_mod\mcc\cfg\CfgNotifications.hpp"
};

class RscTitles
{
	#include "\mcc_sandbox_mod\mcc\dialogs\mcc_InteractionRsc.hpp"
	#include "\mcc_sandbox_mod\mcc\dialogs\compass.hpp"
	#include "\mcc_sandbox_mod\hcam\hcam.hpp"
};


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
	class Module_F: Logic
	{
		class ArgumentsBaseUnits
		{
			class Units;
		};
		class ModuleDescription
		{
			class AnyBrain;
			class EmptyDetector; 
		};
	};
	
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
		
		class ModuleDescription: ModuleDescription
		{
			description = "Who will have MCC access. Enter the players UID as an array  Example ['123213',12312321','1322131231'] or sync with roles"; // Short description, will be formatted as structured text
			sync[] = {"BLUFORunit"};
	 
			class BLUFORunit
			{
				description[] = { // Multi-line descriptions are supported
					"Sync with any player's role that you want to have MCC access"
				};
				displayName = "MCC Contoller"; // Custom name
				icon = "iconMan"; // Custom icon (can be file path or CfgVehicleIcons entry)
				optional = 1; // Synced entity is optional
				duplicate = 1; // Multiple entities of this type can be synced
				synced[] = {"AnyBrain"}; // Pre-define entities like "AnyBrain" can be used. See the list below
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
			class hcam_actionKey
  			{
				displayName = "User custom key:"; 
				description = "Which user's custom key will activate the helmet cam"; 
				typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
				class values
				{
					class 1key	{name = "Use Action 1";	value = 1; default = 1;};
					class 2key	{name = "Use Action 2"; value = 2;};
					class 3key	{name = "Use Action 3"; value = 3;};
					class 4key	{name = "Use Action 4"; value = 4;};
					class 5key	{name = "Use Action 5"; value = 5;};
					class 6key	{name = "Use Action 6"; value = 6;};
					class 7key	{name = "Use Action 7"; value = 7;};
					class 8key	{name = "Use Action 8"; value = 8;};
					class 9key	{name = "Use Action 9"; value = 9;};
					class 10key	{name = "Use Action 10"; value = 10;};
					class 11key	{name = "Use Action 11"; value = 11;};
					class 12key	{name = "Use Action 12"; value = 12;};
					class 13key	{name = "Use Action 13"; value = 13;};
					class 14key	{name = "Use Action 14"; value = 14;};
					class 15key	{name = "Use Action 15"; value = 15;};
					class 16key	{name = "Use Action 16"; value = 16;};
					class 17key	{name = "Use Action 17"; value = 17;};
					class 18key	{name = "Use Action 18"; value = 18;};
					class 19key	{name = "Use Action 19"; value = 19;};
					class 20key	{name = "Use Action 20"; value = 20;};
				};
			};
			
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
		
		class ModuleDescription: ModuleDescription
		{
			description = "Sync to any player role to gain access to the helmet camera";
			sync[] = {"BLUFORunit"};
	 
			class BLUFORunit
			{
				description[] = { 
					"Sync with any player's role"
				};
				displayName = "SF Team camera"; 
				icon = "iconMan"; 
				optional = 1; 
				duplicate = 1;
				synced[] = {"AnyBrain"}; 
			};
		};
	};
	
	class mcc_sandbox_moduleRestrictedZone : Module_F 
	{
		category = "MCC";
		author = "shay_gman";
		displayName = "Restricted zones";
		function = "MCC_fnc_createRestrictedZones";
		picture = "\mcc_sandbox_mod\data\mccModule.paa";
		_generalMacro = "ModuleZoneRestriction_F";
		scope = 2;
		isGlobal = 2;
		isTriggerActivated = 1;
		
		class Arguments
		{
			class sides
			{
				displayName = "Restricted Sides";
				description = "Enter the restricted sides as array [west,east,resistance,civlian]";
				typeName = "NUMBER";
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
				typeName = "NUMBER";
				defaultValue = 10;
			};
			
			class inside
			{
				displayName = "Punished inside the zone";
				description = "Should the players be punished for staying inside the zone or outside";
				typeName = "BOOL";
				class values
				{
					class Enabled
					{
						name = "Inside";
						value = false;
						default = 1;
					};
					class Disabled
					{
						name = "Outside";
						value = true;
					};
				};
			};
			
			class air
			{
				displayName = "Air Vehicles";
				description = "Should air vehicles be punished";
				typeName = "BOOL";
				class values
				{
					class Enabled
					{
						name = "Yes";
						value = false;
						default = 1;
					};
					class Disabled
					{
						name = "No";
						value = true;
					};
				};
			};
			
			class hide
			{
				displayName = "Create markers";
				description = "Create markers on the triggers locations";
				typeName = "BOOL";
				class values
				{
					class Disabled
					{
						name = "No";
						value = false;
					};
					class Enabled
					{
						name = "Yes";
						value = true;
						default = 1;
					};
				};
			};
		};
		
		class ModuleDescription: ModuleDescription
		{
			description = "Create restricted areas";
			sync[] = {"LocationArea_F"};
	 
			class LocationArea_F
			{
				description[] = { 
					"Sync with any trigger"
				};
				optional = 1; 
				duplicate = 1;
				synced[] = {"EmptyDetector"}; 
			};
		};
	};
	
	class mcc_sandbox_moduleILS : Module_F
	{
		category = "MCC";
		author = "shay_gman";
		displayName = "(ILS)Instrument Landing System";
		icon = "\mcc_sandbox_mod\data\mcc_ils.paa";
		picture = "\mcc_sandbox_mod\data\mcc_ils.paa";
		vehicleClass = "Modules";
		function = "";
		scope = 2;
		isGlobal = 1;
		
		class Arguments
		{
			class MCC_runwayName
			{
				displayName = "Runway Name";
				description = "Runway Name display in ILS";
				typeName = "STRING";
				defaultValue = "Runway";
			};
			
			class MCC_runwayDis
			{
				displayName = "Runway Length";
				description = "Runway length in meters";
				typeName = "NUMBER";
				class values
				{
					class L100
					{
						name = "100 meters";
						value = 100;
					};
					class L200
					{
						name = "200 meters";
						value = 200;
						default = 1;
					};
					class L300
					{
						name = "300 meters";
						value = 300;
					};
				};
			};
			
			class MCC_runwaySide
			{
				displayName = "Allowed Sides";
				description = "Only specific sides can use this airfield";
				typeName = "NUMBER";
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
			
			class MCC_runwayCircles
			{
				displayName = "Circles Helpers";
				description = "Allow virtual circles to show the landing path";
				typeName = "BOOL";
				class values
				{
					class Enabled
					{
						name = "On";
						value = true;
						default = 1;
					};
					class Disabled
					{
						name = "Off";
						value = false;
					};
				};
			};
		};
		
		class ModuleDescription: ModuleDescription
		{
			description = "Place ILS module on each runway's start facing the same diraction as the runway";
		};
	};
	
	class Box_NATO_AmmoVeh_F;
	class MCC_crateAmmo : Box_NATO_AmmoVeh_F
	{
		displayName = "Ammo Crate";
		maximumLoad = 600;
		transportAmmo = 12000;
	};

	class MCC_crateSupply : Box_NATO_AmmoVeh_F
	{
		displayName = "Supply Crate";
		maximumLoad = 600;
		transportAmmo = 0;
		transportRepair = 90000;
		model = "\A3\Structures_F_EPA\Mil\Scrapyard\PaperBox_closed_F.p3d";
	};
	
	class MCC_crateFuel : Box_NATO_AmmoVeh_F
	{
		displayName = "Fuel Barrel";
		maximumLoad = 600;
		transportAmmo = 0;
		transportFuel = 500;
		model = "\A3\Structures_F\Items\Vessels\WaterBarrel_F.p3d";
	};
};



class CfgAmmo
{
	//super_flash
	class GrenadeHand;
	class G_40mm_HE;
	#include "\mcc_sandbox_mod\super_flash\CfgAmmo.hpp"
};

class cfgMagazines
{
	class Default;
	class CA_Magazine: Default{};
	class HandGrenade: CA_Magazine{};
	class 1Rnd_HE_Grenade_shell;
	
	#include "\mcc_sandbox_mod\mcc\cfg\cfgMagazines.hpp"
	
	//super_flash
	#include "\mcc_sandbox_mod\super_flash\cfgMagazines.hpp"
};
	
class cfgWeapons
{
	class Default;
	class GrenadeLauncher: Default{};
	class arifle_MX_GL_F;
	class itemCore;
	class InventoryItem_Base_F;
	class Launcher_Base_F; 
	#include "\mcc_sandbox_mod\mcc\cfg\cfgWeapons.hpp"
	
	//super_flash
	#include "\mcc_sandbox_mod\super_flash\CfgWeapons.hpp"
};