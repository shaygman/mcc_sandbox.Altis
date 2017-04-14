class mcc_sandbox_moduleGAIASettings : Module_F
{
	category = "MCC";
	author = "shay_gman";
	displayName = "(Settings) GAIA";
	icon = "\mcc_sandbox_mod\data\mccModule.paa";
	picture = "\mcc_sandbox_mod\data\mccModule.paa";
	vehicleClass = "Modules";
	function = "MCC_fnc_GAIASettings";
	scope = 2;
	isGlobal = 1;

	class Arguments
	{
		class aiSkillGen
		{
			displayName = "AI Skill(overall)";
			typeName = "NUMBER";
			class values
			{
				class rookie
				{
					name = "Rookie";
					value = 1;
				};
				class level2
				{
					name = "0.2";
					value = 2;
				};
				class level3
				{
					name = "0.3";
					value = 3;
				};
				class moderate
				{
					name = "Moderate";
					value = 4;
					default = 1;
				};
				class level5
				{
					name = "0.5";
					value = 5;
				};
				class level6
				{
					name = "0.6";
					value = 6;
				};
				class level7
				{
					name = "0.7";
					value = 7;
				};
				class level8
				{
					name = "0.8";
					value = 8;
				};
				class level9
				{
					name = "0.9";
					value = 9;
				};
				class vetran
				{
					name = "Vetran";
					value = 10;
				};
			};
		};

		class aiSkillAim : aiSkillGen
		{
			displayName = "AI Skill(Aim)";
		};

		class aiSkillSpot : aiSkillGen
		{
			displayName = "AI Skill(Spot)";
		};

		class aiSkillCommand : aiSkillGen
		{
			displayName = "AI Skill(Command)";
		};

		class aiSmoke
		{
			displayName = "AI use smoke/flare";
			typeName = "BOOL";
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

		class aiSmokeChance
		{
			displayName = "Smoke/flares Chance";
			description = "Define how ofter AI will use smoke/flares";
			typeName = "NUMBER";
			class values
			{
				class low
				{
					name = "Low";
					value = 0;
				};
				class normal
				{
					name = "Normal";
					value = 1;
					default = 1;
				};
				class high
				{
					name = "High";
					value = 2;
				};
			};
		};

		class cacheDistance
		{
			displayName = "Cache Distance";
			description = "How far any player should be from a unit before it cached";
			typeName = "NUMBER";
			class values
			{
				class low
				{
					name = "1500";
					value = 1500;
				};
				class normal
				{
					name = "3000";
					value = 3000;
					default = 1;
				};
				class high
				{
					name = "6000";
					value = 6000;
				};
			};
		};

		class gaiacontrol
		{
			displayName = "GAIA Controlls";
			description = "If set to everyone GAIA will give order to all units availables even players";
			typeName = "BOOL";
			class values
			{
				class Enabled
				{
					name = "Only GAIA units";
					value = 0;
					default = 1;
				};
				class Disabled
				{
					name = "Everyone";
					value = 1;
				};
			};
		};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Define MCC settings";
	};
};
