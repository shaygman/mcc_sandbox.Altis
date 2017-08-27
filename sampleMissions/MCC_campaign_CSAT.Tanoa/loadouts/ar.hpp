class ar : rifleman
{
	name    = "Automatic Rifleman";
	picture =  __EVAL(MCCPATH +"mcc\roleSelection\data\AR.paa");
	minPlayersForKit = 2;
	maxKitsInGroup = 2;
	maxKitsInSide = 999;
	allowMg = 1;
	allowAT = 0;
	allowSniper = 0;
	allowPilot = 0;
	allowCrew = 0;

	class west : west
	{
		class primary
		{
			class LMG_03_F
			{
				unlockLevel = 0;
				cfgname = "LMG_03_F";
				magazines[]= {"200Rnd_556x45_Box_Red_F",3,"200Rnd_556x45_Box_Red_F",2};
				attachments1[]= {{0,""},{3,"optic_Aco"},{4,"optic_Holosight"},{6,"optic_MRCO"},{8,"optic_Hamr"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_M"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {};
			};

			class arifle_SPAR_02_blk_F
			{
				unlockLevel = 13;
				cfgname = "arifle_SPAR_02_blk_F";
				magazines[]= {"150Rnd_556x45_Drum_Mag_F",3,"150Rnd_556x45_Drum_Mag_Tracer_F",2};
				attachments1[]= {{0,""},{3,"optic_Aco"},{4,"optic_Holosight"},{6,"optic_MRCO"},{8,"optic_Hamr"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_M"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {{0,""},{5,"bipod_01_F_blk"}};
			};

			class arifle_MX_SW_Black_F
			{
				unlockLevel = 23;
				cfgname = "arifle_MX_SW_Black_F";
				magazines[]= {"100Rnd_65x39_caseless_mag",6,"100Rnd_65x39_caseless_mag_Tracer",2};
				attachments1[]= {{0,""},{3,"optic_Aco"},{4,"optic_Holosight"},{6,"optic_MRCO"},{8,"optic_Hamr"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_h"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {};
			};
		};

		headgear[]= {{0,"H_Bandanna_khk"},{12,"H_Bandanna_mcamo"},{18,"H_HelmetSpecO_blk"}};
	};

	class east : east
	{
		class primary
		{
			class arifle_CTARS_blk_F
			{
				unlockLevel = 0;
				cfgname = "arifle_CTARS_blk_F";
				magazines[]= {"100Rnd_580x42_Mag_F",4,"100Rnd_580x42_Mag_Tracer_F",2};
				attachments1[]= {{0,""},{3,"optic_ACO_grn"},{4,"optic_Holosight"},{6,"optic_MRCO"},{8,"optic_Hamr"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_58_blk_F"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {{0,""},{5,"bipod_01_F_blk"}};
			};

			class LMG_Mk200_F
			{
				unlockLevel = 13;
				cfgname = "LMG_Mk200_F";
				magazines[]= {"200Rnd_65x39_cased_Box",3,"200Rnd_65x39_cased_Box_Tracer",2};
				attachments1[]= {{0,""},{3,"optic_ACO_grn"},{4,"optic_Holosight"},{6,"optic_MRCO"},{8,"optic_Hamr"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_h"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {};
			};

			class LMG_Zafir_F
			{
				unlockLevel = 23;
				cfgname = "LMG_Zafir_F";
				magazines[]= {"150Rnd_762x51_Box",3,"150Rnd_762x51_Box_Tracer",2};
				attachments1[]= {{0,""},{3,"optic_ACO_grn"},{4,"optic_Holosight"},{6,"optic_MRCO"},{8,"optic_Hamr"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_h"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {};
			};
		};

		headgear[]= {{0,"H_Bandanna_khk"},{12,"H_Bandanna_mcamo"},{18,"H_HelmetSpecO_blk"}};
	};

	class guer : guer
	{
		class primary
		{
			class arifle_CTARS_blk_F
			{
				unlockLevel = 0;
				cfgname = "arifle_CTARS_blk_F";
				magazines[]= {"100Rnd_580x42_Mag_F",4,"100Rnd_580x42_Mag_Tracer_F",2};
				attachments1[]= {{0,""},{3,"optic_ACO_grn"},{4,"optic_Holosight"},{6,"optic_MRCO"},{8,"optic_Hamr"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_58_blk_F"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {{0,""},{5,"bipod_01_F_blk"}};
			};

			class LMG_Mk200_F
			{
				unlockLevel = 13;
				cfgname = "LMG_Mk200_F";
				magazines[]= {"200Rnd_65x39_cased_Box",3,"200Rnd_65x39_cased_Box_Tracer",2};
				attachments1[]= {{0,""},{3,"optic_ACO_grn"},{4,"optic_Holosight"},{6,"optic_MRCO"},{8,"optic_Hamr"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_h"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {};
			};

			class LMG_Zafir_F
			{
				unlockLevel = 23;
				cfgname = "LMG_Zafir_F";
				magazines[]= {"150Rnd_762x51_Box",3,"150Rnd_762x51_Box_Tracer",2};
				attachments1[]= {{0,""},{3,"optic_ACO_grn"},{4,"optic_Holosight"},{6,"optic_MRCO"},{8,"optic_Hamr"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_h"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {};
			};
		};

		headgear[]= {{0,"H_Bandanna_khk"},{12,"H_Bandanna_mcamo"},{18,"H_HelmetSpecO_blk"}};
	};
};