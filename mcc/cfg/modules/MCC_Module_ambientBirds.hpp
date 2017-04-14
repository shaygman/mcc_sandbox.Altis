class MCC_Module_ambientBirds : Module_F
{
	category = "MCC";
	displayName = "Ambient Birds";
	function = "MCC_fnc_ambientBirdsSpawnInit";
	scope = 2;
	isGlobal = 0;

	class Attributes: AttributesBase
	{
		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Enables spawning random flocks of birds when units get close to trees";
	};
};