class MCC_Module_atmosphere : Module_F
{
	scope = 2;
	isGlobal = 0;
	category = "MCC";
	displayName = "Atmosphere";
	function = "MCC_fnc_curatorAtmoshphere";
	class Arguments
	{
		class atmosphere
		{
			displayName = "Atmosphere";
			typeName = "NUMBER";
			class values
			{
				class Sandstorm
				{
					name = "Sandstorm";
					value = 14;
					default = 1;
				};
				class Blizzard
				{
					name = "Blizzard";
					value = 15;
				};
				class Independent
				{
					name = "Heat Wave";
					value = 16;
				};
			};
		};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Create visuals atmospheres";
		sync[] = {};
	};
};