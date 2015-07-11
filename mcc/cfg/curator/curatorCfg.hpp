class MCC_Module_Base : Module_F
{
	access = 0;
	author = "shay_gman";
	vehicleClass = "Modules";
	category = "MCC";
	icon = "\mcc_sandbox_mod\data\mccModule.paa";
	picture = "";
	portrait = "\mcc_sandbox_mod\data\mccModule.paa";

	scope = 1;
	scopeCurator = 1;

	displayName = "MCC Module";

	function = "";
	functionPriority = 1;
	isGlobal = 1;
	isTriggerActivated = 0;
	isDisposable = 0;


	class Arguments {};
	class ModuleDescription: ModuleDescription
	{
		description = "";
	};
};

class MCC_Module_addUnitsToZeus : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "Add To Zeus";
	function = "MCC_fnc_addToZeus";
};

class MCC_Module_ambientCivilians : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "Ambient units";
	function = "MCC_fnc_curatorAmbientCivilians";
	scope = 2;
	isGlobal = 0;
	class Arguments
	{
		class isCiv
		{
			displayName = "Ambient Patrols";
			description = "Units will move between buildings";
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

		class isCar
		{
			displayName = "Ambient Cars";
			description = "Cars will spawn and drive around";
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

		class isParkedCar
		{
			displayName = "Parked Cars";
			description = "Empty cars will spawn on the road's sides";
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

		class isLocked
		{
			displayName = "Parked Cars Locked";
			description = "Parked cars will always be locked";
			typeName = "NUMBER";
			class values
			{
				class Enabled
				{
					name = "Yes";
					value = 1;
				};
				class Disabled
				{
					name = "No";
					value = 0;
					default = 1;
				};
			};
		};

		class factionCiv
		{
			displayName = "Faction";
			description = "Config name";
			defaultValue = "CIV_F";
		};

		class factionCivCar
		{
			displayName = "Car's Faction";
			description = "Config name";
			defaultValue = "CIV_F";
		};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Server side: spawn AI around players when next to towns and despawn them when no player around";
	};
};

class ModuleCASGun_F;
class MCC_Module_MCCCAS : ModuleCASGun_F
{
	scopeCurator = 2;
	curatorInfoType = "";
	icon = "\mcc_sandbox_mod\data\mccModule.paa";
	portrait = "\mcc_sandbox_mod\data\mccModule.paa";

	category = "MCC";
	displayName = "CAS";
	model = "\a3\Modules_F_Curator\CAS\surfaceGun.p3d";
	function = "MCC_fnc_curatorMCCCAS";
};

class MCC_Module_createEvac : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "Evac Vehicle";
	function = "MCC_fnc_curatorSetEvac";
};

class MCC_Module_createIED : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "IED/Suicide Bomber";
	function = "MCC_fnc_curatorSetIED";
};

class MCC_Module_createArmedCivilian : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "Armed Civilian";
	function = "MCC_fnc_curatorSetArmedCivilian";
};

class MCC_Module_nightEffects : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "Night Effects";
	function = "MCC_fnc_curatorNightEffects";
};

class MCC_Module_lockDoors : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "Doors Lock/Unlock";
	function = "MCC_fnc_curatorDoorLock";
};

class MCC_Module_atmosphere : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "Atmosphere";
	function = "MCC_fnc_curatorAtmoshphere";
};

class MCC_Module_warZone : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "War Zone Effect";
	function = "MCC_fnc_curatorWarZone";
};

class MCC_Module_garrisonBuildings : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "Garrison";
	function = "MCC_fnc_curatorGarrisonUnits";
};

class MCC_Module_damagePart : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "Damage Part";
	function = "MCC_fnc_curatorDamagePart";
};

class MCC_Module_vehicleSpawnerCurator : MCC_Module_Base
{
	scopeCurator = 2;
	category = "MCC";
	displayName = "Vehicle Kiosk";
	function = "MCC_fnc_curatorVehicleSpawner";
};

class MCC_Module_campaignInit : MCC_Module_Base
{
	scopeCurator = 2;
	scope = 2;
	isGlobal = 0;
	category = "MCC";
	displayName = "Start Campaign";
	function = "MCC_fnc_curatorCampaignInit";

	class Arguments
	{
		class factionPlayer
		{
			displayName = "Players Faction";
			description = "Config name";
			defaultValue = "BLU_F";
		};

		class factionEnemy
		{
			displayName = "Enemy Faction";
			description = "Config name";
			defaultValue = "OPF_F";
		};

		class factionCiv
		{
			displayName = "Civilian Faction";
			description = "Config name";
			defaultValue = "CIV_F";
		};

		class missionMax
		{
			displayName = "Number of Missions";
			description = "Untill Campaign Ends";
			typeName = "NUMBER";
			class values
			{
				class five
				{
					name = "5";
					value = 5;
				};
				class ten
				{
					name = "10";
					value = 10;
					default = 1;
				};
				class fifteen
				{
					name = "15";
					value = 15;
				};
				class unlimited
				{
					name = "unlimited";
					value = 9999;
				};
			};
		};

		class difficulty
		{
			displayName = "Difficulty";
			typeName = "NUMBER";
			class values
			{
				class easy
				{
					name = "Easy";
					value = 10;
				};
				class Medium
				{
					name = "Medium";
					value = 20;
					default = 1;
				};
				class Hard
				{
					name = "Hard";
					value = 40;
				};
			};
		};
	};

	class ModuleDescription: ModuleDescription
	{
		description = "Creates a Campaign. MCC will generate missions and the players will gain resources to expend their base. Every in game day the enemy faction behavior will change according to the players advance";
		sync[] = {"mcc_sandbox_moduleStartLocations","mcc_sandbox_moduleMissionSettings"};

		class mcc_sandbox_moduleStartLocations
		{
			description[] = {
				"Set at least one H.Q start location"
			};
			position = 0;
			direction = 0;
			optional = 0;
			duplicate = 0;
			synced[] = {"AnyVehicle"};
		};
		class mcc_sandbox_moduleMissionSettings
		{
			description[] = {
				"Recommanded to use Role Selection and time acceleration"
			};
			position = 0;
			direction = 0;
			optional = 0;
			duplicate = 0;
			synced[] = {"AnyVehicle"};
		};
	};
};