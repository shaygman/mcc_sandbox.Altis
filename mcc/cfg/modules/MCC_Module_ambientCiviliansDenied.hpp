class MCC_Module_ambientCiviliansDenied : Module_F
{
	category = "MCC";
	displayName = "Ambient units(Restrict)";
	function = "MCC_fnc_ambientDenied";
	scope = 2;
	isGlobal = 0;

	class Arguments
	{
		class radius
		{
			displayName = "Radius";
			typeName = "NUMBER";
			defaultValue = 500;
		};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Server side: deny ambient AI spawn in this area";
	};
};