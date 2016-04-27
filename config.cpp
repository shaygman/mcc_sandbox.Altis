class CfgPatches 
{

	class mcc_sandbox 
	{
		units[] = {"mcc_sandbox_module","mcc_sandbox_moduleSF","mcc_sandbox_moduleRestrictedZone","mcc_sandbox_moduleUndercover","MCC_Module_AAS"};
		weapons[] = {};
		requiredVersion = 1.00;
		requiredAddons[] = {"A3_Modules_F"};
		author[] = {"shay_gman"};
		versionDesc = "MCC Sandbox 4";
		version = "1.1";
	};

	class mcc_sandbox_curatorExp
	{
		units[] = {"MCC_Module_Base","MCC_Module_addUnitsToZeusCurator","MCC_Module_ambientCiviliansCurator","MCC_Module_MCCCASCurator","MCC_Module_createEvacCurator","MCC_Module_createIEDCurator","MCC_Module_createArmedCivilianCurator","MCC_Module_nightEffectsCurator","MCC_Module_lockDoorsCurator","MCC_Module_atmosphereCurator","MCC_Module_warZoneCurator","MCC_Module_garrisonBuildingsCurator","MCC_Module_damagePartCurator","MCC_Module_vehicleSpawnerCurator","MCC_Module_campaignInitCurator","MCC_Module_setResourcesCurator","MCC_Module_underCoverCurator"};
		weapons[] = {};
		requiredVersion = 1.00;
		author[] = {"shay_gman"};
		versionDesc = "MCC Sandbox 4 curator expension";
		version = "1";
	};
	
	class SUP_flash
	{
		units[] = {};
		weapons[] = {"SUPER_arifle_MX_GL_F"};
		requiredAddons[] = {"A3_characters_F","A3_Data_F"};
	};
};	

class CfgMods
{
	class mcc_sandbox
	{
		dir = "@mcc_sandbox_a3";
		name = "MCC Sandbox";
		action = "http://mccsandbox.wikia.com/wiki/MCCSandbox_Wiki";
		actionName = "Website";		
		tooltip = "MCC Sandbox";
		overview = "Mission Control Center is a powerful game mode that let the ArmA player complete freedom as a mission maker. <br />With MCC you can build complected missions the way you wanted in few minutes and save them as a mission file or in your profile to share with friends. <br />MCC have a dynamic AI system that called GAIA that gives AI more human like tactics while they flank, support and use CAS or artillery.  MCC holds unique mission generator so if you can just push in some variables and MCC will generate a complete random mission set to your play-style and the amount of players and objectives needed. MCC holds much more as unique: IED, CAS, Evac Helicopters aproch, air drops, 3D editor, persistence database for players levels and achievements and many many more.";
		picture = "mcc_sandbox_mod\data\mod.paa";
		logo = "mcc_sandbox_mod\data\mod.paa";
		logoOver = "mcc_sandbox_mod\data\mod.paa";
		logoSmall = "mcc_sandbox_mod\data\mod.paa";
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