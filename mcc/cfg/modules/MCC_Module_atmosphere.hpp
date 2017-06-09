class MCC_Module_atmosphere : Module_F
{
	scope = 2;
	isGlobal = 0;
	category = "MCC";
	displayName = "Atmosphere";
	function = "MCC_fnc_curatorAtmoshphere";
	class Arguments
	{
		class atmosphere
		{
			displayName = "Atmosphere";
			description = "Atmosphere type";
			typeName = "NUMBER";
			class values
			{
				class Custom
				{
					name = "Custom";
					value = 0;
				};
				class Random
				{
					name = "Random";
					value = 1;
					default = 1;
				};
				class Clear
				{
					name = "Clear";
					value = 2;
				}
				class Cloudy
				{
					name = "Cloudy";
					value = 3;
				};
				class Rain
				{
					name = "Rain";
					value = 4;
				};
				class Storm
				{
					name = "Storm";
					value = 5;
				};
				class Sandstorm
				{
					name = "Sandstorm";
					value = 6;
				};
				class Blizzard
				{
					name = "Blizzard";
					value = 7;
				};
				class Snow
				{
					name = "Snow";
					value = 8;
				};
				class HeatWave
				{
					name = "Heat Wave";
					value = 9;
				};
			};
		};

		class changeTime
		{
			displayName = "Random Time";
			description = "Random time and date";
			typeName = "BOOL";
			class values
			{
				class Enabled
				{
					name = "Enabled";
					value = true;
				};
				class Disabled
				{
					name = "Disabled";
					value = false;
					default = 1;
				};
			};
		};

		class dust
		{
			displayName = "Dust";
			description = "Dust (effects only in custom atmosphere)";
			typeName = "BOOL";
			class values
			{
				class Enabled
				{
					name = "Enabled";
					value = true;
				};
				class Disabled
				{
					name = "Disabled";
					value = false;
					default = 1;
				};
			};
		};

		class snow
		{
			displayName = "Snow";
			description = "Snow (effects only in custom atmosphere)";
			typeName = "BOOL";
			class values
			{
				class Enabled
				{
					name = "Enabled";
					value = true;
				};
				class Disabled
				{
					name = "Disabled";
					value = false;
					default = 1;
				};
			};
		};

		class newspapers
		{
			displayName = "Newspapers";
			description = "Newspapers (effects only in custom atmosphere)";
			typeName = "BOOL";
			class values
			{
				class Enabled
				{
					name = "Enabled";
					value = true;
				};
				class Disabled
				{
					name = "Disabled";
					value = false;
					default = 1;
				};
			};
		};

		class mist
		{
			displayName = "Mist";
			description = "Mist (effects only in custom atmosphere)";
			typeName = "BOOL";
			class values
			{
				class Enabled
				{
					name = "Enabled";
					value = true;
				};
				class Disabled
				{
					name = "Disabled";
					value = false;
					default = 1;
				};
			};
		};

		class fog
		{
			displayName = "Fog";
			description = "Fog (effects only in custom atmosphere)";
			typeName = "BOOL";
			class values
			{
				class Enabled
				{
					name = "Enabled";
					value = true;
				};
				class Disabled
				{
					name = "Disabled";
					value = false;
					default = 1;
				};
			};
		};

		class leaves
		{
			displayName = "Leaves";
			description = "Leaves (effects only in custom atmosphere)";
			typeName = "BOOL";
			class values
			{
				class Enabled
				{
					name = "Enabled";
					value = true;
				};
				class Disabled
				{
					name = "Disabled";
					value = false;
					default = 1;
				};
			};
		};

		class windsounds
		{
			displayName = "Wind Sounds";
			description = "Wind Sounds (effects only in custom atmosphere)";
			typeName = "BOOL";
			class values
			{
				class Enabled
				{
					name = "Enabled";
					value = true;
				};
				class Disabled
				{
					name = "Disabled";
					value = false;
					default = 1;
				};
			};
		};

		class filtercolor
		{
			displayName = "Color Filter";
			description = "Color Filter (effects only in custom atmosphere)";
			typeName = "NUMBER";
			class values
			{
				class none
				{
					name = "None";
					value = 0;
					default = 1;
				};
				class cold
				{
					name = "Cold";
					value = 1;
				};
				class murky
				{
					name = "Murky";
					value = 2;
				}
				class green
				{
					name = "Green";
					value = 3;
				};
				class sand
				{
					name = "Sand";
					value = 4;
				};
				class yellow
				{
					name = "Yellow";
					value = 5;
				};
				class hot
				{
					name = "Hot";
					value = 6;
				};
				class gray
				{
					name = "Gray";
					value = 7;
				};
			};
		};

		class filtergrain
		{
			displayName = "Grain Filter";
			description = "Grain Filter (effects only in custom atmosphere)";
			typeName = "NUMBER";
			class values
			{
				class none
				{
					name = "None";
					value = 0;
					default = 1;
				};
				class low
				{
					name = "Low";
					value = 1;
				};
				class medium
				{
					name = "Medium";
					value = 2;
				}
				class heavy
				{
					name = "Heavy";
					value = 3;
				};
			};
		};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Create visuals atmospheres";
		sync[] = {};
	};
};