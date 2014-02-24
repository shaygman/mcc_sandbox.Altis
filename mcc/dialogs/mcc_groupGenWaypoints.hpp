#define MCC_GroupGenWPCombo_IDC 9015
#define MCC_GroupGenWPformationCombo_IDC 9016
#define MCC_GroupGenWPspeedCombo_IDC 9017
#define MCC_GroupGenWPbehaviorCombo_IDC 9018

class MCC_waypointsDialogControls:MCC_RscControlsGroup
{
	idc = 510;
	x = 0.1 * safezoneW + safezoneX;
	y = 0.1 * safezoneH + safezoneY;
	w = 0.189063 * safezoneW;
	h = 0.219914 * safezoneH;

	class Controls
	{	

		class MCC_GroupGenInfoText: MCC_RscText
		{
			idc = -1;
			colorBackground[] = {0,0,0,0.9};

			x = 0.270833 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.189063 * safezoneW;
			h = 0.219914 * safezoneH;
		};
		
		class MCC_GroupGenWPTittle: MCC_RscText
		{
			idc = -1;
			text = "Way Points:"; //--- ToDo: Localize;
			colorText[] = {0,1,1,1};
			
			x = 0.333854 * safezoneW + safezoneX;
			y = 0.236103 * safezoneH + safezoneY;
			w = 0.0916667 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		
		class MCC_GroupGenWPCombo: MCC_RscCombo
		{
			idc = MCC_GroupGenWPCombo_IDC;

			x = 0.345313 * safezoneW + safezoneX;
			y = 0.26909 * safezoneH + safezoneY;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		
		class MCC_GroupGenWPformationCombo: MCC_RscCombo
		{
			idc = MCC_GroupGenWPformationCombo_IDC;

			x = 0.345313 * safezoneW + safezoneX;
			y = 0.302077 * safezoneH + safezoneY;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_GroupGenWPspeedCombo: MCC_RscCombo
		{
			idc = MCC_GroupGenWPspeedCombo_IDC;

			x = 0.345313 * safezoneW + safezoneX;
			y = 0.335064 * safezoneH + safezoneY;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_GroupGenWPbehaviorCombo: MCC_RscCombo
		{
			idc = MCC_GroupGenWPbehaviorCombo_IDC;

			x = 0.345313 * safezoneW + safezoneX;
			y = 0.368051 * safezoneH + safezoneY;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_GroupGenWPAdd: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\manageWP.sqf'");

			text = "ADD"; //--- ToDo: Localize;
			x = 0.339583 * safezoneW + safezoneX;
			y = 0.401039 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Add a waypoint to all selected groups"; //--- ToDo: Localize;
		};
		class MCC_GroupGenWPReplace: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\manageWP.sqf'");

			text = "Replace"; //--- ToDo: Localize;
			x = 0.402604 * safezoneW + safezoneX;
			y = 0.401039 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Remove all waypoints from any selected groups and add a new waypoint"; //--- ToDo: Localize;
		};
		class MCC_GroupGenWPClear: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\manageWP.sqf'");

			text = "Clear"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.401039 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Remove all waypoints from any selected groups"; //--- ToDo: Localize;
		};
		class MCC_GroupGenWPTypeTittle: MCC_RscText
		{
			idc = -1;
			text = "Type:"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.85)";
			
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.26909 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_GroupGenWPFormationTittle: MCC_RscText
		{
			idc = -1;
			text = "Formation:"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.85)";
			
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.302077 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_GroupGenWPspeedTittle: MCC_RscText
		{
			idc = -1;
			text = "Speed:"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.85)";
			
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.335064 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_GroupGenWPbehaviorTittle: MCC_RscText
		{
			idc = -1;
			text = "Behavior:"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.85)";
			
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.368051 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
	};
};

