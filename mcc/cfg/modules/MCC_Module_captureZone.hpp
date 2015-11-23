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
				class Tickets
				{
					name = "Tickets";
					value = 3;
				};
			};
		};

		class ScoreReward
		{
			displayName = "Score Reward";
			typeName = "NUMBER";
			defaultValue = 50;
		};

		class flag
		{
			displayName = "Flag";
			typeName = "BOOL";
			class values
			{
				class Enabled
				{
					name = "On";
					value = true;
					default = 1;
				};
				class Disabled
				{
					name = "Off";
					value = false;
				};
			};
		};

		class enableHUD
		{
			displayName = "HUD";
			typeName = "BOOL";
			class values
			{
				class Enabled
				{
					name = "On";
					value = true;
					default = 1;
				};
				class Disabled
				{
					name = "Off";
					value = false;
				};
			};
		};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Create a capture zone that yield resources over time";
		sync[] = {"LocationArea_F","MiscUnlock_F","FlagPole_F"};

		class LocationArea_F
		{
			description = "";
			duplicate = 1;
			sync[] = {"TriggerArea"};
		};

		class TriggerArea
		{
			description[] = {
				"Sync at least one trigger",
				"With the area - will act as the capture zone"
			};
			area = 1;
			position = 1;
			direction = 1;
			optional = 0;
			duplicate = 0;
			vehicle = "EmptyDetector";
		};

		class MiscUnlock_F
		{
			description = "";
			duplicate = 1;
			optional = 1;
			sync[] = {"TriggerUnlock"};
		};

		class TriggerUnlock
		{
			description = "This trigger have to be activated to enable the capture point.";
			duplicate = 1;
			optional = 1;
			vehicle = "EmptyDetector";
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
			vehicle = "FlagPole_F";
		};
	};
};