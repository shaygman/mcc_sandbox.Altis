class MCC_Module_createEvac : Module_F
{
	category = "MCC";
	displayName = "Evac Vehicle";
	function = "MCC_fnc_curatorSetEvac";
	scope = 2;
	isGlobal = 0;

	class Arguments
	{
		class side
		{
			displayName = "Evac Side";
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
				class Civilian
				{
					name = "$STR_CIVILIAN";
					value = 3;
				};
			};
		};

		class gunners
		{
			displayName = "Add Gunners";
			typeName = "NUMBER";
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

		class campaign
		{
			displayName = "Campaign Evac";
			description = "Campaign Evac vehicle will respawn each ingame day if MCC campaign is activated";
			typeName = "NUMBER";
			class values
			{
				class yes
				{
					name = "Yes";
					value = 1;
				};
				class no
				{
					name = "No";
					value = 0;
					default = 1;
				};
			};
		};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Sync it with any vehicle to make it an AI Evac vehicle which the players can command";
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