// By: Shay_gman
// Version: 1.1 (April 2012)
#define groupGen_IDD 2994
#define MCC_MINIMAP 9000

#define MCC_FACTION 8008
#define UNIT_TYPE 3010
#define UNIT_CLASS 3011
#define MCC_GroupGenCurrentGroup_IDD 9003
	
#define MCC_GroupGenInfoText_IDC 9013
#define MCC_GroupGenWPBckgr_IDC 9014
#define MCC_GroupGenWPCombo_IDC 9015
#define MCC_GroupGenWPformationCombo_IDC 9016
#define MCC_GroupGenWPspeedCombo_IDC 9017
#define MCC_GroupGenWPbehaviorCombo_IDC 9018
#define MCC_GroupGenWPAdd_IDC 9019
#define MCC_GroupGenWPReplace_IDC 9020
#define MCC_GroupGenWPClear_IDC 9021

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class mcc_groupGen {
  idd = groupGen_IDD;
  movingEnable = true;
  onLoad = __EVAL("[] execVM '"+MCCPATH+"mcc\dialogs\mcc_groupGen_init.sqf'"); 
  
  controlsBackground[] = 
  {
	mcc_groupGenPic,
	mcc_groupGen_CurrentgroupListBoxFrame,
	MCC_mapBackground,
	MCC_map
  };
  

  //---------------------------------------------
  objects[] = 
  { 
  };
  
  controls[] = 
  {
	mcc_groupGen_tittle,
	mcc_groupGen_factionTittle,
	mcc_groupGen_factionComboBox,
	mcc_groupGen_typeTittle,
	mcc_groupGen_typeComboBox,
	mcc_groupGen_classTittle,
	mcc_groupGen_classComboBox,
	mcc_groupGen_CurrentGroupTittle,
	mcc_groupGen_CurrentgroupListBox,
	mcc_groupGen_classAddButton,
	mcc_groupGen_groupListBoxCreaterButton,
	mcc_groupGen_groupListBoxClearButton,
	closeGeneratorButton,

	mcc_groupGen_WestButton,
	mcc_groupGen_EastButton,
	mcc_groupGen_GuerButton,
	mcc_groupGen_CivButton,

	MCC_GroupGenInfoText,	//WP
	MCC_GroupGenWPBckgr,
	MCC_GroupGenWPCombo,
	MCC_GroupGenWPformationCombo,
	MCC_GroupGenWPspeedCombo,
	MCC_GroupGenWPbehaviorCombo,
	MCC_GroupGenWPAdd,
	MCC_GroupGenWPReplace,
	MCC_GroupGenWPClear
  };
  
 //========================================= Background========================================
	class mcc_groupGenPic: MCC_RscText	
	{
		idc = -1;
		text = "";
		colorBackground[] = { 0, 0, 0, 0.6 };
		
		x = 0.161979 * safezoneW + safezoneX;
		y = 0.159133 * safezoneH + safezoneY;
		w = 0.7 * safezoneW;
		h = 0.7 * safezoneH;
	};
	class mcc_groupGen_groupsframe: MCC_RscFrame 
	{
		idc = -1;
		
		x = 0.161979 * safezoneW + safezoneX;
		y = 0.638986 * safezoneH + safezoneY;
		w = 0.698958 * safezoneW;
		h = 0.208919 * safezoneH;
	};
	
	class mcc_groupGen_CurrentgroupListBoxFrame: MCC_RscText 
	{
		idc = -1;
		
		x = 0.43125 * safezoneW + safezoneX;
		y = 0.664936 * safezoneH + safezoneY;
		w = 0.160417 * safezoneW;
		h = 0.164936 * safezoneH;
		
		colorBackground[] = { 0, 0, 0, 0.6 };
		colorText[] = { 1, 1, 1, 0 };
		text = "";
	};
//===========================================Map==============================================
	class MCC_mapBackground : MCC_RscText 
	{
		idc = -1;
		
		x = 0.167708 * safezoneW + safezoneX;
		y = 0.203116 * safezoneH + safezoneY;
		w = 0.6875 * safezoneW;
		h = 0.428833 * safezoneH;
		
		colorBackground[] = { 1, 1, 1, 1}; 
		colorText[] = { 1, 1, 1, 0};
		text = "";
	};
		
	class MCC_map : MCC_RscMapControl 
	{
		idc = MCC_MINIMAP; 
		
		x = 0.167708 * safezoneW + safezoneX;
		y = 0.203116 * safezoneH + safezoneY;
		w = 0.6875 * safezoneW;
		h = 0.428833 * safezoneH;
		
		text = "";
		onMouseButtonDown = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\mouseDown.sqf'");
		onMouseButtonUp = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\mouseUp.sqf'");
		onMouseButtonDblClick = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\mouseDblClick.sqf'");
		onMouseMoving = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\mouseMoving.sqf'");
	};
 //========================================= Controls========================================
	//Tittle
  	class mcc_groupGen_tittle: MCC_RscText 
	{
		idc = -1;
		
		text = "Groups Generator";
		colorText[] = {0,1,1,1};
		colorBackground[] = { 1, 1, 1, 0 };
		
		x = 0.442708 * safezoneW + safezoneX;
		y = 0.170129 * safezoneH + safezoneY;
		w = 0.164063 * safezoneW;
		h = 0.035 * safezoneH;	
	};
	
	//Faction
	class mcc_groupGen_factionTittle: MCC_RscText 
	{
		idc = -1;
		
		text = "Faction:";
		colorText[] = {0,1,1,1};
		colorBackground[] = { 1, 1, 1, 0 };
		
		x = 0.179167 * safezoneW + safezoneX;
		y = 0.675931 * safezoneH + safezoneY;
		w = 0.0630208 * safezoneW;
		h = 0.0219914 * safezoneH;	
	};
	
	class mcc_groupGen_factionComboBox: MCC_RscCombo 
	{
		idc = MCC_FACTION;
		
		onLBSelChanged = __EVAL("[5] execVM '"+MCCPATH+"mcc\pop_menu\faction.sqf'");
		
		x = 0.247917 * safezoneW + safezoneX;
		y = 0.675931 * safezoneH + safezoneY;
		w = 0.0990328 * safezoneW;
		h = 0.0260715 * safezoneH;
	};
	
	//Type
	class mcc_groupGen_typeTittle: MCC_RscText 
	{
		idc = -1;
		
		text = "Type:";
		colorText[] = {0,1,1,1};
		colorBackground[] = { 1, 1, 1, 0 };
		
		x = 0.179167 * safezoneW + safezoneX;
		y = 0.708919 * safezoneH + safezoneY;
		w = 0.0630208 * safezoneW;
		h = 0.0219914 * safezoneH;
	};
	
	class mcc_groupGen_typeComboBox: MCC_RscCombo 
	{
		idc = UNIT_TYPE;
		
		onLBSelChanged=__EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_change.sqf'");
		
		x = 0.247917 * safezoneW + safezoneX;
		y = 0.708919 * safezoneH + safezoneY;
		w = 0.0990328 * safezoneW;
		h = 0.0260715 * safezoneH;
	};
	
	//Class
	class mcc_groupGen_classTittle: MCC_RscText 
	{
		idc = -1;
		
		text = "Class:";
		colorText[] = {0,1,1,1};
		colorBackground[] = { 1, 1, 1, 0 };
		
		x = 0.179167 * safezoneW + safezoneX;
		y = 0.741906 * safezoneH + safezoneY;
		w = 0.0630208 * safezoneW;
		h = 0.0219914 * safezoneH;
	};
	
	class mcc_groupGen_classComboBox: MCC_RscCombo 
	{
		idc = UNIT_CLASS;
		
		x = 0.247917 * safezoneW + safezoneX;
		y = 0.741906 * safezoneH + safezoneY;
		w = 0.0990328 * safezoneW;
		h = 0.0260715 * safezoneH;
	};
	
	class closeGeneratorButton: MCC_RscButton
	{
		idc = -1;
		
		text = "Close";
		action = "MCC_mcc_screen=0; closeDialog 0; {deletemarkerlocal _x;} foreach MCC_groupGenTempWP;{deletemarkerlocal _x;} foreach MCC_groupGenTempWPLines;";
		
		x = 0.757813 * safezoneW + safezoneX;
		y = 0.80788 * safezoneH + safezoneY;
		w = 0.0984375 * safezoneW;
		h = 0.035 * safezoneH;			
	};
	
	//Current Group
	class mcc_groupGen_CurrentGroupTittle: MCC_RscText 
	{
		idc = -1;
		
		text = "Group:";
		colorText[] = {0,1,1,1};
		colorBackground[] = { 1, 1, 1, 0 };
		
		x = 0.43125 * safezoneW + safezoneX;
		y = 0.642944 * safezoneH + safezoneY;
		w = 0.0630208 * safezoneW;
		h = 0.0219914 * safezoneH;
	};
	
	class mcc_groupGen_CurrentgroupListBox: MCC_RscListBox 
	{
		idc = MCC_GroupGenCurrentGroup_IDD;
		
		x = 0.43125 * safezoneW + safezoneX;
		y = 0.664936 * safezoneH + safezoneY;
		w = 0.160417 * safezoneW;
		h = 0.164936 * safezoneH;
	};
	class mcc_groupGen_classAddButton: MCC_RscButton 
	{
		idc = -1;
		
		text = "Add";
		
		x = 0.356771 * safezoneW + safezoneX;
		y = 0.741906 * safezoneH + safezoneY;
		w = 0.065625 * safezoneW;
		h = 0.035 * safezoneH; 
		
		onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_change.sqf'");
	};
	
	class mcc_groupGen_groupListBoxClearButton: MCC_RscButton 
	{
		idc = -1;
		
		text = "Clear";
		onButtonClick = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_change.sqf'");
		
		x = 0.603125 * safezoneW + safezoneX;
		y = 0.752901 * safezoneH + safezoneY;
		w = 0.065625 * safezoneW;
		h = 0.035 * safezoneH;
	};
	
	class mcc_groupGen_groupListBoxCreaterButton: MCC_RscButton 
	{
		idc = -1;
		
		text = "Create";
		onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\spawn_request.sqf'");
		
		x = 0.603125 * safezoneW + safezoneX;
		y = 0.796884 * safezoneH + safezoneY;
		w = 0.065625 * safezoneW;
		h = 0.035 * safezoneH; 
	};
	
	//=================================Waypoints=================================
	//InfoText
	class MCC_GroupGenInfoText: MCC_RscStructuredText
	{
		idc = MCC_GroupGenInfoText_IDC;
		x = 0.1 * safezoneW + safezoneX;
		y = 0.1 * safezoneH + safezoneY;
		w = 0.1 * safezoneW;
		h = 0.1 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.5)";
		colorBackground[] = {0,0,0,0.9};
	};
	class MCC_GroupGenWPBckgr: MCC_RscStructuredText
	{
		idc = MCC_GroupGenWPBckgr_IDC;
		x = 0.1 * safezoneW + safezoneX;
		y = 0.1 * safezoneH + safezoneY;
		w = 0.1 * safezoneW;
		h = 0.1 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.5)";
		colorBackground[] = {0,0,0,0.8};
	};
	class MCC_GroupGenWPCombo: MCC_RscCombo
	{
		idc = MCC_GroupGenWPCombo_IDC;
		x = 0.1 * safezoneW + safezoneX;
		y = 0.1 * safezoneH + safezoneY;
		w = 0.105 * safezoneW;
		h = 0.0280062 * safezoneH;
	};
	class MCC_GroupGenWPformationCombo: MCC_RscCombo
	{
		idc = MCC_GroupGenWPformationCombo_IDC;
		x = 0.1 * safezoneW + safezoneX;
		y = 0.1 * safezoneH + safezoneY;
		w = 0.105 * safezoneW;
		h = 0.0280062 * safezoneH;
	};
	class MCC_GroupGenWPspeedCombo: MCC_RscCombo
	{
		idc = MCC_GroupGenWPspeedCombo_IDC;
		x = 0.1 * safezoneW + safezoneX;
		y = 0.1 * safezoneH + safezoneY;
		w = 0.105 * safezoneW;
		h = 0.0280062 * safezoneH;
	};
	class MCC_GroupGenWPbehaviorCombo: MCC_RscCombo
	{
		idc = MCC_GroupGenWPbehaviorCombo_IDC;
		x = 0.1 * safezoneW + safezoneX;
		y = 0.1 * safezoneH + safezoneY;
		w = 0.105 * safezoneW;
		h = 0.0280062 * safezoneH;
	};
	class MCC_GroupGenWPAdd: MCC_RscButton {
		idc = MCC_GroupGenWPAdd_IDC;
		text = "ADD";
		x = 0.1 * safezoneW + safezoneX;
		y = 0.1 * safezoneH + safezoneY;
		w = 0.1 * safezoneW;
		h = 0.1 * safezoneH;
		tooltip = "Add a waypoint to all selected groups"; 
		onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\manageWP.sqf'");
	};
	class MCC_GroupGenWPReplace: MCC_RscButton {
		idc = MCC_GroupGenWPReplace_IDC;
		text = "Replace";
		x = 0.1 * safezoneW + safezoneX;
		y = 0.1 * safezoneH + safezoneY;
		w = 0.1 * safezoneW;
		h = 0.1 * safezoneH;
		tooltip = "Remove all waypoints from any selected groups and add a new waypoint"; 
		onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\manageWP.sqf'");
	};
	class MCC_GroupGenWPClear: MCC_RscButton {
		idc = MCC_GroupGenWPClear_IDC;
		text = "Clear";
		x = 0.1 * safezoneW + safezoneX;
		y = 0.1 * safezoneH + safezoneY;
		w = 0.1 * safezoneW;
		h = 0.1 * safezoneH;
		tooltip = "Remove all waypoints from any selected groups"; 
		onButtonClick = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\manageWP.sqf'");
	};
	 
	//Map
	class mcc_groupGen_WestButton: MCC_RscButton 
	{
		idc = -1;
		
		text = "West";
		colorText[] = {0,0,1,1};
		onButtonClick = __EVAL("[west] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_manage.sqf'");
		
		x = 0.620313 * safezoneW + safezoneX;
		y = 0.642944 * safezoneH + safezoneY;
		w = 0.0458333 * safezoneW;
		h = 0.0329871 * safezoneH;
	};
	
	class mcc_groupGen_EastButton: MCC_RscButton 
	{
		idc = -1;
		
		text = "East";
		colorText[] = {1,0,0,1};
		onButtonClick = __EVAL("[east] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_manage.sqf'");
		
		x = 0.671875 * safezoneW + safezoneX;
		y = 0.642944 * safezoneH + safezoneY;
		w = 0.0458333 * safezoneW;
		h = 0.0329871 * safezoneH;			
	};
	
	class mcc_groupGen_GuerButton: MCC_RscButton 
	{
		idc = -1;
		
		text = "Guer";
		colorText[] = {0,1,0,1};
		onButtonClick = __EVAL("[resistance] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_manage.sqf'");
		
		x = 0.723438 * safezoneW + safezoneX;
		y = 0.642944 * safezoneH + safezoneY;
		w = 0.0458333 * safezoneW;
		h = 0.0329871 * safezoneH;		
	};
	
	class mcc_groupGen_CivButton: MCC_RscButton 
	{
		idc = -1;
		
		text = "Civ";
		onButtonClick = __EVAL("[civilian] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_manage.sqf'");
		
		x = 0.775 * safezoneW + safezoneX;
		y = 0.642944 * safezoneH + safezoneY;
		w = 0.0458333 * safezoneW;
		h = 0.0329871 * safezoneH;
	};
 };
