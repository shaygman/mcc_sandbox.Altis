class MCC_TimeDialogControls:MCC_RscControlsGroup
{
	idc = 502;
	x = 0.67 * safezoneW + safezoneX;
	y = 0.2 * safezoneH + safezoneY;
	w = 0.189063 * safezoneW;
	h = 0.197923 * safezoneH;

	class Controls
	{
		class MCC_timeDialogframe: MCC_RscText
		{
			idc = -1;

			x = 0.270833 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.189063 * safezoneW;
			h = 0.197923 * safezoneH;
			colorBackground[] = {0,0,0,0.9};
		};
		class MCC_timeDialogTittle: MCC_RscText
		{
			idc = -1;
			text = "Time:"; //--- ToDo: Localize;
			colorText[] = {0,1,1,1};
			
			x = 0.333854 * safezoneW + safezoneX;
			y = 0.236103 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		};
		class MCC_timeS1Tittle: MCC_RscText
		{
			idc = -1;

			text = "/"; //--- ToDo: Localize;
			x = 0.328125 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.0114583 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_timeDialogConfirm: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[3] execVM '"+MCCPATH+"mcc\pop_menu\mission_settings.sqf'");
			text = "Confirm"; //--- ToDo: Localize;
			
			x = 0.391146 * safezoneW + safezoneX;
			y = 0.379047 * safezoneH + safezoneY;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_timeDialogClose: MCC_RscButtonMenu
		{
			idc = -1;
			onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			text = "Close"; //--- ToDo: Localize;
			
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.379047 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_timeMonthCombo: MCC_RscCombo
		{
			idc = 15;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_timeDayCombo: MCC_RscCombo
		{
			idc = 16;
			x = 0.339583 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_timeYearCombo: MCC_RscCombo
		{
			idc = 17;
			x = 0.402604 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_timeHourCombo: MCC_RscCombo
		{
			idc = 18;
			x = 0.305208 * safezoneW + safezoneX;
			y = 0.324069 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_timeMinuteCombo: MCC_RscCombo
		{
			idc = 19;
			x = 0.368229 * safezoneW + safezoneX;
			y = 0.324069 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_timeS2Tittle: MCC_RscText
		{
			idc = -1;

			text = "/"; //--- ToDo: Localize;
			x = 0.391146 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.0114583 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_timeS3Tittle: MCC_RscText
		{
			idc = -1;

			text = ":"; //--- ToDo: Localize;
			x = 0.356771 * safezoneW + safezoneX;
			y = 0.324069 * safezoneH + safezoneY;
			w = 0.0114583 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
	};
};
