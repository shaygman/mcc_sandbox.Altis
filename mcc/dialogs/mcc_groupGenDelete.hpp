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

			w = 0.217708 * safezoneW;
			h = 0.142944 * safezoneH;
		};
		class MCC_deleteBrushTittle: MCC_RscText
		{
			idc = -1;

			text = "Apply Brush:"; //--- ToDo: Localize;
			x = 0.0401036 * safezoneW;
			y = 0.0109958 * safezoneH;
			w = 0.120313 * safezoneW;
			h = 0.0329871 * safezoneH;
			colorText[] = {0,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class MCC_deleteBrushCombo: MCC_RscCombo
		{
			idc = MCCDELETEBRUSH;

			x = 0.00572965 * safezoneW;
			y = 0.0549788 * safezoneH;
			w = 0.144479 * safezoneW;
			h = 0.0340016 * safezoneH;
		};
		class MCC_deleteBrush: MCC_RscButton
		{
			idc = -1;
			onButtonClick = "hint 'Mark the area you want to delete'; MCC_delete_drawing = true";

			text = "Brush"; //--- ToDo: Localize;
			x = 0.160417 * safezoneW;
			y = 0.0549788 * safezoneH;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Apply brush to an area"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_deleteClose: MCC_RscButtonMenu
		{
			idc = -1;
			text = "Close"; //--- ToDo: Localize;
			onButtonClick = "((uiNamespace getVariable 'MCC_groupGen_Dialog') displayCtrl 518) ctrlShow false";

			x = 0.0744797 * safezoneW;
			y = 0.0989618 * safezoneH;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
	};
};