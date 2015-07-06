class MCC_WeatherDialogControls:MCC_RscControlsGroup
{
	idc = 501;
	x = 0.59 * safezoneW + safezoneX;
	y = 0.15 * safezoneH + safezoneY;
	w = 0.269271 * safezoneW;
	h = (0.329871+0.043983) * safezoneH;

	class Controls
	{

		class MCC_weatherDialogframe: MCC_RscText
		{
			idc = -1;
			text = ""; //--- ToDo: Localize;
			colorBackground[] = { 0, 0, 0,0.9 };

			w = 0.269271 * safezoneW;
			h = (0.329871+0.043983) * safezoneH;
		};

		class MCC_weatherDialogTittle: MCC_RscText
		{
			idc = -1;
			text = "Weather:"; //--- ToDo: Localize;
			colorText[] = {0,1,1,1};

			x = 0.0973957 * safezoneW;
			y = 0.0109958 * safezoneH;
			w = 0.0900001 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		};

		class MCC_fogTittle: MCC_RscText
		{
			idc = -1;
			text = "Fog:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.0549788 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_fogSlider: MCC_RscSlider
		{
			idc = 10;
			onSliderPosChanged = "(_this select 0) ctrlSetTooltip str (_this select 1)";

			x = 0.0744797 * safezoneW;
			y = 0.0549788 * safezoneH;
			w = 0.148958 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_rainTittle: MCC_RscText
		{
			idc = -1;
			text = "Rain:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.0989618 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_rainSlider: MCC_RscSlider
		{
			idc = 11;
			onSliderPosChanged = "(_this select 0) ctrlSetTooltip str (_this select 1)";

			x = 0.0744797 * safezoneW;
			y = 0.0989618 * safezoneH;
			w = 0.148958 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_windTittle: MCC_RscText
		{
			idc = -1;

			text = "Wind:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.142944 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_windSlider: MCC_RscSlider
		{
			idc = 14;
			onSliderPosChanged = "(_this select 0) ctrlSetTooltip str (_this select 1)";

			x = 0.0744797 * safezoneW;
			y = 0.142944 * safezoneH;
			w = 0.148958 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_wavesTittle: MCC_RscText
		{
			idc = -1;

			text = "Waves:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.186927 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_wavesSlider: MCC_RscSlider
		{
			idc = 13;
			onSliderPosChanged = "(_this select 0) ctrlSetTooltip str (_this select 1)";

			x = 0.0744797 * safezoneW;
			y = 0.186927 * safezoneH;
			w = 0.148958 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_overcastTittle: MCC_RscText
		{
			idc = -1;
			text = "Overcast:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.23091 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_overcastSlider: MCC_RscSlider
		{
			idc = 12;
			onSliderPosChanged = "(_this select 0) ctrlSetTooltip str (_this select 1)";

			x = 0.0744797 * safezoneW;
			y = 0.23091 * safezoneH;
			w = 0.148958 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_timeTittle: MCC_RscText
		{
			idc = -1;
			text = "Time:";
			x = 0.00572965 * safezoneW;
			y = (0.23091+0.043983) * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_timeSlider: MCC_RscSlider
		{
			idc = 11225;
			onSliderPosChanged = "(_this select 0) ctrlSetTooltip (format ['%1 Minutes',floor ((_this select 1)*6)])";

			x = 0.0744797 * safezoneW;
			y = (0.23091+0.043983) * safezoneH;
			w = 0.148958 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_weatherDialogClose: MCC_RscButtonMenu
		{
			idc = -1;
			text = "Close"; //--- ToDo: Localize;
			onButtonClick = "((uiNamespace getVariable 'MCC_groupGen_Dialog') displayCtrl 501) ctrlShow false";

			x = 0.00572965 * safezoneW;
			y = (0.285889+0.043983) * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_weatherDialogConfirm: MCC_RscButton
		{
			idc = -1;
			text = "Confirm"; //--- ToDo: Localize;
			onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\pop_menu\mission_settings.sqf'");

			x = 0.200521 * safezoneW;
			y = (0.285889+0.043983) * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_fogMaxTittle: MCC_RscText
		{
			idc = -1;

			text = "max"; //--- ToDo: Localize;
			x = 0.229167 * safezoneW;
			y = 0.0549788 * safezoneH;
			w = 0.034375 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_rainMaxTittle: MCC_RscText
		{
			idc = -1;

			text = "max"; //--- ToDo: Localize;
			x = 0.229167 * safezoneW;
			y = 0.0989618 * safezoneH;
			w = 0.034375 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_windMaxTittle: MCC_RscText
		{
			idc = -1;

			text = "max"; //--- ToDo: Localize;
			x = 0.229167 * safezoneW;
			y = 0.142944 * safezoneH;
			w = 0.034375 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_wavesMaxTittle: MCC_RscText
		{
			idc = -1;

			text = "max"; //--- ToDo: Localize;
			x = 0.229167 * safezoneW;
			y = 0.186927 * safezoneH;
			w = 0.034375 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_overcastMaxTittle: MCC_RscText
		{
			idc = -1;

			text = "max"; //--- ToDo: Localize;
			x = 0.229167 * safezoneW;
			y = 0.23091 * safezoneH;
			w = 0.034375 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_timeMaxTittle: MCC_RscText
		{
			idc = -1;

			text = "max"; //--- ToDo: Localize;
			x = 0.229167 * safezoneW;
			y = (0.23091+0.043983) * safezoneH;
			w = 0.034375 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
	};
};
