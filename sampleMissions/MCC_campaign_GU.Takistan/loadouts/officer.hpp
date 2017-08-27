class officer : rifleman
{
	name    = "Officer";
	picture =  __EVAL(MCCPATH +"mcc\roleSelection\data\Officer.paa");
	minPlayersForKit = 0;
	maxKitsInGroup = 1;
	maxKitsInSide = 999;
	allowMg = 0;
	allowAT = 0;
	allowSniper = 0;
	allowPilot = 0;
	allowCrew = 0;

	class west : west
	{
		class primary
		{
			class CUP_arifle_M16A4_GL
			{
				unlockLevel = 0;
				cfgname = "CUP_arifle_M16A4_GL";
				magazines[]= {"30Rnd_556x45_Stanag",9,"30Rnd_556x45_Stanag_Tracer_Red",2,"1Rnd_HE_Grenade_shell",8,"1Rnd_SmokeRed_Grenade_shell",2,"1Rnd_SmokeGreen_Grenade_shell",2};
				attachments1[]= {{0,""},{3,"CUP_optic_CompM4"},{4,"CUP_optic_TrijiconRx01_desert"},{6,"optic_MRCO"},{8,"CUP_optic_RCO"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_snds_M16"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {{0,""},{1,"CUP_bipod_Harris_1A2_L"}};
			};

			class CUP_arifle_M4A1_BUIS_GL
			{
				unlockLevel = 13;
				cfgname = "CUP_arifle_M4A1_BUIS_GL";
				magazines[]= {"30Rnd_556x45_Stanag",9,"30Rnd_556x45_Stanag_Tracer_Red",2,"1Rnd_HE_Grenade_shell",8,"1Rnd_SmokeRed_Grenade_shell",2,"1Rnd_SmokeGreen_Grenade_shell",2};
				attachments1[]= {{0,""},{3,"CUP_optic_CompM4"},{4,"CUP_optic_TrijiconRx01_desert"},{6,"optic_MRCO"},{8,"CUP_optic_RCO"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_snds_M16"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {};
			};

			class CUP_arifle_Mk17_CQC_EGLM
			{
				unlockLevel = 23;
				cfgname = "CUP_arifle_Mk17_CQC_EGLM";
				magazines[]= {"CUP_20Rnd_762x51_B_SCAR",9,"CUP_20Rnd_TE1_Red_Tracer_762x51_SCAR",2,"1Rnd_HE_Grenade_shell",8,"1Rnd_SmokeRed_Grenade_shell",2,"1Rnd_SmokeGreen_Grenade_shell",2};
				attachments1[]= {{0,""},{3,"CUP_optic_TrijiconRx01_desert"},{4,"optic_Holosight"},{6,"CUP_optic_SUSAT"},{8,"CUP_optic_RCO"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_snds_SCAR_H"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {};
			};
		};

		class secondary
		{
			class none
			{
				unlockLevel = 0;
				cfgname = "";
				magazines[]= {};
				attachments1[]= {};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class MCC_TentDome
			{
				unlockLevel = 0;
				cfgname = "MCC_TentDome";
				magazines[]= {};
				attachments1[]= {};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};
		};


		items1[]={{0,"Binocular"},{5,"Rangefinder", {}},{10,"Laserdesignator", {"Laserbatteries",2}}};
		generalItems[]= {{0,"ItemMap",1},{0,"ItemCompass",1},{0,"ItemWatch",1},{0,"ItemRadio",1},{0,"FirstAidKit",2},{0,"ItemGPS",1}};
		headgear[]= {{0,"H_Cap_usblack"},{12,"CUP_H_PMC_Cap_EP_Grey"},{18,"CUP_H_PMC_Cap_Back_EP_Grey"}};
		vests[]= {{0,"CUP_V_BAF_Osprey_Mk2_DPM_Grenadier"},{9,"CUP_V_BAF_Osprey_Mk4_MTP_Grenadier"},{13,"CUP_V_BAF_Osprey_Mk2_DPM_Officer"},{19,"V_PlateCarrier1_blk"}};
	};

	class east : east
	{
		class primary
		{
			class CUP_arifle_AK74_GL
			{
				unlockLevel = 0;
				cfgname = "CUP_arifle_AK74_GL";
				magazines[]= {"CUP_30Rnd_545x39_AK_M",9,"CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M",2,"CUP_1Rnd_HE_GP25_M",8,"CUP_1Rnd_SmokeRed_GP25_M",2,"CUP_1Rnd_SmokeGreen_GP25_M",2};
				attachments1[]= {{0,""},{3,"CUP_optic_Kobra"},{4,"CUP_optic_PSO_1"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_PBS4"}};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_arifle_AK74M_GL
			{
				unlockLevel = 13;
				cfgname = "CUP_arifle_AK74M_GL";
				magazines[]= {"CUP_30Rnd_545x39_AK_M",9,"CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M",2,"CUP_1Rnd_HE_GP25_M",8,"CUP_1Rnd_SmokeRed_GP25_M",2,"CUP_1Rnd_SmokeGreen_GP25_M",2};
				attachments1[]= {{0,""},{3,"CUP_optic_Kobra"},{4,"CUP_optic_PSO_1"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_PBS4"}};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_arifle_AK107_GL
			{
				unlockLevel = 23;
				cfgname = "CUP_arifle_AK107_GL";
				magazines[]= {"CUP_30Rnd_545x39_AK_M",9,"CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M",2,"CUP_1Rnd_HE_GP25_M",8,"CUP_1Rnd_SmokeRed_GP25_M",2,"CUP_1Rnd_SmokeGreen_GP25_M",2};
				attachments1[]= {{0,""},{3,"CUP_optic_Kobra"},{4,"CUP_optic_PSO_1"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_PBS4"}};
				attachments3[]= {};
				attachments4[]= {};
			};
		};

		class secondary
		{
			class none
			{
				unlockLevel = 0;
				cfgname = "";
				magazines[]= {};
				attachments1[]= {};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class MCC_TentA
			{
				unlockLevel = 0;
				cfgname = "MCC_TentA";
				magazines[]= {};
				attachments1[]= {};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};
		};

		items1[]={{0,"Binocular"},{5,"Rangefinder", {}},{10,"Laserdesignator", {"Laserbatteries",2}}};
		generalItems[]= {{0,"ItemMap",1},{0,"ItemCompass",1},{0,"ItemWatch",1},{0,"ItemRadio",1},{0,"FirstAidKit",2},{0,"ItemGPS",1}};
		headgear[]= {{0,"CUP_H_RUS_Beret_Spetsnaz"},{12,"CUP_H_ChDKZ_Cap"},{18,"CUP_H_C_Ushanka_02"}};
	};

	class guer : guer
	{
		class primary
		{
			class CUP_arifle_AK74_GL
			{
				unlockLevel = 0;
				cfgname = "CUP_arifle_AK74_GL";
				magazines[]= {"CUP_30Rnd_545x39_AK_M",9,"CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M",2,"CUP_1Rnd_HE_GP25_M",8,"CUP_1Rnd_SmokeRed_GP25_M",2,"CUP_1Rnd_SmokeGreen_GP25_M",2};
				attachments1[]= {{0,""},{3,"CUP_optic_Kobra"},{4,"CUP_optic_PSO_1"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_PBS4"}};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_arifle_AK74M_GL
			{
				unlockLevel = 13;
				cfgname = "CUP_arifle_AK74M_GL";
				magazines[]= {"CUP_30Rnd_545x39_AK_M",9,"CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M",2,"CUP_1Rnd_HE_GP25_M",8,"CUP_1Rnd_SmokeRed_GP25_M",2,"CUP_1Rnd_SmokeGreen_GP25_M",2};
				attachments1[]= {{0,""},{3,"CUP_optic_Kobra"},{4,"CUP_optic_PSO_1"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_PBS4"}};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_arifle_AK107_GL
			{
				unlockLevel = 23;
				cfgname = "CUP_arifle_AK107_GL";
				magazines[]= {"CUP_30Rnd_545x39_AK_M",9,"CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M",2,"CUP_1Rnd_HE_GP25_M",8,"CUP_1Rnd_SmokeRed_GP25_M",2,"CUP_1Rnd_SmokeGreen_GP25_M",2};
				attachments1[]= {{0,""},{3,"CUP_optic_Kobra"},{4,"CUP_optic_PSO_1"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_PBS4"}};
				attachments3[]= {};
				attachments4[]= {};
			};
		};

		class secondary
		{
			class none
			{
				unlockLevel = 0;
				cfgname = "";
				magazines[]= {};
				attachments1[]= {};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class MCC_TentA
			{
				unlockLevel = 0;
				cfgname = "MCC_TentA";
				magazines[]= {};
				attachments1[]= {};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};
		};

		items1[]={{0,"Binocular"},{5,"Rangefinder", {}},{10,"Laserdesignator", {"Laserbatteries",2}}};
		generalItems[]= {{0,"ItemMap",1},{0,"ItemCompass",1},{0,"ItemWatch",1},{0,"ItemRadio",1},{0,"FirstAidKit",2},{0,"ItemGPS",1}};
		headgear[]= {{0,"CUP_H_SLA_Boonie"},{12,"CUP_H_ChDKZ_Beret"},{18,"CUP_H_C_Ushanka_02"}};
	};
};