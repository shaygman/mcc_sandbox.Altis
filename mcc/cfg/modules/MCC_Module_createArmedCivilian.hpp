class MCC_Module_createArmedCivilian : Module_F
{
	category = "MCC";
	displayName = "Armed Civilian";
	function = "MCC_fnc_curatorSetArmedCivilian";
	scope = 2;
	isGlobal = 0;

	class Attributes: AttributesBase
	{
		class side : Combo
		{
			displayName = "Attack Side";
			typeName = "NUMBER";
			property = "side";

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
				class Civilian
				{
					name = "$STR_CIVILIAN";
					value = 3;
				};
			};
		};

		class patrol : Combo
		{
			displayName = "Random Patrol";
			typeName = "NUMBER";
			property = "patrol";

			class values
			{
				class yes
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class no
				{
					name = "No";
					value = 0;
				};
			};
		};

		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Make unit act as armed civilian - the unit will randomly draw weapons on units from its rival faction";
		sync[] = {"AnyAI"};

		class AnyAI
		{
			description = "Any AI unit. Not players or empty objects.";
			displayName = "Any AI";
			icon = "iconMan";
			side = 4;
			position = 1;
			direction = 1;
			optional = 0;
			duplicate = 1;
		};
	};
};
