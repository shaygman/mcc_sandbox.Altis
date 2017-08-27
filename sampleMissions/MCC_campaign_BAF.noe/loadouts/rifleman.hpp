class rifleman
{
	name    = "Rifleman";
	picture =  __EVAL(MCCPATH +"mcc\roleSelection\data\Rifleman.paa");
	minPlayersForKit = 0;
	maxKitsInGroup = 99;
	maxKitsInSide = 999;
	allowMg = 0;
	allowAT = 0;
	allowSniper = 0;
	allowPilot = 0;
	allowCrew = 0;

	class west
	{
		class primary
		{
			class CUP_arifle_L85A2
			{
				unlockLevel = 0;
				cfgname = "CUP_arifle_L85A2";
				magazines[]= {"30Rnd_556x45_Stanag",9,"30Rnd_556x45_Stanag_Tracer_Red",2};
				attachments1[]= {{0,""},{3,"CUP_optic_TrijiconRx01_desert"},{4,"optic_Holosight"},{6,"CUP_optic_SUSAT"},{8,"CUP_optic_RCO"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_snds_L85"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {};
			};

			class CUP_arifle_M4A1_black
			{
				unlockLevel = 13;
				cfgname = "CUP_arifle_M4A1_black";
				magazines[]= {"30Rnd_556x45_Stanag",9,"30Rnd_556x45_Stanag_Tracer_Red",2};
				attachments1[]= {{0,""},{3,"CUP_optic_CompM4"},{4,"CUP_optic_TrijiconRx01_desert"},{6,"optic_MRCO"},{8,"CUP_optic_RCO"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_snds_M16"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {};
			};

			class CUP_arifle_M16A4_Base
			{
				unlockLevel = 23;
				cfgname = "CUP_arifle_M16A4_Base";
				magazines[]= {"30Rnd_556x45_Stanag",9,"30Rnd_556x45_Stanag_Tracer_Red",2};
				attachments1[]= {{0,""},{3,"CUP_optic_CompM4"},{4,"CUP_optic_TrijiconRx01_desert"},{6,"optic_MRCO"},{8,"CUP_optic_RCO"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_snds_M16"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {{0,""},{1,"CUP_bipod_Harris_1A2_L"}};
			};
		};

		class secondary
		{

		};

		class handgun
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

			class hgun_Rook40_F
			{
				unlockLevel = 4;
				cfgname = "hgun_Rook40_F";
				magazines[]= {"16Rnd_9x21_Mag",2};
				attachments1[]= {};
				attachments2[]= {{0,""},{2,"muzzle_snds_L"}};
				attachments3[]= {};
				attachments4[]= {};
			};

			class hgun_P07_F
			{
				unlockLevel = 8;
				cfgname = "hgun_P07_F";
				magazines[]= {"16Rnd_9x21_Mag",2};
				attachments1[]= {};
				attachments2[]= {{0,""},{2,"muzzle_snds_L"}};
				attachments3[]= {};
				attachments4[]= {};
			};

			class hgun_ACPC2_F
			{
				unlockLevel = 12;
				cfgname = "hgun_ACPC2_F";
				magazines[]= {"9Rnd_45ACP_Mag",2};
				attachments1[]= {};
				attachments2[]= {{0,""},{2,"muzzle_snds_acp"}};
				attachments3[]= {};
				attachments4[]= {};
			};

			class hgun_Pistol_heavy_02_F
			{
				unlockLevel = 16;
				cfgname = "hgun_Pistol_heavy_02_F";
				magazines[]= {"6Rnd_45ACP_Cylinder",2};
				attachments1[]= {{0,""},{2,"optic_Yorris"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class hgun_Pistol_heavy_01_F
			{
				unlockLevel = 16;
				cfgname = "hgun_Pistol_heavy_01_F";
				magazines[]= {"11Rnd_45ACP_Mag",2};
				attachments1[]= {{0,""},{4,"optic_MRD"}};
				attachments2[]= {{0,""},{2,"muzzle_snds_acp"}};
				attachments3[]= {};
				attachments4[]= {};
			};
		};

		items1[]={{0,""},{20,"Binocular", {}},{40,"Rangefinder", {}}};
		items2[]={{0,"SmokeShell", 2},{3,"MiniGrenade", 2},{7,"HandGrenade", 2},{11,"SmokeShellRed", 2},{13,"SmokeShellGreen", 2},{21,"Chemlight_green", 2},{22,"Chemlight_red", 2},{23,"Chemlight_yellow", 2},{25,"B_IR_Grenade", 2}};
		items3[]={{0,"MiniGrenade", 2},{3,"SmokeShell", 2},{7,"HandGrenade", 2},{11,"SmokeShellRed", 2},{13,"SmokeShellGreen", 2},{21,"Chemlight_green", 2},{22,"Chemlight_red", 2},{23,"Chemlight_yellow", 2},{25,"B_IR_Grenade", 2}};
		generalItems[]= {{0,"ItemMap",1},{0,"ItemCompass",1},{0,"ItemWatch",1},{0,"ItemRadio",1},{0,"FirstAidKit",2}};
		nightVision[]= {{0,""},{0,"CUP_NVG_HMNVS"},{6,"CUP_NVG_PVS7"}};
		headgear[]= {{0,"CUP_H_BAF_Helmet_Net_2_DPM"},{12,"CUP_H_BAF_Helmet_3_MTP"},{18,"CUP_H_BAF_Helmet_Net_2_DDPM"}};
		googles[]= {{0,""},{0,"G_Combat"},{7,"CUP_TK_NeckScarf"},{9,"G_Balaclava_blk"},{11,"G_Tactical_Black"},{13,"G_Sport_Blackred"}};
		vests[]= {{0,"CUP_V_BAF_Osprey_Mk2_DPM_Soldier1"},{9,"CUP_V_BAF_Osprey_Mk4_MTP_Rifleman"},{13,"CUP_V_BAF_Osprey_Mk2_DDPM_Soldier2"},{19,"V_PlateCarrier1_blk"}};
		backpacks[]= {{0,"CUP_B_AlicePack_Khaki"},{7,"CUP_B_AlicePack_Bedroll"},{14,"CUP_B_Bergen_BAF"},{18,"B_AssaultPack_blk"}};
		uniforms[]= {{0,"CUP_U_B_BAF_DPM_S1_RolledUp"},{8,"CUP_U_B_BAF_MTP_S1_RolledUp"},{15,"CUP_U_B_BAF_DDPM_S1_RolledUp"}};
		insigna[]= {{0,""},{0,"111thID"},{0,"BI"},{0,"Curator"},{0,"MANW"}};
	};

	class east
	{
		class primary
		{
			class CUP_arifle_AK74
			{
				unlockLevel = 0;
				cfgname = "CUP_arifle_AK74";
				magazines[]= {"CUP_30Rnd_545x39_AK_M",9,"CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M",2};
				attachments1[]= {{0,""},{3,"CUP_optic_Kobra"},{4,"CUP_optic_PSO_1"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_PBS4"}};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_arifle_AK74M
			{
				unlockLevel = 13;
				cfgname = "CUP_arifle_AK74M";
				magazines[]= {"CUP_30Rnd_545x39_AK_M",9,"CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M",2};
				attachments1[]= {{0,""},{3,"CUP_optic_Kobra"},{4,"CUP_optic_PSO_1"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_PBS4"}};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_arifle_AK107
			{
				unlockLevel = 23;
				cfgname = "CUP_arifle_AK107";
				magazines[]= {"CUP_30Rnd_545x39_AK_M",9,"CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M",2};
				attachments1[]= {{0,""},{3,"CUP_optic_Kobra"},{4,"CUP_optic_PSO_1"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_PBS4"}};
				attachments3[]= {};
				attachments4[]= {};
			};
		};

		class secondary
		{

		};

		class handgun
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

			class hgun_Rook40_F
			{
				unlockLevel = 4;
				cfgname = "hgun_Rook40_F";
				magazines[]= {"16Rnd_9x21_Mag",2};
				attachments1[]= {};
				attachments2[]= {{0,""},{2,"muzzle_snds_L"}};
				attachments3[]= {};
				attachments4[]= {};
			};

			class hgun_P07_F
			{
				unlockLevel = 8;
				cfgname = "hgun_P07_F";
				magazines[]= {"16Rnd_9x21_Mag",2};
				attachments1[]= {};
				attachments2[]= {{0,""},{2,"muzzle_snds_L"}};
				attachments3[]= {};
				attachments4[]= {};
			};

			class hgun_ACPC2_F
			{
				unlockLevel = 12;
				cfgname = "hgun_ACPC2_F";
				magazines[]= {"9Rnd_45ACP_Mag",2};
				attachments1[]= {};
				attachments2[]= {{0,""},{2,"muzzle_snds_acp"}};
				attachments3[]= {};
				attachments4[]= {};
			};

			class hgun_Pistol_heavy_02_F
			{
				unlockLevel = 16;
				cfgname = "hgun_Pistol_heavy_02_F";
				magazines[]= {"6Rnd_45ACP_Cylinder",2};
				attachments1[]= {{0,""},{2,"optic_Yorris"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class hgun_Pistol_heavy_01_F
			{
				unlockLevel = 16;
				cfgname = "hgun_Pistol_heavy_01_F";
				magazines[]= {"11Rnd_45ACP_Mag",2};
				attachments1[]= {{0,""},{4,"optic_MRD"}};
				attachments2[]= {{0,""},{2,"muzzle_snds_acp"}};
				attachments3[]= {};
				attachments4[]= {};
			};
		};

		items1[]={{0,""},{20,"Binocular", {}},{40,"Rangefinder", {}}};
		items2[]={{0,"SmokeShell", 2},{3,"MiniGrenade", 2},{7,"HandGrenade", 2},{11,"SmokeShellRed", 2},{13,"SmokeShellGreen", 2},{21,"Chemlight_green", 2},{22,"Chemlight_red", 2},{23,"Chemlight_yellow", 2},{25,"B_IR_Grenade", 2}};
		items3[]={{0,"MiniGrenade", 2},{3,"SmokeShell", 2},{7,"HandGrenade", 2},{11,"SmokeShellRed", 2},{13,"SmokeShellGreen", 2},{21,"Chemlight_green", 2},{22,"Chemlight_red", 2},{23,"Chemlight_yellow", 2},{25,"B_IR_Grenade", 2}};
		generalItems[]= {{0,"ItemMap",1},{0,"ItemCompass",1},{0,"ItemWatch",1},{0,"ItemRadio",1},{0,"FirstAidKit",2}};
		nightVision[]= {{0,""},{0,"CUP_NVG_HMNVS"},{6,"CUP_NVG_PVS7"}};
		headgear[]= {{0,"CUP_H_RUS_6B27_NVG"},{12,"CUP_H_RUS_6B27_olive"},{18,"CUP_H_RUS_ZSH_1"}};
		googles[]= {{0,""},{0,"G_Combat"},{7,"CUP_TK_NeckScarf"},{9,"G_Balaclava_blk"},{11,"G_Tactical_Black"},{13,"G_Sport_Blackred"}};
		vests[]= {{0,"CUP_V_RUS_6B3_1"},{9,"CUP_V_O_SLA_Flak_Vest03"},{13,"CUP_V_O_SLA_Flak_Vest01"}};
		backpacks[]= {{0,"CUP_B_AlicePack_Khaki"},{7,"CUP_B_AlicePack_Bedroll"},{14,"B_Carryall_ocamo"},{18,"B_FieldPack_blk"}};
		uniforms[]= {{0,"CUP_U_O_RUS_Flora_2"},{8,"CUP_U_O_RUS_EMR_2"},{15,"CUP_U_O_RUS_Gorka_Partizan"}};
		insigna[]= {{0,""},{0,"GryffinRegiment"},{0,"BI"},{0,"Curator"},{0,"MANW"}};
	};

	class guer
	{
		class primary
		{
			class CUP_arifle_AK74
			{
				unlockLevel = 0;
				cfgname = "CUP_arifle_AK74";
				magazines[]= {"CUP_30Rnd_545x39_AK_M",9,"CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M",2};
				attachments1[]= {{0,""},{3,"CUP_optic_Kobra"},{4,"CUP_optic_PSO_1"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_PBS4"}};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_arifle_FNFAL_railed
			{
				unlockLevel = 8;
				cfgname = "CUP_arifle_FNFAL_railed";
				magazines[]= {"CUP_20Rnd_762x51_FNFAL_M",9};
				attachments1[]= {{0,""},{3,"CUP_optic_CompM4"},{4,"CUP_optic_TrijiconRx01_desert"},{6,"optic_MRCO"},{8,"CUP_optic_RCO"},{10,"optic_Arco"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_arifle_AK74M
			{
				unlockLevel = 16;
				cfgname = "CUP_arifle_AK74M";
				magazines[]= {"CUP_30Rnd_545x39_AK_M",9,"CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M",2};
				attachments1[]= {{0,""},{3,"CUP_optic_Kobra"},{4,"CUP_optic_PSO_1"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_PBS4"}};
				attachments3[]= {};
				attachments4[]= {};
			};

			class CUP_arifle_AK107
			{
				unlockLevel = 23;
				cfgname = "CUP_arifle_AK107";
				magazines[]= {"CUP_30Rnd_545x39_AK_M",9,"CUP_30Rnd_TE1_Green_Tracer_545x39_AK_M",2};
				attachments1[]= {{0,""},{3,"CUP_optic_Kobra"},{4,"CUP_optic_PSO_1"}};
				attachments2[]= {{0,""},{9,"CUP_muzzle_PBS4"}};
				attachments3[]= {};
				attachments4[]= {};
			};
		};

		class secondary
		{

		};

		class handgun
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

			class hgun_Rook40_F
			{
				unlockLevel = 4;
				cfgname = "hgun_Rook40_F";
				magazines[]= {"16Rnd_9x21_Mag",2};
				attachments1[]= {};
				attachments2[]= {{0,""},{2,"muzzle_snds_L"}};
				attachments3[]= {};
				attachments4[]= {};
			};

			class hgun_P07_F
			{
				unlockLevel = 8;
				cfgname = "hgun_P07_F";
				magazines[]= {"16Rnd_9x21_Mag",2};
				attachments1[]= {};
				attachments2[]= {{0,""},{2,"muzzle_snds_L"}};
				attachments3[]= {};
				attachments4[]= {};
			};

			class hgun_ACPC2_F
			{
				unlockLevel = 12;
				cfgname = "hgun_ACPC2_F";
				magazines[]= {"9Rnd_45ACP_Mag",2};
				attachments1[]= {};
				attachments2[]= {{0,""},{2,"muzzle_snds_acp"}};
				attachments3[]= {};
				attachments4[]= {};
			};

			class hgun_Pistol_heavy_02_F
			{
				unlockLevel = 16;
				cfgname = "hgun_Pistol_heavy_02_F";
				magazines[]= {"6Rnd_45ACP_Cylinder",2};
				attachments1[]= {{0,""},{2,"optic_Yorris"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class hgun_Pistol_heavy_01_F
			{
				unlockLevel = 16;
				cfgname = "hgun_Pistol_heavy_01_F";
				magazines[]= {"11Rnd_45ACP_Mag",2};
				attachments1[]= {{0,""},{4,"optic_MRD"}};
				attachments2[]= {{0,""},{2,"muzzle_snds_acp"}};
				attachments3[]= {};
				attachments4[]= {};
			};
		};

		items1[]={{0,""},{20,"Binocular", {}},{40,"Rangefinder", {}}};
		items2[]={{0,"SmokeShell", 2},{3,"MiniGrenade", 2},{7,"HandGrenade", 2},{11,"SmokeShellRed", 2},{13,"SmokeShellGreen", 2},{21,"Chemlight_green", 2},{22,"Chemlight_red", 2},{23,"Chemlight_yellow", 2},{25,"B_IR_Grenade", 2}};
		items3[]={{0,"MiniGrenade", 2},{3,"SmokeShell", 2},{7,"HandGrenade", 2},{11,"SmokeShellRed", 2},{13,"SmokeShellGreen", 2},{21,"Chemlight_green", 2},{22,"Chemlight_red", 2},{23,"Chemlight_yellow", 2},{25,"B_IR_Grenade", 2}};
		generalItems[]= {{0,"ItemMap",1},{0,"ItemCompass",1},{0,"ItemWatch",1},{0,"ItemRadio",1},{0,"FirstAidKit",2}};
		nightVision[]= {{0,""},{0,"CUP_NVG_HMNVS"},{6,"CUP_NVG_PVS7"}};
		headgear[]= {{0,"H_Shemag_olive_hs"},{0,"H_Bandanna_sgg"},{0,"CUP_H_TKI_Pakol_2_06"},{0,"CUP_H_TKI_Lungee_Open_02"},{11,"CUP_H_TKI_SkullCap_03"},{12,"CUP_H_TK_Helmet"}};
		googles[]= {{0,""},{0,"G_Combat"},{7,"CUP_TK_NeckScarf"},{9,"G_Balaclava_blk"},{11,"G_Tactical_Black"},{13,"G_Sport_Blackred"}};
		vests[]= {{0,"CUP_V_OI_TKI_Jacket1_03"},{9,"CUP_V_OI_TKI_Jacket4_02"},{13,"CUP_V_OI_TKI_Jacket3_01"},{19,"CUP_V_O_TK_Vest_1"}};
		backpacks[]= {{0,"CUP_B_AlicePack_Khaki"},{7,"CUP_B_AlicePack_Bedroll"},{14,"B_Carryall_ocamo"},{18,"B_FieldPack_blk"}};
		uniforms[]= {{0,"CUP_U_O_CHDKZ_Kam_05"},{0,"CUP_U_I_GUE_Anorak_03"},{0,"CUP_O_TKI_Khet_Jeans_04"},{0,"CUP_O_TKI_Khet_Partug_01"},{0,"CUP_U_O_Partisan_VSR_Mixed2"},{8,"CUP_U_O_TK_MixedCamo"}};
		insigna[]= {{0,""},{0,"TFAegis"},{0,"BI"},{0,"Curator"},{0,"MANW"}};
	};
};