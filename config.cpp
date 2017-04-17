#include "BIS_AddonInfo.hpp"
class CfgPatches
{

	class mcc_sandbox
	{
		units[] = {"mcc_sandbox_module","mcc_sandbox_moduleSF","mcc_sandbox_moduleRestrictedZone","mcc_sandbox_moduleUndercover","MCC_Module_AAS","mcc_Module_createZones","MCC_Module_settingsMechanics","MCC_Module_settings","MCC_Module_settingsMedicSystem","MCC_Module_settingsRS","MCC_Module_ambientBirds","MCC_module_ambientFire","MCC_Module_createIntel","MCC_Module_LHDSpawn"};
		weapons[] = {};
		requiredVersion = 1.00;
		requiredAddons[] = {"A3_Modules_F"};
		author = "shay_gman";
		name = "MCC Sandbox";
		versionDesc = "MCC Sandbox 4";
		version = "1.1";
	};

	class mcc_sandbox_curatorExp
	{
		units[] = {"MCC_Module_Base","MCC_Module_addUnitsToZeusCurator","MCC_Module_ambientCiviliansCurator","MCC_Module_MCCCASCurator","MCC_Module_createEvacCurator","MCC_Module_createIEDCurator","MCC_Module_createArmedCivilianCurator","MCC_Module_nightEffectsCurator","MCC_Module_lockDoorsCurator","MCC_Module_atmosphereCurator","MCC_Module_warZoneCurator","MCC_Module_garrisonBuildingsCurator","MCC_Module_damagePartCurator","MCC_Module_vehicleSpawnerCurator","MCC_Module_campaignInitCurator","MCC_Module_setResourcesCurator","MCC_Module_underCoverCurator","MCC_Module_settingsInGameUICurator","MCC_Module_settingsMedicSystemCurator","MCC_Module_settingsCurator","MCC_Module_settingsMechanicsCurator","MCC_Module_settingsRSCurator","MCC_Module_ambientBirdsCurator","MCC_module_ambientFireCurator","MCC_module_survivalSpawnCratesCurator","MCC_Module_settingsGAIACurator","MCC_Module_createIntelCurator","MCC_Module_LHDSpawnCurator","MCC_Module_LHDSpawnMenuCurator"};
		weapons[] = {};
		requiredVersion = 1.00;
		author = "shay_gman";
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
		//Altis
		class MCC_CAMPAIGN_ALTIS
		{
			briefingName = "(MCC) Campaign";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_campaign.Altis";
		};

		class MCC_CAMPAIGN_ALTIS_CSAT
		{
			briefingName = "(MCC) Campaign CSAT";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_campaign_CSAT.Altis";
		};

		//Tanoa
		class MCC_CAMPAIGN_TANOA
		{
			briefingName = "(MCC) Campaign";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_campaign.Tanoa";
		};

		class MCC_CAMPAIGN_TANOA_CSAT
		{
			briefingName = "(MCC) Campaign CSAT";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_campaign_CSAT.Tanoa";
		};

		//Malden
		class MCC_CAMPAIGN_NOE_abel
		{
			briefingName = "(MCC) Campaign BAF";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_campaign_BAF.abel";
		};

		//noe
		class MCC_CAMPAIGN_NOE_BAF
		{
			briefingName = "(MCC) Campaign BAF";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_campaign_BAF.noe";
		};

		class MCC_CAMPAIGN_NOE_RU
		{
			briefingName = "(MCC) Campaign RU";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_campaign_RU.noe";
		};

		class MCC_campaign_GU_noe
		{
			briefingName = "(MCC) Campaign GU";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_campaign_GU.noe";
		};

		//Sara_dbe1
		class MCC_campaign_USMC_Sara_dbe1
		{
			briefingName = "(MCC) Campaign USMC";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_campaign_USMC.Sara_dbe1";
		};

		class MCC_campaign_RU_Sara_dbe1
		{
			briefingName = "(MCC) Campaign RU";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_campaign_RU.Sara_dbe1";
		};

		class MCC_campaign_GU_Sara_dbe1
		{
			briefingName = "(MCC) Campaign GU";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_campaign_GU.Sara_dbe1";
		};

		//Chernarus
		class MCC_campaign_USMC_Chernarus
		{
			briefingName = "(MCC) Campaign USMC";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_campaign_USMC.Chernarus";
		};

		class MCC_campaign_RU_Chernarus
		{
			briefingName = "(MCC) Campaign RU";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_campaign_RU.Chernarus";
		};

		class MCC_campaign_GU_Chernarus
		{
			briefingName = "(MCC) Campaign GU";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_campaign_GU.Chernarus";
		};

		//Chernarus summer
		class MCC_campaign_USA_Chernarus_Summer
		{
			briefingName = "(MCC) Campaign USA";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_campaign_USA.Chernarus_Summer";
		};

		class MCC_campaign_RU_Chernarus_Summer
		{
			briefingName = "(MCC) Campaign RU";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_campaign_RU.Chernarus_Summer";
		};

		class MCC_campaign_GU_Chernarus_Summer
		{
			briefingName = "(MCC) Campaign GU";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_campaign_GU.Chernarus_Summer";
		};

		//Takistan
		class MCC_campaign_USA_Takistan
		{
			briefingName = "(MCC) Campaign USA";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_campaign_USA.Takistan";
		};

		class MCC_campaign_TK_Takistan
		{
			briefingName = "(MCC) Campaign TK";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_campaign_TK.Takistan";
		};

		class MCC_campaign_GU_Takistan
		{
			briefingName = "(MCC) Campaign GU";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_campaign_GU.Takistan";
		};


		class MCC_TEMPLATE_ALTIS
		{
			briefingName = "(MCC) Template";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_Template.Altis";
		};

		class MCC_TEMPLATE_Chernarus
		{
			briefingName = "(MCC) Template";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_Template.Chernarus";
		};

		class MCC_TEMPLATE_ChernarusSummer
		{
			briefingName = "(MCC) Template";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_Template.Chernarus_Summer";
		};

		class MCC_TEMPLATE_fallujah
		{
			briefingName = "(MCC) Template";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_Template.fallujah";
		};

		class MCC_TEMPLATE_Kunduz
		{
			briefingName = "(MCC) Template";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_Template.Kunduz";
		};

		class MCC_TEMPLATE_lingor3
		{
			briefingName = "(MCC) Template";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_Template.lingor3";
		};

		class MCC_TEMPLATE_Mountains_ACR
		{
			briefingName = "(MCC) Template";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_Template.Mountains_ACR";
		};

		class MCC_TEMPLATE_Panthera3
		{
			briefingName = "(MCC) Template";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_Template.Panthera3";
		};

		class MCC_TEMPLATE_Sara
		{
			briefingName = "(MCC) Template";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_Template.Sara";
		};

		class MCC_TEMPLATE_Sara_dbe1
		{
			briefingName = "(MCC) Template";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_Template.Sara_dbe1";
		};

		class MCC_TEMPLATE_SaraLite
		{
			briefingName = "(MCC) Template";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_Template.SaraLite";
		};

		class MCC_TEMPLATE_STRATIS
		{
			briefingName = "(MCC) Template";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_Template.Stratis";
		};

		class MCC_TEMPLATE_Takistan
		{
			briefingName = "(MCC) Template";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_Template.Takistan";
		};

		class MCC_TEMPLATE_Tano
		{
			briefingName = "(MCC) Template";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_Template.Tanoa";
		};

		class MCC_TEMPLATE_utes
		{
			briefingName = "(MCC) Template";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_Template.utes";
		};

		class MCC_TEMPLATE_Woodland_ACR
		{
			briefingName = "(MCC) Template";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_Template.Woodland_ACR";
		};

		class MCC_TEMPLATE_Zargabad
		{
			briefingName = "(MCC) Template";
			directory = "mcc_sandbox_mod\sampleMissions\MCC_Template.Zargabad";
		};
	};
};

#include "\mcc_sandbox_mod\definesMod.hpp"