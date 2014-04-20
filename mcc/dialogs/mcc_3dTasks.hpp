#define MCC_3dTasksControlsIDC 8020

class MCC_3dTasksControls:MCC_RscControlsGroup
{
	idc = MCC_3dTasksControlsIDC;
	x = 0.195 * safezoneW + safezoneX;
	y = 0.2 * safezoneH + safezoneY;
	w = 0.217708 * safezoneW;
	h = 0.46182 * safezoneH;

	class Controls
	{
		class MCC_3dTasksFrame: MCC_RscText
		{
			idc = -1;
			text = "";
			colorBackground[] = {0,0,0,0.7};
			
			w = 0.217708 * safezoneW;
			h = 0.46182 * safezoneH;
		};
		
		class  MCC_3dTasksTittle: MCC_RscText
		{
			idc = -1;
			text = "Assign task to object:";
			colorText[] = {0,1,1,1};
			
			x = 0.328125 * safezoneW + safezoneX;
			y = 0.236103 * safezoneH + safezoneY;
			w = 0.114583 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_3dTasksSidesTittle: MCC_RscText
		{
			idc = -1;
			text = "Task Side:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.0744792 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *0.9)";
		};
		class MCC_3dTasksNameTittle: MCC_RscText
		{
			idc = -1;
			text = "Task Name:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.324069 * safezoneH + safezoneY;
			w = 0.0744792 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *0.9)";
		};
		class MCC_3dTasksDescTittle: MCC_RscText
		{
			idc = -1;
			text = "Task Desc.:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.368051 * safezoneH + safezoneY;
			w = 0.0744792 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *0.9)";
		};
		class MCC_3dTasksCompletedTittle: MCC_RscText
		{
			idc = -1;
			text = "Completed when:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0744792 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *0.9)";
		};
		class MCC_3dTasksMarkerTittle: MCC_RscText
		{
			idc = -1;
			text = "Linked Marker:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.543983 * safezoneH + safezoneY;
			w = 0.0744792 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *0.9)";
		};
		class MCC_3dTasksIntelTittle: MCC_RscText
		{
			idc = -1;
			text = "Intel:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.587966 * safezoneH + safezoneY;
			w = 0.0744792 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *0.9)";
		};
		class MCC_3dTasksSidesToolBox: MCC_RscToolbox
		{
			idc = -1;
			strings[]={"ALL","WEST","EAST","GUER"};
			rows=1;
			columns=4;
			values[] = {0,1, 2, 3};
			onToolBoxSelChanged = "MCC_TaskSide = (_this select 1);";
			
			x = 0.356771 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.126042 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *0.8)";
		};
		class MCC_3dTasksNameText: MCC_RscText
		{
			idc = 8503;
			text = "";
			type = MCCCT_EDIT;
			style = MCCST_MULTI;
			autocomplete = false;
			access = ReadAndWrite;
			
			x = 0.356771 * safezoneW + safezoneX;
			y = 0.324069 * safezoneH + safezoneY;
			w = 0.126042 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *0.9)";
		};
		class MCC_3dTasksDescText: MCC_RscText
		{
			idc = 8504;
			text = "";
			type = MCCCT_EDIT;
			style = MCCST_MULTI;
			autocomplete = false;
			access = ReadAndWrite;
			
			x = 0.356771 * safezoneW + safezoneX;
			y = 0.368051 * safezoneH + safezoneY;
			w = 0.126042 * safezoneW;
			h = 0.0659743 * safezoneH;
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *0.9)";
		};
		
		class MCC_3dTasksCompletedCombo: MCC_RscCombo
		{
			idc = 8505;
			x = 0.356771 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.126042 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "What will trigger task complete"; //--- ToDo: Localize;
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *0.9)";
		};
		
		class MCC_3dTasksMarkerCombo: MCC_RscCombo
		{
			idc = 8506;
			x = 0.356771 * safezoneW + safezoneX;
			y = 0.543983 * safezoneH + safezoneY;
			w = 0.126042 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "If it linked to a zone which zone marker is it"; //--- ToDo: Localize;
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *0.9)";
		};
		class MCC_3dTasksIntelCombo: MCC_RscCombo
		{
			idc = 8507;
			x = 0.356771 * safezoneW + safezoneX;
			y = 0.587966 * safezoneH + safezoneY;
			w = 0.126042 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "How the players will see the task "; //--- ToDo: Localize;
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *0.9)";
		};
		class MCC_3dTasksPreviusTittle: MCC_RscText
		{
			idc = -1;
			text = "Triggers After:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.456017 * safezoneH + safezoneY;
			w = 0.0744792 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *0.9)";
		};
		class MCC_3dTasksPreviusCombo: MCC_RscCombo
		{
			idc = 8508;
			x = 0.356771 * safezoneW + safezoneX;
			y = 0.456017 * safezoneH + safezoneY;
			w = 0.126042 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Will only create the task after this task have been completed"; //--- ToDo: Localize;
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) *0.9)";
		};
		class MCC_3dTasksAddButton: MCC_RscButton
		{
			idc = -1;
			text = "Add"; //--- ToDo: Localize;
			onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\tasks\tasksAdd.sqf'");
			
			x = 0.328125 * safezoneW + safezoneX;
			y = 0.631948 * safezoneH + safezoneY;
			w = 0.108854 * safezoneW;
			h = 0.0439828 * safezoneH;
		};
	};
};
		
