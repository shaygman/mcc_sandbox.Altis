class MCC_Module_campaignInit : Module_F
{
	scope = 2;
	isGlobal = 0;
	category = "MCC";
	displayName = "Campaign init";
	function = "MCC_fnc_curatorCampaignInit";

	class Attributes: AttributesBase
	{
		class factionPlayer : Edit
		{
			displayName = "Players Faction";
			description = "Config name";
			typeName = "STRING";
			defaultValue = """BLU_F""";
			property = "factionPlayer";
		};

		class factionRivalPlayer : Combo
		{
			displayName = "Rival Players Side";
			description = "Players on rival side will gain resources from killing main faction's players";
			typeName = "NUMBER";
			property = "factionRivalPlayer";

			class values
			{
				class none
				{
					name = "None";
					value = 7;
					default = 1;
				};
				class BLUFOR
				{
					name = "$STR_WEST";
					value = 1;
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
				class Civilian
				{
					name = "$STR_CIVILIAN";
					value = 3;
				};
			};
		};

		class factionEnemy : Edit
		{
			displayName = "Enemy Faction";
			typeName = "STRING";
			description = "Config name";
			defaultValue = """OPF_F""";
			property = "factionEnemy";
		};

		class factionCiv : Edit
		{
			displayName = "Civilian Faction";
			typeName = "STRING";
			description = "Config name";
			defaultValue = """CIV_F""";
			property = "factionCiv";
		};

		class missionMax : Combo
		{
			displayName = "Number of Missions";
			description = "Until Campaign Ends - 0 means no mission will be generated";
			typeName = "NUMBER";
			property = "missionMax";
			class values
			{
				class five
				{
					name = "5";
					value = 5;
				};
				class ten
				{
					name = "10";
					value = 10;
					default = 1;
				};
				class fifteen
				{
					name = "15";
					value = 15;
				};
				class unlimited
				{
					name = "unlimited";
					value = 9999;
				};
			};
		};

		class difficulty : Combo
		{
			displayName = "Difficulty";
			typeName = "NUMBER";
			property = "difficulty";

			class values
			{
				class easy
				{
					name = "Easy";
					value = 10;
				};
				class Medium
				{
					name = "Medium";
					value = 20;
					default = 1;
				};
				class Hard
				{
					name = "Hard";
					value = 40;
				};
			};
		};

		class tickets : Edit
		{
			displayName = "Starting Tickets";
			typeName = "NUMBER";
			defaultValue = 100;
			property = "tickets";
		};

		class missionRotation : Edit
		{
			displayName = "Missions Rotation";
			description = "After each set of mission passed MCC will pick a new location for the next mission";
			typeName = "NUMBER";
			defaultValue = 3;
			property = "missionRotation";
		};

		class tileSize : Edit
		{
			displayName = "Tile Size";
			description = "MCC will categorize the map to tiles - the default size of a tile";
			typeName = "NUMBER";
			defaultValue = 3;
			property = "tileSize";
		};

		class loadDB : Checkbox
		{
			displayName = "Load from DB";
			description = "Load saved camapign data from Data Base";
			property = "loadDB";
		};

		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Creates a Campaign. MCC will generate missions and the players will gain resources to expend their base. Every in game day the enemy faction behavior will change according to the players advance";
		sync[] = {"mcc_sandbox_moduleStartLocations","mcc_sandbox_moduleMissionSettings"};

		class mcc_sandbox_moduleStartLocations
		{
			description[] = {
				"Set at least one H.Q start location"
			};
			position = 0;
			direction = 0;
			optional = 0;
			duplicate = 0;
			synced[] = {"AnyVehicle"};
		};
		class mcc_sandbox_moduleMissionSettings
		{
			description[] = {
				"Recommanded to use Role Selection and time acceleration"
			};
			position = 0;
			direction = 0;
			optional = 0;
			duplicate = 0;
			synced[] = {"AnyVehicle"};
		};
	};
};