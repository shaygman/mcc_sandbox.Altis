class MCC_rssHitLeft {
	idd = -1;
	movingEnable = false;
	enableSimulation = true;
	duration = 0.3;
	fadeIn = 0.1;
	fadeOut = 0.1;
	name = "‏‏mccRscHitLeft";

	class Controls {
		class hitDetect: MCC_RscPicture
		{
			idc = -1;
			text = __EVAL(MCCPATH +"mcc\HUD\data\hitDetectLeft.paa");
			colorText[] = {0.8,0,0,0.4};
			x = 0.2 * safezoneW + safezoneX;
			y = 0.35 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.4 * safezoneH;
		};
	};
};