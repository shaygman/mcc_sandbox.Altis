class mcc_sandbox_moduleCover : Module_F
{
	category = "MCC";
	author = "shay_gman";
	displayName = "Settings (Mechanics)";
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
			displayName = "Allow vault/climb";
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
			displayName = "Weapons binds";
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

		class survive
		{
			displayName = "Survive mod";
			description = "Players can search objects in the world to find resources and weapons";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
					default = 1;
				};
			};
		};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Define MCC's mechanics settings";
	};
};