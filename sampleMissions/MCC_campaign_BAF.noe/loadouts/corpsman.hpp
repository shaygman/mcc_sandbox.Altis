class corpsman : rifleman
{
	name    = "Corpsman";
	picture =  __EVAL(MCCPATH +"mcc\roleSelection\data\Corpsman.paa");
	minPlayersForKit = 0;
	maxKitsInGroup = 2;
	maxKitsInSide = 999;
	allowMg = 0;
	allowAT = 0;
	allowSniper = 0;
	allowPilot = 0;
	allowCrew = 0;

	class west : west
	{
		generalItems[]= {{0,"ItemMap",1},{0,"ItemCompass",1},{0,"ItemWatch",1},{0,"ItemRadio",1},{0,"Medikit", 1},{0,"FirstAidKit",10}};
		vests[]= {{0,"CUP_V_BAF_Osprey_Mk2_DPM_Medic"},{9,"CUP_V_BAF_Osprey_Mk4_MTP_Rifleman"},{13,"CUP_V_BAF_Osprey_Mk2_DDPM_Medic"},{19,"V_PlateCarrier1_blk"}};
		backpacks[]= {{0,"CUP_B_GER_Medic_Flecktarn"},{7,"CUP_B_GER_Medic_Tropentarn"},{14,"B_Bergen_mcamo"},{18,"B_AssaultPack_blk"}};
	};

	class east : east
	{
		generalItems[]= {{0,"ItemMap",1},{0,"ItemCompass",1},{0,"ItemWatch",1},{0,"ItemRadio",1},{0,"Medikit", 1},{0,"FirstAidKit",10}};
		backpacks[]= {{0,"CUP_B_SLA_Medicbag"},{7,"B_Kitbag_mcamo"},{14,"B_Bergen_mcamo"},{18,"B_AssaultPack_blk"}};
	};

	class guer : guer
	{
		generalItems[]= {{0,"ItemMap",1},{0,"ItemCompass",1},{0,"ItemWatch",1},{0,"ItemRadio",1},{0,"Medikit", 1},{0,"FirstAidKit",10}};
		backpacks[]= {{0,"CUP_B_TK_Medic_Desert"},{7,"CUP_B_CivPack_WDL"},{14,"B_Bergen_mcamo"},{18,"B_AssaultPack_blk"}};
	};
};