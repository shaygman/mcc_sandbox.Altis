class mcc_sandbox_modulevehicleSpawner : Module_F
{
	category = "MCC";
	author = "shay_gman";
	displayName = "Vehicle Kiosk";
	icon = "\mcc_sandbox_mod\data\mccModule.paa";
	picture = "\mcc_sandbox_mod\data\mccModule.paa";
	vehicleClass = "Modules";
	function = "MCC_fnc_vehicleSpawnerInit";
	scope = 2;
	isGlobal = 1;
	class Arguments
	{
		class type
		{
			displayName = "Vehicles Type";
			description = "What kind of vehicles the kiosk will spawn";
			typeName = "STRING";
			class values
			{
				class vehicle
				{
					name = "Vehicles";
					value = "vehicle";
					default = 1;
				};
				class tank
				{
					name = "Armored";
					value = "tank";
				};
				class heli
				{
					name = "Helicopters";
					value = "heli";
				};
				class jet
				{
					name = "Fixed Wings";
					value = "jet";
				};
				class ship
				{
					name = "Ships";
					value = "ship";
				};
			};
		};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Create a vheicles kiosk where players can buy vehicles";
		sync[] = {"Land_Noticeboard_F","Land_HelipadEmpty_F"};

		class Land_Noticeboard_F
		{
			description[] = {
				"Sync one Notice Board object",
				"With the module"
			};
			position = 1;
			direction = 1;
			optional = 0;
			duplicate = 0;
			synced[] = {"AnyVehicle"};
		};
		class Land_HelipadEmpty_F
		{
			description[] = {
				"Sync one Invisible Helipad object",
				"With the module"
			};
			position = 1;
			direction = 1;
			optional = 0;
			duplicate = 0;
			synced[] = {"AnyVehicle"};
		};
	};
};