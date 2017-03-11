class MCC_Module_settingsMechanics : Module_F
{
	category = "MCC";
	author = "shay_gman";
	displayName = "(Settings) Mechanics";
	icon = "\mcc_sandbox_mod\data\mccModule.paa";
	picture = "\mcc_sandbox_mod\data\mccModule.paa";
	vehicleClass = "Modules";
	function = "MCC_fnc_settingsCover";
	scope = 2;
	isGlobal = 1;

	class Arguments
	{
		class actionMenu
		{
			displayName = "Action Menu";
			description = "Show MCC's options in the action menu";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};

		class cover
		{
			displayName = "Cover System";
			description = "Enable/Disable cover system";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};

		class coverUI
		{
			displayName = "Cover System UI";
			description = "Show/hide cover UI";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};
		/*
		class coverRecoil
		{
			displayName = "Cover System Recoil";
			description = "While shooting from behind cover players will suffer less recoil - aka weapon resting";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};
		*/
		class coverVault
		{
			displayName = "Allow Vault/Climb";
			description = "While using cover players can climb over obstacles";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};

		class switchWeapons
		{
			displayName = "Weapons Binds";
			description = "Quick weapons selection with the 1-5 buttons";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};

		class interaction
		{
			displayName = "Interaction";
			description = "Players can use MCC interaction with objects/units - requires key binding";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};

		class interactionUI
		{
			displayName = "Interaction UI";
			description = "Show/hide in-game interaction UI";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};

		class arcadeTanks
		{
			displayName = "One Man Tanks";
			description = "Allows one man tank's operation";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};

		class fatigue
		{
			displayName = "Disable Fatigue";
			description = "Disable Fatigue";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};

		class survive
		{
			displayName = "Survival Mod";
			description = "Players can search objects in the world to find resources and weapons and need to drink and eat";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes - Enable searching loot";
					value = 1;
				};

				class Enabled2
				{
					name = "Yes - Disable searching loot";
					value = 2;
				};
				class Disabled
				{
					name = "No";
					value = 0;
					default = 1;
				};
			};
		};

		class survivePlayerPosition
		{
			displayName = "Survival - Load Player Position";
			description = "Load Players last know position and teleport it there";
			typeName = "BOOL";
			class values
			{
				class disable
				{
					name = "Disable";
					value = false;
				};

				class enable
				{
					name = "Enable";
					value = true;
					default = 1;
				};
			};
		};

		class survivePlayerGear
		{
			displayName = "Survival - Load Player Gear";
			description = "Load Players last saved gear";
			typeName = "BOOL";
			class values
			{
				class disable
				{
					name = "Disable";
					value = false;
				};

				class enable
				{
					name = "Enable";
					value = true;
					default = 1;
				};
			};
		};

		class survivePlayerStats
		{
			displayName = "Survival - Load Player Stats";
			description = "Load Players last known stats such as health and food";
			typeName = "BOOL";
			class values
			{
				class disable
				{
					name = "Disable";
					value = false;
				};

				class enable
				{
					name = "Enable";
					value = true;
					default = 1;
				};
			};
		};

		class breachingAmmo
		{
			displayName = "Breaching Ammo";
			description = "Shooting this ammo on a door will unlock and open it. Enter breaching ammo classes as an array";
			defaultValue = '["prpl_8Rnd_12Gauge_Slug","prpl_6Rnd_12Gauge_Slug","rhsusf_8Rnd_Slug","rhsusf_5Rnd_Slug"]';
		};

		class nonLeathalAmmo
		{
			displayName = "Non Lethal Ammo";
			description = "Shooting this ammo on a unit from close range will disable the unit";
			defaultValue = '["prpl_8Rnd_12Gauge_Slug","prpl_6Rnd_12Gauge_Slug","rhsusf_8Rnd_Slug","rhsusf_5Rnd_Slug"]';
		};
	};



	class ModuleDescription: ModuleDescription
	{
		description = "Define MCC's mechanics settings";
	};
};