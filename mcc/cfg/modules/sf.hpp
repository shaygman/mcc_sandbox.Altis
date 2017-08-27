class mcc_sandbox_moduleSF : Module_F
{
	category = "MCC";
	author = "shay_gman";
	displayName = "Special Forces";
	icon = "\mcc_sandbox_mod\data\mcc_sf.paa";
	picture = "\mcc_sandbox_mod\data\mcc_sf.paa";
	vehicleClass = "Modules";
	function = "MCC_fnc_SF";
	scope = 2;
	isGlobal = 1;

	class Attributes: AttributesBase
	{
		class hcam_actionKey : Combo
		{
			displayName = "User custom key:";
			description = "Which user's custom key will activate the helmet cam";
			typeName = "NUMBER"; // Value type, can be "NUMBER", "STRING" or "BOOL"
			property = "hcam_actionKey";

			class values
			{
				class 1key	{name = "Use Action 1";	value = 1; default = 1;};
				class 2key	{name = "Use Action 2"; value = 2;};
				class 3key	{name = "Use Action 3"; value = 3;};
				class 4key	{name = "Use Action 4"; value = 4;};
				class 5key	{name = "Use Action 5"; value = 5;};
				class 6key	{name = "Use Action 6"; value = 6;};
				class 7key	{name = "Use Action 7"; value = 7;};
				class 8key	{name = "Use Action 8"; value = 8;};
				class 9key	{name = "Use Action 9"; value = 9;};
				class 10key	{name = "Use Action 10"; value = 10;};
				class 11key	{name = "Use Action 11"; value = 11;};
				class 12key	{name = "Use Action 12"; value = 12;};
				class 13key	{name = "Use Action 13"; value = 13;};
				class 14key	{name = "Use Action 14"; value = 14;};
				class 15key	{name = "Use Action 15"; value = 15;};
				class 16key	{name = "Use Action 16"; value = 16;};
				class 17key	{name = "Use Action 17"; value = 17;};
				class 18key	{name = "Use Action 18"; value = 18;};
				class 19key	{name = "Use Action 19"; value = 19;};
				class 20key	{name = "Use Action 20"; value = 20;};
			};
		};

		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Sync to any player role to gain access to the helmet camera";
		sync[] = {"BLUFORunit"};

		class BLUFORunit
		{
			description[] = {
				"Sync with any player's role"
			};
			displayName = "SF Team camera";
			icon = "iconMan";
			optional = 1;
			duplicate = 1;
			synced[] = {"AnyBrain"};
		};
	};
};