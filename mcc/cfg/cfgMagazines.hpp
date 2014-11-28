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

class MCC_ammoBoxMag : CA_Magazine 
{
	scope = 2;
	displayName = "Ammo Box";
	picture = "\mcc_sandbox_mod\data\items\ammoBox.paa";
	model = "\A3\Structures_F_EPB\Items\Military\Ammobox_rounds_F.p3d";
	mass = 100;
};