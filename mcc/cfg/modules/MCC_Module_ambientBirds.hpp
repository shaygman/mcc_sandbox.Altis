class MCC_Module_ambientBirds : Module_F
{
	category = "MCC";
	displayName = "Ambient Birds";
	function = "MCC_fnc_ambientBirdsSpawnInit";
	scope = 2;
	isGlobal = 0;

	class ModuleDescription: ModuleDescription
	{
		description = "Spawn random flocks of birds when a unit get close to trees";
	};
};