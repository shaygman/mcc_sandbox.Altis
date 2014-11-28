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

	class controls
	{
		class MCC_mapBackground : MCC_RscPicture 
		{
			idc = -1;
			x = 0.462187 * safezoneW + safezoneX;
			y = 0.213012 * safezoneH + safezoneY;
			w = 0.326562 * safezoneW;
			h = 0.494807 * safezoneH;
			text = "#(argb,512,512,1)r2t(rendertarget12,1.0);";
		};
	};
};
	