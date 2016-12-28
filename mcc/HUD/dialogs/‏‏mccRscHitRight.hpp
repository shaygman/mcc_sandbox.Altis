class MCC_rssHitRight {
	idd = -1;
	movingEnable = false;
	enableSimulation = true;
	duration = 0.3;
	fadeIn = 0.1;
	fadeOut = 0.1;
	name = "‏‏mccRscHitRight";

	class Controls {
		class hitDetect: MCC_RscPicture
		{
			idc = -1;
			text = __EVAL(MCCPATH +"mcc\HUD\data\hitDetectRight.paa");
			colorText[] = {0.8,0,0,0.4};
			x = 0.8 * safezoneW + safezoneX;
			y = 0.35 * safezoneH + safezoneY;
			w = 0.2 * safezoneW;
			h = 0.4 * safezoneH;
		};
	};
};