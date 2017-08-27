class crew : rifleman
{
	name    = "Crewman";
	picture =  __EVAL(MCCPATH +"mcc\roleSelection\data\Crew.paa");
	minPlayersForKit = 0;
	maxKitsInGroup = 99;
	maxKitsInSide = 999;
	allowMg = 0;
	allowAT = 0;
	allowSniper = 0;
	allowPilot = 0;
	allowCrew = 1;

	class west : west
	{
		class primary
		{
			class hgun_PDW2000_F
			{
				unlockLevel = 0;
				cfgname = "hgun_PDW2000_F";
				magazines[]= {"30Rnd_9x21_Mag",6};
				attachments1[]= {{3,"optic_Aco_smg"},{4,"optic_Holosight_smg"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class SMG_01_F
			{
				unlockLevel = 13;
				cfgname = "SMG_01_F";
				magazines[]= {"30Rnd_45ACP_Mag_SMG_01",6};
				attachments1[]= {{3,"optic_Aco_smg"},{4,"optic_Holosight_smg"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class SMG_02_F
			{
				unlockLevel = 13;
				cfgname = "SMG_02_F";
				magazines[]= {"30Rnd_9x21_Mag",6};
				attachments1[]= {{3,"optic_Aco_smg"},{4,"optic_Holosight_smg"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};
		};

		class secondary
		{

		};

		class handgun
		{

		};

		items1[]={{0,""},{20,"Binocular", {}},{40,"Rangefinder", {}}};
		items2[]={{0,"SmokeShell", 2},{3,"MiniGrenade", 2},{7,"HandGrenade", 2},{11,"SmokeShellRed", 2},{13,"SmokeShellGreen", 2},{21,"Chemlight_green", 2},{22,"Chemlight_red", 2},{23,"Chemlight_yellow", 2},{25,"B_IR_Grenade", 2}};
		items3[]={{0,"MiniGrenade", 2},{3,"SmokeShell", 2},{7,"HandGrenade", 2},{11,"SmokeShellRed", 2},{13,"SmokeShellGreen", 2},{21,"Chemlight_green", 2},{22,"Chemlight_red", 2},{23,"Chemlight_yellow", 2},{25,"B_IR_Grenade", 2}};
		generalItems[]= {{0,"ItemMap",1},{0,"ItemCompass",1},{0,"ItemWatch",1},{0,"ItemRadio",1},{0,"FirstAidKit",2}};
		nightVision[]= {{0,""},{0,"NVGoggles"}};
		headgear[]= {{0,"H_HelmetCrew_B"}};
		googles[]= {{0,""},{0,"G_Combat"},{6,"G_Tactical_Black"},{13,"G_Sport_Blackred"}};
		vests[]= {{0,"V_TacVest_khk"}};
		backpacks[]= {};
		uniforms[]= {{0,"U_B_CombatUniform_mcam"}};
		insigna[]= {{0,""},{0,"111thID"},{0,"BI"},{0,"Curator"},{0,"MANW"}};
	};

	class east : east
	{
		class primary
		{
			class hgun_PDW2000_F
			{
				unlockLevel = 0;
				cfgname = "hgun_PDW2000_F";
				magazines[]= {"30Rnd_9x21_Mag",6};
				attachments1[]= {{3,"optic_Aco_smg"},{4,"optic_Holosight_smg"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class SMG_01_F
			{
				unlockLevel = 13;
				cfgname = "SMG_01_F";
				magazines[]= {"30Rnd_45ACP_Mag_SMG_01",6};
				attachments1[]= {{3,"optic_Aco_smg"},{4,"optic_Holosight_smg"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class SMG_02_F
			{
				unlockLevel = 13;
				cfgname = "SMG_02_F";
				magazines[]= {"30Rnd_9x21_Mag",6};
				attachments1[]= {{3,"optic_Aco_smg"},{4,"optic_Holosight_smg"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};
		};

		class secondary
		{

		};

		class handgun
		{

		};

		items1[]={{0,""},{20,"Binocular", {}},{40,"Rangefinder", {}}};
		items2[]={{0,"SmokeShell", 2},{3,"MiniGrenade", 2},{7,"HandGrenade", 2},{11,"SmokeShellRed", 2},{13,"SmokeShellGreen", 2},{21,"Chemlight_green", 2},{22,"Chemlight_red", 2},{23,"Chemlight_yellow", 2},{25,"B_IR_Grenade", 2}};
		items3[]={{0,"MiniGrenade", 2},{3,"SmokeShell", 2},{7,"HandGrenade", 2},{11,"SmokeShellRed", 2},{13,"SmokeShellGreen", 2},{21,"Chemlight_green", 2},{22,"Chemlight_red", 2},{23,"Chemlight_yellow", 2},{25,"B_IR_Grenade", 2}};
		generalItems[]= {{0,"ItemMap",1},{0,"ItemCompass",1},{0,"ItemWatch",1},{0,"ItemRadio",1},{0,"FirstAidKit",2}};
		nightVision[]= {{0,""},{0,"NVGoggles"}};
		headgear[]= {{0,"H_HelmetCrew_O"}};
		googles[]= {{0,""},{0,"G_Combat"},{6,"G_Tactical_Black"},{13,"G_Sport_Blackred"}};
		vests[]= {{0,"V_BandollierB_khk"}};
		backpacks[]= {};
		uniforms[]= {{0,"U_O_CombatUniform_ocamo"}};
		insigna[]= {{0,""},{0,"GryffinRegiment"},{0,"BI"},{0,"Curator"},{0,"MANW"}};
	};

	class guer : guer
	{
		class primary
		{
			class hgun_PDW2000_F
			{
				unlockLevel = 0;
				cfgname = "hgun_PDW2000_F";
				magazines[]= {"30Rnd_9x21_Mag",6};
				attachments1[]= {{3,"optic_Aco_smg"},{4,"optic_Holosight_smg"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class SMG_01_F
			{
				unlockLevel = 13;
				cfgname = "SMG_01_F";
				magazines[]= {"30Rnd_45ACP_Mag_SMG_01",6};
				attachments1[]= {{3,"optic_Aco_smg"},{4,"optic_Holosight_smg"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};

			class SMG_02_F
			{
				unlockLevel = 13;
				cfgname = "SMG_02_F";
				magazines[]= {"30Rnd_9x21_Mag",6};
				attachments1[]= {{3,"optic_Aco_smg"},{4,"optic_Holosight_smg"}};
				attachments2[]= {};
				attachments3[]= {};
				attachments4[]= {};
			};
		};

		class secondary
		{

		};

		class handgun
		{

		};

		items1[]={{0,""},{20,"Binocular", {}},{40,"Rangefinder", {}}};
		items2[]={{0,"SmokeShell", 2},{3,"MiniGrenade", 2},{7,"HandGrenade", 2},{11,"SmokeShellRed", 2},{13,"SmokeShellGreen", 2},{21,"Chemlight_green", 2},{22,"Chemlight_red", 2},{23,"Chemlight_yellow", 2},{25,"B_IR_Grenade", 2}};
		items3[]={{0,"MiniGrenade", 2},{3,"SmokeShell", 2},{7,"HandGrenade", 2},{11,"SmokeShellRed", 2},{13,"SmokeShellGreen", 2},{21,"Chemlight_green", 2},{22,"Chemlight_red", 2},{23,"Chemlight_yellow", 2},{25,"B_IR_Grenade", 2}};
		generalItems[]= {{0,"ItemMap",1},{0,"ItemCompass",1},{0,"ItemWatch",1},{0,"ItemRadio",1},{0,"FirstAidKit",2}};
		nightVision[]= {{0,""},{0,"NVGoggles"}};
		headgear[]= {{0,"H_HelmetCrew_I"}};
		googles[]= {{0,""},{0,"G_Combat"},{6,"G_Tactical_Black"},{13,"G_Sport_Blackred"}};
		vests[]= {{0,"V_TacVest_khk"}};
		backpacks[]= {};
		uniforms[]= {{0,"U_I_CombatUniform"}};
		insigna[]= {{0,""},{0,"TFAegis"},{0,"BI"},{0,"Curator"},{0,"MANW"}};
	};
};