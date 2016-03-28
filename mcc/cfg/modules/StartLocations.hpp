class mcc_sandbox_moduleStartLocations : Module_F
{
	category = "MCC";
	author = "shay_gman";
	displayName = "Start Location";
	icon = "\mcc_sandbox_mod\data\mccModule.paa";
	picture = "\mcc_sandbox_mod\data\mccModule.paa";
	vehicleClass = "Modules";
	function = "MCC_fnc_buildSpawnPoint";
	scope = 2;
	isGlobal = 1;

	class Arguments
	{
		class side
		{
			displayName = "Side";
			typeName = "NUMBER";
			class values
			{
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
			};
		};

		class size
		{
			displayName = "Type";
			description = "Need at least one main Start Location";
			typeName = "STRING";
			class values
			{
				class fob
				{
					name = "F.O.B";
					value = "FOB";
					default = 1;
				};
				class Disabled
				{
					name = "Main";
					value = "MAIN";
				};
			};
		};

		class teleportAtStart
		{
			displayName = "Insertion";
			description = "Open Respawn menu at the beging of the mission and Insertion";
			typeName = "NUMBER";
			class values
			{
				class none
				{
					name = "Don't open/don't teleport";
					value = 0;
				};
				class teleport
				{
					name = "Teleport";
					value = 1;
				};
				class paraDrop
				{
					name = "Paradrop";
					value = 2;
				};
				class halo
				{
					name = "H.A.L.O";
					value = 3;
				};
			};
		};

		class distractable
		{
			displayName = "Distractable";
			typeName = "BOOL";
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

		class construct
		{
			displayName = "Construct Buildings";
			description = "Create an actual building or just a flag pole";
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

	class ModuleDescription: ModuleDescription
	{
		description = "Place start module to predefine MCC's start locations";
	};
};