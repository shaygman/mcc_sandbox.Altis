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
		class side1Score: MCC_RscText
		{
			idc = 20;

			style = 0x02;
			x = 0.412344 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.033 * safezoneH;
		};

		class side2Score: MCC_RscText
		{
			idc = 21;

			style = 0x02;
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.033 * safezoneH;
		};

		class side3Score: MCC_RscText
		{
			idc = 22;

			style = 0x02;
			x = 0.536094 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.0567187 * safezoneW;
			h = 0.033 * safezoneH;
		};

		class infoText: MCC_RscStructuredText
		{
			idc = 9999;
			colorBackground[] = {0,0,0,0};
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.786 * safezoneH + safezoneY;
			w = 0.170156 * safezoneW;
			h = 0.209 * safezoneH;
		};

		class feedBackText: MCC_RscText
		{
			idc = 9989;
			style = 2;
			//colorText[] = {1,0,0,0.8};
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.698 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.066 * safezoneH;
		};

		class selectBox: MCC_RscFrame
		{
			idc = 9929;
			x = 0;
			y = 0;
			w = 0;
			h = 0;
		};
		class map: MCC_RscMapControl
		{
			idc = 9120;
			x = 0.005 * safezoneW + safezoneX;
			y = 0.676 * safezoneH + safezoneY;
			w = 0.216563 * safezoneW;
			h = 0.319 * safezoneH;

			onMouseButtonDown = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\console\mouseDown.sqf'");
			onMouseButtonUp = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\console\mouseUp.sqf'");
			onMouseButtonDblClick = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\console\mouseDblClick.sqf'");
			onMouseMoving = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\console\mouseMoving.sqf'");
		};
	};
};
