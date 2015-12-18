class CfgPatches 
{

	class mcc_sandbox 
	{
		units[] = {"mcc_sandbox_module","mcc_sandbox_moduleSF","mcc_sandbox_moduleRestrictedZone","mcc_sandbox_moduleUndercover","MCC_Module_captureZone","Box_MCC_medic","Box_MCC_miscItems","Box_MCC_tacticalItems","MCC_ammoBox","MCC_crateAmmo","MCC_crateSupply","MCC_crateFuel","MCC_crateAmmoBigWest","MCC_crateSupplyBigWest","MCC_crateFuelBigWest","MCC_crateAmmoBigEast","MCC_crateSupplyBigEast","MCC_crateFuelBigEast","MCC_Module_ambientCiviliansDenied","‏‏MCC_Module_vehicleRespawn","MCC_Module_inGameUI"};
		weapons[] = {"MCC_TentDome","MCC_TentA","MCC_ItemCore","MCC_Item","MCC_videoProbe","MCC_multiTool","MCC_axe_fire","MCC_axe","MCC_shovel","MCC_headTorch","MCC_ammoBoxMag","MCC_antibiotics","MCC_painkillers","MCC_bandage","MCC_epipen","MCC_salineBag","MCC_firstAidKit","MCC_waterpure","MCC_vitamine","MCC_fuelCan","MCC_fuelCan_empty","MCC_fuelbot","MCC_ductTape","MCC_butanetorch","MCC_oilcan","MCC_metalwire","MCC_carBat","MCC_screwdriver","MCC_matches","MCC_foodcontainer","MCC_cerealbox","MCC_bakedBeans","MCC_bakedBeans_open","MCC_bacon","MCC_bacon_open","MCC_rice","MCC_bottle_water","MCC_bottle_murky","MCC_bottle_empty","MCC_canteenWater","MCC_canteenMurky","MCC_canteen","MCC_powderedMilk","MCC_franta","MCC_RedGull","MCC_Spirit","MCC_can_dented","MCC_fruit1","MCC_fruit2","MCC_canOpener","MCC_wood","MCC_battery"};		
		requiredVersion = 1.00;
		requiredAddons[] = {"A3_Modules_F"};
		author[] = {"shay_gman"};
		versionDesc = "MCC Sandbox 4";
		version = "1.1";
	};

	class mcc_sandbox_curatorExp
	{
		units[] = {"MCC_Module_Base","MCC_Module_addUnitsToZeusCurator","MCC_Module_ambientCiviliansCurator","MCC_Module_MCCCASCurator","MCC_Module_createEvacCurator","MCC_Module_createIEDCurator","MCC_Module_createArmedCivilianCurator","MCC_Module_nightEffectsCurator","MCC_Module_lockDoorsCurator","MCC_Module_atmosphereCurator","MCC_Module_warZoneCurator","MCC_Module_garrisonBuildingsCurator","MCC_Module_damagePartCurator","MCC_Module_vehicleSpawnerCurator","MCC_Module_campaignInitCurator","MCC_Module_setResourcesCurator","MCC_Module_underCoverCurator","MCC_moduleCapturePoint","MCC_Module_ambientCiviliansCuratorDenied"};
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