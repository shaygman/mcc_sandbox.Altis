class MCC_module_ambientFire : Module_F
{
	category = "MCC";
	displayName = "Ambient Fire";
	function = "MCC_fnc_ambientFireInit";
	scope = 2;
	isGlobal = 0;

	class Attributes: AttributesBase
	{
		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Explosives and destroyed vehicles will propagate fire";
	};
};