#define MCC_TRAPS_TYPE 2007
#define MCC_TRAPS_OBJECT 2008
#define MCC_TRAPS_EXPLOSIN_SIZE 2009
#define MCC_TRAPS_EXPLOSIN_TYPE 2010
#define MCC_TRAPS_TARGET_FACTION 2011
#define MCC_TRAPS_JAMMABLE 2012
#define MCC_TRAPS_DISARM 2013
#define MCC_TRAPS_TRIGGER 2014
#define MCC_TRAPS_PROXIMITY 2015
#define MCC_TRAPS_AMBUSH 2016

class MCC_IEDDialogControls:MCC_RscControlsGroup
{
	idc = 508;
	x = 0.186 * safezoneW + safezoneX;
	y = 0.18 * safezoneH + safezoneY;
	w = 0.303646 * safezoneW;
	h = 0.4 * safezoneH;

	class Controls
	{
		class MCC_IEDDialogFrame: MCC_RscText
		{
			idc = -1;
			colorBackground[] = {0,0,0,0.9};
			
			w = 0.303646 * safezoneW;
			h = 0.30788 * safezoneH;
		};
		
		class MCC_trapsTittle: MCC_RscText
		{
			idc = -1;

			text = "IED & Ambush:"; //--- ToDo: Localize;
			x = 0.114584 * safezoneW;
			y = 0.0109958 * safezoneH;
			w = 0.09 * safezoneW;
			h = 0.0340016 * safezoneH;
			colorText[] = {0,1,1,1};
		};
		class MCC_trapsTypeTittle: MCC_RscText
		{
			idc = -1;

			text = "Type:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.0989618 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_trapsObjectTittle: MCC_RscText
		{
			idc = -1;

			text = "Object:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.131949 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_trapsExplosionSizeTittle: MCC_RscText
		{
			idc = -1;

			text = "Explosion Size:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.164936 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_trapsExplosionTypeTittle: MCC_RscText
		{
			idc = -1;

			text = "Explosion Type:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.197923 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_trapsDisarmDurationTittle: MCC_RscText
		{
			idc = -1;

			text = "Disarm Duration:"; //--- ToDo: Localize;
			x = 0.160417 * safezoneW;
			y = 0.131949 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_trapsJammableTittle: MCC_RscText
		{
			idc = -1;

			text = "Jammable:"; //--- ToDo: Localize;
			x = 0.160417 * safezoneW;
			y = 0.0989618 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_trapsTargetFactionTittle: MCC_RscText
		{
			idc = -1;

			text = "Target Faction:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.23091 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_trapsTriggerTittle: MCC_RscText
		{
			idc = -1;

			text = "Trigger Type:"; //--- ToDo: Localize;
			x = 0.160417 * safezoneW;
			y = 0.164936 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_trapsProximityTittle: MCC_RscText
		{
			idc = -1;

			text = "Proximity:"; //--- ToDo: Localize;
			x = 0.160417 * safezoneW;
			y = 0.197923 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_trapsAmbushGroupTittle: MCC_RscText
		{
			idc = -1;

			text = "Ambush Group:"; //--- ToDo: Localize;
			x = 0.160417 * safezoneW;
			y = 0.23091 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_trapsType: MCC_RscCombo
		{
			idc = MCC_TRAPS_TYPE;
			onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\traps\trap_change.sqf'");

			x = 0.0802087 * safezoneW;
			y = 0.0989618 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_trapsObject: MCC_RscCombo
		{
			idc = MCC_TRAPS_OBJECT;

			x = 0.0802087 * safezoneW;
			y = 0.131949 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_trapsExplosionSize: MCC_RscCombo
		{
			idc = MCC_TRAPS_EXPLOSIN_SIZE;

			x = 0.0802087 * safezoneW;
			y = 0.164936 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_trapsExplosionType: MCC_RscCombo
		{
			idc = MCC_TRAPS_EXPLOSIN_TYPE;

			x = 0.0802087 * safezoneW;
			y = 0.197923 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_trapsTargetFaction: MCC_RscCombo
		{
			idc = MCC_TRAPS_TARGET_FACTION;

			x = 0.0802087 * safezoneW;
			y = 0.23091 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_trapsJammable: MCC_RscCheckBox
		{
			idc = MCC_TRAPS_JAMMABLE;

			x = 0.234896 * safezoneW;
			y = 0.0989618 * safezoneH;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_trapsDisarm: MCC_RscCombo
		{
			idc = MCC_TRAPS_DISARM;

			x = 0.234896 * safezoneW;
			y = 0.131949 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_trapsTrigger: MCC_RscCombo
		{
			idc = MCC_TRAPS_TRIGGER;

			x = 0.234896 * safezoneW;
			y = 0.164936 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_trapsProximity: MCC_RscCombo
		{
			idc = MCC_TRAPS_PROXIMITY;

			x = 0.234896 * safezoneW;
			y = 0.197923 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_trapsAmbushGroup: MCC_RscCombo
		{
			idc = MCC_TRAPS_AMBUSH;

			x = 0.234896 * safezoneW;
			y = 0.23091 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_trapsCreateIED: MCC_RscButton
		{
			idc = -1;
			onButtonClick =  __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\traps\trap_request.sqf'");

			text = "Create IED"; //--- ToDo: Localize;
			x = 0.154688 * safezoneW;
			y = 0.263897 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Create an IED on the given position"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_trapsCreateAmbush: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\traps\trap_request.sqf'");

			text = "Create Ambush"; //--- ToDo: Localize;
			x = 0.229167 * safezoneW;
			y = 0.263897 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Place an ambush group on the map (Hold Shift and drag a line between a group or IED to sync it with each other) "; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_trapsExplainTittle: MCC_RscText
		{
			idc = -1;

			text = "*Press Ctrl + left mouse button to trigger an IED or ambushing party"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.0301928 * safezoneH;
			w = 0.3 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.58)";
		};
		class MCC_trapsExplainTittle2: MCC_RscText
		{
			idc = -1;

			text = "*Hold Shift + left click and draw a line to link IEDs and/or ambush parties"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.0548928 * safezoneH;
			w = 0.3 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.58)";
		};
		class MCC_trapsCloseButton: MCC_RscButtonMenu
		{
			idc = -1;
			onButtonClick = "((uiNamespace getVariable 'MCC_groupGen_Dialog') displayCtrl 508) ctrlShow false";

			text = "Close"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.263897 * safezoneH;
			w = 0.06799 * safezoneW;
			h = 0.0340016 * safezoneH;
		};
	};
};