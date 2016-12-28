class MCC_rssHitDown {
	idd = -1;
	movingEnable = false;
	enableSimulation = true;
	duration = 0.3;
	fadeIn = 0.1;
	fadeOut = 0.1;
	name = "‏‏mccRscHitDown";

	class Controls {
		class hitDetect: MCC_RscPicture
		{
			idc = -1;
			text = __EVAL(MCCPATH +"mcc\HUD\data\hitDetectDown.paa");
			colorText[] = {0.8,0,0,0.4};
			x = 0.35 * safezoneW + safezoneX;
			y = 0.7 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.2 * safezoneH;
		};
	};
};