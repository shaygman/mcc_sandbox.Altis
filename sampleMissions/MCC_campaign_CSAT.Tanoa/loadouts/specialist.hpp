class specialist : rifleman
{
	name    = "Specialist";
	picture =  __EVAL(MCCPATH +"mcc\roleSelection\data\Specialist.paa");
	minPlayersForKit = 2;
	maxKitsInGroup = 2;
	maxKitsInSide = 999;
	allowMg = 0;
	allowAT = 0;
	allowSniper = 0;
	allowPilot = 0;
	allowCrew = 0;

	class west : west
	{
		items1[]={{0,"MineDetector", {}},{10,"ToolKit", {}},{15,"Binocular", {}},{20,"Rangefinder", {}}};
		items2[]={{0,"ClaymoreDirectionalMine_Remote_Mag", 2},{3,"APERSMine_Range_Mag", 2},{7,"APERSBoundingMine_Range_Mag", 2},{11,"SLAMDirectionalMine_Wire_Mag", 2},{13,"ATMine_Range_Mag", 2},{21,"SatchelCharge_Remote_Mag", 2},{25,"B_IR_Grenade", 2}};
		items3[]={{0,"MiniGrenade", 2},{3,"SmokeShell", 2},{7,"HandGrenade", 2},{11,"SmokeShellRed", 2},{13,"SmokeShellGreen", 2},{21,"Chemlight_green", 2},{22,"Chemlight_red", 2},{23,"Chemlight_yellow", 2},{25,"B_IR_Grenade", 2}};
		generalItems[]= {{0,"ItemMap",1},{0,"ItemCompass",1},{0,"ItemWatch",1},{0,"ItemRadio",1},{0,"FirstAidKit",2},{0,"DemoCharge_Remote_Mag",2}};
		headgear[]= {{0,"H_Watchcap_blk"},{12,"H_HelmetB_light"},{18,"H_HelmetB_light_black"}};
	};

	class east : east
	{
		items1[]={{0,"MineDetector", {}},{10,"ToolKit", {}},{15,"Binocular", {}},{20,"Rangefinder", {}}};
		items2[]={{0,"ClaymoreDirectionalMine_Remote_Mag", 2},{3,"APERSMine_Range_Mag", 2},{7,"APERSBoundingMine_Range_Mag", 2},{11,"SLAMDirectionalMine_Wire_Mag", 2},{13,"ATMine_Range_Mag", 2},{21,"SatchelCharge_Remote_Mag", 2},{25,"B_IR_Grenade", 2}};
		items3[]={{0,"MiniGrenade", 2},{3,"SmokeShell", 2},{7,"HandGrenade", 2},{11,"SmokeShellRed", 2},{13,"SmokeShellGreen", 2},{21,"Chemlight_green", 2},{22,"Chemlight_red", 2},{23,"Chemlight_yellow", 2},{25,"B_IR_Grenade", 2}};
		generalItems[]= {{0,"ItemMap",1},{0,"ItemCompass",1},{0,"ItemWatch",1},{0,"ItemRadio",1},{0,"FirstAidKit",2},{0,"DemoCharge_Remote_Mag",2}};
		headgear[]= {{0,"H_Watchcap_blk"},{12,"H_HelmetO_oucamo"},{18,"H_HelmetSpecO_blk"}};
	};

	class guer : guer
	{
		items1[]={{0,"MineDetector", {}},{10,"ToolKit", {}},{15,"Binocular", {}},{20,"Rangefinder", {}}};
		items2[]={{0,"ClaymoreDirectionalMine_Remote_Mag", 2},{3,"APERSMine_Range_Mag", 2},{7,"APERSBoundingMine_Range_Mag", 2},{11,"SLAMDirectionalMine_Wire_Mag", 2},{13,"ATMine_Range_Mag", 2},{21,"SatchelCharge_Remote_Mag", 2},{25,"B_IR_Grenade", 2}};
		items3[]={{0,"MiniGrenade", 2},{3,"SmokeShell", 2},{7,"HandGrenade", 2},{11,"SmokeShellRed", 2},{13,"SmokeShellGreen", 2},{21,"Chemlight_green", 2},{22,"Chemlight_red", 2},{23,"Chemlight_yellow", 2},{25,"B_IR_Grenade", 2}};
		generalItems[]= {{0,"ItemMap",1},{0,"ItemCompass",1},{0,"ItemWatch",1},{0,"ItemRadio",1},{0,"FirstAidKit",2},{0,"DemoCharge_Remote_Mag",2}};
		headgear[]= {{0,"H_Watchcap_blk"},{12,"H_HelmetIA_net"},{18,"H_HelmetIA_camo"}};
	};
};