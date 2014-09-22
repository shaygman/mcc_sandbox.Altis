////////////////////////////////////////////////////////
// BY Shay Gman 12.2013
////////////////////////////////////////////////////////
#define MCCMW_briefingMap_IDD 951
#define MCC_MINIMAP 51
#define MCC_MWBriefingsTooltip_IDC 9511
#define MCC_MWBriefingText_IDC 9512

class MCCMW_briefingMap {
	  idd = MCCMW_briefingMap_IDD;
	  movingEnable = false;
	  onLoad ="";
	  
	  controlsBackground[] = 
	  {
	  MCC_background,
	  MCC_map,
	  MCC_backgroundFrame
	  };
	  

	  //---------------------------------------------
	  objects[] = 
	  { 
	  };
	  
	  controls[] = 
	  {
		MCC_mapCover,
		MCC_MWBriefingsTooltip,
		MCC_MWBriefingText,
		MCC_MWCloseDialog
	  };
	   
	class MCC_map: MCC_RscMapControl 
	{	
		idc = MCC_MINIMAP; 
		text = "";	
		x = 0.219271 * safezoneW + safezoneX;
		y = 0.412034 * safezoneH + safezoneY;
		w = 0.532813 * safezoneW;
		h = 0.505803 * safezoneH;
		maxSatelliteAlpha = "uinamespace getvariable ['RscDisplayStrategicMap_maxSatelliteAlpha',1]";
		scaleDefault = "uinamespace getvariable ['MCC_MWMap_scale',0.3]";
		scaleMax = "(uinamespace getvariable ['MCC_MWMap_scale',0.3])*2.5";
		scaleMin = "(uinamespace getvariable ['MCC_MWMap_scale',0.3])/2";
		colorOutside[] = {"uinamespace getvariable ['MCC_MWMap_colorOutside_R',0]","uinamespace getvariable ['MCC_MWMap_colorOutside_G',0]","uinamespace getvariable ['MCC_MWMap_colorOutside_B',0]",1};
	};
	class MCC_mapCover: MCC_RscPicture
	{
		idc = -1;
		text = "a3\ui_f\data\igui\rsctitles\interlacing\interlacing_ca.paa";
		x = 0.219271 * safezoneW + safezoneX;
		y = 0.412034 * safezoneH + safezoneY;
		w = 0.532813 * safezoneW;
		h = 0.505803 * safezoneH;
		colorBackground[] = {1,1,1,1};
	};
	class MCC_background: MCC_RscText
	{
		idc = -1;
		text = "";
		x = 0.190625 * safezoneW + safezoneX;
		y = 0.137141 * safezoneH + safezoneY;
		w = 0.601563 * safezoneW;
		h = 0.802687 * safezoneH;
		colorBackground[] = {0,0,0,1};
	};
	
	class MCC_backgroundFrame: MCC_RscFrame
	{
		idc = -1;
		text = "";
		x = 0.190625 * safezoneW + safezoneX;
		y = 0.137141 * safezoneH + safezoneY;
		w = 0.601563 * safezoneW;
		h = 0.802687 * safezoneH;
		colorBackground[] = {1,1,1,1};
	};
	
	class MCC_MWBriefingsTooltip: MCC_RscStructuredText
	{
		idc = MCC_MWBriefingsTooltip_IDC;
		x = 0.1 * safezoneW + safezoneX;
		y = 0.1 * safezoneH + safezoneY;
		w = 0.1 * safezoneW;
		h = 0.1 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.5)";
		colorBackground[] = {0,0,0,0.9};
	};
	
	class MCC_MWBriefingText: MCC_RscStructuredText
	{
		idc = MCC_MWBriefingText_IDC;
		x = 0.219271 * safezoneW + safezoneX;
		y = 0.170129 * safezoneH + safezoneY;
		w = 0.532813 * safezoneW;
		h = 0.23091 * safezoneH;
	};
	
	class MCC_MWCloseDialog: MCC_RscButtonMenu
	{
		idc = -1;
		text = "Close";
		onButtonClick = "closeDialog 0";
		
		x = 0.683333 * safezoneW + safezoneX;
		y = 0.379047 * safezoneH + safezoneY;
		w = 0.0630208 * safezoneW;
		h = 0.0219914 * safezoneH;
	};
};
