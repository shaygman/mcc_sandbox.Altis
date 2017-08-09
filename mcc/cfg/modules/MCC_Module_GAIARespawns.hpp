class MCC_Module_GAIARespawns : Module_F
{
	category = "MCC";
	displayName = "Group Respawns";
	function = "MCC_fnc_curatorGAIARespawn";
	scope = 2;
	isGlobal = 0;

	class Attributes : AttributesBase
	{
		class Respawns : Edit
		{
			displayName = "Respawns";
			description = "How many time can the group respawn";
			typeName = "NUMBER";
			defaultValue = 5;
			property = "Respawns";
		};

		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Sync it with any unit or group to respawn the group when all units in the group dead";
		sync[] = {"Anything"};

		class Anything
		{
			description = "Any group/unit.";
			displayName = "Any group/unit";
			side = 4;
			position = 1;
			direction = 1;
			optional = 0;
			duplicate = 1;
		};
	};
};