class mcc_sandbox_moduleRestrictedZone : Module_F
{
	category = "MCC";
	author = "shay_gman";
	displayName = "Restricted zones";
	function = "MCC_fnc_createRestrictedZones";
	icon = "\mcc_sandbox_mod\data\mccModule.paa";
	picture = "\mcc_sandbox_mod\data\mccModule.paa";
	_generalMacro = "ModuleZoneRestriction_F";
	scope = 2;
	isGlobal = 2;
	isTriggerActivated = 1;

	class Attributes: AttributesBase
	{
		class sides : Combo
		{
			displayName = "Restricted Sides";
			description = "Enter the restricted sides as array [west,east,resistance,civlian]";
			typeName = "NUMBER";
			property = "sides";

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

		class time : Combo
		{
			displayName = "Time Before Punishment";
			description = "How much time in seconds should elapsed before the player will be punished";
			typeName = "NUMBER";
			defaultValue = 10;
			property = "time";
		};

		class air : Checkbox
		{
			displayName = "Air Vehicles";
			description = "Should air vehicles be allowed";
			typeName = "BOOL";
			property = "air";
		};

		class createMarker : Checkbox
		{
			displayName = "Create markers";
			description = "Create markers on the triggers locations";
			typeName = "BOOL";
			property = "createMarker";
		};

		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Sync with any trigger to create restricted areas";
		sync[] = {"LocationArea_F"};

		class LocationArea_F
		{
			description[] = {
				"Sync with any trigger"
			};
			optional = 1;
			duplicate = 1;
			synced[] = {"EmptyDetector"};
		};
	};
};
