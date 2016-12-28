class MCC_Module_AASSpawnAI : Module_F
{
	category = "MCC";
	displayName = "(PvP)AAS Spawn AI";
	function = "MCC_fnc_aas_AIspawn";
	scope = 2;
	isGlobal = 0;
	class Arguments
	{
		class faction1
		{
			displayName = "Spawn Faction";
			description = "As defined in cfgFaction";
			typeName = "STRING";
			defaultValue = "BLU_F";
		};

		class enemySide
		{
			displayName = "Enemy Side";
			description = "Who are we fighting";
			typeName = "NUMBER";
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

		class autoBalance
		{
			displayName = "Auto balance AI";
			description = "Auto balance the number of AI to players";
			typeName = "BOOL";
			class values
			{
				class Enabled
				{
					name = "Enable";
					value = true;
					default = 1;
				};
				class Disabled
				{
					name = "Disable";
					value = false;
				};
			};
		};

		class minAI
		{
			displayName = "Minimum number of AI per side";
			description = "Minimum number of AI no matter how many players";
			typeName = "NUMBER";
			defaultValue = 0;
		};

		class spawnAIDefensive
		{
			displayName = "Spawn on captured";
			description = "Spawn AI on captured sectors or just at start location";
			typeName = "BOOL";
			class values
			{
				class Enabled
				{
					name = "Enable";
					value = true;
					default = 1;
				};
				class Disabled
				{
					name = "Disable";
					value = false;
				};
			};
		};

		class searchRadius
		{
			displayName = "Search Radius";
			description = "How far AI will look for empty vehicles around the spawn point";
			typeName = "NUMBER";
			defaultValue = 300;
		};

		class useRoles
		{
			displayName = "Use MCC roles gear";
			description = "AI will use roles kits as defined in MCC_loadouts";
			typeName = "BOOL";
			class values
			{
				class Enabled
				{
					name = "Enable";
					value = true;
					default = 1;
				};
				class Disabled
				{
					name = "Disable";
					value = false;
				};
			};
		};

		class spawnVehicles
		{
			displayName = "Spawn Vehicles";
			description = "AI will spawn vehicles equals to the enemy vehicels";
			typeName = "BOOL";
			class values
			{
				class Enabled
				{
					name = "Enable";
					value = true;
					default = 1;
				};
				class Disabled
				{
					name = "Disable";
					value = false;
				};
			};
		};
	};
};