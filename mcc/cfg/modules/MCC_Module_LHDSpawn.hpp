class MCC_Module_LHDSpawn : Module_F
{
	category = "MCC";
	displayName = "Carrier-Spawn";
	function = "MCC_fnc_curatorLHDSpawn";
	scope = 2;
	isGlobal = 0;

	class Attributes : AttributesBase
	{
		class side : Combo
		{
			displayName = "Side";
			description = "Which side the carrier belong to";
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

		class hq : Checkbox
		{
			displayName = "Respawn Position";
			description = "The carrier will act as a respawn position";
			typeName = "BOOL";
			property = "hq";
		};

		class isCUP : Checkbox
		{
			displayName = "Spawn CUP LHD";
			description = "Requires CUP addon";
			typeName = "BOOL";
			property = "isCUP";
		};

		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Spawn CUP LHD that can be managed by the mission maker will act a mobile base";
		sync[] = {"AnyVehicle"};

		class AnyVehicle
		{
			description = "Any vehicle. No persons or static objects.";
			displayName = "Any vehicle";
			icon = "iconCar";
			side = 4;
			position = 1;
			direction = 1;
			optional = 0;
			duplicate = 1;
		};
	};
};