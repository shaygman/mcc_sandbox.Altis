class specialist : rifleman
{
	name    = "Specialist";
	picture =  __EVAL(MCCPATH +"mcc\roleSelection\data\Specialist.paa");
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
		items1[]={{0,"MineDetector", {}},{10,"MCC_videoProbe", {}},{15,"Binocular", {}},{20,"Rangefinder", {}}};
		items2[]={{0,"ClaymoreDirectionalMine_Remote_Mag", 2},{3,"APERSMine_Range_Mag", 2},{7,"APERSBoundingMine_Range_Mag", 2},{11,"SLAMDirectionalMine_Wire_Mag", 2},{13,"ATMine_Range_Mag", 2},{21,"SatchelCharge_Remote_Mag", 2},{25,"B_IR_Grenade", 2}};
		generalItems[]= {{0,"MCC_multiTool",1},{0,"ItemMap",1},{0,"ItemCompass",1},{0,"ItemWatch",1},{0,"ItemRadio",1},{0,"FirstAidKit",2},{0,"DemoCharge_Remote_Mag",2}};
		headgear[]= {{0,"CUP_H_FR_BoonieMARPAT"},{12,"H_Watchcap_blk"},{18,"CUP_H_RUS_Bandana_HS"}};
		vests[]= {{0,"CUP_V_B_MTV_Mine"},{9,"CUP_V_B_IOTV_AT"},{13,"CUP_V_B_Interceptor_Rifleman"},{19,"V_PlateCarrier1_blk"}};
	};

	class east : east
	{
		items1[]={{0,"MineDetector", {}},{10,"MCC_videoProbe", {}},{15,"Binocular", {}},{20,"Rangefinder", {}}};
		items2[]={{0,"ClaymoreDirectionalMine_Remote_Mag", 2},{3,"APERSMine_Range_Mag", 2},{7,"APERSBoundingMine_Range_Mag", 2},{11,"SLAMDirectionalMine_Wire_Mag", 2},{13,"ATMine_Range_Mag", 2},{21,"SatchelCharge_Remote_Mag", 2},{25,"B_IR_Grenade", 2}};
		generalItems[]= {{0,"MCC_multiTool",1},{0,"ItemMap",1},{0,"ItemCompass",1},{0,"ItemWatch",1},{0,"ItemRadio",1},{0,"FirstAidKit",2},{0,"DemoCharge_Remote_Mag",2}};
		headgear[]= {{0,"CUP_H_FR_BoonieMARPAT"},{12,"H_Watchcap_blk"},{18,"CUP_H_RUS_Bandana_HS"}};
	};

	class guer : guer
	{
		items1[]={{0,"MineDetector", {}},{10,"MCC_videoProbe", {}},{15,"Binocular", {}},{20,"Rangefinder", {}}};
		items2[]={{0,"ClaymoreDirectionalMine_Remote_Mag", 2},{3,"APERSMine_Range_Mag", 2},{7,"APERSBoundingMine_Range_Mag", 2},{11,"SLAMDirectionalMine_Wire_Mag", 2},{13,"ATMine_Range_Mag", 2},{21,"SatchelCharge_Remote_Mag", 2},{25,"B_IR_Grenade", 2}};
		generalItems[]= {{0,"MCC_multiTool",1},{0,"ItemMap",1},{0,"ItemCompass",1},{0,"ItemWatch",1},{0,"ItemRadio",1},{0,"FirstAidKit",2},{0,"DemoCharge_Remote_Mag",2}};
		headgear[]= {{0,"CUP_H_FR_BoonieMARPAT"},{12,"H_Watchcap_blk"},{18,"CUP_H_RUS_Bandana_HS"}};
	};
};