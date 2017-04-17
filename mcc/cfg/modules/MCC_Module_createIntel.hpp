class MCC_Module_createIntel : Module_F
{
	category = "MCC";
	displayName = "Intel";
	function = "MCC_fnc_curatorSetIntel";
	scope = 2;
	isGlobal = 0;

	class Attributes : AttributesBase
	{
		class shared : Combo
		{
			displayName = "Shared With";
			description = "Who will get the intel notification";
			typeName = "NUMBER";
			property = "shared";

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

		class tittle : Edit
		{
			displayName = "Intel's Tittle";
			typeName = "STRING";
			defaultValue = """Tittle""";
			property = "tittle";
		};

		class text : Edit
		{
			displayName = "Intel's Text";
			typeName = "STRING";
			defaultValue = """Text""";
			property = "text";
		};

		class marker : Edit
		{
			displayName = "Marker Name";
			typeName = "STRING";
			defaultValue = """Marker""";
			property = "marker";
		};

		class delete : Checkbox
		{
			displayName = "Delete Object After";
			description = "Should the object be deleted after using it";
			typeName = "BOOL";
			property = "delete";
		};

		class ModuleDescription: ModuleDescription{};
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