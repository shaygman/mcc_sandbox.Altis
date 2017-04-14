class MCC_Module_AAS : Module_F
{
	category = "MCC";
	displayName = "(PvP)Advance And Secure";
	function = "MCC_fnc_aasInit";
	scope = 2;
	isGlobal = 0;

	class Attributes: AttributesBase
	{
		class side1 : Combo
		{
			displayName = "side1";
			typeName = "NUMBER";
			property = "side1";
			defaultValue = "1";
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

		class side2 : Combo
		{
			displayName = "side2";
			typeName = "NUMBER";
			property = "side2";
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

		class bleedTickets : Edit
		{
			displayName = "Tickets Bleed";
			description = "How many tickets lost every 5 seconds to the loosing side";
			typeName = "NUMBER";
			defaultValue = 2;
			property = "bleedTickets";
		};

		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Creates an Advance And Secure mission where objectives can only be captured in a specific order";
		optional = 0;
		sync[] = {"MCC_Module_captureZone"};

		class MCC_Module_captureZone
		{
			description[] = {
				"Sync with a MCC capture zone or a dummy sector module in order they supposed to be captured. Follow the sector description to set up the AAS mission"
			};
			position = 0;
			direction = 0;
			optional = 0;
			duplicate = 1;
			synced[] = {"AnyVehicle"};
		};
	};
};