class MCC_Module_settingsMedicSystem : Module_F
{
	category = "MCC";
	author = "shay_gman";
	displayName = "(Settings) Medical System";
	icon = "\mcc_sandbox_mod\data\mccModule.paa";
	picture = "\mcc_sandbox_mod\data\mccModule.paa";
	vehicleClass = "Modules";
	function = "MCC_fnc_settingsMedical";
	scope = 2;
	isGlobal = 1;

	class Arguments
	{
		class medicComplex
		{
			displayName = "Complex System";
			description = "Complex system replace all the default ArmA items with advanced items such as bandages, epipens exc";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};

		class medicBleedingEnabled
		{
			displayName = "Bleeding";
			description = "PLayers and AI will suffer from bleeding effects";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};

		class onlyMedicsCanHeal
		{
			displayName = "Medic Heal";
			description = "Only medics can use FAK to heal";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};

		class BleedingTime
		{
			displayName = "Bleeding Time";
			description = "The amount of time it takes to die from bleeding";
			typeName = "NUMBER";
			class values
			{
				class short
				{
					name = "Short";
					value = 100;
				};
				class medium
				{
					name = "Medium";
					value = 200;
					default = 1;
				};
				class long
				{
					name = "Long";
					value = 300;
				};
			};
		};

		class DamageCoef
		{
			displayName = "Bulletproof vests simulation";
			description = "Players can take more damage than usual";
			typeName = "NUMBER";
			class values
			{
				class no
				{
					name = "No Vests";
					value = 1;
				};
				class small
				{
					name = "Small protection";
					value = 0.8;
					default = 1;
				};
				class large
				{
					name = "Large protection";
					value = 0.6;
				};
			};
		};

		class medicXPmesseges
		{
			displayName = "Kill Messages";
			description = "While role selection is active players will get notify when killing another player or AI";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};

		class medicPunishTK
		{
			displayName = "Punish Team Kill";
			description = "Player who died by friendly fire can forgive or punish the killer";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};

		class medicShowUI
		{
			displayName = "Medic HUD";
			description = "Show wounded on HUD";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
					default = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
				};
			};
		};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Place the module to activate MCC medic system";
	};
};