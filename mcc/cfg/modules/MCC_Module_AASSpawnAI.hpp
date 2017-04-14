class MCC_Module_AASSpawnAI : Module_F
{
	category = "MCC";
	displayName = "(PvP)AAS Spawn AI";
	function = "MCC_fnc_aas_AIspawn";
	scope = 2;
	isGlobal = 0;

	class Attributes: AttributesBase
	{
		class faction1 : Edit
		{
			displayName = "Spawn Faction";
			description = "As defined in cfgFaction";
			defaultValue = """BLU_F""";
			property = "faction1";
		};

		class enemySide : Combo
		{
			displayName = "Enemy Side";
			description = "Who are we fighting";
			typeName = "NUMBER";
			property = "enemySide";

			class values
			{
				class BLUFOR
				{
					name = "$STR_WEST";
					value = 1;
					default = 1;
				};
				class OPFOR
				{
					name = "$STR_EAST";
					value = 0;
				};
				class Independent
				{
					name = "$STR_GUERRILA";
					value = 2;
				};
			};
		};

		class autoBalance : Checkbox
		{
			displayName = "Auto balance AI";
			description = "Auto balance the number of AI to players";
			property = "autoBalance";
		};

		class minAI : Edit
		{
			displayName = "Minimum number of AI per side";
			description = "Minimum number of AI no matter how many players";
			typeName = "NUMBER";
			defaultValue = 10;
			property = "minAI";
		};

		class spawnAIDefensive : Checkbox
		{
			displayName = "Spawn at Sectors";
			description = "Spawn AI on captured sectors or just at start location";
			typeName = "BOOL";
			property = "spawnAIDefensive";
		};

		class searchRadius : Edit
		{
			displayName = "Search Vehicles Radius";
			description = "How far AI will look for empty vehicles around the spawn point";
			typeName = "NUMBER";
			defaultValue = 300;
			property = "searchRadius";
		};

		class useRoles : Checkbox
		{
			displayName = "Use MCC roles gear";
			description = "AI will use roles kits as defined in MCC_loadouts";
			typeName = "BOOL";
			property = "useRoles";
		};

		class spawnVehicles : Checkbox
		{
			displayName = "Spawn Vehicles";
			description = "AI will spawn vehicles equals to the enemy vehicels";
			typeName = "BOOL";
			property = "spawnVehicles";
		};

		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Spawn AI that will try to conquer enemy sectors in MCC AAS";
		position = 1;
	};
};