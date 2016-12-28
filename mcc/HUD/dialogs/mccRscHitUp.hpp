class MCC_rssHitUp {
	idd = -1;
	movingEnable = false;
	enableSimulation = true;
	duration = 0.3;
	fadeIn = 0.1;
	fadeOut = 0.1;
	name = "mccRscHitUp";

	class Controls {
		class hitDetect: MCC_RscPicture
		{
			idc = -1;
			text = __EVAL(MCCPATH +"mcc\HUD\data\hitDetectUp.paa");
			colorText[] = {0.8,0,0,0.4};
			x = 0.35 * safezoneW + safezoneX;
			y = 0.1 * safezoneH + safezoneY;
			w = 0.3 * safezoneW;
			h = 0.2 * safezoneH;
		};
	};
};