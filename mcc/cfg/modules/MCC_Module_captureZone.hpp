class MCC_Module_captureZone : Module_F
{
	scope = 2;
	isGlobal = 0;
	category = "MCC";
	displayName = "Capture Zone";
	function = "MCC_fnc_moduleCapturePoint";

	class Arguments
	{
		class type
		{
			displayName = "Type";
			typeName = "NUMBER";
			class values
			{
				class Ammo
				{
					name = "Ammo";
					value = 0;
					default = 1;
				};
				class Supply
				{
					name = "Supply";
					value = 1;
				};
				class Fuel
				{
					name = "Fuel";
					value = 2;
				};
			};
		};

		class ScoreReward
		{
			displayName = "Score Reward";
			typeName = "NUMBER";
			defaultValue = 50;
		};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Create a capture zone that yield resources over time";
		sync[] = {"EmptyDetector","FlagPole_F"};

		class EmptyDetector
		{
			description[] = {
				"Sync at least one trigger",
				"With the module - will be the capture zone"
			};
			position = 1;
			direction = 1;
			optional = 0;
			duplicate = 0;
			synced[] = {"AnyVehicle"};
		};
		class FlagPole_F
		{
			description[] = {
				"change the flag texture if it inside the trigger",
				""
			};
			position = 1;
			direction = 1;
			optional = 0;
			duplicate = 0;
			synced[] = {"AnyVehicle"};
		};
	};
};