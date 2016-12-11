class MCC_Module_settingsRadio : Module_F
{
	category = "MCC";
	author = "shay_gman";
	displayName = "(Settings) Radio System";
	icon = "\mcc_sandbox_mod\data\mccModule.paa";
	picture = "\mcc_sandbox_mod\data\mccModule.paa";
	vehicleClass = "Modules";
	function = "MCC_fnc_settingsRadio";
	scope = 2;
	isGlobal = 1;

	class Arguments
	{
		class radioGlobal
		{
			displayName = "Global Radio Distance";
			description = "In meters";
			typeName = "NUMBER";
			defaultValue = 2000;
		};

		class radioCommander
		{
			displayName = "Commander Radio Distance";
			description = "In meters";
			typeName = "NUMBER";
			defaultValue = 10000;
		};

		class radioSide
		{
			displayName = "Side Radio Distance";
			description = "In meters";
			typeName = "NUMBER";
			defaultValue = 5000;
		};

		class radioGroup
		{
			displayName = "Group Radio Distance";
			description = "In meters";
			typeName = "NUMBER";
			defaultValue = 500;
		};

		class kickIdle
		{
			displayName = "Kick Hot Mic";
			description = "Will kick player with hot mic after some time";
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

		class kickIdleTime
		{
			displayName = "Time Before Kicking Hot Mic";
			description = "In seconds";
			typeName = "NUMBER";
			defaultValue = 10;
		};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Define MCC's radio settings";
	};
};