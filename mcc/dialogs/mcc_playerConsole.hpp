// By: Shay_gman
// Version: 1.1 (May 2012)
#define mcc_playerConsole_IDD 2993
#define MCC_MINIMAP 9120

#define MCC_ConsoleCASAvailableTextBox_IDD 9100
#define MCC_ConsoleEvacFlyHightComboBox_IDD 9101
#define MCC_ConsoleEvacApproachComboBox_IDD 9102
#define MCC_ConsoleEvacTypeText_IDD 9103
#define MCC_ConsoleAirdropAvailableTextBox_IDD 9104

#define MCC_CONSOLEINFOTEXT 9150
#define MCC_CONSOLEINFOLIVEFEED 9151
#define MCC_MAPBACKGROUND 9152
#define MCC_CONSOLEINFOLIVEFEEDNV 9153
#define MCC_CONSOLEINFOLIVEFEEDTM 9154
#define MCC_CONSOLEINFOLIVEFEEDCLOSE 9155
#define MCC_CONSOLEINFOLIVEFEEDNORMAL 9156
#define MCC_CONSOLEINFOUAVCONTROL 9162

#define MCC_CONSOLEWPBCKGR 9157
#define MCC_CONSOLEWPCOMBO 9158
#define MCC_CONSOLEWPFORMATIONCOMBO 9166
#define MCC_CONSOLEWPSPEEDCOMBO 9167
#define MCC_CONSOLEWPBEHAVIORCOMBO 9168

#define MCC_CONSOLEWPADD 	9159
#define MCC_CONSOLEWPREPLACE 9160
#define MCC_CONSOLEWPCLEAR 9161
#define MCC_ConsoleMapRulerButton 9163
#define MCC_ConsoleMapRulerDir 9164
#define MCC_ConsoleMapRulerDis 9165

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class MCC_playerConsole {
  idd = mcc_playerConsole_IDD;
  movingEnable = 1;
  onLoad = __EVAL("[] execVM '"+MCCPATH+"mcc\dialogs\mcc_playerConsole_init.sqf'");

  controlsBackground[] =
  {
  mcc_ConsolePic,
  mcc_ConsoleBackground,
  MCC_mapBackground,
  MCC_mapConsole,
  MCC_ConsoleInfoText
  };


  //---------------------------------------------
  objects[] =
  {
  };

  controls[] =
  {
  mcc_consoleF1,
  mcc_consoleF2,
  mcc_consoleF3,
  mcc_consoleF4,
  mcc_consoleF5,
  mcc_consoleF6,
  MCC_ConsoleExitButton,
  MCC_ConsoleMapRulerDir,
  MCC_ConsoleMapRulerDis,
  MCC_ConsoleMapRulerButton,
  MCC_ConsoleWPBckgr,
  MCC_ConsoleWPCombo,
  MCC_ConsoleWPformationCombo,
  MCC_ConsoleWPspeedCombo,
  MCC_ConsoleWPbehaviorCombo,
  MCC_ConsoleWPAdd,
  MCC_ConsoleWPReplace,
  MCC_ConsoleWPClear,
  MCC_ConsoleInfoLiveFeed,
  MCC_ConsoleInfoLiveFeedNormal,
  MCC_ConsoleInfoLiveFeedNV,
  MCC_ConsoleInfoLiveFeedTM,
  MCC_ConsoleInfoLiveFeedClose,
  MCC_ConsoleInfoUAVControl,
  RscControlsGroupCAS,
  RscControlsCASFolderOut,
  RscControlsGroupAirdrop,
  RscControlsADFolderOut,
  RscControlsGroupEvac,
  RscControlsEvacFolderOut,
  MCC_ResourcesControlsGroup,
  MCC_ConsoleHelp
  };

 //========================================= Background========================================
	class mcc_ConsolePic: MCC_RscPicture	{idc = -1;text = __EVAL(MCCPATH +"data\console.paa");
		x = -0.0446875 * safezoneW + safezoneX;
		y = 0.0939094 * safezoneH + safezoneY;
		w = 1.00406 * safezoneW;
		h = 0.840187 * safezoneH;
	};
	class mcc_ConsoleBackground: MCC_RscText
	{
		idc = -1;
		text = "";
		colorBackground[] = { 0, 0, 0, 1};
		x = 0.204688 * safezoneW + safezoneX;
		y = 0.2025 * safezoneH + safezoneY;
		w = 0.590625 * safezoneW;
		h = 0.595 * safezoneH;
	};

//============================================Buttons==========================================
class mcc_consoleF1: MCC_RscButton
{
	idc = -1;
	x = 0.310937 * safezoneW + safezoneX;
	y = 0.829871 * safezoneH + safezoneY;
	w = 0.0229167 * safezoneW;
	h = 0.0329871 * safezoneH;
	text = "F1";
	onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\console\conoleSwitchMenu.sqf'");
	tooltip = "Main Menu";
};
class mcc_consoleF2: MCC_RscButton
{
	idc = -1;
	x = 0.339583 * safezoneW + safezoneX;
	y = 0.829871 * safezoneH + safezoneY;
	w = 0.0229167 * safezoneW;
	h = 0.0329871 * safezoneH;
	text = "F2";
	onButtonClick = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\console\conoleSwitchMenu.sqf'");
	tooltip = "UAV Control";
};
class mcc_consoleF3: MCC_RscButton
{
	idc = -1;
	x = 0.368229 * safezoneW + safezoneX;
	y = 0.829871 * safezoneH + safezoneY;
	w = 0.0229167 * safezoneW;
	h = 0.0329871 * safezoneH;
	text = "F3";
	onButtonClick = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\console\conoleSwitchMenu.sqf'");
	tooltip = "AC-130 Control";
};
class mcc_consoleF4: MCC_RscButton
{
	idc = -1;
	x = 0.396875 * safezoneW + safezoneX;
	y = 0.829871 * safezoneH + safezoneY;
	w = 0.0229167 * safezoneW;
	h = 0.0329871 * safezoneH;
	text = "F4";
	tooltip = "Forward observer artillery's interface";
	onButtonClick = __EVAL("[0,0,0,[1]] execVM '"+MCCPATH+"mcc\general_scripts\console\conoleOpenMenu.sqf'");
};
class mcc_consoleF5: MCC_RscButton
{
	idc = -1;
	x = 0.425521 * safezoneW + safezoneX;
	y = 0.829871 * safezoneH + safezoneY;
	w = 0.0229167 * safezoneW;
	h = 0.0329871 * safezoneH;
	text = "F5";
	tooltip = "Open RTS interface";
	onButtonClick ="while {dialog} do {closeDialog 0}; createDialog 'MCC_LOGISTICS_BASE_BUILD'";
};
class mcc_consoleF6: MCC_RscButton
{
	idc = -1;
	x = 0.454167 * safezoneW + safezoneX;
	y = 0.829871 * safezoneH + safezoneY;
	w = 0.0229167 * safezoneW;
	h = 0.0329871 * safezoneH;
	colorBackground[] = {0,0,0,0};
	colorFocused[] = {1,1,1,0.2};
	colorShadow[] = { 0, 0, 0, 0};
	colorBorder[] = { 0, 0, 0, 0 };
	colorBackgroundActive[] = {0,0,0,0};
	colorDisabled[] = {0,0,0,0};
	colorBackgroundDisabled[] = {0,0,0,0};
};
 //===========================================Map==============================================
	class MCC_mapBackground : MCC_RscPicture {
		idc = MCC_MAPBACKGROUND;
		x = 0.204688 * safezoneW + safezoneX;
		y = 0.2025 * safezoneH + safezoneY;
		w = 0.590625 * safezoneW;
		h = 0.56 * safezoneH;
		text = "#(argb,512,512,1)r2t(rendertarget12,1.0);";
	};
	class MCC_mapConsole : MCC_RscMapControl {
		idc = MCC_MINIMAP;
		moving = true;
		colorBackground[] = { 1, 1, 1, 1};
		colorText[] = { 1, 1, 1, 0};
		x = 0.204688 * safezoneW + safezoneX;
		y = 0.2025 * safezoneH + safezoneY;
		w = 0.590625 * safezoneW;
		h = 0.56 * safezoneH;
		onMouseButtonDown = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\console\mouseDown.sqf'");
		onMouseButtonUp = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\console\mouseUp.sqf'");
		onMouseButtonDblClick = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\console\mouseDblClick.sqf'");
		onMouseMoving = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\console\mouseMoving.sqf'");
	};
 //========================================= Controls========================================
 	class RscControlsGroupCAS: MCC_RscControlsGroupNoScrollbars
	{
		idc = 2010;
		x = 0.205 * safezoneW + safezoneX;
		y = 0.2 * safezoneH + safezoneY;
		w = 0 * safezoneW;
		h = 0.143 * safezoneH;
		class controls
		{
			class MCC_ConsoleCASBkcg: MCC_RscText
			{
				idc = -1;
				text = "";
				colorBackground[] = {0,0,0,0.8};
				x = 0 * safezoneW;
				y = 0 * safezoneH;
				w = 0.257813 * safezoneW;
				h = 0.143 * safezoneH;
			};

			class MCC_ConsoleCASAvailableText: MCC_RscText
			{
				idc = -1;

				text = "CAS Available:";
				x = 0.00515602 * safezoneW;
				y = 0.011 * safezoneH;
				w = 0.113437 * safezoneW;
				h = 0.033 * safezoneH;
				colorText[] = {0,1,1,1};
				colorBackground[] = {1,1,1,0};
				sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			};
			class MCC_ConsoleCASAvailableTextBox: MCC_RscListbox
			{
				idc = MCC_ConsoleCASAvailableTextBox_IDD;

				x = 0.00515602 * safezoneW;
				y = 0.055 * safezoneH;
				w = 0.226875 * safezoneW;
				h = 0.075 * safezoneH;
				sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			};
			class MCC_ConsoleCASFrame: MCC_RscFrame
			{
				idc = -1;
				x = 0.00515602 * safezoneW;
				y = 0.055 * safezoneH;
				w = 0.226875 * safezoneW;
				h = 0.077 * safezoneH;
			};
			class MCC_ConsoleCallCASButton: MCC_RscButton
			{
				idc = -1;
				onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\console\console_request.sqf'");

				text = "Call CAS";
				x = 0.154688 * safezoneW;
				y = 0.011 * safezoneH;
				w = 0.0773437 * safezoneW;
				h = 0.033 * safezoneH;
				tooltip = "Call selected CAS - Click and drag on the mini-map to define CAS's approach";
			};

			class MCC_ConsoleCASFolderIn: MCC_RscButtonMenu
			{
				idc = 1010;
				x = 0.237813 * safezoneW;
				y = 0 * safezoneH;
				w = 0.02 * safezoneW;
				h = 0.143 * safezoneH;
			};
		};
	};

	class RscControlsCASFolderOut: MCC_RscControlsGroupNoScrollbars
	{
		idc = 1011;
		x = 0.205 * safezoneW + safezoneX;
		y = 0.2 * safezoneH + safezoneY;
		w = 0.02 * safezoneW;
		h = 0.143 * safezoneH;
		class controls
		{
			class MCC_ConsoleCASFolderOut: MCC_RscText
			{
				idc = -1;
				colorBackground[] = {0.25,0.25,0.25,0.8};
				x = 0 * safezoneW;
				y = 0 * safezoneH;
				w = 0.02 * safezoneW;
				h = 0.143 * safezoneH;
			};

			class MCC_ConsoleCASFolderOutPic: MCC_RscPicture
			{
				idc = -1;
				text =  __EVAL(MCCPATH +"mcc\interaction\data\cas_ca.paa");
				x = 0 * safezoneW;
				y = 0.05 * safezoneH;
				w = 0.02 * safezoneW;
				h = 0.02 * safezoneH;
			};
		};
	};

	class RscControlsGroupAirdrop: MCC_RscControlsGroupNoScrollbars
	{
		idc = 2020;
		x = 0.205 * safezoneW + safezoneX;
		y = 0.35 * safezoneH + safezoneY;
		w = 0 * safezoneW;
		h = 0.143 * safezoneH;
		class controls
		{
			class MCC_ConsoleADBkcg: MCC_RscText
			{
				idc = -1;
				text = "";
				colorBackground[] = {0,0,0,0.8};
				x = 0 * safezoneW;
				y = 0 * safezoneH;
				w = 0.257813 * safezoneW;
				h = 0.143 * safezoneH;
			};

			class MCC_ConsoleAirdropAvailableText: MCC_RscText
			{
				idc = -1;

				text = "Airdrop Available:";
				x = 0.00515602 * safezoneW;
				y = 0.011 * safezoneH;
				w = 0.113437 * safezoneW;
				h = 0.033 * safezoneH;
				colorText[] = {0,1,1,1};
				colorBackground[] = {1,1,1,0};
				sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			};
			class MCC_ConsoleAirdropAvailableTextBox: MCC_RscListbox
			{
				idc = MCC_ConsoleAirdropAvailableTextBox_IDD;

				x = 0.00515602 * safezoneW;
				y = 0.055 * safezoneH;
				w = 0.226875 * safezoneW;
				h = 0.075 * safezoneH;
				sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			};
			class MCC_ConsoleAirdropFrame: MCC_RscFrame
			{
				idc = -1;
				x = 0.00515602 * safezoneW;
				y = 0.055 * safezoneH;
				w = 0.226875 * safezoneW;
				h = 0.077 * safezoneH;
			};
			class MCC_ConsoleAirdropCallButton: MCC_RscButton
			{
				idc = -1;
				onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\console\console_request.sqf'");

				text = "Call Airdrop";
				x = 0.154688 * safezoneW;
				y = 0.011 * safezoneH;
				w = 0.0773437 * safezoneW;
				h = 0.033 * safezoneH;
				tooltip = "Call selected airdrop - Click and drag on the mini-map to define airdrop's approach";
			};

			class MCC_ConsoleADFolderIn: MCC_RscButtonMenu
			{
				idc = 1020;
				x = 0.237813 * safezoneW;
				y = 0 * safezoneH;
				w = 0.02 * safezoneW;
				h = 0.143 * safezoneH;
			};
		};
	};

	class RscControlsADFolderOut: MCC_RscControlsGroupNoScrollbars
	{
		idc = 1021;
		x = 0.205 * safezoneW + safezoneX;
		y = 0.35 * safezoneH + safezoneY;
		w = 0.02 * safezoneW;
		h = 0.143 * safezoneH;
		class controls
		{
			class MCC_ConsoleADFolderOut: MCC_RscText
			{
				idc = -1;
				colorBackground[] = {0.25,0.25,0.25,0.8};
				x = 0 * safezoneW;
				y = 0 * safezoneH;
				w = 0.02 * safezoneW;
				h = 0.143 * safezoneH;
			};

			class MCC_ConsoleADSFolderOutPic: MCC_RscPicture
			{
				idc = -1;
				text =  __EVAL(MCCPATH +"mcc\interaction\data\supplydrop_ca.paa");
				x = 0 * safezoneW;
				y = 0.05 * safezoneH;
				w = 0.02 * safezoneW;
				h = 0.02 * safezoneH;
			};
		};
	};

	class RscControlsGroupEvac: MCC_RscControlsGroupNoScrollbars
	{
		idc = 2030;
		x = 0.205 * safezoneW + safezoneX;
		y = 0.52 * safezoneH + safezoneY;
		w = 0 * safezoneW;
		h = 0.154 * safezoneH;
		class controls
		{
			class MCC_ConsoleEvacBkcg: MCC_RscText
			{
				idc = -1;
				text = "";
				colorBackground[] = {0,0,0,0.8};
				x = 0 * safezoneW;
				y = 0 * safezoneH;
				w = 0.257813 * safezoneW;
				h = 0.154 * safezoneH;
			};

			class MCC_ConsoleEvacText: MCC_RscText
			{
				idc = -1;

				text = "Evac Management:";
				x = 0.004635 * safezoneW;
				y = 0.008222 * safezoneH;
				w = 0.165 * safezoneW;
				h = 0.033 * safezoneH;
				colorText[] = {0,1,1,1};
				colorBackground[] = {1,1,1,0};
				sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			};
			class MCC_ConsoleEvacTypeText: MCC_RscText
			{
				idc = -1;

				text = "Evac:";
				x = 0.004635 * safezoneW;
				y = 0.052222 * safezoneH;
				w = 0.0567187 * safezoneW;
				h = 0.022 * safezoneH;
				colorText[] = {1,1,1,1};
				colorBackground[] = {1,1,1,0};
			};
			class MCC_ConsoleEvacType: MCC_RscCombo
			{
				idc = MCC_ConsoleEvacTypeText_IDD;
				onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\console\evac_focus.sqf'");

				x = 0.06651 * safezoneW;
				y = 0.052222 * safezoneH;
				w = 0.103125 * safezoneW;
				h = 0.022 * safezoneH;
			};
			class MCC_ConsoleEvacFlyHightText: MCC_RscText
			{
				idc = -1;

				text = "Flight Hight:";
				x = 0.004635 * safezoneW;
				y = 0.118222 * safezoneH;
				w = 0.0567187 * safezoneW;
				h = 0.022 * safezoneH;
				colorText[] = {1,1,1,1};
				colorBackground[] = {1,1,1,0};
			};
			class MCC_ConsoleEvacFlyHightComboBox: MCC_RscCombo
			{
				idc = MCC_ConsoleEvacFlyHightComboBox_IDD;

				x = 0.06651 * safezoneW;
				y = 0.118222 * safezoneH;
				w = 0.103125 * safezoneW;
				h = 0.022 * safezoneH;
			};
			class MCC_ConsoleEvacApproachText: MCC_RscText
			{
				idc = -1;

				text = "Insertion:";
				x = 0.004635 * safezoneW;
				y = 0.085222 * safezoneH;
				w = 0.0567187 * safezoneW;
				h = 0.022 * safezoneH;
				colorBackground[] = {1,1,1,0};
			};
			class MCC_ConsoleEvacApproachComboBox: MCC_RscCombo
			{
				idc = MCC_ConsoleEvacApproachComboBox_IDD;

				x = 0.06651 * safezoneW;
				y = 0.085222 * safezoneH;
				w = 0.103125 * safezoneW;
				h = 0.022 * safezoneH;
			};
			class MCC_ConsoleCallEvacButton: MCC_RscButton
			{
				idc = -1;
				onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\console\evacwp.sqf'");

				text = "Call EVAC";
				x = 0.174791 * safezoneW;
				y = 0.041222 * safezoneH;
				w = 0.06 * safezoneW;
				h = 0.044 * safezoneH;
				tooltip = "Call selected EVAC - Mouse click on the mini-map to call it";
				sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			};
			class MCC_ConsoleCallEvac3WPButton: MCC_RscButton
			{
				idc = -1;
				onButtonClick = __EVAL("nul=[1] execVM '"+MCCPATH+"mcc\general_scripts\console\evacwp.sqf'");

				text = "Call EVAC 3 WP";
				x = 0.174791 * safezoneW;
				y = 0.096222 * safezoneH;
				w = 0.06 * safezoneW;
				h = 0.044 * safezoneH;
				tooltip = "Call selected EVAC - Mouse click on the mini-map to call it";
				sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			};

			class MCC_ConsoleEvacFolderIn: MCC_RscButtonMenu
			{
				idc = 1030;
				x = 0.237813 * safezoneW;
				y = 0 * safezoneH;
				w = 0.02 * safezoneW;
				h = 0.154 * safezoneH;
			};
		};
	};

	class RscControlsEvacFolderOut: MCC_RscControlsGroupNoScrollbars
	{
		idc = 1031;
		x = 0.205 * safezoneW + safezoneX;
		y = 0.52 * safezoneH + safezoneY;
		w = 0.02 * safezoneW;
		h = 0.154 * safezoneH;
		class controls
		{
			class MCC_ConsoleEvacFolderOut: MCC_RscText
			{
				idc = -1;
				colorBackground[] = {0.25,0.25,0.25,0.8};
				x = 0 * safezoneW;
				y = 0 * safezoneH;
				w = 0.02 * safezoneW;
				h = 0.154 * safezoneH;
			};

			class MCC_ConsoleEvacFolderOutPic: MCC_RscPicture
			{
				idc = -1;
				text =  __EVAL(MCCPATH +"mcc\interaction\data\transport_ca.paa");
				x = 0 * safezoneW;
				y = 0.06 * safezoneH;
				w = 0.02 * safezoneW;
				h = 0.02 * safezoneH;
			};
		};
	};

	class MCC_ResourcesControlsGroup: MCC_RscControlsGroupNoScrollbars
	{
		idc = 80;

		x = 0.555 * safezoneW + safezoneX;
		y = 0.2 * safezoneH + safezoneY;
		w = 0.268125 * safezoneW;
		h = 0.088 * safezoneH;
		class controls
		{
			class background: MCC_RscText
			{
				idc = -1;
				text = "";
				colorBackground[] = { 0, 0, 0, 0.6};
				x = 0.04 * safezoneW;
				y = 0 * safezoneH;
				w = 0.2 * safezoneW;
				h = 0.07 * safezoneH;
			};

			class MCC_AmmoText: MCC_RscText
			{
				idc = 81;
				style = 2;
				sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";

				x = 0.04125 * safezoneW;
				y = 0.036 * safezoneH;
				w = 0.0360937 * safezoneW;
				h = 0.033 * safezoneH;
			};

			class MCC_RepairText: MCC_RscText
			{
				idc = 82;
				style = 2;
				sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";

				x = 0.0825002 * safezoneW;
				y = 0.036 * safezoneH;
				w = 0.0360937 * safezoneW;
				h = 0.033 * safezoneH;
			};

			class MCC_FuelText: MCC_RscText
			{
				idc = 83;
				style = 2;
				sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";

				x = 0.12375 * safezoneW;
				y = 0.036 * safezoneH;
				w = 0.0360937 * safezoneW;
				h = 0.033 * safezoneH;
			};
			class MCC_FoodText: MCC_RscText
			{
				idc = 84;
				style = 2;
				sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";

				x = 0.165 * safezoneW;
				y = 0.036 * safezoneH;
				w = 0.0360937 * safezoneW;
				h = 0.033 * safezoneH;
			};
			class MCC_MedText: MCC_RscText
			{
				idc = 85;
				style = 2;
				sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";

				x = 0.20625 * safezoneW;
				y = 0.036 * safezoneH;
				w = 0.0360937 * safezoneW;
				h = 0.033 * safezoneH;
			};
			class MCC_Ammo: MCC_RscPicture
			{
				idc = 91;
				tooltip = "Ammo";
				text =  __EVAL(MCCPATH +"data\IconAmmo.paa");
				colorText[] = { 0.9, 0, 0, 1 };

				x = 0.0515627 * safezoneW;
				y = 0.005 * safezoneH;
				w = 0.0154689 * safezoneW;
				h = 0.033 * safezoneH;
			};
			class MCC_Repair: MCC_RscPicture
			{
				idc = 92;
				tooltip = "Supplies";
				text = __EVAL(MCCPATH +"data\IconRepair.paa");
				colorText[] = { 0, 0.5, 0.9, 1 };

				x = 0.0928127 * safezoneW;
				y = 0.005 * safezoneH;
				w = 0.0154689 * safezoneW;
				h = 0.033 * safezoneH;
			};
			class MCC_Fuel: MCC_RscPicture
			{
				idc = 93;
				tooltip = "Fuel";
				text = __EVAL(MCCPATH +"data\IconFuel.paa");
				colorText[] = { 0, 0.9, 0.5, 1 };

				x = 0.134063 * safezoneW;
				y = 0.005 * safezoneH;
				w = 0.0154689 * safezoneW;
				h = 0.033 * safezoneH;
			};
			class MCC_FoodPic: MCC_RscPicture
			{
				idc = 94;
				tooltip = "Food";
				text = __EVAL(MCCPATH +"data\IconFood.paa");
				colorText[] = { 0.9, 0.5, 0, 1 };

				x = 0.175313 * safezoneW;
				y = 0.005 * safezoneH;
				w = 0.0154689 * safezoneW;
				h = 0.033 * safezoneH;
			};
			class MCC_MedPic: MCC_RscPicture
			{
				idc = 95;
				tooltip = "Meds";
				text = __EVAL(MCCPATH +"data\IconMed.paa");
				colorText[] = { 0, 0.9, 0.9, 1 };

				x = 0.216563 * safezoneW;
				y = 0.005 * safezoneH;
				w = 0.0154689 * safezoneW;
				h = 0.033 * safezoneH;
			};
		};
	};

	class MCC_ConsoleWPBckgr: MCC_RscStructuredText
		{
			idc = MCC_CONSOLEWPBCKGR;
			x = 0.1 * safezoneW + safezoneX;
			y = 0.1 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.5)";
			colorBackground[] = {0,0,0,0.8};
		};
	class MCC_ConsoleWPCombo: MCC_RscCombo
	{
		idc = MCC_CONSOLEWPCOMBO;
		x = 0.1 * safezoneW + safezoneX;
		y = 0.1 * safezoneH + safezoneY;
		w = 0.105 * safezoneW;
		h = 0.0280062 * safezoneH;
	};
	class MCC_ConsoleWPformationCombo: MCC_RscCombo
	{
		idc = MCC_CONSOLEWPFORMATIONCOMBO;
		x = 0.1 * safezoneW + safezoneX;
		y = 0.1 * safezoneH + safezoneY;
		w = 0.105 * safezoneW;
		h = 0.0280062 * safezoneH;
	};
	class MCC_ConsoleWPspeedCombo: MCC_RscCombo
	{
		idc = MCC_CONSOLEWPSPEEDCOMBO;
		x = 0.1 * safezoneW + safezoneX;
		y = 0.1 * safezoneH + safezoneY;
		w = 0.105 * safezoneW;
		h = 0.0280062 * safezoneH;
	};
	class MCC_ConsoleWPbehaviorCombo: MCC_RscCombo
	{
		idc = MCC_CONSOLEWPBEHAVIORCOMBO;
		x = 0.1 * safezoneW + safezoneX;
		y = 0.1 * safezoneH + safezoneY;
		w = 0.105 * safezoneW;
		h = 0.0280062 * safezoneH;
	};
	class MCC_ConsoleWPAdd: MCC_RscButton {
		idc = MCC_CONSOLEWPADD;
		text = "ADD";
		x = 0.1 * safezoneW + safezoneX;
		y = 0.1 * safezoneH + safezoneY;
		w = 0.1 * safezoneW;
		h = 0.1 * safezoneH;
		tooltip = "Add a waypoint to all selected groups";
		onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\console\manageWP.sqf'");
	};
	class MCC_ConsoleWPReplace: MCC_RscButton {
		idc = MCC_CONSOLEWPREPLACE;
		text = "Replace";
		x = 0.1 * safezoneW + safezoneX;
		y = 0.1 * safezoneH + safezoneY;
		w = 0.1 * safezoneW;
		h = 0.1 * safezoneH;
		tooltip = "Remove all waypoints from any selected groups and add a new waypoint";
		onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\console\manageWP.sqf'");
	};
	class MCC_ConsoleWPClear: MCC_RscButton {
		idc = MCC_CONSOLEWPCLEAR;
		text = "Clear";
		x = 0.1 * safezoneW + safezoneX;
		y = 0.1 * safezoneH + safezoneY;
		w = 0.1 * safezoneW;
		h = 0.1 * safezoneH;
		tooltip = "Remove all waypoints from any selected groups";
		onButtonClick = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\console\manageWP.sqf'");
	};
	class MCC_ConsoleInfoText: MCC_RscStructuredText
		{
			idc = MCC_CONSOLEINFOTEXT;
			x = 0.1 * safezoneW + safezoneX;
			y = 0.1 * safezoneH + safezoneY;
			w = 0.1 * safezoneW;
			h = 0.1 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.5)";
			colorBackground[] = {0,0,0,0.8};
		};
	class MCC_ConsoleInfoLiveFeed: MCC_RscButton {
		idc = MCC_CONSOLEINFOLIVEFEED;
		text = "Live Feed";
		x = 0.217813 * safezoneW + safezoneX;
		y = 0.668037 * safezoneH + safezoneY;
		w = 0.06 * safezoneW;
		h = 0.03 * safezoneH;
		onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\console\liveFeed.sqf'");
	};

	class MCC_ConsoleInfoUAVControl: MCC_RscButton {
		idc = MCC_CONSOLEINFOUAVCONTROL;
		text = "Take Control";
		x = 0.1 * safezoneW + safezoneX;
		y = 0.1 * safezoneH + safezoneY;
		w = 0.1 * safezoneW;
		h = 0.1 * safezoneH;
		onButtonClick =  __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\console\consoleTakeControl.sqf'");
	};

	class MCC_ConsoleMapRulerButton: MCC_RscButton {
		idc = MCC_ConsoleMapRulerButton;
		text = "Ruler";
		tooltip = "Activate the map ruler - left click on the map and drag from one point to another to measure distance and direction";
		x = 0.4 * safezoneW + safezoneX;
		y = 0.763 * safezoneH + safezoneY;
		w = 0.06 * safezoneW;
		h = 0.03 * safezoneH;
		onButtonClick =  "MCC_ConsoleRuler = true";
	};

	class MCC_ConsoleMapRulerDir: MCC_RscText {
		idc = MCC_ConsoleMapRulerDir;
		text = "Direction:";
		x = (0.4 * safezoneW + safezoneX) + (0.065 * safezoneW);
		y = 0.763 * safezoneH + safezoneY;
		w = 0.08 * safezoneW;
		h = 0.03 * safezoneH;
	};
	class MCC_ConsoleMapRulerDis: MCC_RscText {
		idc = MCC_ConsoleMapRulerDis;
		text = "Distance:";
		x = (0.4 * safezoneW + safezoneX) + (0.195 * safezoneW);
		y = 0.763 * safezoneH + safezoneY;
		w = 0.08 * safezoneW;
		h = 0.03 * safezoneH;
	};
	class MCC_ConsoleInfoLiveFeedNormal: MCC_RscButton {
		idc = MCC_CONSOLEINFOLIVEFEEDNORMAL;
		text = "Video";
		x = 0.37 * safezoneW + safezoneX;
		y = (0.213012 * safezoneH + safezoneY) + (0.494807 * safezoneH);
		w = 0.06 * safezoneW;
		h = 0.03 * safezoneH;
		onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\console\liveFeed.sqf'");
	};

	class MCC_ConsoleInfoLiveFeedNV: MCC_RscButton {
		idc = MCC_CONSOLEINFOLIVEFEEDNV;
		text = "N/V";
		x = (0.37 * safezoneW + safezoneX) + (0.065 * safezoneW);
		y = (0.213012 * safezoneH + safezoneY) + (0.494807 * safezoneH);
		w = 0.06 * safezoneW;
		h = 0.03 * safezoneH;
		onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\console\liveFeed.sqf'");
	};
	class MCC_ConsoleInfoLiveFeedTM: MCC_RscButton {
		idc = MCC_CONSOLEINFOLIVEFEEDTM;
		text = "T/I";
		x = (0.37 * safezoneW + safezoneX) + (0.13 * safezoneW);
		y = (0.213012 * safezoneH + safezoneY) + (0.494807 * safezoneH);
		w = 0.06 * safezoneW;
		h = 0.03 * safezoneH;
		onButtonClick = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\console\liveFeed.sqf'");
	};

	class MCC_ConsoleInfoLiveFeedClose: MCC_RscButton {
		idc = MCC_CONSOLEINFOLIVEFEEDCLOSE;
		text = "Close Feed";
		x = (0.37 * safezoneW + safezoneX) + (0.195 * safezoneW);
		y = (0.213012 * safezoneH + safezoneY) + (0.494807 * safezoneH);
		w = 0.06 * safezoneW;
		h = 0.03 * safezoneH;
		onButtonClick = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\console\liveFeed.sqf'");
	};

	class MCC_ConsoleHelp: MCC_RscStructuredText
	{
		idc = -1;
		text = "(?)";
		colorBackground[] = { 0, 0, 0, 0.7};
		onMouseEnter = "[_this, true,[12,12],'console'] spawn MCC_fnc_help";

		x = 0.55 * safezoneW + safezoneX;
		y = 0.21 * safezoneH + safezoneY;
		w = 0.020625 * safezoneW;
		h = 0.033 * safezoneH;
	};
	//=================================Buttons=============================================
	class MCC_ConsoleExitButton: MCC_RscButton {
		idc = -1;
		text = "";
		x = 0.480312 * safezoneW + safezoneX;
		y = 0.822072 * safezoneH + safezoneY;
		w = 0.0328125 * safezoneW;
		h = 0.0420094 * safezoneH;
		colorBackground[] = {0,0,0,0};
		colorFocused[] = {1,1,1,0.2};
		colorShadow[] = { 0, 0, 0, 0};
		colorBorder[] = { 0, 0, 0, 0 };
		colorBackgroundActive[] = {0,0,0,0};
		colorDisabled[] = {0,0,0,0};
		colorBackgroundDisabled[] = {0,0,0,0};
		tooltip = "Close the conosle";
		onButtonClick = "closedialog 0;";
	};
};
