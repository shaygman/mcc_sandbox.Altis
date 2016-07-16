class MCC_Module_AAS : Module_F
{
	category = "MCC";
	displayName = "Advance And Secure";
	function = "MCC_fnc_aasInit";
	scope = 2;
	isGlobal = 0;
	class Arguments
	{
		class side1
		{
			displayName = "side1";
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

		class side2
		{
			displayName = "side2";
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
					default = 1;
				};
				class Independent
				{
					name = "$STR_GUERRILA";
					value = 2;
				};
			};
		};

		class bleedTickets
		{
			displayName = "Tickets Bleed";
			description = "How many tickets lost every 5 seconds to the loosing side";
			typeName = "NUMBER";
			defaultValue = 2;
		};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Creates an Advance And Secure mission where objectives can only be captured in a specific order";

		class moduleSector_F
		{
			description[] = {
				"Sync with a sector or a dummy sector module in order they supposed to be captured. Follow the sector description to set up the AAS mission"
			};
			position = 0;
			direction = 0;
			optional = 0;
			duplicate = 1;
			synced[] = {"AnyVehicle"};
		};
		class moduleSectorDummy_F
		{
			description[] = {
				"Sync with a sector or a dummy sector module in order they supposed to be captured. Follow the sector description to set up the AAS mission"
			};
			position = 0;
			direction = 0;
			optional = 0;
			duplicate = 1;
			synced[] = {"AnyVehicle"};
		};
	};
};