class MCC_TentDome : Launcher_Base_F 
{
	displayName = "Respawn Tent (khaki)";
	descriptionShort = "Allow players from your group respawn near the tent if no enemies nearby for a limited time";
	picture = "\mcc_sandbox_mod\data\tentFoldedKhaki.paa";
	model = "\A3\Structures_F\Civ\Camping\Ground_sheet_folded_khaki_F.p3d";
	magazines[] = {};
	canLock = 0;
	tBody = 100;
	weight = 0;
	value = 4;
	type = 4; 
	simulation = "Weapon";
	scope = 2;
};

class MCC_TentA : MCC_TentDome 
{
	displayName = "Respawn Tent (OPFOR)";
	picture = "\mcc_sandbox_mod\data\tentFoldedOPFOR.paa";
	model = "\A3\Structures_F\Civ\Camping\Ground_sheet_folded_OPFOR_F.p3d";
};

class MCC_videoProbe : itemCore 
{
	scope = 2;
	displayName = "Tactical Video Probe";
	descriptionShort = "Enables mirroring under doors.";
	picture = "\mcc_sandbox_mod\data\tacticalProbe.paa";
	model = "\A3\Weapons_F\Items\MineDetector";
	class ItemInfo 
	{
		allowedSlots[] = {801,701,901};
		mass = 30;
		type = 201;
	};
};

class MCC_multiTool : itemCore 
{
	scope = 2;
	displayName = "Multi-tool";
	descriptionShort = "Enables picklocking, defusing and opening beers.";
	picture = "\mcc_sandbox_mod\data\multitool.paa";
	model = "\A3\Structures_F\Items\Tools\Pliers_F.p3d";
	class ItemInfo
	{
		allowedSlots[] = {801,701,901};
		mass = 10;
		type = 201;
	};
};