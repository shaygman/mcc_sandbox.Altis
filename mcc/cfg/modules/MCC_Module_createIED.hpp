class MCC_Module_createIED : Module_F
{
	category = "MCC";
	displayName = "IED/Suicide Bomber";
	function = "MCC_fnc_curatorSetIED";
	scope = 2;
	isGlobal = 0;

	class Attributes : AttributesBase
	{
		class side : Combo
		{
			displayName = "Activate Side";
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

		class size : Combo
		{
			displayName = "Explosion Size";
			typeName = "STRING";
			property = "size";

			class values
			{
				class small
				{
					name = "Small";
					value = "small";
				};
				class medium
				{
					name = "Medium";
					value = "medium";
					default = 1;
				};
				class large
				{
					name = "Large";
					value = "large";
				};
			};
		};

		class effect : Combo
		{
			displayName = "Explosion Effect";
			typeName = "NUMBER";
			property = "effect";

			class values
			{
				class Deadly
				{
					name = "Deadly";
					value = 0;
					default = 1;
				};
				class Disabling
				{
					name = "Disabling";
					value = 1;
				};
				class Fake
				{
					name = "Fake";
					value = 2;
				};
				class None
				{
					name = "None";
					value = 3;
				};
			};
		};

		class disarmTime : Combo
		{
			displayName = "Disarm Time";
			typeName = "NUMBER";
			property = "disarmTime";

			class values
			{
				class t10
				{
					name = "10 seconds";
					value = 10;
					default = 1;
				};
				class t30
				{
					name = "30 seconds";
					value = 30;
				};
				class t60
				{
					name = "60 seconds";
					value = 60;
				};
				class t120
				{
					name = "120 seconds";
					value = 120;
				};
				class t240
				{
					name = "240 seconds";
					value = 240;
				};
			};
		};

		class Jammable : Combo
		{
			displayName = "Jammable";
			typeName = "NUMBER";
			property = "Jammable";

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

		class ActivationType : Combo
		{
			displayName = "Activation Type";
			typeName = "NUMBER";
			property = "ActivationType";

			class values
			{
				class Proximity
				{
					name = "Proximity";
					value = 0;
					default = 1;
				};
				class Radio
				{
					name = "Radio/Spotter";
					value = 1;
				};
				class missionMaker
				{
					name = "Mission Maker Only";
					value = 2;
				};
				class miniGame
				{
					name = "Mini-Game(Proximity)";
					value = 3;
				};
				class miniGameManual
				{
					name = "Mini-Game(Manual)";
					value = 4;
				};
			};
		};

		class Distance : Combo
		{
			displayName = "Activation Distance";
			typeName = "NUMBER";
			property = "Distance";

			class values
			{
				class t5
				{
					name = "5 meters";
					value = 5;
				};
				class t10
				{
					name = "10 meters";
					value = 10;
				};
				class t20
				{
					name = "20 meters";
					value = 20;
					default = 1;
				};
				class t30
				{
					name = "30 meters";
					value = 30;
				};
				class t40
				{
					name = "40 meters";
					value = 40;
				};
				class t50
				{
					name = "50 meters";
					value = 50;
				};
			};
		};

		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Sync it with any vehicle or object to create an IED or with an AI to create suicide Bomber";
		sync[] = {"Anything"};

		class Anything
		{
			description = "Any vehicle. No persons or static objects.";
			displayName = "Any vehicle";
			side = 4;
			position = 1;
			direction = 1;
			optional = 0;
			duplicate = 1;
		};
	};
};