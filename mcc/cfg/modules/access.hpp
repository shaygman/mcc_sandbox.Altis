class mcc_sandbox_module : Module_F
{
	category = "MCC";
	author = "shay_gman";
	displayName = "Access Rights";
	icon = "\mcc_sandbox_mod\data\mcc_access.paa";
	picture = "\mcc_sandbox_mod\data\mcc_access.paa";
	vehicleClass = "Modules";
	function = "MCC_fnc_accessRights";
	scope = 2;
	isGlobal = 1;

	class Attributes: AttributesBase
	{
		class names : Edit
		{
			displayName = "MCC Operators";
			description = "Enter the player's UID of the players that will have access to MCC. Example ['123213',12312321','1322131231']";
			defaultValue = """[]""";
			property = "names";
		};

		class allowAdmin : Checkbox
		{
			displayName = "Admin Access";
			description = "Allow admin or host access to MCC";
			typeName = "BOOL";
			property = "allowAdmin";
		};

		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Who will have MCC access. Enter the players UID as an array  Example ['123213',12312321','1322131231'] or sync with roles"; // Short description, will be formatted as structured text
		sync[] = {"BLUFORunit"};

		class BLUFORunit
		{
			description[] = { // Multi-line descriptions are supported
				"Sync with any player's role that you want to have MCC access"
			};
			displayName = "MCC Contoller"; // Custom name
			icon = "iconMan"; // Custom icon (can be file path or CfgVehicleIcons entry)
			optional = 1; // Synced entity is optional
			duplicate = 1; // Multiple entities of this type can be synced
			synced[] = {"AnyBrain"}; // Pre-define entities like "AnyBrain" can be used. See the list below
		};
	};
};