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
class MineDetector;
class MCC_ItemCore: MineDetector
{
    type = 4096;
    detectRange = -1;
    simulation = "ItemMineDetector";
    scope = 1;
};

class MCC_Item: InventoryItem_Base_f
{
	mass = 10;
	uniformModel = "\A3\weapons_F\ammo\mag_univ.p3d";
	allowedSlots[] = {801,701,901};
}

class MCC_videoProbe : MCC_ItemCore
{
	scope = 2;
	displayName = "Tactical Video Probe";
	descriptionShort = "Enables mirroring under doors.";
	picture = "\mcc_sandbox_mod\data\tacticalProbe.paa";
	model = "\A3\Weapons_F\Items\MineDetector";
	class ItemInfo : MCC_Item
	{
		mass = 30;
	};
};

class MCC_multiTool : MCC_ItemCore
{
	scope = 2;
	displayName = "Multi-tool";
	descriptionShort = "Enables picklocking, defusing and opening beers.";
	picture = "\mcc_sandbox_mod\data\multitool.paa";
	model = "\A3\Structures_F\Items\Tools\Pliers_F.p3d";
	class ItemInfo : MCC_Item
	{
		mass = 10;
	};
};

class MCC_axe_fire : MCC_ItemCore
{
	scope = 2;
	displayName = "Fire Axe";
	picture = "\mcc_sandbox_mod\data\items\axe_fire.paa";
	model = "\A3\Structures_F\Items\Tools\Axe_fire_F.p3d";
	class ItemInfo : MCC_Item
	{
		mass = 40;
	};
};

class MCC_axe : MCC_ItemCore
{
	scope = 2;
	displayName = "Axe";
	picture = "\mcc_sandbox_mod\data\items\axe.paa";
	model = "\A3\Structures_F\Items\Tools\Axe_F.p3d";
	class ItemInfo : MCC_Item
	{
		mass = 40;
	};
};

class MCC_shovel : MCC_ItemCore
{
	scope = 2;
	displayName = "Shovel";
	picture = "\mcc_sandbox_mod\data\items\shovel.paa";
	model = "\A3\Structures_F_EPA\Items\Tools\Shovel_F.p3d";
	class ItemInfo : MCC_Item
	{
		mass = 40;
	};
};

class MCC_headTorch : MCC_ItemCore
{
	scope = 2;
	displayName = "Head Torch";
	descriptionShort = "Gold diggers starter kit.";
	picture = "\mcc_sandbox_mod\data\items\headTorch.paa";
	model = "\A3\Weapons_F\Items\MineDetector";
	class ItemInfo : MCC_Item
	{
		mass = 5;
	};
};