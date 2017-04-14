class MCC_module_vehicleRespawn : Module_F
{
	category = "MCC";
	displayName = "Vehicle Respawn";
	function = "MCC_fnc_vehicleRespawn";
	scope = 2;
	isGlobal = 0;

	class Attributes: AttributesBase
	{
		class abondanDistance : Edit
		{
			displayName = "Abandon Distance";
			description = "How far must a unit be before vehicle is forced to respawn if empty, leave empty for none";
			typeName = "NUMBER";
			defaultValue = 300;
			property = "abondanDistance";
		};

		class waitTime : Edit
		{
			displayName = "Wait Time";
			description = "How long before vehicle respawn in seconds";
			typeName = "NUMBER";
			defaultValue = 5;
			property = "waitTime";
		};

		class tickets : Edit
		{
			displayName = "Respawns";
			description = "How many time can the vehicle repsawn, leave empty for infinite";
			typeName = "NUMBER";
			property = "tickets";
		};

		class destroyEffect : Checkbox
		{
			displayName = "Explosion Effect";
			description = "Vehicle wreck will explode before delete";
			typeName = "BOOL";
			property = "destroyEffect";
		};

		class respawnDisabled : Checkbox
		{
			displayName = "Disabled Vehicles";
			description = "Respawn Disabled Vehicles";
			typeName = "BOOL";
			property = "respawnDisabled";
		};

		class code : Edit
		{
			displayName = "Code";
			description = "Code to execute on respawn vehicle refers as _this";
			typeName = "STRING";
			defaultValue = "";
			property = "code";
		};

		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Sync it with any vehicles to respawn";
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