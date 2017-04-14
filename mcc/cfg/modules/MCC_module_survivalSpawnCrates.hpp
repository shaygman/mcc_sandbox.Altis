class MCC_module_survivalSpawnCrates : Module_F
{
	scope = 2;
	isGlobal = 1;
	category = "MCC";
	author = "shay_gman";
	displayName = "Survival: Spawn loot in buildings";
	function = "MCC_fnc_spawnCratesInHousesInit";
	icon = "\mcc_sandbox_mod\data\mccModule.paa";
	picture = "\mcc_sandbox_mod\data\mccModule.paa";
	vehicleClass = "Modules";

	class Attributes: AttributesBase
	{
		class radius : Edit
		{
			displayName = "Radius";
			description = "Radius in meters around the module";
			typeName = "NUMBER";
			defaultValue = 300;
			property = "radius";
		};

		class density : Edit
		{
			displayName = "Density";
			description = "density in 1-10 where 10 is max";
			typeName = "NUMBER";
			defaultValue = 3;
			property = "density";
		};

		class markers : Checkbox
		{
			displayName = "Markers";
			description = "Create markers";
			typeName = "BOOL";
			property = "markers";
		};

		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Spawn loot crates in buildings either around the module or in any of the synced triggers";
		sync[] = {"TriggerArea"};

		class TriggerArea
		{
			description[] = {
				"Sync triggers with the module",
				"Spawns loot in buildings"
			};
			area = 1;
			position = 1;
			direction = 1;
			optional = 0;
			duplicate = 0;
			vehicle = "EmptyDetector";
		};
	};
};