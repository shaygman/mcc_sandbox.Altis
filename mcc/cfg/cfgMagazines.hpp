class MCC_6Rnd_12Gauge_beanBag
{
	ammo = "prpl_B_12Gauge_Slug";
	count = 6;
	descriptionshort = "12Gauge Non-lethal Beanbag";
	displayname = "12Gauge 6Rnds Beanbag";
	displaynameshort = "Beanbag";
	initspeed = 396;
	mass = 4;
	maxLeadSpeed = 23;
	maxThrowHoldTime = 2;
	maxThrowIntensityCoef = 1.4;
	minThrowIntensityCoef = 0.3;
	model = "\A3\weapons_F\ammo\mag_univ.p3d";
	modelSpecial = "";
	nameSound = "magazine";
	picture = "\A3\Weapons_F\Data\UI\M_12gauge_CA.paa";
	quickReload = 0;
	reloadaction = "GestureReloadM4SSAS";
	scope = 2;
	selectionFireAnim = "zasleh";
	simulation = "ProxyMagazines";
	type = 256;
	useAction = 0;
	useActionTitle = "";
	value = 1;
	weaponpoolavailable = 1;
	weight = 0;
};

class MCC_magazine : CA_Magazine
{
	type = 1111;
};

class MCC_ammoBoxMag : MCC_magazine
{
	scope = 2;
	displayName = "Ammo Box";
	picture = "\mcc_sandbox_mod\data\items\ammoBox.paa";
	model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d";
	value = 50;
	count = 1;
	mass = 100;
};
class MCC_antibiotics : MCC_magazine
{
	scope = 2;
	displayName = "Antibiotics";
	descriptionShort = "Destroy or slow down the growth of bacteria.";
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
	descriptionShort = "Good for a headache or a gun wound.";
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
	model = "\A3\Structures_F\Items\Stationery\saline.p3d";
	value = 40;
	mass = 30;
};

class MCC_firstAidKit : MCC_antibiotics
{
	displayName = "First aid kit";
	picture = "\mcc_sandbox_mod\data\items\firstaidKit.paa";
	model = "\A3\Weapons_F\Items\Medikit";
	value = 50;
	mass = 80;
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

class MCC_fuelCan : MCC_magazine
{
	scope = 2;
	displayName = "Fuel canister";
	picture = "\mcc_sandbox_mod\data\items\fuelCan.paa";
	model = "\A3\Structures_F\Items\Vessels\CanisterFuel_F.p3d";
	mcc_surviveType = "fuel";
	value = 50;
	count = 1;
	mass = 100;
};

class MCC_fuelbot : MCC_magazine
{
	scope = 2;
	displayName = "Fuel bottle";
	picture = "\mcc_sandbox_mod\data\items\fuelbot.paa";
	model = "\A3\Structures_F\Items\Food\BottlePlastic_V1_F.p3d";
	mcc_surviveType = "fuel";
	value = 10;
	count = 1;
	mass = 30;
};

class MCC_ductTape : MCC_magazine
{
	scope = 2;
	displayName = "Duct Tape";
	picture = "\mcc_sandbox_mod\data\items\ductTape.paa";
	model = "\A3\Structures_F_EPA\Items\Tools\DuctTape_F.p3d";
	mcc_surviveType = "repair";
	value = 10;
	count = 1;
	mass = 5;
};

class MCC_butanetorch : MCC_magazine
{
	scope = 2;
	displayName = "Butane torch";
	picture = "\mcc_sandbox_mod\data\items\butanetorch.paa";
	model = "\A3\Structures_F_EPA\Items\Tools\ButaneTorch_F.p3d";
	mcc_surviveType = "repair";
	value = 30;
	count = 1;
	mass = 30;
};

class MCC_oilcan : MCC_magazine
{
	scope = 2;
	displayName = "Oil canister";
	picture = "\mcc_sandbox_mod\data\items\oilcan.paa";
	model = "\A3\Structures_F\Items\Vessels\CanisterOil_F.p3d";
	mcc_surviveType = "repair";
	value = 40;
	count = 1;
	mass = 40;
};

class MCC_metalwire : MCC_magazine
{
	scope = 2;
	displayName = "Scrap Metal";
	picture = "\mcc_sandbox_mod\data\items\metalwire.paa";
	model = "\A3\Structures_F_EPA\Items\Tools\MetalWire_F.p3d";
	mcc_surviveType = "repair";
	value = 30;
	count = 1;
	mass = 15;
};

class MCC_carBat : MCC_magazine
{
	scope = 2;
	displayName = "Car Battery";
	picture = "\mcc_sandbox_mod\data\items\carBat.paa";
	model = "\A3\Structures_F_Bootcamp\Items\Electronics\CarBattery_02_F.p3d";
	mcc_surviveType = "repair";
	value = 50;
	count = 1;
	mass = 80;
};

class MCC_foodcontainer : MCC_magazine
{
	scope = 2;
	displayName = "Food container";
	picture = "\mcc_sandbox_mod\data\items\foodcontainer.paa";
	model = "\A3\Structures_F_Bootcamp\Items\Food\FoodContainer_01_F.p3d";
	mcc_surviveType = "food";
	value = 50;
	count = 1;
	mass = 100;
};

class MCC_cerealbox : MCC_magazine
{
	scope = 2;
	displayName = "Cereal box";
	picture = "\mcc_sandbox_mod\data\items\cerealbox.paa";
	model = "\A3\Structures_F_EPA\Items\Food\CerealsBox_F.p3d";
	mcc_surviveType = "food";
	value = 20;
	count = 1;
	mass = 30;
};

class MCC_bacon : MCC_magazine
{
	scope = 2;
	displayName = "Canned Food";
	picture = "\mcc_sandbox_mod\data\items\bacon.paa";
	model = "\A3\Structures_F\Items\Food\TacticalBacon_F.p3d";
	mcc_surviveType = "food";
	value = 10;
	count = 1;
	mass = 20;
};

class MCC_rice : MCC_magazine
{
	scope = 2;
	displayName = "Rice";
	picture = "\mcc_sandbox_mod\data\items\rice.paa";
	model = "\A3\Structures_F_EPA\Items\Food\RiceBox_F.p3d";
	mcc_surviveType = "food";
	value = 30;
	count = 1;
	mass = 50;
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