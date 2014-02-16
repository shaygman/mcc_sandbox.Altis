// By: Shay_gman
// Version: 1.1 (April 2012)
#define groupGen_IDD 2994
#define MCC_MINIMAP 9000

#define MCC_FACTION 8008
#define UNIT_TYPE 3010
#define UNIT_CLASS 3011
#define MCC_GGUNIT_TYPE 3012
#define MCC_GGUNIT_BEHAVIOR 3030
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

#define MCC_GGListBoxIDC 3013
#define MCC_GGADDIDC 3014
#define MCC_GGCLEARIDC 3015
#define MCC_GGUNIT_EMPTY 3016
#define MCC_GGUNIT_EMPTYTITLE 3017
#define mcc_groupGen_CurrentgroupNameTittle_IDC 3018
#define mcc_groupGen_CurrentgroupNameText_IDC 3019
#define MCC_GGSAVE_GROUPIDC 3020

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
	mcc_groupGen_factionTittle,
	mcc_groupGen_factionComboBox,
	mcc_groupGen_typeTittle,
	mcc_groupGen_typeComboBox,
	mcc_groupGen_branchTittle,
	mcc_groupGen_branchComboBox,
	mcc_groupGen_classTittle,
	mcc_groupGen_classComboBox,
	mcc_groupGen_BehaviorComboBox,
	mcc_groupGen_BehaviorTittle,
	mcc_groupGen_EmptyTittle,
	mcc_groupGen_EmptyComboBox,
	mcc_groupGen_CurrentgroupListBox,
	mcc_groupGen_CurrentgroupNameTittle,
	mcc_groupGen_CurrentgroupNameText,
	mcc_groupGen_classAddButton,
	mcc_groupGen_groupListBoxCreaterButton,
	mcc_groupGen_groupListSaveButton,
	mcc_groupGen_groupListBoxClearButton,
	mcc_groupGen_groupListBoxAddToZoneButton,
	closeGeneratorButton,

	mcc_groupGen_AllButton,
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
		
		x = 0.104687 * safezoneW + safezoneX;
		y = 0.0381804 * safezoneH + safezoneY;
		w = 0.836458 * safezoneW;
		h = 0.802687 * safezoneH;
	};
	class mcc_groupGen_groupsframe: MCC_RscFrame 
	{
		idc = -1;
		
		x = 0.104687 * safezoneW + safezoneX;
		y = 0.0381804 * safezoneH + safezoneY;
		w = 0.836458 * safezoneW;
		h = 0.802687 * safezoneH;
	};
	
	class mcc_groupGen_CurrentgroupListBoxFrame: MCC_RscText 
	{
		idc = MCC_GGListBoxIDC;
		
		x = 0.373958 * safezoneW + safezoneX;
		y = 0.620953 * safezoneH + safezoneY;
		w = 0.0973958 * safezoneW;
		h = 0.120953 * safezoneH;
			
		colorBackground[] = { 0, 0, 0, 0.6 };
		colorText[] = { 1, 1, 1, 1 };
		text = "";
	};
//===========================================Map==============================================
	class MCC_mapBackground : MCC_RscText 
	{
		idc = -1;
		
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.093159 * safezoneH + safezoneY;
		w = 0.676042 * safezoneW;
		h = 0.472816 * safezoneH;
		
		colorBackground[] = { 1, 1, 1, 1}; 
		colorText[] = { 1, 1, 1, 0};
		text = "";
	};
		
	class MCC_map : MCC_RscMapControl 
	{
		idc = MCC_MINIMAP; 
		
		x = 0.184896 * safezoneW + safezoneX;
		y = 0.0931586 * safezoneH + safezoneY;
		w = 0.676042 * safezoneW;
		h = 0.472816 * safezoneH;
		
		text = "";
		onMouseButtonDown = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\mouseDown.sqf'");
		onMouseButtonUp = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\mouseUp.sqf'");
		onMouseButtonDblClick = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\mouseDblClick.sqf'");
		onMouseMoving = __EVAL("[_this] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\mouseMoving.sqf'");
	};
 //========================================= Controls========================================
	//Tittle
	
	//Faction
	class mcc_groupGen_factionTittle: MCC_RscText 
	{
		idc = -1;
		
		text = "Faction:";
		colorText[] = {0,1,1,1};
		colorBackground[] = { 1, 1, 1, 0 };
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		
		x = 0.121875 * safezoneW + safezoneX;
		y = 0.57697 * safezoneH + safezoneY;
		w = 0.0431042 * safezoneW;
		h = 0.0219914 * safezoneH;
	};
	
	class mcc_groupGen_factionComboBox: MCC_RscCombo 
	{
		idc = MCC_FACTION;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		onLBSelChanged = __EVAL("[5] execVM '"+MCCPATH+"mcc\pop_menu\faction.sqf'");
			
		x = 0.173438 * safezoneW + safezoneX;
		y = 0.57697 * safezoneH + safezoneY;
		w = 0.120313 * safezoneW;
		h = 0.0260715 * safezoneH;
	};
	
	//Type
	class mcc_groupGen_typeTittle: MCC_RscText 
	{
		idc = -1;
		
		text = "Type:";
		colorText[] = {0,1,1,1};
		colorBackground[] = { 1, 1, 1, 0 };
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		
		x = 0.121875 * safezoneW + safezoneX;
		y = 0.609957 * safezoneH + safezoneY;
		w = 0.0431042 * safezoneW;
		h = 0.0219914 * safezoneH;
	};
	
	class  mcc_groupGen_typeComboBox: MCC_RscCombo
	{
		idc = MCC_GGUNIT_TYPE;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		onLBSelChanged = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_change.sqf'");

		x = 0.173438 * safezoneW + safezoneX;
		y = 0.609957 * safezoneH + safezoneY;
		w = 0.120313 * safezoneW;
		h = 0.0260715 * safezoneH;
	};
	
	class mcc_groupGen_BranchTittle: MCC_RscText
	{
		idc = -1;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";

		text = "Branch:"; //--- ToDo: Localize;
		x = 0.121875 * safezoneW + safezoneX;
		y = 0.642944 * safezoneH + safezoneY;
		w = 0.0431042 * safezoneW;
		h = 0.0219914 * safezoneH;
		colorText[] = {0,1,1,1};
		colorBackground[] = {1,1,1,0};
	};
	
	class mcc_groupGen_branchComboBox: MCC_RscCombo 
	{
		idc = UNIT_TYPE;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		
		onLBSelChanged=__EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_change.sqf'");
		
		x = 0.173438 * safezoneW + safezoneX;
		y = 0.642944 * safezoneH + safezoneY;
		w = 0.120313 * safezoneW;
		h = 0.0260715 * safezoneH;
	};
	
	//Class
	class mcc_groupGen_classTittle: MCC_RscText 
	{
		idc = -1;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		
		text = "Class:";
		colorText[] = {0,1,1,1};
		colorBackground[] = { 1, 1, 1, 0 };
		
		x = 0.121875 * safezoneW + safezoneX;
		y = 0.675931 * safezoneH + safezoneY;
		w = 0.0431042 * safezoneW;
		h = 0.0219914 * safezoneH;
	};
	
	class mcc_groupGen_classComboBox: MCC_RscCombo 
	{
		idc = UNIT_CLASS;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		
		x = 0.173438 * safezoneW + safezoneX;
		y = 0.675931 * safezoneH + safezoneY;
		w = 0.120313 * safezoneW;
		h = 0.0260715 * safezoneH;
	};
	
	//Behavior
	class mcc_groupGen_BehaviorTittle: MCC_RscText 
	{
		idc = -1;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		
		text = "Behavior:";
		colorText[] = {0,1,1,1};
		colorBackground[] = { 1, 1, 1, 0 };
		
		x = 0.121875 * safezoneW + safezoneX;
		y = 0.708919 * safezoneH + safezoneY;
		w = 0.0431042 * safezoneW;
		h = 0.0219914 * safezoneH;
	};
	
	class mcc_groupGen_BehaviorComboBox: MCC_RscCombo 
	{
		idc = MCC_GGUNIT_BEHAVIOR;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		
		x = 0.173438 * safezoneW + safezoneX;
		y = 0.708919 * safezoneH + safezoneY;
		w = 0.120313 * safezoneW;
		h = 0.0260715 * safezoneH;
	};
	
	//Empty
	class mcc_groupGen_EmptyTittle: MCC_RscText 
	{
		idc = MCC_GGUNIT_EMPTYTITLE;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		
		text = "Empty:";
		colorText[] = {0,1,1,1};
		colorBackground[] = { 1, 1, 1, 0 };
		
		x = 0.121875 * safezoneW + safezoneX;
		y = 0.741906 * safezoneH + safezoneY;
		w = 0.0431042 * safezoneW;
		h = 0.0219914 * safezoneH;
	};
	
	class mcc_groupGen_EmptyComboBox: MCC_RscCombo 
	{
		idc = MCC_GGUNIT_EMPTY;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		
		x = 0.173438 * safezoneW + safezoneX;
		y = 0.741906 * safezoneH + safezoneY;
		w = 0.120313 * safezoneW;
		h = 0.0260715 * safezoneH;
	};
	
	class closeGeneratorButton: MCC_RscButton
	{
		idc = -1;
		
		text = "Close";
		action = "MCC_mcc_screen=0; closeDialog 0; {deletemarkerlocal _x;} foreach MCC_groupGenTempWP;{deletemarkerlocal _x;} foreach MCC_groupGenTempWPLines;";
		
		x = 0.838021 * safezoneW + safezoneX;
		y = 0.796884 * safezoneH + safezoneY;
		w = 0.0984375 * safezoneW;
		h = 0.035 * safezoneH;	
	};
	
	
	
	//Current Group
	class mcc_groupGen_CurrentgroupListBox: MCC_RscListBox 
	{
		idc = MCC_GroupGenCurrentGroup_IDD;
		
		x = 0.373958 * safezoneW + safezoneX;
		y = 0.620953 * safezoneH + safezoneY;
		w = 0.0973958 * safezoneW;
		h = 0.120953 * safezoneH;
	};
	
	class mcc_groupGen_CurrentgroupNameTittle: MCC_RscText
	{
		idc = mcc_groupGen_CurrentgroupNameTittle_IDC;
		text = "Name:"; //--- ToDo: Localize;
		x = 0.373958 * safezoneW + safezoneX;
		y = 0.57697 * safezoneH + safezoneY;
		w = 0.034375 * safezoneW;
		h = 0.0329871 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class mcc_groupGen_CurrentgroupNameText: MCC_RscText
	{
		idc = mcc_groupGen_CurrentgroupNameText_IDC;
		type = MCCCT_EDIT;
		
		x = 0.408333 * safezoneW + safezoneX;
		y = 0.57697 * safezoneH + safezoneY;
		w = 0.0630208 * safezoneW;
		h = 0.0329871 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class mcc_groupGen_classAddButton: MCC_RscButton 
	{
		idc = MCC_GGADDIDC;
		
		text = "Add";
		tooltip = "Add the selected unit to the list"; 
		
		x = 0.299479 * safezoneW + safezoneX;
		y = 0.57697 * safezoneH + safezoneY;
		w = 0.065625 * safezoneW;
		h = 0.035 * safezoneH;
		
		onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_change.sqf'");
	};
	
	class mcc_groupGen_groupListBoxClearButton: MCC_RscButton 
	{
		idc = MCC_GGCLEARIDC;
		
		text = "Clear";
		onButtonClick = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_change.sqf'");
		tooltip = "Remove all units from the list"; 
		
		x = 0.299479 * safezoneW + safezoneX;
		y = 0.620953 * safezoneH + safezoneY;
		w = 0.065625 * safezoneW;
		h = 0.035 * safezoneH;
	};
	
	class mcc_groupGen_groupListSaveButton: MCC_RscButton
	{
		idc = MCC_GGSAVE_GROUPIDC;
		onButtonClick = __EVAL("[4] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_change.sqf'");

		text = "Save as Custom"; //--- ToDo: Localize;
		x = 0.299479 * safezoneW + safezoneX;
		y = 0.664936 * safezoneH + safezoneY;
		w = 0.065625 * safezoneW;
		h = 0.035 * safezoneH;
		tooltip = "Save the group as a custom group"; //--- ToDo: Localize;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	};

	
	class mcc_groupGen_groupListBoxCreaterButton: MCC_RscButton 
	{
		idc = -1;
		
		text = "Create";
		tooltip = "Mouse click on the map to create the group - AI behavior will be ignored"; 
		onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\spawn_request.sqf'");
		
		x = 0.299479 * safezoneW + safezoneX;
		y = 0.708919 * safezoneH + safezoneY;
		w = 0.065625 * safezoneW;
		h = 0.035 * safezoneH;
	};
	
	class mcc_groupGen_groupListBoxAddToZoneButton: MCC_RscButton 
	{
		idc = -1;
		
		text = "Add to zone";
		tooltip = "Create the group in the selected zone"; 
		onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\spawn_request.sqf'");
		
		x = 0.299479 * safezoneW + safezoneX;
		y = 0.752901 * safezoneH + safezoneY;
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
		
		x = 0.666146 * safezoneW + safezoneX;
		y = 0.565974 * safezoneH + safezoneY;
		w = 0.0458333 * safezoneW;
		h = 0.0329871 * safezoneH;
	};
	
	class mcc_groupGen_EastButton: MCC_RscButton 
	{
		idc = -1;
		
		text = "East";
		colorText[] = {1,0,0,1};
		onButtonClick = __EVAL("[east] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_manage.sqf'");
		
		x = 0.717708 * safezoneW + safezoneX;
		y = 0.565974 * safezoneH + safezoneY;
		w = 0.0458333 * safezoneW;
		h = 0.0329871 * safezoneH;	
	};
	
	class mcc_groupGen_GuerButton: MCC_RscButton 
	{
		idc = -1;
		
		text = "Guer";
		colorText[] = {0,1,0,1};
		onButtonClick = __EVAL("[resistance] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_manage.sqf'");
		
		x = 0.769271 * safezoneW + safezoneX;
		y = 0.565974 * safezoneH + safezoneY;
		w = 0.0458333 * safezoneW;
		h = 0.0329871 * safezoneH;
	};
	
	class mcc_groupGen_CivButton: MCC_RscButton 
	{
		idc = -1;
		
		text = "Civ";
		onButtonClick = __EVAL("[civilian] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_manage.sqf'");
		
		x = 0.820833 * safezoneW + safezoneX;
		y = 0.565974 * safezoneH + safezoneY;
		w = 0.0458333 * safezoneW;
		h = 0.0329871 * safezoneH;
	};
	
	class mcc_groupGen_AllButton: MCC_RscButton
	{
		idc = -1;
		
		onButtonClick = __EVAL("[west,east,resistance,civilian] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_manage.sqf'");

		text = "All"; //--- ToDo: Localize;
		x = 0.614583 * safezoneW + safezoneX;
		y = 0.565974 * safezoneH + safezoneY;
		w = 0.0458333 * safezoneW;
		h = 0.0329871 * safezoneH;
	};
 };
