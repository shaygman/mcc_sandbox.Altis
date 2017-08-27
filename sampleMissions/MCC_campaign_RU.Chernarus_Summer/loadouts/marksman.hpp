class marksman : rifleman
{
	name    = "marksman";
	picture =  __EVAL(MCCPATH +"mcc\roleSelection\data\Marksman.paa");
	minPlayersForKit = 4;
	maxKitsInGroup = 1;
	maxKitsInSide = 999;
	allowMg = 0;
	allowAT = 0;
	allowSniper = 1;
	allowPilot = 0;
	allowCrew = 0;

	class west : west
	{
		class primary
		{
			class CUP_srifle_Mk12SPR
			{
				unlockLevel = 0;
				cfgname = "CUP_srifle_Mk12SPR";
				magazines[]= {"20Rnd_762x51_Mag",11};
				attachments1[]= {{0,"CUP_optic_Elcan_reflex"},{4,"optic_DMS"},{6,"CUP_optic_SB_3_12x50_PMII"},{8,"CUP_optic_LeupoldM3LR"},{10,"optic_tws"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_snds_Mk12"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {{3,"CUP_bipod_Harris_1A2_L"},{5,"bipod_01_F_snd"},{8,"bipod_02_F_blk"}};
			};

			class CUP_srifle_M14_DMR
			{
				unlockLevel = 6;
				cfgname = "CUP_srifle_M14_DMR";
				magazines[]= {"CUP_20Rnd_762x51_DMR",9,"CUP_20Rnd_TE1_Red_Tracer_762x51_DMR",2};
				attachments1[]= {{0,"CUP_optic_Elcan_reflex"},{4,"optic_DMS"},{6,"CUP_optic_SB_3_12x50_PMII"},{8,"CUP_optic_LeupoldM3LR"},{10,"optic_tws"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_B"}};
				attachments3[]= {};
				attachments4[]= {{3,"CUP_bipod_Harris_1A2_L"},{5,"bipod_01_F_snd"},{8,"bipod_02_F_blk"}};
			};

			class CUP_srifle_M24_wdl
			{
				unlockLevel = 12;
				cfgname = "CUP_srifle_M24_wdl";
				magazines[]= {"CUP_5Rnd_762x51_M24",11};
				attachments1[]= {{0,"CUP_optic_Elcan_reflex"},{4,"optic_DMS"},{6,"CUP_optic_SB_3_12x50_PMII"},{8,"CUP_optic_LeupoldM3LR"},{10,"optic_tws"}};
				attachments2[]= {};
				attachments3[]= {{0,""},{1,"CUP_Mxx_camo"}};
				attachments4[]= {{3,"CUP_bipod_Harris_1A2_L"},{5,"bipod_01_F_snd"},{8,"bipod_02_F_blk"}};
			};

			class srifle_EBR_F
			{
				unlockLevel = 18;
				cfgname = "srifle_EBR_F";
				magazines[]= {"20Rnd_762x51_Mag",9,"20Rnd_762x51_Mag",2};
				attachments1[]= {{0,"CUP_optic_Elcan_reflex"},{4,"optic_DMS"},{6,"CUP_optic_SB_3_12x50_PMII"},{8,"CUP_optic_LeupoldM3LR"},{10,"optic_tws"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_B"}};
				attachments3[]= {};
				attachments4[]= {{3,"CUP_bipod_Harris_1A2_L"},{5,"CUP_bipod_VLTOR_Modpod"},{8,"bipod_02_F_blk"}};
			};

			class CUP_srifle_AWM_wdl
			{
				unlockLevel = 24;
				cfgname = "CUP_srifle_AWM_wdl";
				magazines[]= {"CUP_5Rnd_86x70_L115A1",11};
				attachments1[]= {{0,"CUP_optic_Elcan_reflex"},{4,"optic_DMS"},{6,"CUP_optic_SB_3_12x50_PMII"},{8,"CUP_optic_LeupoldM3LR"},{10,"optic_tws"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_snds_AWM"}};
				attachments3[]= {};
				attachments4[]= {{3,"CUP_bipod_Harris_1A2_L"},{5,"bipod_01_F_snd"},{8,"bipod_02_F_blk"}};
			};

			class CUP_srifle_M110
			{
				unlockLevel = 30;
				cfgname = "CUP_srifle_M110";
				magazines[]= {"CUP_20Rnd_762x51_B_M110",11};
				attachments1[]= {{0,"CUP_optic_Elcan_reflex"},{4,"optic_DMS"},{6,"CUP_optic_SB_3_12x50_PMII"},{8,"CUP_optic_LeupoldM3LR"},{10,"optic_tws"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_snds_M110"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {{3,"CUP_bipod_Harris_1A2_L"},{5,"bipod_01_F_snd"},{8,"bipod_02_F_blk"}};
			};

			class CUP_srifle_M107_Base
			{
				unlockLevel = 36;
				cfgname = "CUP_srifle_M107_Base";
				magazines[]= {"CUP_10Rnd_127x99_M107",9};
				attachments1[]= {{0,"CUP_optic_Elcan_reflex"},{4,"optic_DMS"},{6,"optic_LRPS"},{8,"CUP_optic_LeupoldM3LR"},{10,"optic_tws"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_srifle_AS50
			{
				unlockLevel = 42;
				cfgname = "CUP_srifle_AS50";
				magazines[]= {"CUP_5Rnd_127x99_as50_M",9};
				attachments1[]= {{0,"CUP_optic_Elcan_reflex"},{4,"optic_DMS"},{6,"optic_LRPS"},{8,"CUP_optic_LeupoldM3LR"},{10,"optic_tws"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};
		};

		items1[]={{0,"Rangefinder", {}},{10,"Laserdesignator", {"Laserbatteries",2}}};
		headgear[]= {{0,"H_HelmetB_camo"},{12,"H_Shemag_olive"},{18,"H_Shemag_khk"}};
		uniforms[]= {{0,"CUP_U_B_BAF_DDPM_Tshirt"},{7,"CUP_U_B_BAF_DPM_Tshirt"},{14,"CUP_U_B_BAF_DPM_Tshirt"},{21,"CUP_U_I_Ghillie_Top"},{28,"CUP_U_B_USMC_Ghillie_WDL"},{35,"U_B_GhillieSuit"}};
	};

	class east : east
	{
		class primary
		{
			class CUP_srifle_SVD
			{
				unlockLevel = 0;
				cfgname = "CUP_srifle_SVD";
				magazines[]= {"CUP_10Rnd_762x54_SVD_M",9};
				attachments1[]= {{0,"CUP_optic_PSO_1"},{4,"CUP_optic_PSO_3"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_srifle_LeeEnfield_rail
			{
				unlockLevel = 8;
				cfgname = "CUP_srifle_LeeEnfield_rail";
				magazines[]= {"CUP_10x_303_M",9,"CUP_10x_303_M",2};
				attachments1[]= {{0,"CUP_optic_Elcan_reflex"},{4,"optic_DMS"},{6,"CUP_optic_SB_3_12x50_PMII"},{8,"CUP_optic_LeupoldM3LR"},{10,"optic_tws"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {{3,"CUP_bipod_Harris_1A2_L"},{5,"CUP_bipod_VLTOR_Modpod"},{8,"bipod_02_F_blk"}};
			};

			class srifle_DMR_01_F
			{
				unlockLevel = 16;
				cfgname = "srifle_DMR_01_F";
				magazines[]= {"10Rnd_762x51_Mag",9};
				attachments1[]= {{0,"optic_Hamr"},{4,"optic_MRCO"},{6,"optic_DMS"},{8,"optic_SOS"},{10,"optic_Holosight"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_B"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {{3,"bipod_02_F_hex"},{5,"bipod_01_F_snd"},{8,"bipod_02_F_blk"}};
			};

			class CUP_srifle_CZ550_rail
			{
				unlockLevel = 24;
				cfgname = "CUP_srifle_CZ550_rail";
				magazines[]= {"CUP_5x_22_LR_17_HMR_M",9,"CUP_5x_22_LR_17_HMR_M",2};
				attachments1[]= {{0,"CUP_optic_Elcan_reflex"},{4,"optic_DMS"},{6,"CUP_optic_SB_3_12x50_PMII"},{8,"CUP_optic_LeupoldM3LR"},{10,"optic_tws"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_srifle_VSSVintorez
			{
				unlockLevel = 32;
				cfgname = "CUP_srifle_VSSVintorez";
				magazines[]= {"CUP_10Rnd_9x39_SP5_VSS_M",9};
				attachments1[]= {{0,"CUP_optic_PSO_1"},{4,"CUP_optic_PSO_3"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_srifle_ksvk
			{
				unlockLevel = 40;
				cfgname = "CUP_srifle_ksvk";
				magazines[]= {"CUP_5Rnd_127x108_KSVK_M",9};
				attachments1[]= {{0,"CUP_optic_PSO_1"},{4,"CUP_optic_PSO_3"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class srifle_GM6_camo_F
			{
				unlockLevel = 48;
				cfgname = "srifle_GM6_camo_F";
				magazines[]= {"5Rnd_127x108_Mag",9};
				attachments1[]= {{0,"optic_MRCO"},{4,"optic_DMS"},{6,"optic_SOS"},{8,"optic_Holosight"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};
		};

		items1[]={{0,"Rangefinder", {}},{10,"Laserdesignator", {"Laserbatteries",2}}};
	};

	class guer : guer
	{
		class primary
		{
			class CUP_srifle_SVD
			{
				unlockLevel = 0;
				cfgname = "CUP_srifle_SVD";
				magazines[]= {"CUP_10Rnd_762x54_SVD_M",9};
				attachments1[]= {{0,"CUP_optic_PSO_1"},{4,"CUP_optic_PSO_3"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_srifle_LeeEnfield_rail
			{
				unlockLevel = 8;
				cfgname = "CUP_srifle_LeeEnfield_rail";
				magazines[]= {"CUP_10x_303_M",9,"CUP_10x_303_M",2};
				attachments1[]= {{0,"CUP_optic_Elcan_reflex"},{4,"optic_DMS"},{6,"CUP_optic_SB_3_12x50_PMII"},{8,"CUP_optic_LeupoldM3LR"},{10,"optic_tws"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {{3,"CUP_bipod_Harris_1A2_L"},{5,"CUP_bipod_VLTOR_Modpod"},{8,"bipod_02_F_blk"}};
			};

			class srifle_DMR_01_F
			{
				unlockLevel = 16;
				cfgname = "srifle_DMR_01_F";
				magazines[]= {"10Rnd_762x51_Mag",9};
				attachments1[]= {{0,"optic_Hamr"},{4,"optic_MRCO"},{6,"optic_DMS"},{8,"optic_SOS"},{10,"optic_Holosight"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_B"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {{3,"bipod_02_F_hex"},{5,"bipod_01_F_snd"},{8,"bipod_02_F_blk"}};
			};

			class CUP_srifle_CZ550_rail
			{
				unlockLevel = 24;
				cfgname = "CUP_srifle_CZ550_rail";
				magazines[]= {"CUP_5x_22_LR_17_HMR_M",9,"CUP_5x_22_LR_17_HMR_M",2};
				attachments1[]= {{0,"CUP_optic_Elcan_reflex"},{4,"optic_DMS"},{6,"CUP_optic_SB_3_12x50_PMII"},{8,"CUP_optic_LeupoldM3LR"},{10,"optic_tws"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_srifle_VSSVintorez
			{
				unlockLevel = 32;
				cfgname = "CUP_srifle_VSSVintorez";
				magazines[]= {"CUP_10Rnd_9x39_SP5_VSS_M",9};
				attachments1[]= {{0,"CUP_optic_PSO_1"},{4,"CUP_optic_PSO_3"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_srifle_ksvk
			{
				unlockLevel = 40;
				cfgname = "CUP_srifle_ksvk";
				magazines[]= {"CUP_5Rnd_127x108_KSVK_M",9};
				attachments1[]= {{0,"CUP_optic_PSO_1"},{4,"CUP_optic_PSO_3"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class srifle_GM6_camo_F
			{
				unlockLevel = 48;
				cfgname = "srifle_GM6_camo_F";
				magazines[]= {"5Rnd_127x108_Mag",9};
				attachments1[]= {{0,"optic_MRCO"},{4,"optic_DMS"},{6,"optic_SOS"},{8,"optic_Holosight"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};
		};

		items1[]={{0,"Rangefinder", {}},{10,"Laserdesignator", {"Laserbatteries",2}}};
	};
};