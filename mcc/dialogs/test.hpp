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
	{ 
	};

	class controls 
	{
		class MCC_weatherDialogframe: MCC_RscText
		{
			idc = -1;
			text = ""; //--- ToDo: Localize;
			colorBackground[] = { 0, 0, 0,0.9 };
			
			x = 0.270833 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.269271 * safezoneW;
			h = 0.23091 * safezoneH;
		};

		class MCC_weatherDialogTittle: MCC_RscText
		{
			idc = -1;
			text = "Weather:"; //--- ToDo: Localize;
			colorText[] = {0,1,1,1};
			
			x = 0.368229 * safezoneW + safezoneX;
			y = 0.236103 * safezoneH + safezoneY;
			w = 0.0900001 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		};

		class MCC_fogTittle: MCC_RscText
		{
			idc = -1;
			text = "Fog:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_rainTittle: MCC_RscText
		{
			idc = -1;
			text = "Rain:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.324069 * safezoneH + safezoneY;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_overcastTittle: MCC_RscText
		{
			idc = -1;
			text = "Overcast:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.368051 * safezoneH + safezoneY;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_fogSlider: MCC_RscSlider
		{
			idc = 10;
			onSliderPosChanged = "(_this select 0) ctrlSetTooltip str (_this select 1)";
			
			x = 0.345313 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.148958 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_rainSlider: MCC_RscSlider
		{
			idc = 11;
			onSliderPosChanged = "(_this select 0) ctrlSetTooltip str (_this select 1)";
			
			x = 0.345313 * safezoneW + safezoneX;
			y = 0.324069 * safezoneH + safezoneY;
			w = 0.148958 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_overcastSlider: MCC_RscSlider
		{
			idc = 12;
			onSliderPosChanged = "(_this select 0) ctrlSetTooltip str (_this select 1)";
			
			x = 0.345313 * safezoneW + safezoneX;
			y = 0.368051 * safezoneH + safezoneY;
			w = 0.148958 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_weatherDialogClose: MCC_RscButtonMenu
		{
			idc = -1;
			text = "Close"; //--- ToDo: Localize;
			onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.412034 * safezoneH + safezoneY;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_weatherDialogConfirm: MCC_RscButton
		{
			idc = -1;
			text = "Confirm"; //--- ToDo: Localize;
			onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\pop_menu\mission_settings.sqf'");
			
			x = 0.471354 * safezoneW + safezoneX;
			y = 0.412034 * safezoneH + safezoneY;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_fogMaxTittle: MCC_RscText
		{
			idc = -1;

			text = "max"; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.034375 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_rainMaxTittle: MCC_RscText
		{
			idc = -1;

			text = "max"; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.324069 * safezoneH + safezoneY;
			w = 0.034375 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_overcastMaxTittle: MCC_RscText
		{
			idc = -1;

			text = "max"; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.368051 * safezoneH + safezoneY;
			w = 0.034375 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
	};
};