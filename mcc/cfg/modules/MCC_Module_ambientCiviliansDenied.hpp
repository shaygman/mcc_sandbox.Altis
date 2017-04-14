class MCC_Module_ambientCiviliansDenied : Module_F
{
	category = "MCC";
	displayName = "Ambient units(Restrict)";
	function = "MCC_fnc_ambientDenied";
	scope = 2;
	isGlobal = 0;

	class Attributes: AttributesBase
	{
		class radius : Edit
		{
			displayName = "Radius";
			typeName = "NUMBER";
			defaultValue = 500;
			property = "radius";
		};

		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Server side: deny ambient AI spawn in this area";
	};
};