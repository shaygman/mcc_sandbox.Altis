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
	icon = "\mcc_sandbox_mod\data\mccModule.paa";
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
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "Off";
					value = 0;
				};
			};
		};
	};
	
	class ModuleDescription: ModuleDescription
	{
		description = "Place ILS module on each runway's start facing the same diraction as the runway";
	};
};

class mcc_sandbox_moduleStartLocations : Module_F
{
	category = "MCC";
	author = "shay_gman";
	displayName = "Start Location";
	icon = "\mcc_sandbox_mod\data\mccModule.paa";
	picture = "\mcc_sandbox_mod\data\mccModule.paa";
	vehicleClass = "Modules";
	function = "MCC_fnc_buildSpawnPoint";
	scope = 2;
	isGlobal = 1;
	
	class Arguments
	{
		class side
		{
			displayName = "Side";
			typeName = "NUMBER";
			class values
			{
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
			};
		};
		
		class size
		{
			displayName = "Tyoe";
			typeName = "STRING";
			class values
			{
				class fob
				{
					name = "F.O.B";
					value = "FOB";
					default = 1;
				};
				class Disabled
				{
					name = "Main";
					value = "MAIN";
				};
			};
		};
		
		class distractable
		{
			displayName = "Distractable";
			typeName = "BOOL";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};
	};
	
	class ModuleDescription: ModuleDescription
	{
		description = "Place start module to predefine MCC's start locations";
	};
};

class mcc_sandbox_moduleMissionSettings : Module_F
{
	category = "MCC";
	author = "shay_gman";
	displayName = "Settings (MCC)";
	icon = "\mcc_sandbox_mod\data\mccModule.paa";
	picture = "\mcc_sandbox_mod\data\mccModule.paa";
	vehicleClass = "Modules";
	function = "MCC_fnc_missionSettings";
	scope = 2;
	isGlobal = 1;
	
	class Arguments
	{
		class t2t
		{
			displayName = "Teleport 2 Team";
			typeName = "NUMBER";
			class values
			{
				class disabled
				{
					name = "Disabled";
					value = 0;
				};
				class jip
				{
					name = "JIP Only";
					value = 1;
					default = 1;
				};
				class respawn
				{
					name = "After Respawn";
					value = 2;
				};
				class always
				{
					name = "Always";
					value = 3;
				};
			};
		};
		class saveGear
		{
			displayName = "Save Gear";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};
		class messages
		{
			displayName = "MCC messages";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};
		
		class nameTags
		{
			displayName = "Name Tags";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};
		
		class groupMarkers
		{
			displayName = "Group Markers";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};
		
		class artilleryComputer
		{
			displayName = "Artilery Computer";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};
		
		class timeAccel
		{
			displayName = "Time Acceleration";
			typeName = "NUMBER";
			class values
			{
				class disabled
				{
					name = "Disabled";
					value = 0;
					default = 1;
				};
				class tx5
				{
					name = "x5";
					value = 5;
				};
				class tx10
				{
					name = "x10";
					value = 2;
				};
				class tx15
				{
					name = "x15";
					value = 15;
				};
				class tx20
				{
					name = "x20";
					value = 20;
				};
			};
		};
		
		class deleteBody
		{
			displayName = "Delete dead players' bodies";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};
		
		class respawnMenu
		{
			displayName = "Respawn Menu";
			description = "Allow start location dialog on JIP or after respawn";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};
		
		class sqlPDA
		{
			displayName = "Squad Leader PDA";
			description = "Allow Squad Leader PDA";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};
		
		class commanderConsole
		{
			displayName = "Commander Console";
			description = "Allow Commander Console";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};
		
		class squadDialog
		{
			displayName = "Squad Dialog";
			description = "Players can open the squad dialog and form/change squads - requires key binding";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};
		
		class squadDialogPip
		{
			displayName = "Squad Dialog (camera)";
			description = "Player can inspect others from their squad in the Squad Dialog";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};
		
		class logistics
		{
			displayName = "Logistics";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};
		
		class interaction
		{
			displayName = "Interaction";
			description = "Players can use MCC interaction with objects/units - requires key binding";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};
	};
	
	class ModuleDescription: ModuleDescription
	{
		description = "Define MCC settings";
	};
};

class mcc_sandbox_moduleGAIASettings : Module_F
{
	category = "MCC";
	author = "shay_gman";
	displayName = "Settings (GAIA)";
	icon = "\mcc_sandbox_mod\data\mccModule.paa";
	picture = "\mcc_sandbox_mod\data\mccModule.paa";
	vehicleClass = "Modules";
	function = "MCC_fnc_GAIASettings";
	scope = 2;
	isGlobal = 1;
	
	class Arguments
	{
		class aiSkillGen
		{
			displayName = "AI Skill(overall)";
			typeName = "NUMBER";
			class values
			{
				class rookie
				{
					name = "Rookie";
					value = 0.1;
				};
				class moderate
				{
					name = "Moderate";
					value = 0.4;
					default = 1;
				};
				class vetran
				{
					name = "Vetran";
					value = 0.8;
				};
			};
		};
		
		class aiSkillAim : aiSkillGen
		{
			displayName = "AI Skill(Aim)";
		};
		
		class aiSkillSpot : aiSkillGen
		{
			displayName = "AI Skill(Spot)";
		};
		
		class aiSkillCommand : aiSkillGen
		{
			displayName = "AI Skill(Command)";
		};
		
		class aiSmoke
		{
			displayName = "AI use smoke/flare";
			typeName = "BOOL";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};
		
		class aiSmokeChance
		{
			displayName = "Smoke/flares Chance";
			description = "Define how ofter AI will use smoke/flares";
			typeName = "NUMBER";
			class values
			{
				class low
				{
					name = "Low";
					value = 0;
				};
				class normal
				{
					name = "Normal";
					value = 1;
					default = 1;
				};
				class high
				{
					name = "High";
					value = 2;
				};
			};
		};
		
		class cacheDistance
		{
			displayName = "Cache Distance";
			description = "How far any player should be from a unit before it cached";
			typeName = "NUMBER";
			class values
			{
				class low
				{
					name = "1500";
					value = 1500;
				};
				class normal
				{
					name = "3000";
					value = 3000;
					default = 1;
				};
				class high
				{
					name = "6000";
					value = 6000;
				};
			};
		};
		
		class gaiacontrol
		{
			displayName = "GAIA Controlls";
			description = "If set to everyone GAIA will give order to all units availables even players";
			typeName = "BOOL";
			class values
			{
				class Enabled
				{
					name = "Only GAIA units";
					value = 0;
					default = 1;
				};
				class Disabled
				{
					name = "Everyone";
					value = 1;
				};
			};
		};
	};
	
	class ModuleDescription: ModuleDescription
	{
		description = "Define MCC settings";
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