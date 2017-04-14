class mcc_sandbox_moduleILS : Module_F
{
	category = "MCC";
	author = "shay_gman";
	displayName = "(ILS)Instrument Landing System";
	icon = "\mcc_sandbox_mod\data\mcc_ils.paa";
	picture = "\mcc_sandbox_mod\data\mcc_ils.paa";
	vehicleClass = "Modules";
	function = "";
	scope = 2;
	isGlobal = 1;

	class Attributes: AttributesBase
	{
		class MCC_runwayName : Edit
		{
			control = "Edit";
			displayName = "Runway Name";
			description = "Runway Name display in ILS";
			defaultValue = """Runway""";
			property = "MCC_runwayName";
		};

		class MCC_runwayDis : Combo
		{
			displayName = "Runway Length";
			description = "Runway length in meters";
			typeName = "NUMBER";
			property = "MCC_runwayDis";
			class values
			{
				class L100
				{
					name = "100 meters";
					value = 100;
				};
				class L200
				{
					name = "200 meters";
					value = 200;
					default = 1;
				};
				class L300
				{
					name = "300 meters";
					value = 300;
				};
			};
		};

		class MCC_runwaySide : Combo
		{
			displayName = "Allowed Sides";
			description = "Only specific sides can use this airfield";
			typeName = "NUMBER";
			property = "MCC_runwaySide";
			class values
			{
				class All
				{
					name = "All";
					value = -1;
					default = 1;
				};
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
				class Civilian
				{
					name = "$STR_CIVILIAN";
					value = 3;
				};
			};
		};

		class MCC_runwayCircles : Checkbox
		{
			displayName = "Circles Helpers";
			description = "Allow virtual circles to show the landing path";
			property = "MCC_runwayCircles";
		};

		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Place ILS module on each runway's start facing the same diraction as the runway";
		position = 1;
		direction = 1;
	};
};