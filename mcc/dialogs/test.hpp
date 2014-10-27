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
		class MCC_keyBindsLogin: MCC_keyBindsGroup
		{
			x = 0.5 * safezoneW + safezoneX;
			y = 0.25 * safezoneH + safezoneY;
		};
	};
};
	