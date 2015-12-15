class MCC_Module_forceCamera : Module_F
{
	category = "MCC";
	author = "shay_gman";
	displayName = "Force Camera";
	icon = "\mcc_sandbox_mod\data\mccModule.paa";
	picture = "\mcc_sandbox_mod\data\mccModule.paa";
	vehicleClass = "Modules";
	function = "MCC_fnc_forceCamera";
	scope = 2;
	isGlobal = 1;

	class Arguments
	{
		class mode
		{
			displayName = "Allow 3rd Person";
			typeName = "NUMBER";
			class values
			{
				class noOne
				{
					name = "No One";
					value = 0;
					default = 1;
				};

				class vehicles
				{
					name = "All Vehicles";
					value = 1;
				};

				class air
				{
					name = "Air Vehicles Only";
					value = 2;
				};
			};
		};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Force 1st person camera";
	};
};