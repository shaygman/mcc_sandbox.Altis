#define MCCDELETEBRUSH 1030

class MCC_deleteDialogControls:MCC_RscControlsGroup
{
	idc = 518;
	x = 0.186 * safezoneW + safezoneX;
	y = 0.42 * safezoneH + safezoneY;
	w = 0.217708 * safezoneW;
	h = 0.142944 * safezoneH;

	class Controls
	{
		class MCC_deleteDialogFrame: MCC_RscText
		{
			idc = -1;
			colorBackground[] = {0,0,0,0.9};
			x = 0.270833 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.217708 * safezoneW;
			h = 0.142944 * safezoneH;
		};
		class MCC_deleteBrushTittle: MCC_RscText
		{
			idc = -1;

			text = "Delete Brush:"; //--- ToDo: Localize;
			x = 0.310937 * safezoneW + safezoneX;
			y = 0.236103 * safezoneH + safezoneY;
			w = 0.120313 * safezoneW;
			h = 0.0329871 * safezoneH;
			colorText[] = {0,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class MCC_deleteBrushCombo: MCC_RscCombo
		{
			idc = MCCDELETEBRUSH;

			x = 0.276563 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.144479 * safezoneW;
			h = 0.0340016 * safezoneH;
		};
		class MCC_deleteBrush: MCC_RscButton
		{
			idc = -1;
			onButtonClick = "hint 'Mark the area you want to delete'; MCC_delete_drawing = true";

			text = "Delete"; //--- ToDo: Localize;
			x = 0.43125 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Delete the certain type of objects"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_deleteClose: MCC_RscButtonMenu
		{
			idc = -1;
			text = "Close"; //--- ToDo: Localize;
			onButtonClick = __EVAL("[17] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			
			x = 0.345313 * safezoneW + safezoneX;
			y = 0.324069 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
	};
};