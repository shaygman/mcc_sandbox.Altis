class MCC_Module_inGameUI : Module_F
{
	category = "MCC";
	author = "shay_gman";
	displayName = "(Settings) HUD";
	icon = "\mcc_sandbox_mod\data\mccModule.paa";
	picture = "\mcc_sandbox_mod\data\mccModule.paa";
	vehicleClass = "Modules";
	function = "MCC_fnc_inGameUI";
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
				class disabled
				{
					name = "Everyone";
					value = -1;
				};

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

		class compass
		{
			displayName = "Compass HUD";
			typeName = "BOOL";
			class values
			{
				class disable
				{
					name = "Disable";
					value = false;
				};

				class enable
				{
					name = "Enable";
					value = true;
					default = 1;
				};
			};
		};

		class compassTeamMates
		{
			displayName = "Compass Show Squad";
			typeName = "BOOL";
			class values
			{
				class disable
				{
					name = "Disable";
					value = false;
				};

				class enable
				{
					name = "Enable";
					value = true;
					default = 1;
				};
			};
		};

		class nameTags
		{
			displayName = "Name Tags";
			description = "Show in-game name tags, ranks (role and health stats while Role Selection is active)";
			typeName = "NUMBER";
			class values
			{
				class disable
				{
					name = "Disable";
					value = 0;
					default = 1;
				};

				class enableDirect
				{
					name = "Enable - Pointing";
					value = 1;
				};

				class enableRadius
				{
					name = "Enable - Radius";
					value = 2;
				};
			};
		};

		class suppression
		{
			displayName = "Suppression";
			description = "Activate client side suppression effects";
			typeName = "BOOL";
			class values
			{
				class disable
				{
					name = "Disable";
					value = false;
					default = 1;
				};

				class enable
				{
					name = "Enable";
					value = true;
				};
			};
		};

		class hitRadar
		{
			displayName = "Hit Radar";
			description = "Indicate the general direction of enemies firing on the player";
			typeName = "BOOL";
			class values
			{
				class disable
				{
					name = "Disable";
					value = false;
					default = 1;
				};

				class enable
				{
					name = "Enable";
					value = true;
				};
			};
		};

		class tickets
		{
			displayName = "Tickets";
			description = "Show opposing sides and tickets remains";
			typeName = "BOOL";
			class values
			{
				class disable
				{
					name = "Disable";
					value = false;
					default = 1;
				};

				class enable
				{
					name = "Enable";
					value = true;
				};
			};
		};

		class groupMarkers
		{
			displayName = "Squads Markers";
			description = "Show Squads markers on the map for all players while playing in a squad from the Squad Dialog";
			typeName = "BOOL";
			class values
			{
				class disable
				{
					name = "Disable";
					value = false;
				};

				class enable
				{
					name = "Enable";
					value = true;
					default = 1;
				};
			};
		};

		class indevidualMarkers
		{
			displayName = "Units Markers";
			description = "Show units markers on the map for all players while playing in a squad from the Squad Dialog";
			typeName = "BOOL";
			class values
			{
				class disable
				{
					name = "Disable";
					value = false;
					default = 1;
				};

				class enable
				{
					name = "Enable";
					value = true;
				};
			};
		};

		class tutorials
		{
			displayName = "MCC Tutorials";
			description = "Enable MCC Tutorials such as Squad Leader role exc";
			typeName = "BOOL";
			class values
			{
				class disable
				{
					name = "Disable";
					value = false;
				};

				class enable
				{
					name = "Enable";
					value = true;
					default = 1;
				};
			};
		};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Set MCC in-game UI and HUD options";
	};
};