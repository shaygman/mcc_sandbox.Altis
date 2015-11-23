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