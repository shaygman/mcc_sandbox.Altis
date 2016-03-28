class MCC_TentDome : Launcher_Base_F
{
	displayName = "Respawn Tent (khaki MCC)";
	descriptionShort = "Allow players from your group respawn near the tent if no enemies nearby for a limited time";
	picture = "\mcc_sandbox_mod\data\tentFoldedKhaki.paa";
	model = "\A3\Structures_F\Civ\Camping\Ground_sheet_folded_khaki_F.p3d";
	author = "MCC-Team";
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
	displayName = "Respawn Tent (OPFOR MCC)";
	picture = "\mcc_sandbox_mod\data\tentFoldedOPFOR.paa";
	model = "\A3\Structures_F\Civ\Camping\Ground_sheet_folded_OPFOR_F.p3d";
};

class MCC_axe_fire : MCC_TentDome
{
	scope = 2;
	displayName = "Fire Axe(MCC)";
	picture = "\mcc_sandbox_mod\data\items\axe_fire.paa";
	model = "\A3\Structures_F\Items\Tools\Axe_fire_F.p3d";
};

class MCC_axe : MCC_TentDome
{
	scope = 2;
	displayName = "Axe(MCC)";
	picture = "\mcc_sandbox_mod\data\items\axe.paa";
	model = "\A3\Structures_F\Items\Tools\Axe_F.p3d";
};

class MCC_shovel : MCC_TentDome
{
	scope = 2;
	displayName = "Shovel(MCC)";
	picture = "\mcc_sandbox_mod\data\items\shovel.paa";
	model = "\A3\Structures_F_EPA\Items\Tools\Shovel_F.p3d";
};

class MCC_ItemCore: ItemCore {
    type = 4096;
    detectRange = -1;
    simulation = "ItemMineDetector";
    author = "MCC-Team";
};

class MCC_Item: InventoryItem_Base_f
{
	mass = 10;
	uniformModel = "\A3\weapons_F\ammo\mag_univ.p3d";
	descriptionShort = "";
};

class MCC_videoProbe : MCC_ItemCore
{
	scope = 2;
	displayName = "Tactical Video Probe(MCC)";
	descriptionShort = "Enables mirroring under doors.";
	picture = "\mcc_sandbox_mod\data\tacticalProbe.paa";
	model = "\A3\Weapons_F\Items\MineDetector";
	class ItemInfo : MCC_Item
	{
		mass = 30;
		allowedSlots[] = {801,701,901};
	};
};

class MCC_multiTool : MCC_ItemCore
{
	scope = 2;
	displayName = "Multi-tool(MCC)";
	descriptionShort = "Enables picklocking, defusing and opening beers.";
	picture = "\mcc_sandbox_mod\data\multitool.paa";
	model = "\A3\Structures_F\Items\Tools\Pliers_F.p3d";
	class ItemInfo : MCC_Item
	{
		mass = 10;
	};
};

class MCC_headTorch : MCC_ItemCore
{
	scope = 2;
	displayName = "Head Torch(MCC)";
	descriptionShort = "Gold diggers starter kit.";
	picture = "\mcc_sandbox_mod\data\items\headTorch.paa";
	model = "\A3\Weapons_F\Items\MineDetector";
	class ItemInfo : MCC_Item
	{
		mass = 5;
	};
};

//========================== misc items ==========================

class MCC_ammoBoxMag : MCC_ItemCore
{
	scope = 2;
	displayName = "Ammo Box(MCC)";
	descriptionShort = "Ressuply nearby players.";
	picture = "\mcc_sandbox_mod\data\items\ammoBox.paa";
	model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d";
	value = 50;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 50;
	};
};


class MCC_antibiotics : MCC_ItemCore
{
	scope = 2;
	displayName = "Antibiotics(MCC)";
	descriptionShort = "Destroy or slow down the growth of bacteria, cures sickness.";
	picture = "\mcc_sandbox_mod\data\items\antibiotics.paa";
	model = "\A3\Structures_F_EPA\Items\Medical\Antibiotic_F.p3d";
	mcc_surviveType = "med";
	value = 50;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 5;
	};
};

class MCC_painkillers : MCC_antibiotics
{
	displayName = "Painkillers(MCC)";
	descriptionShort = "Good for a headache or a gun wound temporary cure sickness.";
	picture = "\mcc_sandbox_mod\data\items\painkillers.paa";
	model = "\A3\Structures_F_EPA\Items\Medical\PainKillers_F.p3d";
	value = 30;
};


class MCC_bandage : MCC_antibiotics
{
	displayName = "Bandage(MCC)";
	descriptionShort = "So you won't bleed all over the carpet.";
	picture = "\mcc_sandbox_mod\data\items\bandage.paa";
	model = "\A3\Structures_F_EPA\Items\Medical\Bandage_F.p3d";
	value = 10;
};

class MCC_epipen : MCC_antibiotics
{
	displayName = "Epipen(MCC)";
	descriptionShort = "What I need is a big fat magic marker. Revive downed unconscious soldiers";
	picture = "\mcc_sandbox_mod\data\items\epipen.paa";
	model = "\A3\Structures_F\Items\Stationery\PencilYellow_F.p3d";
	value = 40;
};

class MCC_salineBag : MCC_antibiotics
{
	displayName = "Saline Bag(MCC)";
	descriptionShort = "I'm all out of blood i'm so lost with out you. Recover from blood loss effects";
	picture = "\mcc_sandbox_mod\data\items\saline.paa";
	model = "\A3\Structures_F_EPA\Items\Medical\BloodBag_F.p3d";
	value = 40;
	class ItemInfo : MCC_Item
	{
		mass = 15;
	};
};

class MCC_firstAidKit : MCC_antibiotics
{
	displayName = "First aid kit(MCC)";
	descriptionShort = "Heals completely";
	picture = "\mcc_sandbox_mod\data\items\firstaidKit.paa";
	model = "\A3\Weapons_F\Items\Medikit";
	value = 50;
	class ItemInfo : MCC_Item
	{
		mass = 40;
	};
};

class MCC_waterpure : MCC_antibiotics
{
	displayName = "Water purification tablets(MCC)";
	descriptionShort = "In this forsaken place water purifications tabs are the common coin";
	picture = "\mcc_sandbox_mod\data\items\waterpure.paa";
	model = "\A3\Structures_F_EPA\Items\Medical\WaterPurificationTablets_F.p3d";
	value = 0.1;
	class ItemInfo : MCC_Item
	{
		mass = 1;
	};
};

class MCC_vitamine : MCC_antibiotics
{
	displayName = "Vitamins(MCC)";
	descriptionShort = "Age with style";
	picture = "\mcc_sandbox_mod\data\items\vitamine.paa";
	model = "\A3\Structures_F_EPA\Items\Medical\VitaminBottle_F.p3d";
	value = 20;
};

class MCC_fuelCan : MCC_ItemCore
{
	scope = 2;
	displayName = "Fuel canister(MCC)";
	descriptionShort = "Refuel vehicles.";
	picture = "\mcc_sandbox_mod\data\items\CanisterFuel.paa";
	model = "\A3\Structures_F\Items\Vessels\CanisterFuel_F.p3d";
	mcc_surviveType = "fuel";
	value = 50;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 50;
	};
};

class MCC_fuelCan_empty : MCC_ItemCore
{
	scope = 2;
	displayName = "Fuel canister - Empty(MCC)";
	descriptionShort = "Good for a stealing some fuel from your neighbor car.";
	picture = "\mcc_sandbox_mod\data\items\CanisterFuelEmpty.paa";
	model = "\A3\Structures_F\Items\Vessels\CanisterFuel_F.p3d";
	mcc_surviveType = "fuel";
	value = 10;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 10;
	};
};

class MCC_fuelbot : MCC_ItemCore
{
	scope = 2;
	displayName = "Fuel bottle(MCC)";
	descriptionShort = "Refuel vehicles.";
	picture = "\mcc_sandbox_mod\data\items\bottle_fuel.paa";
	model = "\A3\Structures_F\Items\Food\BottlePlastic_V1_F.p3d";
	mcc_surviveType = "fuel";
	value = 10;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 7;
	};
};

class MCC_ductTape : MCC_ItemCore
{
	scope = 2;
	displayName = "Duct Tape(MCC)";
	picture = "\mcc_sandbox_mod\data\items\ductTape.paa";
	model = "\A3\Structures_F_EPA\Items\Tools\DuctTape_F.p3d";
	mcc_surviveType = "repair";
	value = 10;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 3;
	};
};

class MCC_butanetorch : MCC_ItemCore
{
	scope = 2;
	displayName = "Butane torch(MCC)";
	picture = "\mcc_sandbox_mod\data\items\butanetorch.paa";
	model = "\A3\Structures_F_EPA\Items\Tools\ButaneTorch_F.p3d";
	mcc_surviveType = "repair";
	value = 30;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 15;
	};
};

class MCC_oilcan : MCC_ItemCore
{
	scope = 2;
	displayName = "Oil canister(MCC)";
	picture = "\mcc_sandbox_mod\data\items\oilcan.paa";
	model = "\A3\Structures_F\Items\Vessels\CanisterOil_F.p3d";
	mcc_surviveType = "repair";
	value = 40;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 20;
	};
};

class MCC_metalwire : MCC_ItemCore
{
	scope = 2;
	displayName = "Scrap Metal(MCC)";
	picture = "\mcc_sandbox_mod\data\items\metalwire.paa";
	model = "\A3\Structures_F_EPA\Items\Tools\MetalWire_F.p3d";
	mcc_surviveType = "repair";
	value = 30;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 7;
	};
};

class MCC_carBat : MCC_ItemCore
{
	scope = 2;
	displayName = "Car Battery(MCC)";
	picture = "\mcc_sandbox_mod\data\items\carBat.paa";
	model = "\A3\Structures_F_Bootcamp\Items\Electronics\CarBattery_02_F.p3d";
	mcc_surviveType = "repair";
	value = 50;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 40;
	};
};

class MCC_screwdriver : MCC_ItemCore
{
	scope = 2;
	displayName = "Screwdriver(MCC)";
	descriptionShort = "Fix stuff or open a tuna.";
	picture = "\mcc_sandbox_mod\data\items\screwdriver.paa";
	model = "\A3\Structures_F\Items\Tools\Screwdriver_V1_F.p3d";
	mcc_surviveType = "repair";
	value = 15;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 2;
	};
};

class MCC_matches : MCC_ItemCore
{
	scope = 2;
	displayName = "Matches(MCC)";
	descriptionShort = "Combined with dry wood can make awsome fire.";
	picture = "\mcc_sandbox_mod\data\items\matches.paa";
	model = "\A3\Structures_F_EPA\Items\Tools\Matches_F.p3d";
	mcc_surviveType = "repair";
	value = 2;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 1;
	};
};

class MCC_foodcontainer : MCC_ItemCore
{
	scope = 2;
	displayName = "Food container(MCC)";
	descriptionShort = "Hope it still fresh.";
	picture = "\mcc_sandbox_mod\data\items\foodcontainer.paa";
	model = "\A3\Structures_F_Bootcamp\Items\Food\FoodContainer_01_F.p3d";
	mcc_surviveType = "food";
	value = 50;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 25;
	};
};

class MCC_cerealbox : MCC_ItemCore
{
	scope = 2;
	displayName = "Cereal box(MCC)";
	descriptionShort = "My kingdom for a glass of milk.";
	picture = "\mcc_sandbox_mod\data\items\cerealbox.paa";
	model = "\A3\Structures_F_EPA\Items\Food\CerealsBox_F.p3d";
	mcc_surviveType = "food";
	value = 20;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 8;
	};
};

class MCC_bakedBeans : MCC_ItemCore
{
	scope = 2;
	displayName = "Baked Beans(MCC)";
	descriptionShort = "Mmm wonder how can I open it";
	picture = "\mcc_sandbox_mod\data\items\bakedBeans.paa";
	model = "\A3\Structures_F_EPA\Items\Food\BakedBeans_F.p3d";
	mcc_surviveType = "food";
	value = 10;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 8;
	};
};

class MCC_bakedBeans_open : MCC_ItemCore
{
	scope = 2;
	displayName = "Baked Beans - Open(MCC)";
	descriptionShort = "Clear backblast!!!";
	picture = "\mcc_sandbox_mod\data\items\bakedBeans_open.paa";
	model = "\A3\Structures_F_EPA\Items\Food\BakedBeans_F.p3d";
	mcc_surviveType = "food";
	value = 10;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 8;
	};
};

class MCC_bacon : MCC_ItemCore
{
	scope = 2;
	displayName = "Tactical Bacon(MCC)";
	descriptionShort = "Mmm wonder how can I open it";
	picture = "\mcc_sandbox_mod\data\items\bacon.paa";
	model = "\A3\Structures_F\Items\Food\TacticalBacon_F.p3d";
	mcc_surviveType = "food";
	value = 10;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 8;
	};
};

class MCC_bacon_open : MCC_ItemCore
{
	scope = 2;
	displayName = "Tactical Bacon - Open(MCC)";
	descriptionShort = "Where is PETA when we need them ";
	picture = "\mcc_sandbox_mod\data\items\bacon_open.paa";
	model = "\A3\Structures_F\Items\Food\TacticalBacon_F.p3d";
	mcc_surviveType = "food";
	value = 10;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 8;
	};
};

class MCC_rice : MCC_ItemCore
{
	scope = 2;
	displayName = "Rice(MCC)";
	descriptionShort = "I pretty sure you have to cook it first";
	picture = "\mcc_sandbox_mod\data\items\rice.paa";
	model = "\A3\Structures_F_EPA\Items\Food\RiceBox_F.p3d";
	mcc_surviveType = "food";
	value = 30;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 16;
	};
};

class MCC_bottle_water : MCC_ItemCore
{
	scope = 2;
	displayName = "Bottle - Clean Water(MCC)";
	picture = "\mcc_sandbox_mod\data\items\bottle_water.paa";
	model = "\A3\Structures_F\Items\Food\BottlePlastic_V1_F.p3d";
	mcc_surviveType = "food";
	value = 10;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 8;
	};
};

class MCC_bottle_murky : MCC_ItemCore
{
	scope = 2;
	displayName = "Bottle - Murky Water(MCC)";
	descriptionShort = "Looks like a little aquarium";
	picture = "\mcc_sandbox_mod\data\items\bottle_murky.paa";
	model = "\A3\Structures_F\Items\Food\BottlePlastic_V1_F.p3d";
	mcc_surviveType = "food";
	value = 2;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 8;
	};
};

class MCC_bottle_empty : MCC_ItemCore
{
	scope = 2;
	displayName = "Bottle - Empty(MCC)";
	descriptionShort = "Fill with water or fuel just dont drink the last one";
	picture = "\mcc_sandbox_mod\data\items\bottle_empty.paa";
	model = "\A3\Structures_F\Items\Food\BottlePlastic_V1_F.p3d";
	mcc_surviveType = "food";
	value = 0;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 3;
	};
};

class MCC_canteenWater : MCC_ItemCore
{
	scope = 2;
	displayName = "Canteen - Clean Water(MCC)";
	picture = "\mcc_sandbox_mod\data\items\canteenWater.paa";
	model = "\A3\Structures_F\Items\Food\BottlePlastic_V1_F.p3d";
	mcc_surviveType = "food";
	value = 10;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 8;
	};
};

class MCC_canteenMurky : MCC_ItemCore
{
	scope = 2;
	displayName = "Canteen - Murky Water(MCC)";
	picture = "\mcc_sandbox_mod\data\items\canteenMurky.paa";
	model = "\A3\Structures_F\Items\Food\BottlePlastic_V1_F.p3d";
	mcc_surviveType = "food";
	value = 2;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 8;
	};
};

class MCC_canteen : MCC_ItemCore
{
	scope = 2;
	displayName = "Canteen - Empty(MCC)";
	descriptionShort = "Fill with water";
	picture = "\mcc_sandbox_mod\data\items\canteen.paa";
	model = "\A3\Structures_F\Items\Food\BottlePlastic_V1_F.p3d";
	mcc_surviveType = "food";
	value = 0;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 3;
	};
};

class MCC_powderedMilk : MCC_ItemCore
{
	scope = 2;
	displayName = "Powdered Milk(MCC)";
	picture = "\mcc_sandbox_mod\data\items\powderedMilk.paa";
	model = "\A3\Structures_F_EPA\Items\Food\PowderedMilk_F.p3d";
	mcc_surviveType = "food";
	value = 15;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 4;
	};
};

class MCC_franta : MCC_ItemCore
{
	scope = 2;
	displayName = "Franta(MCC)";
	picture = "\mcc_sandbox_mod\data\items\franta.paa";
	model = "\A3\Structures_F\Items\Food\Can_V2_F.p3d";
	mcc_surviveType = "food";
	value = 15;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 3;
	};
};

class MCC_RedGull : MCC_ItemCore
{
	scope = 2;
	displayName = "RedGull(MCC)";
	picture = "\mcc_sandbox_mod\data\items\RedGull.paa";
	model = "\A3\Structures_F\Items\Food\Can_V3_F.p3d";
	mcc_surviveType = "food";
	value = 15;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 3;
	};
};

class MCC_Spirit : MCC_ItemCore
{
	scope = 2;
	displayName = "Spirit(MCC)";
	picture = "\mcc_sandbox_mod\data\items\Spirit.paa";
	model = "\A3\Structures_F\Items\Food\Can_V1_F.p3d";
	mcc_surviveType = "food";
	value = 15;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 3;
	};
};

class MCC_can_dented : MCC_ItemCore
{
	scope = 2;
	displayName = "Used Can(MCC)";
	picture = "\mcc_sandbox_mod\data\items\can_dented.paa";
	model = "\A3\Structures_F\Items\Food\Can_Dented_F.p3d";
	mcc_surviveType = "food";
	value = 1;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 1;
	};
};

class MCC_fruit1 : MCC_rice
{
	displayName = "Strange fruit(MCC)";
	picture = "\mcc_sandbox_mod\data\items\fruit1.paa";
	model = "\A3\weapons_F\ammo\mag_univ.p3d";
	value = 5;
	class ItemInfo : MCC_Item
	{
		mass = 2;
	};
};


class MCC_fruit2 : MCC_fruit1
{
	displayName = "Strange fruit(MCC)";
	picture = "\mcc_sandbox_mod\data\items\fruit2.paa";
	model = "\A3\weapons_F\ammo\mag_univ.p3d";
};

class MCC_canOpener : MCC_ItemCore
{
	scope = 2;
	displayName = "Can Opener(MCC)";
	picture = "\mcc_sandbox_mod\data\items\canOpener.paa";
	model = "\A3\Structures_F_EPA\Items\Tools\CanOpener_F.p3d";
	value = 5;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 5;
	};
};

class MCC_wood : MCC_ItemCore
{
	scope = 2;
	displayName = "Dry Wood(MCC)";
	descriptionShort = "Find some matches to make fire";
	picture = "\mcc_sandbox_mod\data\items\wood.paa";
	model = "\A3\Structures_F\Civ\Accessories\WoodPile_F.p3d";
	value = 5;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 20;
	};
};

class MCC_battery : MCC_ItemCore
{
	scope = 2;
	displayName = "battery(MCC)";
	picture = "\mcc_sandbox_mod\data\items\battery.paa";
	model = "\A3\Structures_F\Civ\Accessories\WoodPile_F.p3d";
	value = 5;
	count = 1;
	class ItemInfo : MCC_Item
	{
		mass = 1;
	};
};