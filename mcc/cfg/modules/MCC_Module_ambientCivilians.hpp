class MCC_Module_ambientCivilians : Module_F
{
	category = "MCC";
	displayName = "Ambient units";
	function = "MCC_fnc_curatorAmbientCivilians";
	scope = 2;
	isGlobal = 0;
	class Arguments
	{
		class isCiv
		{
			displayName = "Ambient Patrols";
			description = "Units will move between buildings";
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

		class isCar
		{
			displayName = "Ambient Cars";
			description = "Cars will spawn and drive around";
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

		class isParkedCar
		{
			displayName = "Parked Cars";
			description = "Empty cars will spawn on the road's sides";
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

		class isLocked
		{
			displayName = "Parked Cars Locked";
			description = "Parked cars will always be locked";
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

		class factionCiv
		{
			displayName = "Faction";
			typeName = "STRING";
			description = "Config name";
			defaultValue = "CIV_F";
		};

		class factionCivCar
		{
			displayName = "Car's Faction";
			typeName = "STRING";
			description = "Config name";
			defaultValue = "CIV_F";
		};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Server side: spawn AI around players when next to towns and despawn them when no player around";
	};
};