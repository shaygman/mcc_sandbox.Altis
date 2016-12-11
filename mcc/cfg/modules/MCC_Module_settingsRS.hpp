class MCC_Module_settingsRS : Module_F
{
	category = "MCC";
	author = "shay_gman";
	displayName = "(Settings) Role Selection";
	icon = "\mcc_sandbox_mod\data\mccModule.paa";
	picture = "\mcc_sandbox_mod\data\mccModule.paa";
	vehicleClass = "Modules";
	function = "MCC_fnc_missionSettingsRS";
	scope = 2;
	isGlobal = 1;

	class Arguments
	{
		class rsAllWeapons
		{
			displayName = "All Weapons";
			description = "Unlock all weapons and gear regarding player level";
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

		class allowKitChange
		{
			displayName = "Kit Change";
			description = "Enable changing kits in FOB/HQ - requires Role Selection enabled";
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

		class rsGainXp
		{
			displayName = "XP Gain";
			description = "Gain XP automatically from actions or just by admins";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Automatically";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "Manually";
					value = 0;
				};
			};
		};

		class rsEnableRoleWeapons
		{
			displayName = "Limit Weapons";
			description = "Enable penalty for picking heavy weapons not from your kit";
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

		class rsEnableDriversPilots
		{
			displayName = "Restrict Drivers/Pilots";
			description = "Enable only drivers/pilots and pilot can operate tanks/helicopters";
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
	};
};