class mcc_sandbox_moduleUndercover : Module_F
{
	category = "MCC";
	author = "shay_gman";
	displayName = "Undercover Agents";
	icon = "\mcc_sandbox_mod\data\mcc_sf.paa";
	picture = "\mcc_sandbox_mod\data\mcc_sf.paa";
	vehicleClass = "Modules";
	function = "MCC_fnc_curatorUnderCover";
	scope = 2;
	isGlobal = 1;

	class Attributes: AttributesBase
	{
		class removeGear : Combo
		{
			displayName = "Remove Weapons:";
			description = "Remove all weapons on game start";
			typeName = "NUMBER";
			property = "removeGear";

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

		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Sync to any player role to play as an Undercover agent. Undercover agents can move freely in near enemy units as long as they keep their gun concealed and are not acting suspicious";
		sync[] = {"BLUFORunit"};

		class BLUFORunit
		{
			description[] = {
				"Sync with any player's role"
			};
			displayName = "Undercover Agent";
			icon = "iconMan";
			optional = 1;
			duplicate = 1;
			synced[] = {"AnyBrain"};
		};
	};
};