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
	
	class Arguments
	{
		class sides
		{
			displayName = "Restricted Sides";
			description = "Enter the restricted sides as array [west,east,resistance,civlian]";
			typeName = "NUMBER";
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
		
		class time
		{
			displayName = "Time Before Punishment";
			description = "How much time in seconds should elapsed before the player will be punished";
			typeName = "NUMBER";
			defaultValue = 10;
		};
		
		class inside
		{
			displayName = "Punished inside the zone";
			description = "Should the players be punished for staying inside the zone or outside";
			typeName = "BOOL";
			class values
			{
				class Enabled
				{
					name = "Inside";
					value = false;
					default = 1;
				};
				class Disabled
				{
					name = "Outside";
					value = true;
				};
			};
		};
		
		class air
		{
			displayName = "Air Vehicles";
			description = "Should air vehicles be punished";
			typeName = "BOOL";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = false;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = true;
				};
			};
		};
		
		class hide
		{
			displayName = "Create markers";
			description = "Create markers on the triggers locations";
			typeName = "BOOL";
			class values
			{
				class Disabled
				{
					name = "No";
					value = false;
				};
				class Enabled
				{
					name = "Yes";
					value = true;
					default = 1;
				};
			};
		};
	};
	
	class ModuleDescription: ModuleDescription
	{
		description = "Create restricted areas";
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
