// By: Ollem
// Version: 1.0 (February 2013)
#define MCC_SaveLoadScreen_IDD 7000
#define MCC_SAVE_LIST 7010
#define MCC_SAVE_DIS 7011
#define MCC_SAVE_NAME 7012
#define MCC_SAVE_PERSISTENT 7013

#define MCC_LOAD_INPUT 7001

#define MCCST_CENTER 0x02
#define MCCST_MULTI 16
#define MCCCT_EDIT 2

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class MCC_SaveLoadScreen
{
	idd = MCC_SaveLoadScreen_IDD;
	movingEnable = true;
	onLoad = __EVAL("_this execVM '"+MCCPATH+"mcc\dialogs\MCC_SaveLoadScreenInit.sqf'");

	class controlsBackground 	{
		class MCC_SaveLoadBackground: MCC_RscText
		{
			idc = -1;
			moving = true;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.247099 * safezoneH + safezoneY;
			w = 0.446875 * safezoneW;
			h = 0.516798 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};
	};


	//---------------------------------------------
	objects[] =
	{
	};

	class controls {
		//========================================= Input ========================================
		class MCC_SaveLoadHeader: MCC_RscText
		{
			style = MCCST_CENTER;
			idc = -1;
			text = "Save / Load MCC configuration";
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.247099 * safezoneH + safezoneY;
			w = 0.446875 * safezoneW;
			h = 0.0439828 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};

		class MCC_LoadHeader: MCC_RscText
		{
			idc = -1;
			text = "Paste (crtl-v) MCC configuration code here:";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			x = 0.283437 * safezoneW + safezoneX;
			y = 0.434 * safezoneH + safezoneY;
			w = 0.221719 * safezoneW;
			h = 0.033 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {1,0,1,0};
		};

		//========================================= Text Input Box =========================================
		//class MCC_LoadInput : MCC_RscText {idc = MCC_LOAD_INPUT;type = MCCCT_EDIT;style = MCCST_MULTI;colorBackground[] = { 0, 0, 0, 0 };colorText[] = { 1, 1, 1, 1 };colorSelection[] = { 1, 1, 1, 1 };colorBorder[] = { 1, 1, 1, 1 };BorderSize = 0.01;autocomplete = false;x = 0.5; y = 0.275;w = 0.4; h = 0.04;sizeEx = 0.03;text = "";};

		class MCC_LoadFrame: MCC_RscText
		{
			idc = MCC_LOAD_INPUT;
			text = "";
			type = MCCCT_EDIT;
			style = MCCST_MULTI;
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			x = 0.288021 * safezoneW + safezoneX;
			y = 0.302077 * safezoneH + safezoneY;
			w = 0.429688 * safezoneW;
			h = 0.142944 * safezoneH;
			colorSelection[] = { 1, 1, 1, 1 };
			colorDisabled[] = { 0, 0, 0, 1 };
			autocomplete = false;
			access = ReadAndWrite;
		};

		//========================================= Buttons ========================================
		class MCC_SaveButton: MCC_RscButton		//Save to clipboard
		{
			idc = 0;
			text = "Save To Clipboard";
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			x = 0.283437 * safezoneW + safezoneX;
			y = 0.467 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.032987 * safezoneH;
			tooltip = "Save current MCC configuration to ClipBoard";
			onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\commandLine\mcc_loadConfig.sqf'");
		};

		class MCC_LoadButton: MCC_RscButton		//Load from clipboard
		{
			idc = -1;
			text = "Load From Clipboard";
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.467 * safezoneH + safezoneY;
			w = 0.108854 * safezoneW;
			h = 0.032987 * safezoneH;
			tooltip = "Paste MCC mission configuration code from clipboard (crtl-v) in text box first";
			onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\commandLine\mcc_loadConfig.sqf'");
		};

		class MCC_CancelButton: MCC_RscButton	//Close dialog
		{
			idc = -1;
			text = "Close";
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			x = 0.6375 * safezoneW + safezoneX;
			y = 0.719914 * safezoneH + safezoneY;
			w = 0.0802083 * safezoneW;
			h = 0.0329871 * safezoneH;
			onButtonClick = "closeDialog 0;";
		};

		class MCC_saveList: MCC_RscListBox	//List of all the save slots
		{
			idc = MCC_SAVE_LIST;
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			x = 0.282292 * safezoneW + safezoneX;
			y = 0.510996 * safezoneH + safezoneY;
			w = 0.20625 * safezoneW;
			h = 0.15394 * safezoneH;
			onLBSelChanged = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\commandLine\mcc_loadConfig.sqf'");
		};

		class MCC_saveDescription: MCC_RscText	//Description fo the saved mission
		{
			idc = MCC_SAVE_DIS;
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			x = 0.5 * safezoneW + safezoneX;
			y = 0.510996 * safezoneH + safezoneY;
			w = 0.217708 * safezoneW;
			h = 0.15394 * safezoneH;
			text = "";
			type = MCCCT_EDIT;
			style = MCCST_MULTI;
			autocomplete = false;
			access = ReadAndWrite;
		};

		class MCC_saveName: MCC_RscText	//Name of the saved mission
		{
			idc = MCC_SAVE_NAME;
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			x = 0.342604 * safezoneW + safezoneX;
			y = 0.675931 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.0329871 * safezoneH;
			text = "";
			type = MCCCT_EDIT;
			style = MCCST_MULTI;
			autocomplete = false;
			access = ReadAndWrite;
		};

		class MCC_saveNameTittle: MCC_RscText
		{
			idc = -1;
			text = "Save Name:"; //--- ToDo: Localize;
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			x = 0.288021 * safezoneW + safezoneX;
			y = 0.675931 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
			colorText[] = {0,1,1,1};
		};

		class MCC_saveUIButton: MCC_RscButton	//Save to UI
		{
			idc = -1;
			onButtonClick = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\commandLine\mcc_loadConfig.sqf'");
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			tooltip = "Save a mission to profile name space - choose a slot from the above list first";
			text = "Save To Profile"; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.675931 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_loadUIButton: MCC_RscButton	//Load from UI
		{
			idc = -1;
			onButtonClick = __EVAL("[4] execVM '"+MCCPATH+"mcc\general_scripts\commandLine\mcc_loadConfig.sqf'");
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			tooltip = "Load a mission from profile name space - choose a slot from the above list first";
			text = "Load From Profile"; //--- ToDo: Localize;
			x = 0.620312 * safezoneW + safezoneX;
			y = 0.675931 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC3DSaveAllToSQM: MCC_RscButton
		{
			idc = -1;
			colorDisabled[] = {1,0.4,0.3,0.8};
			onButtonClick = __EVAL("[5] execVM '"+MCCPATH+"mcc\general_scripts\commandLine\mcc_loadConfig.sqf'");
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.85)";
			tooltip = "Save all missions's object in SQM file format and copy it to clipboard."; //--- ToDo: Localize;
			text = "Save All (SQM)"; //--- ToDo: Localize;
			x = 0.288021 * safezoneW + safezoneX;
			y = 0.719914 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC3DSaveToSQM: MCC_RscButton
		{
			idc = -1;
			colorDisabled[] = {1,0.4,0.3,0.8};
			onButtonClick = __EVAL("[7] execVM '"+MCCPATH+"mcc\general_scripts\commandLine\mcc_loadConfig.sqf'");
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.85)";
			tooltip = "Save only MCC/Zeus missions's object in SQM file format and copy it to clipboard."; //--- ToDo: Localize;
			text = "Save MCC (SQM)"; //--- ToDo: Localize;
			x = 0.4 * safezoneW + safezoneX;
			y = 0.719914 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC3DSaveToComp: MCC_RscButton
		{
			idc = -1;
			colorDisabled[] = {1,0.4,0.3,0.8};
			onButtonClick = __EVAL("[6] execVM '"+MCCPATH+"mcc\general_scripts\commandLine\mcc_loadConfig.sqf'");
			tooltip = "Save MCC's 3D editor placments in a composition's format to clipboard and RPT file"; //--- ToDo: Localize;
			text = "Save Comp"; //--- ToDo: Localize;
			x = 0.402604 * safezoneW + safezoneX;
			y = 0.719914 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		//Persistent saving
		class activatePersistent: MCC_RscButton
		{
			idc = MCC_SAVE_PERSISTENT;
			text = "Activate Persistent"; //--- ToDo: Localize;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.044 * safezoneH;
			onButtonClick = __EVAL("[8] execVM '"+MCCPATH+"mcc\general_scripts\commandLine\mcc_loadConfig.sqf'");
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			tooltip = "Activate Persistent data saving and loading from DB"; //--- ToDo: Localize;
		};
		class clearPersistent: MCC_RscButton
		{
			idc = -1;
			text = "Clear Persistent"; //--- ToDo: Localize;
			x = 0.628906 * safezoneW + safezoneX;
			y = 0.456 * safezoneH + safezoneY;
			w = 0.0773437 * safezoneW;
			h = 0.044 * safezoneH;
			onButtonClick = __EVAL("[9] execVM '"+MCCPATH+"mcc\general_scripts\commandLine\mcc_loadConfig.sqf'");
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			tooltip = "Clear defualt persistent data from DB"; //--- ToDo: Localize;
		};
	};
};
