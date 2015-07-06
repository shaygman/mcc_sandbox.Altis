class MCC_Module_Base : Module_F
{
	access = 0;
	author = "shay_gman";
	vehicleClass = "Modules";
	category = "MCC";
	icon = "\mcc_sandbox_mod\data\mccModule.paa";
	picture = "";
	portrait = "\mcc_sandbox_mod\data\mccModule.paa";

	scope = 1;
	scopeCurator = 1;

	displayName = "MCC Module";

	function = "";
	functionPriority = 1;
	isGlobal = 1;
	isTriggerActivated = 0;
	isDisposable = 0;


	class Arguments {};
	class ModuleDescription: ModuleDescription
	{
		description = "";
	};
};

class MCC_Module_addUnitsToZeus : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "Add To Zeus";
	function = "MCC_fnc_addToZeus";
};

class MCC_Module_ambientCivilians : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "Ambient units";
	function = "MCC_fnc_curatorAmbientCivilians";
};

class ModuleCASGun_F;
class MCC_Module_MCCCAS : ModuleCASGun_F
{
	scopeCurator = 2;
	curatorInfoType = "";
	icon = "\mcc_sandbox_mod\data\mccModule.paa";
	portrait = "\mcc_sandbox_mod\data\mccModule.paa";

	category = "MCC";
	displayName = "CAS";
	model = "\a3\Modules_F_Curator\CAS\surfaceGun.p3d";
	function = "MCC_fnc_curatorMCCCAS";
};

class MCC_Module_createEvac : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "Evac Vehicle";
	function = "MCC_fnc_curatorSetEvac";
};

class MCC_Module_createIED : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "IED/Suicide Bomber";
	function = "MCC_fnc_curatorSetIED";
};

class MCC_Module_createArmedCivilian : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "Armed Civilian";
	function = "MCC_fnc_curatorSetArmedCivilian";
};

class MCC_Module_nightEffects : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "Night Effects";
	function = "MCC_fnc_curatorNightEffects";
};

class MCC_Module_lockDoors : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "Doors Lock/Unlock";
	function = "MCC_fnc_curatorDoorLock";
};

class MCC_Module_atmosphere : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "Atmosphere";
	function = "MCC_fnc_curatorAtmoshphere";
};

class MCC_Module_warZone : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "War Zone Effect";
	function = "MCC_fnc_curatorWarZone";
};

class MCC_Module_garrisonBuildings : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "Garrison";
	function = "MCC_fnc_curatorGarrisonUnits";
};

class MCC_Module_damagePart : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "Damage Part";
	function = "MCC_fnc_curatorDamagePart";
};