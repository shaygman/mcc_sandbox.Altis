class MCC_Module_RTSBuildings : Module_F
{
	category = "MCC";
	displayName = "(RTS)Buildings";
	function = "MCC_fnc_curatorRTSBuilding";
	scope = 2;
	isGlobal = 0;

	class Attributes : AttributesBase
	{
		class building : Combo
		{
			displayName = "Building";
			typeName = "STRING";
			property = "building";

			class values
			{
				class MCC_rts_storage1
				{
					name = "Storage Area";
					value = "MCC_rts_storage1";
					default = 1;
				};
				class MCC_rts_storage2
				{
					name = "Advanced Storage Area";
					value = "MCC_rts_storage2";
				};
				class MCC_rts_storage3
				{
					name = "Greater Storage Area";
					value = "MCC_rts_storage3";
				};
				class MCC_rts_barracks1
				{
					name = "Shooting Range - Basic";
					value = "MCC_rts_barracks1";
					default = 1;
				};
				class MCC_rts_barracks2
				{
					name = "Shooting Range - Advanced";
					value = "MCC_rts_barracks2";
				};
				class MCC_rts_barracks3
				{
					name = "Barracks";
					value = "MCC_rts_barracks3";
				};
				class MCC_rts_house1
				{
					name = "Sleeping Area";
					value = "MCC_rts_house1";
				};
				class MCC_rts_house2
				{
					name = "Sleeping Shack";
					value = "MCC_rts_house2";
				};
				class MCC_rts_house3
				{
					name = "Cargo House";
					value = "MCC_rts_house3";
				};
				class MCC_rts_tradepost1
				{
					name = "Trade Post";
					value = "MCC_rts_tradepost1";
				};
				class MCC_rts_workshop1
				{
					name = "Workshop";
					value = "MCC_rts_workshop1";
				};
				class MCC_rts_workshop2
				{
					name = "Advanced Workshop";
					value = "MCC_rts_workshop2";
				};
				class MCC_rts_workshop3
				{
					name = "Mechanic Workshop";
					value = "MCC_rts_workshop3";
				};
				class MCC_rts_workshop4
				{
					name = "Aerial Workshop";
					value = "MCC_rts_workshop4";
				};
				class MCC_rts_workshop5
				{
					name = "Jet Workshop";
					value = "MCC_rts_workshop5";
				};
				class MCC_rts_elecPower1
				{
					name = "Diesel Generator";
					value = "MCC_rts_elecPower1";
				};
				class MCC_rts_elecPower2
				{
					name = "Advanced Diesel Generator";
					value = "MCC_rts_elecPower2";
				};
				class MCC_rts_elecPower3
				{
					name = "Solar Generator";
					value = "MCC_rts_elecPower3";
				};
				class MCC_rts_triage1
				{
					name = "Infirmary";
					value = "MCC_rts_triage1";
				};
				class MCC_rts_triage2
				{
					name = "Medical Lab";
					value = "MCC_rts_triage2";
				};
			};
		};

		class side : Combo
		{
			displayName = "Side";
			typeName = "NUMBER";
			property = "side";

			class values
			{
				class BLUFOR
				{
					name = "$STR_WEST";
					value = 1;
					default = 1;
				};
				class OPFOR
				{
					name = "$STR_EAST";
					value = 0;
				};
				class Independent
				{
					name = "$STR_GUERRILA";
					value = 2;
				};
				class Civilian
				{
					name = "$STR_CIVILIAN";
					value = 3;
				};
			};
		};
		class ModuleDescription: ModuleDescription{};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Build RTS building instantly";
	};
};