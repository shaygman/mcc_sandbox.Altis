// By: Shay_gman
// Version: 1.1 (February 2011)
#define boxGen_IDD 2995

#define ALLGEAR_IDD 8500
#define BOXGEAR_IDD 8501
#define GEARCLASS_IDD 8502

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class boxGen {
  idd = boxGen_IDD;
  movingEnable = true;
  onLoad = __EVAL("[] execVM '"+MCCPATH+"mcc\dialogs\mcc_boxGen_init.sqf'"); 
  
  controlsBackground[] = 
  {
	MCC_Bckgrnd,
	allGearBackground,
	boxGearBackground
  };
  

  //---------------------------------------------
  objects[] = 
  { 
  };
  
  controls[] = 
  {
  allGearList,
  boxGearList,
  boxGeneratorTittle,
  gearClassTitle,
  gearClasCombo,
  addAllButton,
  addOneButton,
  removeOneButtton,
  generateBoxButton,
  boxGeneratorFrame,
  closeGeneratorButton
  };
  
 //========================================= Background========================================
	class MCC_Bckgrnd : MCC_RscText {
		idc = -1; 
		moving = true;
		colorBackground[] = { 0, 0, 0, 0.6 };
		x = 0.273698 * safezoneW + safezoneX;
		y = 0.238962 * safezoneH + safezoneY;
		w = 0.435417 * safezoneW;
		h = 0.55 * safezoneH;
		text = "";
		};
	class allGearBackground : MCC_RscText {
		idc = -1;
		moving = true;
		colorBackground[] = { 0, 0, 0, 0.6 };
		colorText[] = { 1, 1, 1, 0 };
		x = 0.292375 * safezoneW + safezoneX;
		y = 0.32143 * safezoneH + safezoneY;
		w = 0.171875 * safezoneW;
		h = 0.38485 * safezoneH;
		text = "";
		};
	class boxGearBackground : MCC_RscText {
		idc = -1;
		moving = true;
		colorBackground[] = { 0, 0, 0, 0.6 };
		colorText[] = { 1, 1, 1, 0 };
		x = 0.505729 * safezoneW + safezoneX;
		y = 0.32143 * safezoneH + safezoneY;
		w = 0.177604 * safezoneW;
		h = 0.38485 * safezoneH;
		text = "";
		};
	class boxGeneratorFrame: MCC_RscFrame{
		idc = -1;
		x = 0.273698 * safezoneW + safezoneX;
		y = 0.238962 * safezoneH + safezoneY;
		w = 0.435417 * safezoneW;
		h = 0.55 * safezoneH;
		};
 //========================================= Controls========================================
  	class allGearList: MCC_RscListBox {
		idc = ALLGEAR_IDD;
		x = 0.292375 * safezoneW + safezoneX;
		y = 0.32143 * safezoneH + safezoneY;
		w = 0.171875 * safezoneW;
		h = 0.38485 * safezoneH;
		sizeEx =0.035;
		};
	class boxGearList: MCC_RscListBox {
		idc = BOXGEAR_IDD;
		x = 0.505729 * safezoneW + safezoneX;
		y = 0.32143 * safezoneH + safezoneY;
		w = 0.177604 * safezoneW;
		h = 0.38485 * safezoneH;
		sizeEx =0.035;
		};
	class gearClasCombo: MCC_RscCombo{
		idc = GEARCLASS_IDD;
		x = 0.325833 * safezoneW + safezoneX;
		y = 0.280086 * safezoneH + safezoneY;
		w = 0.0916667 * safezoneW;
		h = 0.0175931 * safezoneH;
		sizeEx =0.028;
		style = MCCST_LEFT;
		colorText[] = { 1, 1, 1, 1 };
		colorSelect[] = { 1.0, 0.35, 0.3, 1 };
		colorBackground[] = { 0, 0, 0, 0.6 };
		colorSelectBackground[] = { 0, 0, 0, 1 };
		onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\dialogs\mcc_boxGen_change.sqf'");
		};
	//Tittles
	class boxGeneratorTittle: MCC_RscText {
		idc = -1;
		text = "Box Generator:";
		x = 0.292375 * safezoneW + safezoneX;
		y = 0.252596 * safezoneH + safezoneY;
		w = 0.1375 * safezoneW;
		h = 0.0226897 * safezoneH;
		sizeEx =0.06;
		colorText[] = {0,1,1,1};
		colorBackground[] = {1,1,1,0};
		};
	class gearClassTitle:MCC_RscText{
		idc = -1;
		text = "Class:";
		x = 0.292375 * safezoneW + safezoneX;
		y = 0.280086 * safezoneH + safezoneY;
		w = 0.0362846 * safezoneW;
		h = 0.0226897 * safezoneH;
		sizeEx =0.03;
		colorText[] = {1,1,1,1};
		colorBackground[] = {1,1,1,0};
		};
	//Buttons
	class addAllButton: MCC_RscButton{
		idc = -1;
		text = ">>";
		x = 0.471354 * safezoneW + safezoneX;
		y = 0.434026 * safezoneH + safezoneY;
		w = 0.0286458 * safezoneW;
		h = 0.0274893 * safezoneH;
		action =  __EVAL("[1] execVM '"+MCCPATH+"mcc\dialogs\mcc_boxGen_change.sqf'");
		tooltip = "Add current weapon and 6 magazines"; 
		};  
	class addOneButton: MCC_RscButton{
		idc = -1;
		text = ">";
		x = 0.471354 * safezoneW + safezoneX;
		y = 0.478009 * safezoneH + safezoneY;
		w = 0.0286458 * safezoneW;
		h = 0.0274893 * safezoneH;
		action =  __EVAL("[2] execVM '"+MCCPATH+"mcc\dialogs\mcc_boxGen_change.sqf'");
		tooltip = "Add current weapon"; 
		};  
	class removeOneButtton: MCC_RscButton{
		idc = -1;
		text = "Clear";
		x = 0.471354 * safezoneW + safezoneX;
		y = 0.521991 * safezoneH + safezoneY;
		w = 0.0286458 * safezoneW;
		h = 0.0274893 * safezoneH;
		action =  __EVAL("[3] execVM '"+MCCPATH+"mcc\dialogs\mcc_boxGen_change.sqf'");
		};  
	class generateBoxButton: MCC_RscButton{
		idc = -1;
		text = "Generate";
		x = 0.551563 * safezoneW + safezoneX;
		y = 0.719914 * safezoneH + safezoneY;
		w = 0.0572917 * safezoneW;
		h = 0.0274893 * safezoneH;
		action =  __EVAL("[4] execVM '"+MCCPATH+"mcc\dialogs\mcc_boxGen_change.sqf'");
		}; 
	class closeGeneratorButton: MCC_RscButton{
		idc = -1;
		text = "Close";
		x = 0.482812 * safezoneW + safezoneX;
		y = 0.719914 * safezoneH + safezoneY;
		w = 0.0572917 * safezoneW;
		h = 0.0274893 * safezoneH;
		action = "closeDialog 0;deleteVehicle tempBox";
		};
 };
