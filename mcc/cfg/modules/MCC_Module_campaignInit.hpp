class MCC_Module_campaignInit : Module_F
{
	scope = 2;
	isGlobal = 0;
	category = "MCC";
	displayName = "Start Campaign";
	function = "MCC_fnc_curatorCampaignInit";

	class Arguments
	{
		class factionPlayer
		{
			displayName = "Players Faction";
			description = "Config name";
			typeName = "STRING";
			defaultValue = "BLU_F";
		};

		class factionRivalPlayer
		{
			displayName = "Rival Players Side";
			description = "Players on rival side will gain resources from killing main faction's players";
			typeName = "NUMBER";
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

		class factionEnemy
		{
			displayName = "Enemy Faction";
			typeName = "STRING";
			description = "Config name";
			defaultValue = "OPF_F";
		};

		class factionCiv
		{
			displayName = "Civilian Faction";
			typeName = "STRING";
			description = "Config name";
			defaultValue = "CIV_F";
		};

		class missionMax
		{
			displayName = "Number of Missions";
			description = "Until Campaign Ends - 0 means no mission will be generated";
			typeName = "NUMBER";
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

		class difficulty
		{
			displayName = "Difficulty";
			typeName = "NUMBER";
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

		class tickets
		{
			displayName = "Starting Tickets";
			typeName = "NUMBER";
			defaultValue = 100;
		};
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