//by Bon_Inf*

#define BON_ARTY_DIALOG 999900
#define BON_ARTY_SHELLSLEFT 999901
#define BON_ARTY_XRAY 999902
#define BON_ARTY_YANKEE 999903
#define BON_ARTY_CANNONLIST 999904
#define BON_ARTY_XRAYEDIT 999905
#define BON_ARTY_YANKEEEDIT 999906
#define BON_ARTY_DIRECTION 999907
#define BON_ARTY_DISTANCE 999908
#define BON_ARTY_HEIGHT 999909
#define BON_ARTY_HEIGHTINDEX 999910
#define BON_ARTY_DELAYEDIT 999911
#define BON_ARTY_SUMMARY 999913
#define BON_ARTY_REQUESTBUTTON 999914
#define BON_ARTY_TYPE 999915
#define BON_ARTY_NRSHELLS 999916
#define BON_ARTY_SPREAD 999917
#define BON_ARTY_XCORRECTION 999918
#define BON_ARTY_YCORRECTION 999919
#define BON_ARTY_ADJUSTBUTTON 999920
#define BON_ARTY_MISSIONTYPE 999921

class ArtilleryDialog {
	idd = BON_ARTY_DIALOG;
	movingEnable = true; 
	onLoad = __EVAL("[] execVM '"+MCCPATH+"bon_artillery\dialog\bon_initartillery.sqf'");

	class controlsBackground {
		class mcc_ConsolePic: MCC_RscPicture {
			idc = -1;
			text =  __EVAL(MCCPATH +"data\console.paa");
			x = -0.0446875 * safezoneW + safezoneX;
			y = 0.0939094 * safezoneH + safezoneY;
			w = 1.00406 * safezoneW;
			h = 0.840187 * safezoneH;
		};
		
		class mcc_ConsoleBackground: MCC_RscText {
			idc = -1;
			text = "";
			colorBackground[] = { 0, 0, 0, 1};
			x = 0.204688 * safezoneW + safezoneX;
			y = 0.2025 * safezoneH + safezoneY;
			w = 0.590625 * safezoneW;
			h = 0.595 * safezoneH;
		};
			
		class HW_ArtiListBckgrnd : MCC_RscText {
			idc = -1;
			moving = true;
			colorBackground[] = { 0, 0, 0, 0.6 };
			colorText[] = { 1, 1, 1, 0 };
			x = 0.005; y = 0.520;
			w = 0.285; h = 0.275;
			text = "";
		};
	};

	class controls {
		//============================================Buttons==========================================
		class mcc_consoleF1: MCC_RscButton
		{
			idc = -1;
			x = 0.310937 * safezoneW + safezoneX;
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
			onButtonClick = "closedialog 0;createDialog 'MCC_playerConsole';";
			tooltip = "Main Menu";
		};
		class mcc_consoleF2: MCC_RscButton
		{
			idc = -1;
			x = 0.339583 * safezoneW + safezoneX;
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
			onButtonClick = "closedialog 0;createDialog 'MCC_playerConsole2';";
			tooltip = "UAV Control"; 
		};
		class mcc_consoleF3: MCC_RscButton
		{
			idc = -1;
			x = 0.368229 * safezoneW + safezoneX;
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
			onButtonClick = "closedialog 0;createDialog 'MCC_playerConsole3';";
			tooltip = "AC-130 Control"; 
		};
		class mcc_consoleF4: MCC_RscButton
		{
			idc = -1;
			x = 0.396875 * safezoneW + safezoneX;
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
			tooltip = "Forward observer artillery's interface"; 
			onButtonClick = __EVAL("nul=[0,0,0,[1]] execVM '"+MCCPATH+"mcc\general_scripts\console\conoleOpenMenu.sqf'");
		};
		class mcc_consoleF5: MCC_RscButton
		{
			idc = -1;
			x = 0.425521 * safezoneW + safezoneX;
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
		class HW_ArtiTextField : MCC_RscText {
			idc = -1;
			style = MCCST_LEFT;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			x = 0.3; y = 0.15;
			w = 0.3; h = 0.05;
			sizeEx = 0.03;
			text = "";
		};
		class HW_ArtiInstructions : HW_ArtiTextField {
			idc = BON_ARTY_SUMMARY;
			style = MCCST_MULTI;
			linespacing = 1.00000;
			x = 0.005; y = 0.131;
			w = 0.2875; h = 0.389;
			sizeEx = 0.0225;
			text = "Always use 'Cancel' to unregister without actually executing a fire mission.\n\n\n\n\n\n\n\n\n\n\n\n\n\nWritten by Bon_Inf*.";
		};
		class HW_ArtiShellsLeft : HW_ArtiTextField {
			idc = BON_ARTY_SHELLSLEFT;
			text = "Shells left: 0815";
		};
		class HW_Articoord : HW_ArtiTextField {
			y = 0.1725 + 0.05;
			w = 0.22;
			text = "Your current position:";
		};
		class HW_ArtiXcoord : HW_ArtiTextField {
			idc = BON_ARTY_XRAY;
			style = MCCST_RIGHT;
			y = 0.1725 + 0.05 + 0.05;
			w = 0.175;
		};
		class HW_ArtiYcoord : HW_ArtiTextField {
			idc = BON_ARTY_YANKEE;
			style = MCCST_RIGHT;
			y = 0.1725 + 0.05 + 0.05 + 0.05;
			w = 0.175;
		};


		class HW_ArtiCannonList : MCC_RscListbox {
			idc = BON_ARTY_CANNONLIST;
			style = MCCLB_MULTI;
			default = 1;
			x = 0.005; y = 0.520;
			w = 0.2875; h = 0.275;
			onLBSelChanged = "[] call arti_dlgUpdate";
			onLBDblClick = "";
			rowHeight = 0.04;
			maxHistoryDelay = 10;
			canDrag = 0;
			xcolumn1 = "0.1f";
			xcolumn2 = "0.25f";
			xcolumn3 = "0.85f";		
		};


		class HW_ArtiXcoordunit : MCC_RscText {
			idc = BON_ARTY_XRAYEDIT;
			type = MCCCT_EDIT;
			style = MCCST_LEFT;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			colorSelection[] = { 1, 1, 1, 1 };
			colorBorder[] = { 1, 1, 1, 1 };
			BorderSize = 0.01;
			autocomplete = false;  
			x = 0.66; y = 0.225;
			w = 0.085; h = 0.035;

			sizeEx = 0.03;
			text = "";
		};
		class HW_ArtiYcoordunit : HW_ArtiXCoordunit {
			idc = BON_ARTY_YANKEEEDIT;
			y = 0.225 + 0.05;
		};
		class HW_ArtiDirection : HW_ArtiXCoordunit {
			idc = BON_ARTY_DIRECTION;
			y = 0.225 + 0.05 + 0.05;
		};
		class HW_ArtiDistance : HW_ArtiXCoordunit {
			idc = BON_ARTY_DISTANCE;
			y = 0.225 + 0.05 + 0.05 + 0.05;
		};

		class HW_ArtiXCoordUnitDescr : HW_ArtiXcoordunit {
			idc = -1;
			type = MCCCT_STATIC; 
			x = 0.55; y = 0.225;
			w = 0.75;
			text = "x-ray";
		};
		class HW_ArtiYCoordUnitDescr : HW_ArtiXCoordUnitDescr {
			y = 0.225 + 0.05;
			text = "yankee";
		};
		class HW_ArtiDirDescr : HW_ArtiXCoordUnitDescr {
			y = 0.225 + 0.05 + 0.05;
			text = "direction";
		};
		class HW_ArtiDistDescr : HW_ArtiXCoordUnitDescr {
			y = 0.225 + 0.05 + 0.05 + 0.05;
			text = "distance";
		};

		class HW_ArtiHeightSlider : MCC_RscSlider {
			style = MCCCT_SL_VERT;
			idc = BON_ARTY_HEIGHT;
			x = 0.8; y = 0.175;
			w = 0.035; h = 0.3;
		};
		class HW_ArtiSliderTitle : MCC_RscText {
			idc = -1;
			style = MCCST_MULTI;
			linespacing = 1.00000;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			x = 0.8 - 0.025; y = 0.175 + 0.05;
			w = 0.03; h = 0.18;
			sizeEx = 0.03;
			text = "Height";
		};
		class HW_ArtiSliderDescr : MCC_RscText {
			idc = BON_ARTY_HEIGHTINDEX;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			x = 0.785; y = 0.175 + 0.295;
			w = 0.045; h = 0.05;
			sizeEx = 0.025;
			text = "";
		};

		class HW_ArtiType : MCC_RscCombo {
			idc = BON_ARTY_TYPE;
			style = MCCST_LEFT;
			colorText[] = { 1, 1, 1, 1 };
			colorSelect[] = { 1.0, 0.35, 0.3, 1 };
			colorSelectBackground[] = { 0, 0, 0, 1 };
			sizeEx = 0.028;
			x = 0.425; y = 0.57;
			w = 0.15; h = 0.028;
		};
		class HW_ArtiNrShells : HW_ArtiType {
			idc = BON_ARTY_NRSHELLS;
			y = 0.57 + 0.05;
		};
		class HW_ArtiSpread : HW_ArtiType {
			idc = BON_ARTY_SPREAD;
			y = 0.57 + 0.05 + 0.05;
		};
		class HW_ArtiMission : HW_ArtiType {
			idc = BON_ARTY_MISSIONTYPE;
			y = 0.57 + 0.05 + 0.05 + 0.05;
		};

		class HW_ArtiTypeTitle : MCC_RscText {
			idc = -1;
			style = MCCST_LEFT;
			colorBackground[] = { 1, 1, 1, 0 };
			colorText[] = { 1, 1, 1, 1 };
			x = 0.3; y = 0.57 - 0.015;
			w = 0.22; h = 0.05;
			sizeEx = 0.03;
			text = "Type:";
		};
		class HW_ArtiNrShellsTitle : HW_ArtiTypeTitle {
			y = 0.57 - 0.015 + 0.05;
			text = "Nr. Shells:";
		};
		class HW_ArtiSpreadTitle : HW_ArtiTypeTitle {
			y = 0.57 - 0.015 + 0.05 + 0.05;
			text = "Spread:";
		};
		class HW_ArtiMissionTitle : HW_ArtiTypeTitle {
			y = 0.57 - 0.015 + 0.05 + 0.05 + 0.05;
			text = "Fire:";
		};



		class HW_ArtiDelayDescr : HW_ArtiTextField {
			x = 0.63; y = 0.5375;
			w = 0.125;
			text = "delay in sec.";
		};
		class HW_ArtiDelayunit : HW_ArtiXCoordunit {
			idc = BON_ARTY_DELAYEDIT;
			x = 0.63 + 0.145; y = 0.545;
		};
		class HW_ArtiConfirmButton : MCC_RscButton {
			idc = -1;
			colorDisabled[] = {1, 0.4, 0.3, 0.8};
			x = 0.75; y = 0.6;
			w = 0.105825; h = 0.0422876;
			size = 0.02821;
			sizeEx = 0.02821;
			text = "Confirm";
			onButtonClick = __EVAL("[] execVM '"+MCCPATH+"bon_artillery\bon_arti_setup.sqf'");
		};
		class HW_ArtiClearButton : HW_ArtiConfirmButton {
			x = 0.75 - 0.125;
			text = "Reset";
			onButtonClick = __EVAL("[] execVM '"+MCCPATH+"bon_artillery\bon_arti_clearcannons.sqf'");
		};
		class HW_artiCoordApplyButton : MCC_RscButton {
			idc = -1;
			x = 0.3; y = 0.1725 + 0.05;
			w = 0.225; h = 0.15;
			colorText[] = { 0, 0, 0, 0 };
			colorFocused[] = { 0, 0, 0, 0 };
			colorDisabled[] = { 0, 0, 0, 0 };
			colorBackground[] = { 0, 0, 0, 0 };
			colorBackgroundDisabled[] = { 0, 0, 0, 0 };
			colorBackgroundActive[] = { 0, 0, 0, 0 };
			colorShadow[] = { 0, 0, 0, 0 };
			colorBorder[] = { 0, 0, 0, 0 };
			text = "Copy Position";
			onButtonClick = __EVAL("[] execVM '"+MCCPATH+"bon_artillery\dialog\apply_pos.sqf'");			
		};

		class HW_RequestButton : MCC_RscButton {
			idc = BON_ARTY_REQUESTBUTTON;
			colorDisabled[] = {1, 0.4, 0.3, 0.8};
			x = 0.7; y = 0.82;
			text = "Execute";
			onButtonClick = __EVAL("player execVM '"+MCCPATH+"bon_artillery\bon_arti_request.sqf'");
		};
		class HW_CancelButton : HW_RequestButton {
			idc = -1;
			x = 0.7 - 0.2;
			text = "Cancel";
			onButtonClick = __EVAL("player execVM '"+MCCPATH+"bon_artillery\bon_arti_cancle.sqf'");
		};


		class HW_ArtiXCorrTitle : HW_ArtiTextField {
			x = 0.6; y = 0.73;
			w = 0.2;
			sizeEx = 0.028;
			text = "Corr. left-right";
		};
		class HW_ArtiRightCorrection : MCC_RscButton {
			idc = -1;
			x = 0.85; y = 0.735;
			w = 0.025; h = 0.025;
			text = ">";
			onButtonClick = __EVAL("'Right' execVM '"+MCCPATH+"bon_artillery\bon_arti_correction.sqf'");
		};
		class HW_ArtiXCorrectionunit : HW_ArtiXCoordunit {
			idc = BON_ARTY_XCORRECTION;
			style = MCCST_CENTER;
			x = 0.775; y = 0.735;
			text = "0";
		};
		class HW_ArtiLeftCorrection : HW_ArtiRightCorrection {
			x = 0.74; y = 0.735;
			text = "<";
			onButtonClick = __EVAL("'Left' execVM '"+MCCPATH+"bon_artillery\bon_arti_correction.sqf'");
		};

		class HW_ArtiYCorrTitle : HW_ArtiTextField {
			x = 0.6; y = 0.675;
			w = 0.2;
			sizeEx = 0.028;
			text = "Corr. distance";
		};
		class HW_ArtiUpCorrection : HW_ArtiRightCorrection {
			x = 0.85; y = 0.68;
			text = "+";
			onButtonClick = __EVAL("'Up' execVM '"+MCCPATH+"bon_artillery\bon_arti_correction.sqf'");
		};
		class HW_ArtiYCorrectionunit : HW_ArtiXCoordunit {
			idc = BON_ARTY_YCORRECTION;
			style = MCCST_CENTER;
			x = 0.775; y = 0.68;
			text = "0";
		};
		class HW_ArtiDownCorrection : HW_ArtiRightCorrection {
			x = 0.74; y = 0.68;
			text = "-";
			onButtonClick = __EVAL("'Down' execVM '"+MCCPATH+"bon_artillery\bon_arti_correction.sqf'");
		};
	};
};