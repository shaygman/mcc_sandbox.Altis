class CfgPatches 
{

	class mcc_sandbox 
	{
		units[] = {"mcc_sandbox_module","mcc_sandbox_moduleSF","mcc_sandbox_moduleRestrictedZone"};
		weapons[] = {};
		requiredVersion = 1.00;
		requiredAddons[] = {"A3_Modules_F"};
		author[] = {"shay_gman"};
		versionDesc = "MCC Sandbox 4";
		version = "1";
	};
	
	class SUP_flash
	{
		units[] = {};
		weapons[] = {"SUPER_arifle_MX_GL_F"};
		requiredAddons[] = {"A3_characters_F","A3_Data_F"};
	};
	
	class prpl_shoutgun
	{
		units[] = {};
		weapons[] = {"prpl_benelliBreach"};
		requiredVersion = 0.3;
		requiredAddons[] = {};
		version = "0.6";
		author = "Purple";
	};
	
	/*
	class A3_Modules_F_Curator_Objectives
	{
		requiredAddons[] = {"A3_Modules_F_Curator"};
		units[] = {"ModuleObjective_F","ModuleObjectiveSector_MCC","ModuleObjectiveMove_F","ModuleObjectiveSector_F","ModuleObjectiveAttackDefend_F","ModuleObjectiveNeutralize_F","ModuleObjectiveProtect_F","ModuleObjectiveGetIn_F"};
		weapons[] = {};
		requiredVersion = 1;
	};
	*/
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

//super_flash
#include "\mcc_sandbox_mod\super_flash\config.cpp"