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

			w = 0.189063 * safezoneW;
			h = 0.197923 * safezoneH;
			colorBackground[] = {0,0,0,0.9};
		};
		class MCC_timeDialogTittle: MCC_RscStructuredText
		{
			idc = 20;
			colorText[] = {0,1,1,1};

			x = 0.00572965 * safezoneW;
			y = 0.0109958 * safezoneH;
			w = 0.15 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class MCC_timeS1Tittle: MCC_RscText
		{
			idc = -1;

			text = "/"; //--- ToDo: Localize;
			x = 0.0572916 * safezoneW;
			y = 0.0549788 * safezoneH;
			w = 0.0114583 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_timeDialogConfirm: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[3] execVM '"+MCCPATH+"mcc\pop_menu\mission_settings.sqf'");
			text = "Confirm"; //--- ToDo: Localize;

			x = 0.120313 * safezoneW;
			y = 0.15394 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_timeDialogClose: MCC_RscButtonMenu
		{
			idc = -1;
			onButtonClick = "((uiNamespace getVariable 'MCC_groupGen_Dialog') displayCtrl 502) ctrlShow false";
			text = "Close"; //--- ToDo: Localize;

			x = 0.00572965 * safezoneW;
			y = 0.15394 * safezoneH;
			w = 0.0572917 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_timeMonthCombo: MCC_RscCombo
		{
			idc = 15;
			onLBSelChanged=__EVAL ("[5] execVM '"+MCCPATH+"mcc\pop_menu\mission_settings.sqf'");
			x = 0.00572965 * safezoneW;
			y = 0.0549788 * safezoneH;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_timeDayCombo: MCC_RscCombo
		{
			idc = 16;
			onLBSelChanged=__EVAL ("[5] execVM '"+MCCPATH+"mcc\pop_menu\mission_settings.sqf'");
			x = 0.0687497 * safezoneW;
			y = 0.0549788 * safezoneH;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_timeYearCombo: MCC_RscCombo
		{
			idc = 17;
			onLBSelChanged=__EVAL ("[5] execVM '"+MCCPATH+"mcc\pop_menu\mission_settings.sqf'");
			x = 0.131771 * safezoneW;
			y = 0.0549788 * safezoneH;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_timeHourCombo: MCC_RscCombo
		{
			idc = 18;
			x = 0.0343746 * safezoneW;
			y = 0.0989618 * safezoneH;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_timeMinuteCombo: MCC_RscCombo
		{
			idc = 19;
			x = 0.0973957 * safezoneW;
			y = 0.0989618 * safezoneH;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_timeS2Tittle: MCC_RscText
		{
			idc = -1;

			text = "/"; //--- ToDo: Localize;
			x = 0.120313 * safezoneW;
			y = 0.0549788 * safezoneH;
			w = 0.0114583 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_timeS3Tittle: MCC_RscText
		{
			idc = -1;

			text = ":"; //--- ToDo: Localize;
			x = 0.0859376 * safezoneW;
			y = 0.0989618 * safezoneH;
			w = 0.0114583 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
	};
};
