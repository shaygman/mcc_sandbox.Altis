class mcc_Module_createZones : Module_F
{
	category = "MCC";
	displayName = "MCC Zones";
	function = "MCC_fnc_createZonesInit";
	scope = 2;
	isGlobal = 0;

	class Attributes: AttributesBase
	{
		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Sync with triggers to create MCC zones";

		class TriggerArea
		{
			description[] = {
				"Sync at least one trigger",
				"With the module to create zone"
			};
			area = 1;
			position = 1;
			direction = 1;
			optional = 0;
			duplicate = 0;
			vehicle = "EmptyDetector";
		};
	};
};