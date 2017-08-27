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
			class arifle_SPAR_03_blk_F
			{
				unlockLevel = 0;
				cfgname = "arifle_SPAR_03_blk_F";
				magazines[]= {"20Rnd_762x51_Mag",9};
				attachments1[]= {{0,"optic_Hamr"},{4,"optic_MRCO"},{6,"optic_DMS"},{8,"optic_SOS"},{10,"optic_Holosight"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_B"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {{3,"bipod_02_F_hex"},{5,"bipod_01_F_snd"},{8,"bipod_02_F_blk"}};
			};

			class arifle_MXM_F
			{
				unlockLevel = 13;
				cfgname = "arifle_MXM_F";
				magazines[]= {"30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2};
				attachments1[]= {{0,"optic_Hamr"},{4,"optic_MRCO"},{6,"optic_DMS"},{8,"optic_SOS"},{10,"optic_Holosight"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_h"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {{3,"bipod_02_F_hex"},{5,"bipod_01_F_snd"},{8,"bipod_02_F_blk"}};
			};

			class srifle_LRR_camo_F
			{
				unlockLevel = 23;
				cfgname = "srifle_LRR_camo_F";
				magazines[]= {"7Rnd_408_Mag",9};
				attachments1[]= {{0,"optic_MRCO"},{4,"optic_DMS"},{6,"optic_SOS"},{8,"optic_Holosight"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};
		};

		headgear[]= {{0,"H_HelmetB_camo"},{12,"H_Shemag_khk"},{18,"H_HelmetB_light_black"}};
		uniforms[]= {{0,"U_B_T_Soldier_AR_F"},{8,"U_B_T_Sniper_F"},{15,"U_B_T_FullGhillie_tna_F"}};
	};

	class east : east
	{
		class primary
		{
			class srifle_DMR_07_blk_F
			{
				unlockLevel = 0;
				cfgname = "srifle_DMR_07_blk_F";
				magazines[]= {"20Rnd_650x39_Cased_Mag_F",9};
				attachments1[]= {{0,"optic_Hamr"},{4,"optic_MRCO"},{6,"optic_DMS"},{8,"optic_SOS"},{10,"optic_Holosight"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_H"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {{3,"bipod_02_F_hex"},{5,"bipod_01_F_snd"},{8,"bipod_02_F_blk"}};
			};

			class srifle_DMR_01_F
			{
				unlockLevel = 13;
				cfgname = "srifle_DMR_01_F";
				magazines[]= {"10Rnd_762x51_Mag",9};
				attachments1[]= {{0,"optic_Hamr"},{4,"optic_MRCO"},{6,"optic_DMS"},{8,"optic_SOS"},{10,"optic_Holosight"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_B"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {{3,"bipod_02_F_hex"},{5,"bipod_01_F_snd"},{8,"bipod_02_F_blk"}};
			};

			class srifle_GM6_camo_F
			{
				unlockLevel = 23;
				cfgname = "srifle_GM6_camo_F";
				magazines[]= {"5Rnd_127x108_Mag",9};
				attachments1[]= {{0,"optic_MRCO"},{4,"optic_DMS"},{6,"optic_SOS"},{8,"optic_Holosight"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};
		};

		headgear[]= {{0,"H_HelmetO_ocamo"},{12,"H_Shemag_olive"},{18,"H_HelmetSpecO_blk"}};
		uniforms[]= {{0,"U_O_CombatUniform_ocamo"},{8,"U_O_T_Sniper_F"},{15,"U_O_T_FullGhillie_tna_F"}};
	};

	class guer : guer
	{
		class primary
		{
			class srifle_EBR_F
			{
				unlockLevel = 0;
				cfgname = "srifle_EBR_F";
				magazines[]= {"20Rnd_762x51_Mag",9};
				attachments1[]= {{0,"optic_Hamr"},{4,"optic_MRCO"},{6,"optic_DMS"},{8,"optic_SOS"},{10,"optic_Holosight"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_B"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {{3,"bipod_02_F_hex"},{5,"bipod_01_F_snd"},{8,"bipod_02_F_blk"}};
			};

			class arifle_MXM_F
			{
				unlockLevel = 13;
				cfgname = "arifle_MXM_F";
				magazines[]= {"30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2};
				attachments1[]= {{0,"optic_Hamr"},{4,"optic_MRCO"},{6,"optic_DMS"},{8,"optic_SOS"},{10,"optic_Holosight"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_h"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {{3,"bipod_02_F_hex"},{5,"bipod_01_F_snd"},{8,"bipod_02_F_blk"}};
			};

			class srifle_LRR_F
			{
				unlockLevel = 23;
				cfgname = "srifle_LRR_F";
				magazines[]= {"7Rnd_408_Mag",9};
				attachments1[]= {{0,"optic_MRCO"},{4,"optic_DMS"},{6,"optic_SOS"},{8,"optic_Holosight"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};
		};

		uniforms[]= {{0,"U_I_C_Soldier_Bandit_2_F"},{8,"U_I_CombatUniform_tshirt"},{15,"U_I_GhillieSuit"}};
	};
};