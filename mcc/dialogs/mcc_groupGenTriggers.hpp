#define MCC_TRIGGERS_ACTIVATE 3064
#define MCC_TRIGGERS_CONDITION 3065
#define MCC_TRIGGERS_SHAPE 3066
#define MCC_TRIGGERS_LIST 3067
#define MCC_TRIGGERS_NAME 3068 
#define MCC_TRIGGERS_TIME_MIN 3071
#define MCC_TRIGGERS_TIME_MAX 3072
#define MCC_TRIGGERS_STAT_COND 3073
#define MCC_TRIGGERS_STAT_DEACTIVE 3075

class MCC_triggersDialogControls: MCC_RscControlsGroup
{
	idc = 515;
	x = 0.535 * safezoneW + safezoneX;
	y = 0.275 * safezoneH + safezoneY;
	w = 0.320833 * safezoneW;
	h = 0.285889 * safezoneH;

	class Controls
	{			
		class MCC_jukeboxDialogFrame: MCC_RscText
		{
			idc = -1;
			colorBackground[] = {0,0,0,0.9};

			w = 0.320833 * safezoneW;
			h = 0.285889 * safezoneH;
		};
		
		class MCC_triggerGenTittle: MCC_RscText
		{
			idc = -1;
			text = "Triggers Generator:"; //--- ToDo: Localize;
			x = 0.0916667 * safezoneW;
			y = 0.0109958 * safezoneH;
			w = 0.144375 * safezoneW;
			h = 0.0280063 * safezoneH;
			colorText[] = {0,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_triggerGenActivateTittle: MCC_RscText
		{
			idc = -1;
			text = "Activate:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.0439828 * safezoneH;
			w = 0.0458333 * safezoneW;
			h = 0.0219914 * safezoneH;
			colorText[] = {1,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_triggerGenConditionTittle: MCC_RscText
		{
			idc = -1;
			text = "Condition:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.0769698 * safezoneH;
			w = 0.0458333 * safezoneW;
			h = 0.0219914 * safezoneH;
			colorText[] = {1,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
		};
		class MCC_triggerGenShapeTittle: MCC_RscText
		{
			idc = -1;
			text = "Shape:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.164936 * safezoneH;
			w = 0.0458333 * safezoneW;
			h = 0.0219914 * safezoneH;
			colorText[] = {1,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_triggerGenNameTittle: MCC_RscText
		{
			idc = -1;
			text = "Name:"; //--- ToDo: Localize;
			x = 0.171875 * safezoneW;
			y = 0.164936 * safezoneH;
			w = 0.0458333 * safezoneW;
			h = 0.0219914 * safezoneH;
			colorText[] = {1,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_triggerGenTriggerTittle: MCC_RscText
		{
			idc = -1;
			text = "Available Triggers:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.208919 * safezoneH;
			w = 0.0802083 * safezoneW;
			h = 0.0219914 * safezoneH;
			colorText[] = {1,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_triggerGenActivate: MCC_RscCombo
		{
			idc = MCC_TRIGGERS_ACTIVATE;
			x = 0.0572916 * safezoneW;
			y = 0.0439828 * safezoneH;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_triggerGenCondition: MCC_RscCombo
		{
			idc = MCC_TRIGGERS_CONDITION;
			x = 0.0572916 * safezoneW;
			y = 0.0769698 * safezoneH;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_triggerGenShape: MCC_RscCombo
		{
			idc = MCC_TRIGGERS_SHAPE;
			x = 0.0572916 * safezoneW;
			y = 0.164936 * safezoneH;
			w = 0.103125 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_triggerGenTrigger: MCC_RscCombo
		{
			idc = MCC_TRIGGERS_LIST;
			x = 0.0916667 * safezoneW;
			y = 0.208919 * safezoneH;
			w = 0.0802083 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_triggerGenName: MCC_RscText
		{
			idc = MCC_TRIGGERS_NAME;
			type = MCCCT_EDIT;
			x = 0.223438 * safezoneW;
			y = 0.164936 * safezoneH;
			w = 0.0916667 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_triggerGenNameFrame: MCC_RscFrame
		{
			idc = -1;
			x = 0.223438 * safezoneW;
			y = 0.164936 * safezoneH;
			w = 0.0916667 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_triggerGenCreate: MCC_RscButton
		{
			idc = -1;
			text = "Create"; //--- ToDo: Localize;
			x = 0.246355 * safezoneW;
			y = 0.197923 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
			onButtonClick = __EVAL ("[0] execVM '"+MCCPATH+"mcc\general_scripts\triggers\triggers.sqf'");
			tooltip = "Create trigger"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_triggerGenMove: MCC_RscButton
		{
			idc = -1;
			text = "Move"; //--- ToDo: Localize;
			x = 0.177605 * safezoneW;
			y = 0.208919 * safezoneH;
			w = 0.0515625 * safezoneW;
			h = 0.0219914 * safezoneH;
			onButtonClick = __EVAL ("[2] execVM '"+MCCPATH+"mcc\general_scripts\triggers\triggers.sqf'");
			tooltip = "Move the selected trigger"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_triggerGenTimeMinTittle: MCC_RscText
		{
			idc = -1;
			
			text = "Time Min:"; //--- ToDo: Localize;
			x = 0.183334 * safezoneW;
			y = 0.0439828 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_triggerGenTimeMaxTittle: MCC_RscText
		{
			idc = -1;

			text = "Time Max:"; //--- ToDo: Localize;
			x = 0.252084 * safezoneW;
			y = 0.0439828 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_triggerGenTimeMin: MCC_RscText
		{
			idc = MCC_TRIGGERS_TIME_MIN;
			type = MCCCT_EDIT;
			text = "0";
			x = 0.183334 * safezoneW;
			y = 0.0769698 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_triggerGenTimeMinFrame: MCC_RscFrame
		{
			idc = -1;
			x = 0.183334 * safezoneW;
			y = 0.0769698 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_triggerGenTimeMax: MCC_RscText
		{
			idc = MCC_TRIGGERS_TIME_MAX;
			type = MCCCT_EDIT;
			text = "0";
			x = 0.252084 * safezoneW;
			y = 0.0769698 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_triggerGenTimeMaxFrame: MCC_RscFrame
		{
			idc = -1;
			x = 0.252084 * safezoneW;
			y = 0.0769698 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_triggerStatCondTittle: MCC_RscText
		{
			idc = -1;

			text = "Condition:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.109957 * safezoneH;
			w = 0.0458333 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_triggerStatCond: MCC_RscText
		{
			idc = MCC_TRIGGERS_STAT_COND;
			text = "this";
			type = MCCCT_EDIT;
			x = 0.0572916 * safezoneW;
			y = 0.109957 * safezoneH;
			w = 0.103125 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_triggerStatCondFrame: MCC_RscFrame
		{
			idc = -1;

			x = 0.0572916 * safezoneW;
			y = 0.109957 * safezoneH;
			w = 0.103125 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_triggerStatDeactive: MCC_RscText
		{
			idc = MCC_TRIGGERS_STAT_DEACTIVE;
			type = MCCCT_EDIT;
			x = 0.217709 * safezoneW;
			y = 0.109957 * safezoneH;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_triggerStatDeactiveFrame: MCC_RscFrame
		{
			idc = -1;

			x = 0.217709 * safezoneW;
			y = 0.109957 * safezoneH;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_triggerStatDeactiveTittle: MCC_RscText
		{
			idc = -1;

			text = "On Dea:"; //--- ToDo: Localize;
			x = 0.166146 * safezoneW;
			y = 0.109957 * safezoneH;
			w = 0.0458333 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		
		class MCC_triggersClose: MCC_RscButtonMenu
		{
			idc = -1;
			onButtonClick = "((uiNamespace getVariable 'MCC_groupGen_Dialog') displayCtrl 515) ctrlShow false";

			text = "Close"; //--- ToDo: Localize;
			x = 0.126042 * safezoneW;
			y = 0.241906 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Link the sound or music to the selected zone"; //--- ToDo: Localize;
		};
	};
};
