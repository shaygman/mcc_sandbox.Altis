#define MCC_MARKER_TEXT 3050
#define MCC_MARKER_COLOR 3051
#define MCC_MARKER_TYPE 3052
#define MCC_MARKER_SHAPE 3053
#define MCC_MARKER_BRUSH 3054
#define MCC_MARKER_AVAILABE 3049

class MCC_markersDialogControls:MCC_RscControlsGroup
{
	idc = 511;
	x = 0.635 * safezoneW + safezoneX;
	y = 0.26 * safezoneH + safezoneY;
	w = 0.223438 * safezoneW;
	h = 0.241906 * safezoneH;

	class Controls
	{	
		class MCC_markersDialogFrame: MCC_RscText
		{
			idc = -1;
			colorBackground[] = {0,0,0,0.9};
			x = 0;
			y = 0;
			w = 0.223438 * safezoneW;
			h = 0.241906 * safezoneH;
		};

		class MCC_markerGeneratorTittle: MCC_RscText
		{
			idc = -1;

			text = "Marker Generator:"; //--- ToDo: Localize;
			x = 0.0286457 * safezoneW;
			y = 0.0109958 * safezoneH;
			w = 0.144375 * safezoneW;
			h = 0.0280063 * safezoneH;
			colorText[] = {0,1,1,1};
		};
		
		class MCC_markerColorTittle: MCC_RscText
		{
			idc = -1;

			text = "Color:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.0549788 * safezoneH;
			w = 0.039375 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_markerTypeTittle: MCC_RscText
		{
			idc = -1;

			text = "Type:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.0879658 * safezoneH;
			w = 0.039375 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_markerShapeTittle: MCC_RscText
		{
			idc = -1;

			text = "Shape:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.120953 * safezoneH;
			w = 0.039375 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_markerBrushTittle: MCC_RscText
		{
			idc = -1;

			text = "Brush:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.15394 * safezoneH;
			w = 0.039375 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_markerTextTittle: MCC_RscText
		{
			idc = -1;

			text = "Name:"; //--- ToDo: Localize;
			x = 0.126042 * safezoneW;
			y = 0.0769698 * safezoneH;
			w = 0.0401042 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_markerText: MCC_RscText
		{
			idc = MCC_MARKER_TEXT;
			type = 2;

			x = 0.126042 * safezoneW;
			y = 0.0989618 * safezoneH;
			w = 0.0916667 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_markerColor: MCC_RscCombo
		{
			idc = MCC_MARKER_COLOR;

			x = 0.0515627 * safezoneW;
			y = 0.0549788 * safezoneH;
			w = 0.065625 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_markerType: MCC_RscCombo
		{
			idc = MCC_MARKER_TYPE;

			x = 0.0515627 * safezoneW;
			y = 0.0879658 * safezoneH;
			w = 0.065625 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_markerShape: MCC_RscCombo
		{
			idc = MCC_MARKER_SHAPE;

			x = 0.0515627 * safezoneW;
			y = 0.120953 * safezoneH;
			w = 0.065625 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_markerBrush: MCC_RscCombo
		{
			idc = MCC_MARKER_BRUSH;

			x = 0.0515627 * safezoneW;
			y = 0.15394 * safezoneH;
			w = 0.065625 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_markerSpawnMarker: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL ("[0] execVM '"+MCCPATH+"mcc\pop_menu\markers_req.sqf'");

			text = "Marker"; //--- ToDo: Localize;
			x = 0.177605 * safezoneW;
			y = 0.142944 * safezoneH;
			w = 0.0401042 * safezoneW;
			h = 0.0439828 * safezoneH;
			tooltip = "Create a marker"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_markerSpawnBrush: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL ("[1] execVM '"+MCCPATH+"mcc\pop_menu\markers_req.sqf'");

			text = "Brush"; //--- ToDo: Localize;
			x = 0.126042 * safezoneW;
			y = 0.142944 * safezoneH;
			w = 0.0401042 * safezoneW;
			h = 0.0439828 * safezoneH;
			tooltip = "Create a brush"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_markerDeleteMarker: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL ("[2] execVM '"+MCCPATH+"mcc\pop_menu\markers_req.sqf'");

			text = "Delete"; //--- ToDo: Localize;
			x = 0.183334 * safezoneW;
			y = 0.0439828 * safezoneH;
			w = 0.034375 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Delete marker or brush with the give name"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
		};
		
		class MCC_markerAvailableCombo: MCC_RscCombo
		{
			idc = MCC_MARKER_AVAILABE;

			x = 0.126042 * safezoneW;
			y = 0.0439828 * safezoneH;
			w = 0.0515625 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
		};
		
		class MCC_markerClose: MCC_RscButtonMenu
		{
			idc = -1;
			onButtonClick = "((uiNamespace getVariable 'MCC_groupGen_Dialog') displayCtrl 511) ctrlShow false";

			text = "Close"; //--- ToDo: Localize;
			x = 0.0687497 * safezoneW;
			y = 0.197923 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
	};
};

