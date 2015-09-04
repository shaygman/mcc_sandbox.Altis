class MCC_Module_setResources : Module_F
{
	scope = 2;
	isGlobal = 1;
	category = "MCC";
	displayName = "Set Resources";
	function = "MCC_fnc_setResources";

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

		class repair
		{
			displayName = "Supplies";
			typeName = "NUMBER";
			defaultValue = 500;
		};

		class ammo
		{
			displayName = "Ammo";
			typeName = "NUMBER";
			defaultValue = 500;
		};

		class fuel
		{
			displayName = "Fuel";
			typeName = "NUMBER";
			defaultValue = 500;
		};

		class food
		{
			displayName = "Food";
			typeName = "NUMBER";
			defaultValue = 100;
		};

		class meds
		{
			displayName = "Meds";
			typeName = "NUMBER";
			defaultValue = 100;
		};
	};
};