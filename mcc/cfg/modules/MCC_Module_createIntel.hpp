class MCC_Module_createIntel : Module_F
{
	category = "MCC";
	displayName = "Intel";
	function = "MCC_fnc_curatorSetIntel";
	scope = 2;
	isGlobal = 0;

	class Arguments
	{
		class shared
		{
			displayName = "Shared With";
			description = "Who will get the intel notification";
			typeName = "NUMBER";
			class values
			{
				class all
				{
					name = "All";
					value = 0;
				};
				class group
				{
					name = "Group";
					value = 1;
				};
				class side
				{
					name = "Side";
					value = 2;
					default = 1;
				};
			};
		};

		class tittle
		{
			displayName = "Intel's Tittle";
			typeName = "STRING";
		};

		class text
		{
			displayName = "Intel's Text";
			typeName = "STRING";
		};

		class marker
		{
			displayName = "Marker Name";
			typeName = "STRING";
		};

		class delete
		{
			displayName = "Delete Object After";
			description = "Shoul the object be deleted after using it";
			typeName = "BOOL";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = true;
				};
				class Disabled
				{
					name = "No";
					value = false;
					default = 1;
				};
			};
		};

	};

	class ModuleDescription: ModuleDescription
	{
		description = "Sync it with any object or unit to create an intel. Players can interact with it and  get info";
		sync[] = {"Anything"};

		class Anything
		{
			description = "Any object/vehicle/unit.";
			displayName = "Any object/vehicle/unit";
			side = 4;
			position = 1;
			direction = 1;
			optional = 0;
			duplicate = 1;
		};
	};
};