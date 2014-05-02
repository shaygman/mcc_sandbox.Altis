class MCC_WeatherDialogControls:MCC_RscControlsGroup
{
	idc = 501;
	x = 0.59 * safezoneW + safezoneX;
	y = 0.15 * safezoneH + safezoneY;
	w = 0.269271 * safezoneW;
	h = 0.329871 * safezoneH;

	class Controls
	{

		class MCC_weatherDialogframe: MCC_RscText
		{
			idc = -1;
			text = ""; //--- ToDo: Localize;
			colorBackground[] = { 0, 0, 0,0.9 };
			
			w = 0.269271 * safezoneW;
			h = 0.329871 * safezoneH;
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
		
		//----- titles -------------------------------
		class MCC_WeatherTittle: MCC_RscText 
		{
			idc = -1;	text = "Weather:";
			x = 0.00572965 * safezoneW;
			y = 0.0549788 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_FogTittle: MCC_RscText 
		{
			idc = -1;	text = "Fog:";
			x = 0.00572965 * safezoneW;
			y = 0.0989618 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_WindTittle: MCC_RscText 
		{
			idc = -1;	text = "Wind:";
			x = 0.00572965 * safezoneW;
			y = 0.142945 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_WavesTittle: MCC_RscText 
		{
			idc = -1;	text = "Waves:";
			x = 0.00572965 * safezoneW;
			y = 0.186928 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_ChangeWeatherTittle: MCC_RscText 
		{
			idc = -1;	text = "Change delay:"; 
			x = 0.00572965 * safezoneW;
			y = 0.230911 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		//----- Combos -------------------------------
		class MCC_WeatherCombo: MCC_RscCombo 
		{
			idc = 10;
			x = 0.0744797 * safezoneW; // + safezoneX;
			y = 0.0549788 * safezoneH; // + safezoneY;
			w = 0.10000 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_FogCombo: MCC_RscCombo 
		{
			idc = 11;
			x = 0.0744797 * safezoneW; // + safezoneX;
			y = 0.0989618 * safezoneH; // + safezoneY;
			w = 0.10000 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_WindCombo: MCC_RscCombo 
		{
			idc = 12;
			x = 0.0744797 * safezoneW; // + safezoneX;
			y = 0.142945 * safezoneH; // + safezoneY;
			w = 0.10000 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_WavesCombo: MCC_RscCombo 
		{
			idc = 13;
			x = 0.0744797 * safezoneW; // + safezoneX;
			y = 0.186928 * safezoneH; // + safezoneY;
			w = 0.10000 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_ChangeWeatherCombo: MCC_RscCombo 
		{
			idc = 14;
			x = 0.0744797 * safezoneW; // + safezoneX;
			y = 0.230911 * safezoneH; // + safezoneY;
			w = 0.10000 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
		//----- Buttons ---------------------------------------------
		class MCC_weatherDialogConfirm: MCC_RscButton
		{
			idc = 8;
			onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\pop_menu\mission_settings.sqf'");
			text = "Confirm"; //--- ToDo: Localize;
			
			x = 0.120313 * safezoneW;
			y = 0.27500 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_weatherDialogClose: MCC_RscButtonMenu
		{
			idc = 9;
			onButtonClick = "((uiNamespace getVariable 'MCC_groupGen_Dialog') displayCtrl 501) ctrlShow false;((uiNamespace getVariable 'MCC_groupGen_Dialog') displayCtrl 9000) ctrlShow true;((uiNamespace getVariable 'MCC_groupGen_Dialog') displayCtrl 9001) ctrlShow true;((uiNamespace getVariable 'MCC_groupGen_Dialog') displayCtrl 9002) ctrlShow true;";
			text = "Close"; //--- ToDo: Localize;
			
			x = 0.00572965 * safezoneW;
			y = 0.27500 * safezoneH;
			w = 0.0572917 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
	};
};
