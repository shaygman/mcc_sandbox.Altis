class mcc_sandbox_moduleMissionSettings : Module_F
{
	category = "MCC";
	author = "shay_gman";
	displayName = "Settings (MCC)";
	icon = "\mcc_sandbox_mod\data\mccModule.paa";
	picture = "\mcc_sandbox_mod\data\mccModule.paa";
	vehicleClass = "Modules";
	function = "MCC_fnc_missionSettings";
	scope = 2;
	isGlobal = 1;
	
	class Arguments
	{
		class t2t
		{
			displayName = "Teleport 2 Team";
			typeName = "NUMBER";
			class values
			{
				class disabled
				{
					name = "Disabled";
					value = 0;
				};
				class jip
				{
					name = "JIP Only";
					value = 1;
					default = 1;
				};
				class respawn
				{
					name = "After Respawn";
					value = 2;
				};
				class always
				{
					name = "Always";
					value = 3;
				};
			};
		};
		class saveGear
		{
			displayName = "Save Gear";
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
		class messages
		{
			displayName = "MCC messages";
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
		
		class sync
		{
			displayName = "Sync JIP";
			description = "Sync join in progress players with the server";
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
		
		class nameTags
		{
			displayName = "Name Tags";
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
		
		class groupMarkers
		{
			displayName = "Group Markers";
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
		
		class artilleryComputer
		{
			displayName = "Artilery Computer";
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
		
		class timeAccel
		{
			displayName = "Time Acceleration";
			typeName = "NUMBER";
			class values
			{
				class disabled
				{
					name = "Disabled";
					value = 0;
					default = 1;
				};
				class tx5
				{
					name = "x5";
					value = 5;
				};
				class tx10
				{
					name = "x10";
					value = 2;
				};
				class tx15
				{
					name = "x15";
					value = 15;
				};
				class tx20
				{
					name = "x20";
					value = 20;
				};
			};
		};
		
		class deleteBody
		{
			displayName = "Delete dead players' bodies";
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
		
		class respawnMenu
		{
			displayName = "Respawn Menu";
			description = "Allow start location dialog on JIP or after respawn";
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
		
		class sqlPDA
		{
			displayName = "Squad Leader PDA";
			description = "Allow Squad Leader PDA";
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
		
		class commanderConsole
		{
			displayName = "Commander Console";
			description = "Allow Commander Console";
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
		
		class squadDialog
		{
			displayName = "Squad Dialog";
			description = "Players can open the squad dialog and form/change squads - requires key binding";
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
		
		class squadDialogPip
		{
			displayName = "Squad Dialog (camera)";
			description = "Player can inspect others from their squad in the Squad Dialog";
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
		
		class logistics
		{
			displayName = "Logistics";
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
		
		class interaction
		{
			displayName = "Interaction";
			description = "Players can use MCC interaction with objects/units - requires key binding";
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
		description = "Define MCC settings";
	};
};