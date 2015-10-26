class MCC_b_markerAmmo
{
	#ifdef MCCMODE
	icon = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\b_markerAmmo.paa";
	texture = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\b_markerAmmo.paa";
	#else
	icon = "mcc\cfg\modules\data\markers\b_markerAmmo.paa";
	texture = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\b_markerAmmo.paa";
	#endif

	color[] = {"(profilenamespace getvariable ['Map_Independent_R',0])","(profilenamespace getvariable ['Map_Independent_G',1])","(profilenamespace getvariable ['Map_Independent_B',1])","(profilenamespace getvariable ['Map_Independent_A',0.8])"};

	markerClass = "NATO_BLUFOR";
	name = "Ammo";
	scope = 1;
	shadow = 0;
	showEditorMarkerColor = 1;
	side = 1;
	size = 29;
};

class MCC_b_markerFuel : MCC_b_markerAmmo
{
	#ifdef MCCMODE
	icon = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\b_markerFuel.paa";
	texture = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\b_markerFuel.paa";
	#else
	icon = "mcc\cfg\modules\data\markers\b_markerFuel.paa";
	texture = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\b_markerFuel.paa";
	#endif

	color[] = {"(profilenamespace getvariable ['Map_Independent_R',0])","(profilenamespace getvariable ['Map_Independent_G',1])","(profilenamespace getvariable ['Map_Independent_B',1])","(profilenamespace getvariable ['Map_Independent_A',0.8])"};

	name = "Fuel";
};

class MCC_b_markerRepair : MCC_b_markerAmmo
{
	#ifdef MCCMODE
	icon = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\b_markerRepair.paa";
	texture = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\b_markerRepair.paa";
	#else
	icon = "mcc\cfg\modules\data\markers\b_markerRepair.paa";
	texture = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\b_markerRepair.paa";
	#endif

	color[] = {"(profilenamespace getvariable ['Map_Independent_R',0])","(profilenamespace getvariable ['Map_Independent_G',1])","(profilenamespace getvariable ['Map_Independent_B',1])","(profilenamespace getvariable ['Map_Independent_A',0.8])"};

	name = "Repair";
};

class MCC_n_markerAmmo : MCC_b_markerAmmo
{
	#ifdef MCCMODE
	icon = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\n_markerAmmo.paa";
	texture = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\n_markerAmmo.paa";
	#else
	icon = "mcc\cfg\modules\data\markers\n_markerAmmo.paa";
	texture = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\n_markerAmmo.paa";
	#endif

	color[] = {"(profilenamespace getvariable ['Map_Independent_R',0])","(profilenamespace getvariable ['Map_Independent_G',1])","(profilenamespace getvariable ['Map_Independent_B',1])","(profilenamespace getvariable ['Map_Independent_A',0.8])"};

	markerClass = "NATO_Independent";
	name = "Ammo";
};

class MCC_n_markerFuel : MCC_n_markerAmmo
{
	#ifdef MCCMODE
	icon = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\n_markerFuel.paa";
	texture = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\n_markerFuel.paa";
	#else
	icon = "mcc\cfg\modules\data\markers\n_markerFuel.paa";
	texture = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\n_markerFuel.paa";
	#endif

	color[] = {"(profilenamespace getvariable ['Map_Independent_R',0])","(profilenamespace getvariable ['Map_Independent_G',1])","(profilenamespace getvariable ['Map_Independent_B',1])","(profilenamespace getvariable ['Map_Independent_A',0.8])"};

	name = "Fuel";
};

class MCC_n_markerRepair : MCC_n_markerAmmo
{
	#ifdef MCCMODE
	icon = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\n_markerRepair.paa";
	texture = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\n_markerRepair.paa";
	#else
	icon = "mcc\cfg\modules\data\markers\n_markerRepair.paa";
	texture = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\n_markerRepair.paa";
	#endif

	color[] = {"(profilenamespace getvariable ['Map_Independent_R',0])","(profilenamespace getvariable ['Map_Independent_G',1])","(profilenamespace getvariable ['Map_Independent_B',1])","(profilenamespace getvariable ['Map_Independent_A',0.8])"};

	name = "Repair";
};

class MCC_o_markerAmmo : MCC_b_markerAmmo
{
	#ifdef MCCMODE
	icon = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\o_markerAmmo.paa";
	texture = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\o_markerAmmo.paa";
	#else
	icon = "mcc\cfg\modules\data\markers\o_markerAmmo.paa";
	texture = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\o_markerAmmo.paa";
	#endif

	color[] = {"(profilenamespace getvariable ['Map_Independent_R',0])","(profilenamespace getvariable ['Map_Independent_G',1])","(profilenamespace getvariable ['Map_Independent_B',1])","(profilenamespace getvariable ['Map_Independent_A',0.8])"};

	markerClass = "NATO_OPFOR";
	name = "Ammo";
};

class MCC_o_markerFuel : MCC_o_markerAmmo
{
	#ifdef MCCMODE
	icon = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\o_markerFuel.paa";
	texture = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\o_markerFuel.paa";
	#else
	icon = "mcc\cfg\modules\data\markers\o_markerFuel.paa";
	texture = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\o_markerFuel.paa";
	#endif

	color[] = {"(profilenamespace getvariable ['Map_Independent_R',0])","(profilenamespace getvariable ['Map_Independent_G',1])","(profilenamespace getvariable ['Map_Independent_B',1])","(profilenamespace getvariable ['Map_Independent_A',0.8])"};

	name = "Fuel";
};

class MCC_o_markerRepair : MCC_o_markerAmmo
{
	#ifdef MCCMODE
	icon = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\o_markerRepair.paa";
	texture = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\o_markerRepair.paa";
	#else
	icon = "mcc\cfg\modules\data\markers\o_markerRepair.paa";
	texture = "\mcc_sandbox_mod\mcc\cfg\modules\data\markers\o_markerRepair.paa";
	#endif

	color[] = {"(profilenamespace getvariable ['Map_Independent_R',0])","(profilenamespace getvariable ['Map_Independent_G',1])","(profilenamespace getvariable ['Map_Independent_B',1])","(profilenamespace getvariable ['Map_Independent_A',0.8])"};

	name = "Repair";
};