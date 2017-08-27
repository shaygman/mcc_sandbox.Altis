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
			class CUP_lmg_m249_para
			{
				unlockLevel = 0;
				cfgname = "CUP_lmg_m249_para";
				magazines[]= {"CUP_200Rnd_TE4_Red_Tracer_556x45_M249",4};
				attachments1[]= {{0,""},{3,"CUP_optic_TrijiconRx01_desert"},{4,"optic_Holosight"},{6,"CUP_optic_SUSAT"},{8,"CUP_optic_RCO"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_M"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {};
			};

			class CUP_lmg_M240
			{
				unlockLevel = 13;
				cfgname = "CUP_lmg_M240";
				magazines[]= {"CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M",4};
				attachments1[]= {{0,""},{3,"optic_Aco"},{4,"optic_Holosight"},{6,"optic_MRCO"},{8,"optic_Hamr"},{10,"optic_Arco"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_lmg_Mk48_wdl
			{
				unlockLevel = 23;
				cfgname = "CUP_lmg_Mk48_wdl";
				magazines[]= {"CUP_100Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M",4};
				attachments1[]= {{0,""},{3,"optic_Aco"},{4,"optic_Holosight"},{6,"optic_MRCO"},{8,"optic_Hamr"},{10,"optic_Arco"}};
				attachments2[]= {};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {};
			};
		};
	};

	class east : east
	{
		class primary
		{
			class CUP_arifle_RPK74_45
			{
				unlockLevel = 0;
				cfgname = "CUP_arifle_RPK74_45";
				magazines[]= {"CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M",9,"CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M",2};
				attachments1[]= {{0,""},{3,"CUP_optic_Kobra"},{4,"CUP_optic_PSO_1"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_PBS4"}};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_arifle_RPK74
			{
				unlockLevel = 13;
				cfgname = "CUP_arifle_RPK74";
				magazines[]= {"CUP_75Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M",5};
				attachments1[]= {{0,""},{3,"CUP_optic_Kobra"},{4,"CUP_optic_PSO_1"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_PBS4"}};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_lmg_Pecheneg
			{
				unlockLevel = 23;
				cfgname = "CUP_lmg_Pecheneg";
				magazines[]= {"CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M",4};
				attachments1[]= {{0,""},{3,"CUP_optic_PechenegScope"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};
		};
	};

	class guer : guer
	{
		class primary
		{
			class CUP_arifle_RPK74_45
			{
				unlockLevel = 0;
				cfgname = "CUP_arifle_RPK74_45";
				magazines[]= {"CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M",9,"CUP_45Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M",2};
				attachments1[]= {{0,""},{3,"CUP_optic_Kobra"},{4,"CUP_optic_PSO_1"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_PBS4"}};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_arifle_RPK74
			{
				unlockLevel = 13;
				cfgname = "CUP_arifle_RPK74";
				magazines[]= {"CUP_75Rnd_TE4_LRT4_Green_Tracer_545x39_RPK_M",5};
				attachments1[]= {{0,""},{3,"CUP_optic_Kobra"},{4,"CUP_optic_PSO_1"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_PBS4"}};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_lmg_Pecheneg
			{
				unlockLevel = 23;
				cfgname = "CUP_lmg_Pecheneg";
				magazines[]= {"CUP_100Rnd_TE4_LRT4_762x54_PK_Tracer_Green_M",4};
				attachments1[]= {{0,""},{3,"CUP_optic_PechenegScope"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};
		};
	};
};