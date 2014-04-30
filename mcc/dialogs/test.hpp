class mcc_test
{
	idd = 9999999;
	movingEnable = true;
	onLoad ="";

	controlsBackground[] = 
	{
	};


	//---------------------------------------------
	objects[] = 
	{ 	//(0.671875 * safezoneW + safezoneX) / safezoneW -X
	};	//(0.478009 * safezoneH + safezoneY) / safezoneH - Y

	class Controls
	{
		class MCC_GroupGenInfoText: MCC_RscStructuredText
		{
			idc = MCC_GroupGenInfoText_IDC;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.5)";
			colorBackground[] = {0,0,0,0.9};
			
			w = 0.327273 * safezoneW;
			h = 0.372873 * safezoneH;
		};
	};
};