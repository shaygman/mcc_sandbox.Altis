class MCC_ammoBoxMag : Item_Base_F
{
	scope = 2;
	displayName = "Ammo Box";
	picture = "\mcc_sandbox_mod\data\items\ammoBox.paa";
	model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d";
	value = 50;
	count = 1;
	mass = 50;
};
class MCC_antibiotics : Item_Base_F
{
	scope = 2;
	displayName = "Antibiotics";
	descriptionShort = "Destroy or slow down the growth of bacteria, cures sickness.";
	picture = "\mcc_sandbox_mod\data\items\antibiotics.paa";
	model = "\A3\Structures_F_EPA\Items\Medical\Antibiotic_F.p3d";
	mcc_surviveType = "med";
	value = 50;
	count = 1;
	mass = 5;
};

class MCC_painkillers : MCC_antibiotics
{
	displayName = "Painkillers";
	descriptionShort = "Good for a headache or a gun wound temporary cure sickness.";
	picture = "\mcc_sandbox_mod\data\items\painkillers.paa";
	model = "\A3\Structures_F_EPA\Items\Medical\PainKillers_F.p3d";
	value = 30;
};

class MCC_bandage : MCC_antibiotics
{
	displayName = "Bandage";
	descriptionShort = "So you won't bleed all over the carpet.";
	picture = "\mcc_sandbox_mod\data\items\bandage.paa";
	model = "\A3\Structures_F_EPA\Items\Medical\Bandage_F.p3d";
	value = 10;
};

class MCC_epipen : MCC_antibiotics
{
	displayName = "Epipen";
	descriptionShort = "What I need is a big fat magic marker";
	picture = "\mcc_sandbox_mod\data\items\epipen.paa";
	model = "\A3\Structures_F\Items\Stationery\PencilYellow_F.p3d";
	value = 40;
};

class MCC_salineBag : MCC_antibiotics
{
	displayName = "Saline Bag";
	descriptionShort = "I'm all out of blood i'm so lost with out you";
	picture = "\mcc_sandbox_mod\data\items\saline.paa";
	model = "\A3\Structures_F_EPA\Items\Medical\BloodBag_F.p3d";
	value = 40;
	mass = 15;
};

class MCC_firstAidKit : MCC_antibiotics
{
	displayName = "First aid kit";
	picture = "\mcc_sandbox_mod\data\items\firstaidKit.paa";
	model = "\A3\Weapons_F\Items\Medikit";
	value = 50;
	mass = 40;
};

class MCC_waterpure : MCC_antibiotics
{
	displayName = "Water purification tablets";
	descriptionShort = "In this forsaken place water purifications tabs are the common coin";
	picture = "\mcc_sandbox_mod\data\items\waterpure.paa";
	model = "\A3\Structures_F_EPA\Items\Medical\WaterPurificationTablets_F.p3d";
	value = 0.1;
	mass = 1;
};

class MCC_vitamine : MCC_antibiotics
{
	displayName = "Vitamins";
	descriptionShort = "Age with style";
	picture = "\mcc_sandbox_mod\data\items\vitamine.paa";
	model = "\A3\Structures_F_EPA\Items\Medical\VitaminBottle_F.p3d";
	value = 20;
};

class MCC_fuelCan : Item_Base_F
{
	scope = 2;
	displayName = "Fuel canister";
	descriptionShort = "Refuel vehicles.";
	picture = "\mcc_sandbox_mod\data\items\CanisterFuel.paa";
	model = "\A3\Structures_F\Items\Vessels\CanisterFuel_F.p3d";
	mcc_surviveType = "fuel";
	value = 50;
	count = 1;
	mass = 50;
};

class MCC_fuelCan_empty : Item_Base_F
{
	scope = 2;
	displayName = "Fuel canister - Empty";
	descriptionShort = "Good for a stealing some fuel from your neighbor car.";
	picture = "\mcc_sandbox_mod\data\items\CanisterFuelEmpty.paa";
	model = "\A3\Structures_F\Items\Vessels\CanisterFuel_F.p3d";
	mcc_surviveType = "fuel";
	value = 10;
	count = 1;
	mass = 10;
}

class MCC_fuelbot : Item_Base_F
{
	scope = 2;
	displayName = "Fuel bottle";
	descriptionShort = "Refuel vehicles.";
	picture = "\mcc_sandbox_mod\data\items\bottle_fuel.paa";
	model = "\A3\Structures_F\Items\Food\BottlePlastic_V1_F.p3d";
	mcc_surviveType = "fuel";
	value = 10;
	count = 1;
	mass = 7;
};

class MCC_ductTape : Item_Base_F
{
	scope = 2;
	displayName = "Duct Tape";
	picture = "\mcc_sandbox_mod\data\items\ductTape.paa";
	model = "\A3\Structures_F_EPA\Items\Tools\DuctTape_F.p3d";
	mcc_surviveType = "repair";
	value = 10;
	count = 1;
	mass = 3;
};

class MCC_butanetorch : Item_Base_F
{
	scope = 2;
	displayName = "Butane torch";
	picture = "\mcc_sandbox_mod\data\items\butanetorch.paa";
	model = "\A3\Structures_F_EPA\Items\Tools\ButaneTorch_F.p3d";
	mcc_surviveType = "repair";
	value = 30;
	count = 1;
	mass = 15;
};

class MCC_oilcan : Item_Base_F
{
	scope = 2;
	displayName = "Oil canister";
	picture = "\mcc_sandbox_mod\data\items\oilcan.paa";
	model = "\A3\Structures_F\Items\Vessels\CanisterOil_F.p3d";
	mcc_surviveType = "repair";
	value = 40;
	count = 1;
	mass = 20;
};

class MCC_metalwire : Item_Base_F
{
	scope = 2;
	displayName = "Scrap Metal";
	picture = "\mcc_sandbox_mod\data\items\metalwire.paa";
	model = "\A3\Structures_F_EPA\Items\Tools\MetalWire_F.p3d";
	mcc_surviveType = "repair";
	value = 30;
	count = 1;
	mass = 7;
};

class MCC_carBat : Item_Base_F
{
	scope = 2;
	displayName = "Car Battery";
	picture = "\mcc_sandbox_mod\data\items\carBat.paa";
	model = "\A3\Structures_F_Bootcamp\Items\Electronics\CarBattery_02_F.p3d";
	mcc_surviveType = "repair";
	value = 50;
	count = 1;
	mass = 40;
};

class MCC_screwdriver : Item_Base_F
{
	scope = 2;
	displayName = "Screwdriver";
	descriptionShort = "Fix stuff or open a tuna.";
	picture = "\mcc_sandbox_mod\data\items\screwdriver.paa";
	model = "\A3\Structures_F\Items\Tools\Screwdriver_V1_F.p3d";
	mcc_surviveType = "repair";
	value = 15;
	count = 1;
	mass = 2;
};

class MCC_matches : Item_Base_F
{
	scope = 2;
	displayName = "Matches";
	descriptionShort = "Combined with dry wood can make awsome fire.";
	picture = "\mcc_sandbox_mod\data\items\matches.paa";
	model = "\A3\Structures_F_EPA\Items\Tools\Matches_F.p3d";
	mcc_surviveType = "repair";
	value = 2;
	count = 1;
	mass = 1;
};

class MCC_foodcontainer : Item_Base_F
{
	scope = 2;
	displayName = "Food container";
	descriptionShort = "Hope it still fresh.";
	picture = "\mcc_sandbox_mod\data\items\foodcontainer.paa";
	model = "\A3\Structures_F_Bootcamp\Items\Food\FoodContainer_01_F.p3d";
	mcc_surviveType = "food";
	value = 50;
	count = 1;
	mass = 25;
};

class MCC_cerealbox : Item_Base_F
{
	scope = 2;
	displayName = "Cereal box";
	descriptionShort = "My kingdom for a glass of milk.";
	picture = "\mcc_sandbox_mod\data\items\cerealbox.paa";
	model = "\A3\Structures_F_EPA\Items\Food\CerealsBox_F.p3d";
	mcc_surviveType = "food";
	value = 20;
	count = 1;
	mass = 8;
};

class MCC_bakedBeans : Item_Base_F
{
	scope = 2;
	displayName = "Baked Beans";
	descriptionShort = "Mmm wonder how can I open it";
	picture = "\mcc_sandbox_mod\data\items\bakedBeans.paa";
	model = "\A3\Structures_F_EPA\Items\Food\BakedBeans_F.p3d";
	mcc_surviveType = "food";
	value = 10;
	count = 1;
	mass = 8;
};

class MCC_bakedBeans_open : Item_Base_F
{
	scope = 2;
	displayName = "Baked Beans - Open";
	descriptionShort = "Clear backblast!!!";
	picture = "\mcc_sandbox_mod\data\items\bakedBeans_open.paa";
	model = "\A3\Structures_F_EPA\Items\Food\BakedBeans_F.p3d";
	mcc_surviveType = "food";
	value = 10;
	count = 1;
	mass = 8;
};

class MCC_bacon : Item_Base_F
{
	scope = 2;
	displayName = "Tactical Bacon";
	descriptionShort = "Mmm wonder how can I open it";
	picture = "\mcc_sandbox_mod\data\items\bacon.paa";
	model = "\A3\Structures_F\Items\Food\TacticalBacon_F.p3d";
	mcc_surviveType = "food";
	value = 10;
	count = 1;
	mass = 8;
};

class MCC_bacon_open : Item_Base_F
{
	scope = 2;
	displayName = "Tactical Bacon - Open";
	descriptionShort = "Where is PETA when we need them ";
	picture = "\mcc_sandbox_mod\data\items\bacon_open.paa";
	model = "\A3\Structures_F\Items\Food\TacticalBacon_F.p3d";
	mcc_surviveType = "food";
	value = 10;
	count = 1;
	mass = 8;
};

class MCC_rice : Item_Base_F
{
	scope = 2;
	displayName = "Rice";
	descriptionShort = "I pretty sure you have to cook it first";
	picture = "\mcc_sandbox_mod\data\items\rice.paa";
	model = "\A3\Structures_F_EPA\Items\Food\RiceBox_F.p3d";
	mcc_surviveType = "food";
	value = 30;
	count = 1;
	mass = 16;
};

class MCC_bottle_water : Item_Base_F
{
	scope = 2;
	displayName = "Bottle - Clean Water";
	picture = "\mcc_sandbox_mod\data\items\bottle_water.paa";
	model = "\A3\Structures_F\Items\Food\BottlePlastic_V1_F.p3d";
	mcc_surviveType = "food";
	value = 10;
	count = 1;
	mass = 8;
};

class MCC_bottle_murky : Item_Base_F
{
	scope = 2;
	displayName = "Bottle - Murky Water";
	descriptionShort = "Looks like a little aquarium";
	picture = "\mcc_sandbox_mod\data\items\bottle_murky.paa";
	model = "\A3\Structures_F\Items\Food\BottlePlastic_V1_F.p3d";
	mcc_surviveType = "food";
	value = 2;
	count = 1;
	mass = 8;
};

class MCC_bottle_empty : Item_Base_F
{
	scope = 2;
	displayName = "Bottle - Empty ";
	descriptionShort = "Fill with water or fuel just dont drink the last one";
	picture = "\mcc_sandbox_mod\data\items\bottle_empty.paa";
	model = "\A3\Structures_F\Items\Food\BottlePlastic_V1_F.p3d";
	mcc_surviveType = "food";
	value = 0;
	count = 1;
	mass = 3;
};

class MCC_canteenWater : Item_Base_F
{
	scope = 2;
	displayName = "Canteen - Clean Water";
	picture = "\mcc_sandbox_mod\data\items\canteenWater.paa";
	model = "\A3\Structures_F\Items\Food\BottlePlastic_V1_F.p3d";
	mcc_surviveType = "food";
	value = 10;
	count = 1;
	mass = 8;
};

class MCC_canteenMurky : Item_Base_F
{
	scope = 2;
	displayName = "Canteen - Murky Water";
	picture = "\mcc_sandbox_mod\data\items\canteenMurky.paa";
	model = "\A3\Structures_F\Items\Food\BottlePlastic_V1_F.p3d";
	mcc_surviveType = "food";
	value = 2;
	count = 1;
	mass = 8;
};

class MCC_canteen : Item_Base_F
{
	scope = 2;
	displayName = "Canteen - Empty";
	descriptionShort = "Fill with water";
	picture = "\mcc_sandbox_mod\data\items\canteen.paa";
	model = "\A3\Structures_F\Items\Food\BottlePlastic_V1_F.p3d";
	mcc_surviveType = "food";
	value = 0;
	count = 1;
	mass = 3;
};

class MCC_powderedMilk : Item_Base_F
{
	scope = 2;
	displayName = "Powdered Milk";
	picture = "\mcc_sandbox_mod\data\items\powderedMilk.paa";
	model = "\A3\Structures_F_EPA\Items\Food\PowderedMilk_F.p3d";
	mcc_surviveType = "food";
	value = 15;
	count = 1;
	mass = 4;
};

class MCC_franta : Item_Base_F
{
	scope = 2;
	displayName = "Franta";
	picture = "\mcc_sandbox_mod\data\items\franta.paa";
	model = "\A3\Structures_F\Items\Food\Can_V2_F.p3d";
	mcc_surviveType = "food";
	value = 15;
	count = 1;
	mass = 3;
};

class MCC_RedGull : Item_Base_F
{
	scope = 2;
	displayName = "RedGull";
	picture = "\mcc_sandbox_mod\data\items\RedGull.paa";
	model = "\A3\Structures_F\Items\Food\Can_V3_F.p3d";
	mcc_surviveType = "food";
	value = 15;
	count = 1;
	mass = 3;
};

class MCC_Spirit : Item_Base_F
{
	scope = 2;
	displayName = "Spirit";
	picture = "\mcc_sandbox_mod\data\items\Spirit.paa";
	model = "\A3\Structures_F\Items\Food\Can_V1_F.p3d";
	mcc_surviveType = "food";
	value = 15;
	count = 1;
	mass = 3;
};

class MCC_can_dented : Item_Base_F
{
	scope = 2;
	displayName = "Used Can";
	picture = "\mcc_sandbox_mod\data\items\can_dented.paa";
	model = "\A3\Structures_F\Items\Food\Can_Dented_F.p3d";
	mcc_surviveType = "food";
	value = 1;
	count = 1;
	mass = 1;
};

class MCC_fruit1 : MCC_rice
{
	displayName = "Strange fruit";
	picture = "\mcc_sandbox_mod\data\items\fruit1.paa";
	model = "\A3\weapons_F\ammo\mag_univ.p3d";
	value = 5;
	mass = 2;
};


class MCC_fruit2 : MCC_fruit1
{
	displayName = "Strange fruit";
	picture = "\mcc_sandbox_mod\data\items\fruit2.paa";
	model = "\A3\weapons_F\ammo\mag_univ.p3d";
};

class MCC_canOpener : Item_Base_F
{
	scope = 2;
	displayName = "Can Opener";
	picture = "\mcc_sandbox_mod\data\items\canOpener.paa";
	model = "\A3\Structures_F_EPA\Items\Tools\CanOpener_F.p3d";
	value = 5;
	count = 1;
	mass = 1;
};

class MCC_wood : Item_Base_F
{
	scope = 2;
	displayName = "Dry Wood";
	descriptionShort = "Find some matches to make fire";
	picture = "\mcc_sandbox_mod\data\items\wood.paa";
	model = "\A3\Structures_F\Civ\Accessories\WoodPile_F.p3d";
	value = 5;
	count = 1;
	mass = 20;
};

class MCC_battery : Item_Base_F
{
	scope = 2;
	displayName = "battery";
	picture = "\mcc_sandbox_mod\data\items\battery.paa";
	model = "\A3\Structures_F\Civ\Accessories\WoodPile_F.p3d";
	value = 5;
	count = 1;
	mass = 1;
};