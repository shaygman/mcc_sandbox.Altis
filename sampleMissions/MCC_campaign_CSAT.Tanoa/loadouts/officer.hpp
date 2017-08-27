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
			class arifle_TRG21_GL_F
			{
				unlockLevel = 0;
				cfgname = "arifle_TRG21_GL_F";
				magazines[]= {"30Rnd_556x45_Stanag",9,"30Rnd_556x45_Stanag_Tracer_Red",2,"1Rnd_HE_Grenade_shell",8};
				attachments1[]= {{0,"optic_Hamr"},{3,"optic_Aco"},{4,"optic_Holosight"},{6,"optic_MRCO"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_M"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {};
			};

			class arifle_SPAR_01_GL_blk_F
			{
				unlockLevel = 13;
				cfgname = "arifle_SPAR_01_GL_blk_F";
				magazines[]= {"30Rnd_556x45_Stanag",9,"30Rnd_556x45_Stanag_Tracer_Red",2,"1Rnd_HE_Grenade_shell",8};
				attachments1[]= {{0,"optic_Hamr"},{3,"optic_Aco"},{4,"optic_Holosight"},{6,"optic_MRCO"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_M"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {};
			};

			class arifle_MX_GL_khk_F
			{
				unlockLevel = 23;
				cfgname = "arifle_MX_GL_khk_F";
				magazines[]= {"30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2,"1Rnd_HE_Grenade_shell",8};
				attachments1[]= {{0,"optic_Hamr"},{3,"optic_Aco"},{4,"optic_Holosight"},{6,"optic_MRCO"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_h"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {};
			};
		};

		items1[]={{0,"Binocular", {}},{10,"Rangefinder", {}},{15,"Laserdesignator", {"Laserbatteries",2}}};
		items2[]={{0,"1Rnd_Smoke_Grenade_shell", 2},{3,"1Rnd_SmokeRed_Grenade_shell", 2},{7,"1Rnd_SmokeGreen_Grenade_shell", 2},{11,"UGL_FlareWhite_F", 2},{13,"SmokeShellGreen", 2},{21,"Chemlight_green", 2},{22,"Chemlight_red", 2},{23,"Chemlight_yellow", 2},{25,"B_IR_Grenade", 2}};
		items3[]={{0,"MiniGrenade", 2},{3,"SmokeShell", 2},{7,"HandGrenade", 2},{11,"SmokeShellRed", 2},{13,"SmokeShellGreen", 2},{21,"Chemlight_green", 2},{22,"Chemlight_red", 2},{23,"Chemlight_yellow", 2},{25,"B_IR_Grenade", 2}};
		generalItems[]= {{0,"ItemMap",1},{0,"ItemCompass",1},{0,"ItemWatch",1},{0,"ItemRadio",1},{0,"FirstAidKit",2},{0,"ItemGPS",1}};
		headgear[]= {{0,"H_Cap_brn_SPECOPS"},{12,"H_Beret_grn_SF"},{18,"H_HelmetB_light_black"}};
	};

	class east : east
	{
		class primary
		{
			class arifle_CTAR_GL_blk_F
			{
				unlockLevel = 0;
				cfgname = "arifle_CTAR_GL_blk_F";
				magazines[]= {"30Rnd_580x42_Mag_F",9,"30Rnd_580x42_Mag_Tracer_F",2,"1Rnd_HE_Grenade_shell",8};
				attachments1[]= {{0,"optic_Hamr"},{3,"optic_Aco"},{4,"optic_Holosight"},{6,"optic_MRCO"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_58_blk_F"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {};
			};

			class arifle_Katiba_GL_F
			{
				unlockLevel = 13;
				cfgname = "arifle_Katiba_GL_F";
				magazines[]= {"30Rnd_65x39_caseless_green",9,"30Rnd_65x39_caseless_green_mag_Tracer",2,"1Rnd_HE_Grenade_shell",8};
				attachments1[]= {{0,"optic_Hamr"},{3,"optic_Aco"},{4,"optic_Holosight"},{6,"optic_MRCO"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_h"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {};
			};

			class arifle_MX_GL_Black_F
			{
				unlockLevel = 23;
				cfgname = "arifle_MX_GL_Black_F";
				magazines[]= {"30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2,"1Rnd_HE_Grenade_shell",8};
				attachments1[]= {{0,"optic_Hamr"},{3,"optic_Aco"},{4,"optic_Holosight"},{6,"optic_MRCO"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_h"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {};
			};
		};

		items1[]={{0,"Binocular", {}},{10,"Rangefinder", {}},{15,"Laserdesignator", {"Laserbatteries",2}}};
		items2[]={{0,"1Rnd_Smoke_Grenade_shell", 2},{3,"1Rnd_SmokeRed_Grenade_shell", 2},{7,"1Rnd_SmokeGreen_Grenade_shell", 2},{11,"UGL_FlareWhite_F", 2},{13,"SmokeShellGreen", 2},{21,"Chemlight_green", 2},{22,"Chemlight_red", 2},{23,"Chemlight_yellow", 2},{25,"B_IR_Grenade", 2}};
		items3[]={{0,"MiniGrenade", 2},{3,"SmokeShell", 2},{7,"HandGrenade", 2},{11,"SmokeShellRed", 2},{13,"SmokeShellGreen", 2},{21,"Chemlight_green", 2},{22,"Chemlight_red", 2},{23,"Chemlight_yellow", 2},{25,"B_IR_Grenade", 2}};
		generalItems[]= {{0,"ItemMap",1},{0,"ItemCompass",1},{0,"ItemWatch",1},{0,"ItemRadio",1},{0,"FirstAidKit",2},{0,"ItemGPS",1}};
		headgear[]= {{0,"H_MilCap_ocamo"},{12,"H_Cap_blk"},{18,"H_HelmetSpecO_blk"}};
	};

	class guer : guer
	{
		class primary
		{
			class arifle_AK12_GL_F
			{
				unlockLevel = 0;
				cfgname = "arifle_AK12_GL_F";
				magazines[]= {"30Rnd_762x39_Mag_Green_F",9,"30Rnd_762x39_Mag_Green_F",2,"1Rnd_HE_Grenade_shell",8};
				attachments1[]= {{0,"optic_Hamr"},{3,"optic_Aco"},{4,"optic_Holosight"},{6,"optic_MRCO"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_B"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {};
			};

			class arifle_Mk20_GL_F
			{
				unlockLevel = 13;
				cfgname = "arifle_Mk20_GL_F";
				magazines[]= {"30Rnd_556x45_Stanag",9,"30Rnd_556x45_Stanag_Tracer_Red",2,"1Rnd_HE_Grenade_shell",8};
				attachments1[]= {{0,"optic_Hamr"},{3,"optic_Aco"},{4,"optic_Holosight"},{6,"optic_MRCO"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_M"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {};
			};

			class arifle_MX_GL_Black_F
			{
				unlockLevel = 23;
				cfgname = "arifle_MX_GL_Black_F";
				magazines[]= {"30Rnd_65x39_caseless_mag",9,"30Rnd_65x39_caseless_mag_Tracer",2,"1Rnd_HE_Grenade_shell",8};
				attachments1[]= {{0,"optic_Hamr"},{3,"optic_Aco"},{4,"optic_Holosight"},{6,"optic_MRCO"},{10,"optic_Arco"}};
				attachments2[]= {{0,""},{9,"muzzle_snds_h"}};
				attachments3[]= {{0,""},{1,"acc_flashlight"},{7,"acc_pointer_IR"}};
				attachments4[]= {};
			};
		};

		items1[]={{0,"Binocular", {}},{10,"Rangefinder", {}},{15,"Laserdesignator", {"Laserbatteries",2}}};
		items2[]={{0,"1Rnd_Smoke_Grenade_shell", 2},{3,"1Rnd_SmokeRed_Grenade_shell", 2},{7,"1Rnd_SmokeGreen_Grenade_shell", 2},{11,"UGL_FlareWhite_F", 2},{13,"SmokeShellGreen", 2},{21,"Chemlight_green", 2},{22,"Chemlight_red", 2},{23,"Chemlight_yellow", 2},{25,"B_IR_Grenade", 2}};
		items3[]={{0,"MiniGrenade", 2},{3,"SmokeShell", 2},{7,"HandGrenade", 2},{11,"SmokeShellRed", 2},{13,"SmokeShellGreen", 2},{21,"Chemlight_green", 2},{22,"Chemlight_red", 2},{23,"Chemlight_yellow", 2},{25,"B_IR_Grenade", 2}};
		generalItems[]= {{0,"ItemMap",1},{0,"ItemCompass",1},{0,"ItemWatch",1},{0,"ItemRadio",1},{0,"FirstAidKit",2},{0,"ItemGPS",1}};
		headgear[]= {{0,"H_Cap_grn"},{12,"H_Cap_blk"},{18,"H_HelmetIA_camo"}};
	};
};