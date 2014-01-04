////////////////////////////////////////////////////////
// BY Shay Gman 03.2013
////////////////////////////////////////////////////////


class MCC_SandboxLoading {
	  idd = MCC_SANDBOXLOADING_IDD;
	  movingEnable = true;
	  onLoad = __EVAL("_this execVM '"+MCCPATH+"mcc\dialogs\mcc_guiTabLoading_init.sqf'");
	  
	  controlsBackground[] = 
	  {
	  MCC_pic,
	  MCC_background
	  };
	  

	  //---------------------------------------------
	  objects[] = 
	  { 
	  };
	  
	  controls[] = 
	  {
	  };

	class MCC_background: MCC_RscPicture {idc = 0; text = "";
		x = 0.168549 * safezoneW + safezoneX;
		y = 0.0919812 * safezoneH + safezoneY;
		w = 0.662902 * safezoneW;
		h = 0.816037 * safezoneH;
		colorBackground[] = {0,0,0,0.8};
	};
	class MCC_pic: MCC_RscPicture {idc = -1; text = __EVAL(MCCPATH +"mcc\dialogs\mcc_background.paa");x = 0.1 * safezoneW + safezoneX;
		y = 0.005 * safezoneH + safezoneY;
		w = 0.8 * safezoneW;
		h = 1.01 * safezoneH;
	};

};