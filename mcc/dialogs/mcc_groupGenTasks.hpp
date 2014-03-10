#define MCC_TASKS_NAME 3056
#define MCC_TASKS_DESCRIPTION 3057
#define MCC_TASKS_LIST 3058

class MCC_tasksDialogControls: MCC_RscControlsGroup
{
	idc = 513;
	x = 0.62 * safezoneW + safezoneX;
	y = 0.28 * safezoneH + safezoneY;
	w = 0.240625 * safezoneW;
	h = 0.274893 * safezoneH;

	class Controls
	{			
		class MCC_tasksDialogFrame: MCC_RscText
		{
			idc = -1;
			colorBackground[] = {0,0,0,0.9};
			
			w = 0.240625 * safezoneW;
			h = 0.274893 * safezoneH;
		};
		class MCC_TasksGeneratorTittle: MCC_RscText
		{
			idc = -1;

			text = "Tasks Generator:"; //--- ToDo: Localize;
			x = 0.0515627 * safezoneW;
			y = 0.0109958 * safezoneH;
			w = 0.137812 * safezoneW;
			h = 0.0280063 * safezoneH;
			colorText[] = {0,1,1,1};
		};
		class MCC_TasksNameTittle: MCC_RscText
		{
			idc = -1;

			text = "Name:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.0439828 * safezoneH;
			w = 0.0590624 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		
		class MCC_TasksAvaliableTittle: MCC_RscText
		{
			idc = -1;

			text = "Available:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.15394 * safezoneH;
			w = 0.0572917 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		
		class MCC_TasksDescriptionTittle: MCC_RscText
		{
			idc = -1;

			text = "Description:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.0769698 * safezoneH;
			w = 0.0590626 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_TasksName: MCC_RscText
		{
			idc = MCC_TASKS_NAME;
			type = 2;

			x = 0.0687497 * safezoneW;
			y = 0.0439828 * safezoneH;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_TasksDescription: MCC_RscText
		{
			idc = MCC_TASKS_DESCRIPTION;
			type = 2;

			x = 0.0687497 * safezoneW;
			y = 0.0769698 * safezoneH;
			w = 0.166146 * safezoneW;
			h = 0.0549786 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_Taskslist: MCC_RscCombo
		{
			idc = MCC_TASKS_LIST;

			x = 0.0687497 * safezoneW;
			y = 0.15394 * safezoneH;
			w = 0.166146 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_TasksCreate: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL ("[0] execVM '"+MCCPATH+"mcc\pop_menu\tasks_req.sqf'");

			text = "Create"; //--- ToDo: Localize;
			x = 0.183334 * safezoneW;
			y = 0.0439828 * safezoneH;
			w = 0.0515625 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Create Task with the given name and description"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_TasksWP: MCC_RscButton
		{
			idc = -1;
			onButtonClick =  __EVAL ("[7] execVM '"+MCCPATH+"mcc\pop_menu\tasks_req.sqf'");

			text = "WP"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.186927 * safezoneH;
			w = 0.034375 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Add Waypoint to the selected task"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_TasksWPCin: MCC_RscButton
		{
			idc = -1;
			onButtonClick =  __EVAL ("[1] execVM '"+MCCPATH+"mcc\pop_menu\tasks_req.sqf'");

			text = "WP (cin)"; //--- ToDo: Localize;
			x = 0.0458336 * safezoneW;
			y = 0.186927 * safezoneH;
			w = 0.034375 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Add Waypoint to the selected task with an establish shot"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_TasksSucceed: MCC_RscButton
		{
			idc = -1;
			onButtonClick =  __EVAL ("[2] execVM '"+MCCPATH+"mcc\pop_menu\tasks_req.sqf'");

			text = "Succeed"; //--- ToDo: Localize;
			x = 0.200521 * safezoneW;
			y = 0.186927 * safezoneH;
			w = 0.034375 * safezoneW;
			h = 0.0329871 * safezoneH;
			colorText[] = {0,1,0,0.5};
			tooltip = "Mark the selected task as succeeded"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_TasksFailed: MCC_RscButton
		{
			idc = -1;
			onButtonClick =  __EVAL ("[3] execVM '"+MCCPATH+"mcc\pop_menu\tasks_req.sqf'");

			text = "Failed"; //--- ToDo: Localize;
			x = 0.160367 * safezoneW;
			y = 0.186927 * safezoneH;
			w = 0.034375 * safezoneW;
			h = 0.0329871 * safezoneH;
			colorText[] = {1,0,0,0.7};
			tooltip = "Mark the selected task as Failed"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_TasksCancled: MCC_RscButton
		{
			idc = -1;
			onButtonClick =  __EVAL ("[4] execVM '"+MCCPATH+"mcc\pop_menu\tasks_req.sqf'");

			text = "Cancel"; //--- ToDo: Localize;
			x = 0.0859376 * safezoneW;
			y = 0.186927 * safezoneH;
			w = 0.034375 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Mark the selected task as cancelled"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_TasksDelete: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL ("[8] execVM '"+MCCPATH+"mcc\pop_menu\tasks_req.sqf'");

			text = "Delete"; //--- ToDo: Localize;
			x = 0.126042 * safezoneW;
			y = 0.186927 * safezoneH;
			w = 0.0286458 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Delete the selected task"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		
		class MCC_tasksClose: MCC_RscButtonMenu
		{
			idc = -1;
			onButtonClick = "((uiNamespace getVariable 'MCC_groupGen_Dialog') displayCtrl 513) ctrlShow false";

			text = "Close"; //--- ToDo: Localize;
			x = 0.0859376 * safezoneW;
			y = 0.23091 * safezoneH;
			w = 0.0802083 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

	};
};