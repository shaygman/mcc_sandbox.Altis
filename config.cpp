class CfgPatches {

	class mcc_sandbox {
		units[] = {};
		weapons[] = {};
		requiredVersion = 1.00;
		requiredAddons[] = {};
		author[] = {"shay_gman"};
		versionDesc = "MCC Sandbox 4";
		version = "1";
	};
};	

class CfgMissions {

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

class cfgVehicles
{
	class Logic ;

	class mcc_sandbox_module : Logic
	{
		displayName = "(MCC Sandbox) Access Rights";
		icon = "\mcc_sandbox_mod\data\mcc_access.paa";
		picture = "\mcc_sandbox_mod\data\mcc_access.paa";
		vehicleClass = "Modules";

		class Eventhandlers {
		init = "_ok = _this execVM '\mcc_sandbox_mod\init_moduleAcess.sqf'";
		};
	};
	
	class mcc_sandbox_moduleSF : Logic
	{
		displayName = "(MCC Sandbox) Special Forces";
		icon = "\mcc_sandbox_mod\data\mcc_sf.paa";
		picture = "\mcc_sandbox_mod\data\mcc_sf.paa";
		vehicleClass = "Modules";

		class Eventhandlers {
		init = "_ok = _this execVM '\mcc_sandbox_mod\init_moduleSF.sqf'";
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