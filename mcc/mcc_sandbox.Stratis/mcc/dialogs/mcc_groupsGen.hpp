// By: Shay_gman
// Version: 1.1 (April 2012)
#define groupGen_IDD 2994
#define MCC_MINIMAP 9000

#define MCC_FACTION 8008
#define UNIT_TYPE 3010
#define UNIT_CLASS 3011

#define MCC_GroupGenCurrentGroup_IDD 9003
#define MCC_GroupGenWPType_IDD 9004
#define MCC_GroupGenWPConbatMode_IDD 9005
#define MCC_GroupGenWPFormation_IDD 9006
#define MCC_GroupGenWPSpeed_IDD 9007
#define MCC_GroupGenWPBehavior_IDD 9008
#define MCC_GroupGenWPcondition_IDD 9009
#define MCC_GroupGenGroups_IDD 9010
#define MCC_WPTimeout_IDD 9011
#define MCC_GroupGenWPStatment_IDD 9012



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
	mcc_groupGen_groupsframe,
	mcc_groupGen_Wpframe,
	mcc_groupGen_groupSpawnframe,
	mcc_groupGen_CurrentgroupListBoxFrame,
	mcc_groupGen_WPconditionTextBoxFrame,
	mcc_groupGen_GroupsListBoxFrame,
	mcc_groupGen_WPStatmentTextBoxFrame
  };
  

  //---------------------------------------------
  objects[] = 
  { 
  };
  
  controls[] = 
  {
  MCC_mapBackground,
  MCC_map,
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
  mcc_waypoints_tittle,		//WP
  mcc_groupGen_WPTypeTittle,
  mcc_groupGen_WPTypeComboBox,
  mcc_groupGen_WPCombatModeTittle,
  mcc_groupGen_WPCombatComboBox,
  mcc_groupGen_WPFormationTittle,
  mcc_groupGen_WPFormationComboBox,
  mcc_groupGen_WPSpeedTittle,
  mcc_groupGen_WPSpeedComboBox,
  mcc_groupGen_WPBehaviorTittle,
  mcc_groupGen_WPBehaviorComboBox,
  mcc_groupGen_WPconditionTittle,
  mcc_groupGen_WPconditionTextBox,
  mcc_groupGen_WPTimeoutTittle,
  mcc_groupGen_WPTimeoutCombobox,
  mcc_groupGen_WPStatmentTittle,
  mcc_groupGen_WPStatmentTextBox,
  mcc_groupGen_WPAddButton,
  mcc_groupGen_WPClearButton,
  closeGeneratorButton,
  mcc_groupGen_WestButton,
  mcc_groupGen_EastButton,
  mcc_groupGen_GuerButton,
  mcc_groupGen_CivButton,
  mcc_groupGen_GroupsTittle,
  mcc_groupGen_GroupsListBox
  };
  
 //========================================= Background========================================
	class mcc_groupGenPic: MCC_RscText	{idc = -1;text = "";colorBackground[] = { 0, 0, 0, 0.6 };x = 0.16 * safezoneW + safezoneX;y = 0.16 * safezoneH + safezoneY;	w = 0.7 * safezoneW;	h = 0.7 * safezoneH;};
	class mcc_groupGen_groupsframe: MCC_RscFrame {idc = -1;x = 0.54375 * safezoneW + safezoneX;y = 0.4825 * safezoneH + safezoneY;w = 0.30625 * safezoneW;	h = 0.3675 * safezoneH;};
	class mcc_groupGen_Wpframe: MCC_RscFrame {idc = -1;x = 0.171875 * safezoneW + safezoneX;y = 0.4825 * safezoneH + safezoneY;w = 0.371875 * safezoneW;	h = 0.3675 * safezoneH;};
	class mcc_groupGen_groupSpawnframe: MCC_RscFrame {idc = -1;x = 0.171875 * safezoneW + safezoneX;y = 0.1675 * safezoneH + safezoneY;w = 0.371875 * safezoneW;	h = 0.315 * safezoneH;};
	class mcc_groupGen_CurrentgroupListBoxFrame: MCC_RscText {idc = -1;x = 0.259375 * safezoneW + safezoneX;y = 0.3775 * safezoneH + safezoneY;w = 0.175 * safezoneW;h = 0.07 * safezoneH;moving = true;colorBackground[] = { 0, 0, 0, 0.6 };colorText[] = { 1, 1, 1, 0 };text = "";};
	class mcc_groupGen_WPconditionTextBoxFrame : MCC_RscText {idc = -1;x = 0.285 * safezoneW + safezoneX;y = 0.7975 * safezoneH + safezoneY;w = 0.175595 * safezoneW;h = 0.0420239 * safezoneH;sizeEx = 0.03;moving = true;colorBackground[] = { 0, 0, 0, 0.6 };colorText[] = { 1, 1, 1, 0 };text = "";};
	class mcc_groupGen_GroupsListBoxFrame : MCC_RscText {idc=-1;x = 0.554688 * safezoneW + safezoneX;y = 0.57 * safezoneH + safezoneY;w = 0.251563 * safezoneW;	h = 0.21 * safezoneH;moving = true;colorBackground[] = { 0, 0, 0, 0.6 };colorText[] = { 1, 1, 1, 0 };text = "";};
	class mcc_groupGen_WPStatmentTextBoxFrame : MCC_RscText {idc = -1;x = 0.38 * safezoneW + safezoneX;y = 0.62 * safezoneH + safezoneY;w = 0.15 * safezoneW;h = 0.06 * safezoneH;moving = true;colorBackground[] = { 0, 0, 0, 0.6 };colorText[] = { 1, 1, 1, 0 };text = "";};
 //===========================================Map==============================================
	class MCC_mapBackground : MCC_RscText {idc = -1; moving = true; colorBackground[] = { 1, 1, 1, 1}; colorText[] = { 1, 1, 1, 0};x = 0.54375 * safezoneW + safezoneX;y = 0.1675 * safezoneH + safezoneY;w = 0.30625 * safezoneW;h = 0.315 * safezoneH; text = "";};
	class MCC_map : MCC_RscMapControl {idc = MCC_MINIMAP; moving = true; x = 0.54375 * safezoneW + safezoneX;y = 0.1675 * safezoneH + safezoneY;w = 0.30625 * safezoneW;h = 0.315 * safezoneH;text = "";onMouseButtonDown = __EVAL("[_this] execVM '"+MCCPATH+"mcc\mouseDown.sqf'");
	onMouseButtonUp = __EVAL("[_this] execVM '"+MCCPATH+"mcc\mouseUp.sqf'");
	onMouseMoving = __EVAL("[_this] execVM '"+MCCPATH+"mcc\mouseMoving.sqf'");};
 //========================================= Controls========================================
	//Tittle
  	class mcc_groupGen_tittle: MCC_RscText {idc = -1;text = "Groups Generator";x = 0.357812 * safezoneW + safezoneX;y = 0.1675 * safezoneH + safezoneY;	w = 0.164063 * safezoneW;	h = 0.035 * safezoneH;	colorText[] = {0,1,1,1};colorBackground[] = { 1, 1, 1, 0 };};
	class mcc_waypoints_tittle: MCC_RscText {idc = -1;text = "Waypoints Generator";x = 0.335938 * safezoneW + safezoneX;y = 0.4825 * safezoneH + safezoneY;	w = 0.185937 * safezoneW;h = 0.035 * safezoneH;colorText[] = {0,1,1,1};colorBackground[] = { 1, 1, 1, 0 };};
	//Faction
	class mcc_groupGen_factionTittle: MCC_RscText {idc = -1;text = "Faction:";x = 0.19375 * safezoneW + safezoneX;y = 0.22 * safezoneH + safezoneY;w = 0.065625 * safezoneW;	h = 0.035 * safezoneH;	colorText[] = {0,1,1,1};colorBackground[] = { 1, 1, 1, 0 };};
	class mcc_groupGen_factionComboBox: MCC_RscCombo {idc = MCC_FACTION;x = 0.270313 * safezoneW + safezoneX;y = 0.22 * safezoneH + safezoneY;w = 0.0990328 * safezoneW;
													  h = 0.0260715 * safezoneH; onLBSelChanged = __EVAL("[5] execVM '"+MCCPATH+"mcc\pop_menu\faction.sqf'");};
		//Type
	class mcc_groupGen_typeTittle: MCC_RscText {idc = -1;text = "Type:";x = 0.19375 * safezoneW + safezoneX;y = 0.2725 * safezoneH + safezoneY;w = 0.065625 * safezoneW;h = 0.035 * safezoneH;colorText[] = {0,1,1,1};colorBackground[] = { 1, 1, 1, 0 };};
	class mcc_groupGen_typeComboBox: MCC_RscCombo {idc = UNIT_TYPE;x = 0.270313 * safezoneW + safezoneX;y = 0.2725 * safezoneH + safezoneY;w = 0.0990328 * safezoneW;h = 0.0260715 * safezoneH; onLBSelChanged=__EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_change.sqf'");};
	//Class
	class mcc_groupGen_classTittle: MCC_RscText {idc = -1;text = "Class:";x = 0.19375 * safezoneW + safezoneX;y = 0.325 * safezoneH + safezoneY;w = 0.065625 * safezoneW;h = 0.035 * safezoneH;colorText[] = {0,1,1,1};colorBackground[] = { 1, 1, 1, 0 };};
	class mcc_groupGen_classComboBox: MCC_RscCombo {idc = UNIT_CLASS;x = 0.270313 * safezoneW + safezoneX;y = 0.325 * safezoneH + safezoneY;w = 0.0990328 * safezoneW;h = 0.0260715 * safezoneH;};
	//Current Group
	class mcc_groupGen_CurrentGroupTittle: MCC_RscText {idc = -1;text = "Group:";x = 0.19375 * safezoneW + safezoneX;y = 0.3775 * safezoneH + safezoneY;w = 0.065625 * safezoneW;h = 0.035 * safezoneH;colorText[] = {0,1,1,1};colorBackground[] = { 1, 1, 1, 0 };};
	class mcc_groupGen_CurrentgroupListBox: MCC_RscListBox {idc = MCC_GroupGenCurrentGroup_IDD;x = 0.259375 * safezoneW + safezoneX;y = 0.3775 * safezoneH + safezoneY;w = 0.175 * safezoneW;h = 0.07 * safezoneH;};
	class mcc_groupGen_classAddButton: MCC_RscButton {idc = -1;text = "Add";x = 0.379687 * safezoneW + safezoneX;y = 0.325 * safezoneH + safezoneY;w = 0.065625 * safezoneW;	h = 0.035 * safezoneH; onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_change.sqf'");};
	class mcc_groupGen_groupListBoxClearButton: MCC_RscButton {idc = -1;text = "Clear";x = 0.445313 * safezoneW + safezoneX;y = 0.38 * safezoneH + safezoneY;	w = 0.065625 * safezoneW;	h = 0.035 * safezoneH; onButtonClick = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_change.sqf'");};
	class mcc_groupGen_groupListBoxCreaterButton: MCC_RscButton {idc = -1;text = "Create";x = 0.445313 * safezoneW + safezoneX;y = 0.43 * safezoneH + safezoneY;	w = 0.065625 * safezoneW;	h = 0.035 * safezoneH; onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\spawn_request.sqf'");};
	
	//=================================Waypoints=================================
	//WP Type
	class mcc_groupGen_WPTypeTittle: MCC_RscText {idc = -1;text = "WP Type:";x = 0.19375 * safezoneW + safezoneX;y = 0.535 * safezoneH + safezoneY;	w = 0.109375 * safezoneW;	h = 0.035 * safezoneH;	colorText[] = {0,1,1,1};colorBackground[] = { 1, 1, 1, 0 };};
	class mcc_groupGen_WPTypeComboBox: MCC_RscCombo {idc = MCC_GroupGenWPType_IDD;x = 0.285 * safezoneW + safezoneX;y = 0.535 * safezoneH + safezoneY;w = 0.075 * safezoneW;	h = 0.0260715 * safezoneH; sizeEx=0.025;};
	//Combat Mode
	class mcc_groupGen_WPCombatModeTittle: MCC_RscText {idc = -1;text = "Combat Mode:";x = 0.19375 * safezoneW + safezoneX;y = 0.5875 * safezoneH + safezoneY;	w = 0.109375 * safezoneW;	h = 0.035 * safezoneH;	colorText[] = {0,1,1,1};colorBackground[] = { 1, 1, 1, 0 };};
	class mcc_groupGen_WPCombatComboBox: MCC_RscCombo {idc = MCC_GroupGenWPConbatMode_IDD;x = 0.285 * safezoneW + safezoneX;y = 0.5875 * safezoneH + safezoneY;	w = 0.075 * safezoneW;	h = 0.0260715 * safezoneH; sizeEx=0.025;};
	//Formation
	class mcc_groupGen_WPFormationTittle: MCC_RscText {idc = -1;text = "Formation:";x = 0.19375 * safezoneW + safezoneX;y = 0.64 * safezoneH + safezoneY;	w = 0.109375 * safezoneW;	h = 0.035 * safezoneH;	colorText[] = {0,1,1,1};colorBackground[] = { 1, 1, 1, 0 };};
	class mcc_groupGen_WPFormationComboBox: MCC_RscCombo {idc = MCC_GroupGenWPFormation_IDD;x = 0.285 * safezoneW + safezoneX;y = 0.64 * safezoneH + safezoneY;w = 0.075 * safezoneW;	h = 0.0260715 * safezoneH; sizeEx=0.025;};
	//Speed
	class mcc_groupGen_WPSpeedTittle: MCC_RscText {idc = -1;text = "Speed:";x = 0.19375 * safezoneW + safezoneX;y = 0.6925 * safezoneH + safezoneY;w = 0.109375 * safezoneW;	h = 0.035 * safezoneH;	colorText[] = {0,1,1,1};colorBackground[] = { 1, 1, 1, 0 };};
	class mcc_groupGen_WPSpeedComboBox: MCC_RscCombo {idc = MCC_GroupGenWPSpeed_IDD;x = 0.285 * safezoneW + safezoneX;y = 0.6925 * safezoneH + safezoneY;w = 0.075 * safezoneW;	h = 0.0260715 * safezoneH; sizeEx=0.025;};
	//Behavior
	class mcc_groupGen_WPBehaviorTittle: MCC_RscText {idc = -1;text = "Behavior:";x = 0.19375 * safezoneW + safezoneX;y = 0.745 * safezoneH + safezoneY;	w = 0.109375 * safezoneW;	h = 0.035 * safezoneH;	colorText[] = {0,1,1,1};colorBackground[] = { 1, 1, 1, 0 };};
	class mcc_groupGen_WPBehaviorComboBox: MCC_RscCombo {idc = MCC_GroupGenWPBehavior_IDD;x = 0.285 * safezoneW + safezoneX;y = 0.745 * safezoneH + safezoneY;w = 0.075 * safezoneW;	h = 0.0260715 * safezoneH; sizeEx=0.025;};
	//Condition
	class mcc_groupGen_WPconditionTittle: MCC_RscText {idc = -1;text = "WP Condition:";x = 0.19375 * safezoneW + safezoneX;y = 0.7975 * safezoneH + safezoneY;	w = 0.109375 * safezoneW;	h = 0.035 * safezoneH;	colorText[] = {0,1,1,1};colorBackground[] = { 1, 1, 1, 0 };};
	class mcc_groupGen_WPconditionTextBox : MCC_RscText {idc = MCC_GroupGenWPcondition_IDD;type = MCCCT_EDIT;style = MCCST_MULTI;colorBackground[] = { 0, 0, 0, 0 };colorText[] = { 1, 1, 1, 1 };colorSelection[] = { 1, 1, 1, 1 };colorBorder[] = { 1, 1, 1, 1 };
		BorderSize = 0.01;autocomplete = true;x = 0.285 * safezoneW + safezoneX;y = 0.7975 * safezoneH + safezoneY;w = 0.175595 * safezoneW;h = 0.0420239 * safezoneH;sizeEx = 0.025;text = "true";};
	//Timeout
	class mcc_groupGen_WPTimeoutTittle: MCC_RscText {idc = -1;text = "TimeOut:";x = 0.37 * safezoneW + safezoneX;y = 0.535 * safezoneH + safezoneY;	w = 0.109375 * safezoneW;	h = 0.035 * safezoneH;	colorText[] = {0,1,1,1};colorBackground[] = { 1, 1, 1, 0 };};
	class mcc_groupGen_WPTimeoutCombobox: MCC_RscCombo {idc = MCC_WPTimeout_IDD;x = 0.45 * safezoneW + safezoneX;y = 0.535 * safezoneH + safezoneY;w = 0.075 * safezoneW;	h = 0.0260715 * safezoneH; sizeEx=0.025;};
	//Statment
	class mcc_groupGen_WPStatmentTittle: MCC_RscText {idc = -1;text = "WP Statment:";x = 0.37 * safezoneW + safezoneX;y = 0.5875 * safezoneH + safezoneY;	w = 0.109375 * safezoneW;	h = 0.035 * safezoneH;	colorText[] = {0,1,1,1};colorBackground[] = { 1, 1, 1, 0 };};
	class mcc_groupGen_WPStatmentTextBox : MCC_RscText {idc = MCC_GroupGenWPStatment_IDD;type = MCCCT_EDIT;style = MCCST_MULTI;colorBackground[] = { 0, 0, 0, 0 };colorText[] = { 1, 1, 1, 1 };colorSelection[] = { 1, 1, 1, 1 };colorBorder[] = { 1, 1, 1, 1 };
		BorderSize = 0.01;autocomplete = true;x = 0.38 * safezoneW + safezoneX;y = 0.62 * safezoneH + safezoneY;w = 0.15 * safezoneW;h = 0.06 * safezoneH;sizeEx = 0.025;text = "";};
	//Controls
	class mcc_groupGen_WPAddButton: MCC_RscButton {idc = -1;text = "Add WP";x = 0.37 * safezoneW + safezoneX;y = 0.745 * safezoneH + safezoneY;	w = 0.065625 * safezoneW;	h = 0.035 * safezoneH; onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\spawn_request.sqf'");};
	class mcc_groupGen_WPClearButton: MCC_RscButton {idc = -1;text = "Clear WP";x = 0.45625 * safezoneW + safezoneX;y = 0.745 * safezoneH + safezoneY;	w = 0.065625 * safezoneW;	h = 0.035 * safezoneH; onButtonClick = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\spawn_request.sqf'");};
	class closeGeneratorButton: MCC_RscButton{idc = -1;text = "Close";x = 0.696875 * safezoneW + safezoneX;y = 0.7975 * safezoneH + safezoneY;w = 0.0984375 * safezoneW;h = 0.035 * safezoneH;	action = "MCC_mcc_screen=0; closeDialog 0; {deletemarkerlocal _x;} foreach MCC_groupGenTempWP;{deletemarkerlocal _x;} foreach MCC_groupGenTempWPLines;{deletemarkerlocal _x} foreach MCC_groupGenTempWP;{deletemarkerlocal _x} foreach MCC_groupGenTempWPLines;";};
	//Map
	class mcc_groupGen_WestButton: MCC_RscButton {idc = -1;text = "West";x = 0.54375 * safezoneW + safezoneX;y = 0.4825 * safezoneH + safezoneY;w = 0.065625 * safezoneW;	h = 0.035 * safezoneH;	colorText[] = {0,0,1,1};onButtonClick = __EVAL("[1,0] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_manage.sqf'");};
	class mcc_groupGen_EastButton: MCC_RscButton {idc = -1;text = "East";x = 0.620313 * safezoneW + safezoneX;y = 0.4825 * safezoneH + safezoneY;w = 0.065625 * safezoneW;	h = 0.035 * safezoneH;	colorText[] = {1,0,0,1};onButtonClick = __EVAL("[1,1] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_manage.sqf'");};
	class mcc_groupGen_GuerButton: MCC_RscButton {idc = -1;text = "Guer";x = 0.696875 * safezoneW + safezoneX;y = 0.4825 * safezoneH + safezoneY;w = 0.065625 * safezoneW;	h = 0.035 * safezoneH;	colorText[] = {0,1,0,1};onButtonClick = __EVAL("[1,2] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_manage.sqf'");};
	class mcc_groupGen_CivButton: MCC_RscButton {idc = -1;text = "Civ";x = 0.773438 * safezoneW + safezoneX;y = 0.4825 * safezoneH + safezoneY;	w = 0.065625 * safezoneW;	h = 0.035 * safezoneH;onButtonClick = __EVAL("[1,3] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_manage.sqf'");};
	//Groups
	class mcc_groupGen_GroupsTittle: MCC_RscText {idc = -1;	text = "Groups:";	x = 0.554688 * safezoneW + safezoneX;	y = 0.535 * safezoneH + safezoneY;	w = 0.065625 * safezoneW;	h = 0.035 * safezoneH;	colorText[] = {0,1,1,1};colorBackground[] = { 1, 1, 1, 0 };};
	class mcc_groupGen_GroupsListBox : MCC_RscListBox {idc=MCC_GroupGenGroups_IDD; 	x = 0.554688 * safezoneW + safezoneX;
																					y = 0.57 * safezoneH + safezoneY;
																					w = 0.251563 * safezoneW;
																					h = 0.21 * safezoneH;
																					onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\group_manage.sqf'");};
 };
