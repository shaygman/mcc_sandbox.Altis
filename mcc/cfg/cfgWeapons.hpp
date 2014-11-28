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
		type = 619;
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
		type = 619;
	};
};

class MCC_Item: InventoryItem_Base_f 
{
	mass = 10;
	allowedSlots[] = {801,701,901};
	uniformModel = "\A3\weapons_F\ammo\mag_univ.p3d";
	type = 619;
}

class MCC_antibiotics : itemCore 
{
	scope = 2;
	displayName = "Antibiotics";
	descriptionShort = "Destroy or slow down the growth of bacteria.";
	picture = "\mcc_sandbox_mod\data\items\antibiotics.paa";
	model = "\A3\Structures_F_EPA\Items\Medical\Antibiotic_F.p3d";
	mcc_surviveType = "med";
	mcc_surviveValue = 50;
	class ItemInfo : MCC_Item
	{
		mass = 10;
	};
};

class MCC_painkillers : MCC_antibiotics 
{
	displayName = "Painkillers";
	descriptionShort = "Good for a headache or a gun wound.";
	picture = "\mcc_sandbox_mod\data\items\painkillers.paa";
	model = "\A3\Structures_F_EPA\Items\Medical\PainKillers_F.p3d";
	mcc_surviveValue = 30;
};

class MCC_bandage : MCC_antibiotics 
{
	displayName = "Bandage";
	descriptionShort = "So you won't bleed all over the carpet.";
	picture = "\mcc_sandbox_mod\data\items\bandage.paa";
	model = "\A3\Structures_F_EPA\Items\Medical\Bandage_F.p3d";
	mcc_surviveValue = 10;
};

class MCC_waterpure : MCC_antibiotics 
{
	displayName = "Water purification tablets";
	descriptionShort = "In this forsaken place water purifications tabs are the common coin";
	picture = "\mcc_sandbox_mod\data\items\waterpure.paa";
	model = "\A3\Structures_F_EPA\Items\Medical\WaterPurificationTablets_F.p3d";
	mcc_surviveValue = 0.1;
	class ItemInfo : MCC_Item
	{
		mass = 0.1;
	};
};

class MCC_fruit1 : MCC_waterpure 
{
	displayName = "Strange fruit";
	picture = "\mcc_sandbox_mod\data\items\fruit1.paa";
	model = "\A3\weapons_F\ammo\mag_univ.p3d";
	mcc_surviveValue = 1;
	class ItemInfo : MCC_Item
	{
		mass = 1;
	};
};

class MCC_fruit2 : MCC_fruit1 
{
	displayName = "Strange fruit";
	picture = "\mcc_sandbox_mod\data\items\fruit2.paa";
	model = "\A3\weapons_F\ammo\mag_univ.p3d";
};
	
class MCC_vitamine : MCC_antibiotics 
{
	displayName = "Vitamins";
	descriptionShort = "Age with style";
	picture = "\mcc_sandbox_mod\data\items\vitamine.paa";
	model = "\A3\Structures_F_EPA\Items\Medical\VitaminBottle_F.p3d";
	mcc_surviveValue = 20;
};

class MCC_fuelCan : itemCore 
{
	scope = 2;
	displayName = "Fuel canister";
	picture = "\mcc_sandbox_mod\data\items\fuelCan.paa";
	model = "\A3\Structures_F\Items\Vessels\CanisterFuel_F.p3d";
	mcc_surviveType = "fuel";
	mcc_surviveValue = 50;
	class ItemInfo : MCC_Item 
	{
		mass = 100;
	};
};

class MCC_fuelbot : itemCore 
{
	scope = 2;
	displayName = "Fuel bottle";
	picture = "\mcc_sandbox_mod\data\items\fuelbot.paa";
	model = "\A3\Structures_F\Items\Food\BottlePlastic_V1_F.p3d";
	mcc_surviveType = "fuel";
	mcc_surviveValue = 10;
	class ItemInfo : MCC_Item 
	{
		mass = 30;
	};
};

class MCC_ductTape : itemCore 
{
	scope = 2;
	displayName = "Duct Tape";
	picture = "\mcc_sandbox_mod\data\items\ductTape.paa";
	model = "\A3\Structures_F_EPA\Items\Tools\DuctTape_F.p3d";
	mcc_surviveType = "repair";
	mcc_surviveValue = 10;
	class ItemInfo : MCC_Item 
	{
		mass = 5;
	};
};

class MCC_butanetorch : itemCore 
{
	scope = 2;
	displayName = "Butane torch";
	picture = "\mcc_sandbox_mod\data\items\butanetorch.paa";
	model = "\A3\Structures_F_EPA\Items\Tools\ButaneTorch_F.p3d";
	mcc_surviveType = "repair";
	mcc_surviveValue = 30;
	class ItemInfo : MCC_Item 
	{
		mass = 30;
	};
};

class MCC_oilcan : itemCore 
{
	scope = 2;
	displayName = "Oil canister";
	picture = "\mcc_sandbox_mod\data\items\oilcan.paa";
	model = "\A3\Structures_F\Items\Vessels\CanisterOil_F.p3d";
	mcc_surviveType = "repair";
	mcc_surviveValue = 40;
	class ItemInfo : MCC_Item 
	{
		mass = 40;
	};
};

class MCC_metalwire : itemCore 
{
	scope = 2;
	displayName = "Scrap Metal";
	picture = "\mcc_sandbox_mod\data\items\metalwire.paa";
	model = "\A3\Structures_F_EPA\Items\Tools\MetalWire_F.p3d";
	mcc_surviveType = "repair";
	mcc_surviveValue = 30;
	class ItemInfo : MCC_Item 
	{
		mass = 15;
	};
};

class MCC_carBat : itemCore 
{
	scope = 2;
	displayName = "Car Battery";
	picture = "\mcc_sandbox_mod\data\items\carBat.paa";
	model = "\A3\Structures_F_Bootcamp\Items\Electronics\CarBattery_02_F.p3d";
	mcc_surviveType = "repair";
	mcc_surviveValue = 50;
	class ItemInfo : MCC_Item 
	{
		mass = 80;
	};
};

class MCC_foodcontainer : itemCore 
{
	scope = 2;
	displayName = "Food container";
	picture = "\mcc_sandbox_mod\data\items\foodcontainer.paa";
	model = "\A3\Structures_F_Bootcamp\Items\Food\FoodContainer_01_F.p3d";
	mcc_surviveType = "food";
	mcc_surviveValue = 50;
	class ItemInfo : MCC_Item 
	{
		mass = 100;
	};
};

class MCC_cerealbox : itemCore 
{
	scope = 2;
	displayName = "Cereal box";
	picture = "\mcc_sandbox_mod\data\items\cerealbox.paa";
	model = "\A3\Structures_F_EPA\Items\Food\CerealsBox_F.p3d";
	mcc_surviveType = "food";
	mcc_surviveValue = 20;
	class ItemInfo : MCC_Item 
	{
		mass = 40;
	};
};

class MCC_bacon : itemCore 
{
	scope = 2;
	displayName = "Canned Food";
	picture = "\mcc_sandbox_mod\data\items\bacon.paa";
	model = "\A3\Structures_F\Items\Food\TacticalBacon_F.p3d";
	mcc_surviveType = "food";
	mcc_surviveValue = 10;
	class ItemInfo : MCC_Item 
	{
		mass = 20;
	};
};

class MCC_rice : itemCore 
{
	scope = 2;
	displayName = "Rice";
	picture = "\mcc_sandbox_mod\data\items\rice.paa";
	model = "\A3\Structures_F_EPA\Items\Food\RiceBox_F.p3d";
	mcc_surviveType = "food";
	mcc_surviveValue = 30;
	class ItemInfo : MCC_Item 
	{
		mass = 50;
	};
};