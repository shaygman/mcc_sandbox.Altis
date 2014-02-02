// Made By: Shay_gman
// Version: 1.1 (February 2011)

//-----------------------------------------------------------------------------
// IDD's & IDC's
//-----------------------------------------------------------------------------
#define MCC3D_IDD 8000
#define MCC_FACTION 8008
#define MCC_UNIT_TYPE 8001
#define MCC_UNIT_CLASS 8002
#define MCC_NAMEBOX 8003 
#define MCC_INITBOX 8004 
#define MCC_PRESETS 8005
#define MCC_SETTING_EMPTY 8006
#define MCC_ZONE_LOC 8007

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class MCC3D_Dialog 
{
  idd = MCC3D_IDD;
  movingEnable = true;
  onLoad = __EVAL("[] execVM '"+MCCPATH+"mcc\dialogs\mcc_3d_init.sqf'");
  
  controlsBackground[] = 
  {
	MCC_pic,
	MCC_Bckgrnd,		//mcc background
	nameBackground,
	initBackground
  };
  

  //---------------------------------------------
  objects[] = 
  { 
  };
  
  controls[] = 
  {
  faction,
  factionTittle,
  mcc3DTitle,
  unit_type,
  unit_Class,
  UnitTitle,
  UnitTypeTitle,
  setting_Empty,
  EmptyTitle,
  change,
  Close_dialog,
  unitNameTitle,
  nameBox,
  initTitle,
  initBox,
  presetsTitle,
  presetsCombo,
  addPresetButton,
  Zone_Loc, // New
  Zone_LocTitle // New
  };
 //========================================= Background======================================
class MCC_pic : MCC_RscPicture {idc = -1; moving = true; x = 0.264 * safezoneW + safezoneX;
	y = 0.227 * safezoneH + safezoneY;
	w = 0.19 * safezoneW;
	h = 0.47 * safezoneH; text = __EVAL(MCCPATH +"mcc\dialogs\mcc_background.paa");
	colorBackground[] = {0,0,0,0.5};};
class MCC_Bckgrnd : MCC_RscText {idc = -1; moving = true; x = 0.282292 * safezoneW + safezoneX;
	y = 0.26909 * safezoneH + safezoneY;
	w = 0.160417 * safezoneW;
	h = 0.38485 * safezoneH; text = "";colorBackground[] = {0,0,0,0.7};};
class nameBackground : MCC_RscText {idc = -1;moving = true;colorBackground[] = { 0, 0, 0, 0.6 };colorText[] = { 1, 1, 1, 0 };x = 0.328125 * safezoneW + safezoneX;
	y = 0.478009 * safezoneH + safezoneY;
	w = 0.108854 * safezoneW;
	h = 0.0549786 * safezoneH;sizeEx = 0.028;text = "";};
class initBackground : nameBackground {idc = -1;x = 0.328125 * safezoneW + safezoneX;
	y = 0.478009 * safezoneH + safezoneY;
	w = 0.108854 * safezoneW;
	h = 0.0549786 * safezoneH;sizeEx = 0.028;text = "";};
 //========================================= Controls========================================
 
//-------------------------------------------ComboBox----------------------------------------
class faction : MCC_RscCombo {idc=MCC_FACTION; style=MCCST_LEFT; colorText[]={1,1,1,1};colorSelect[]={1.0,0.35,0.3,1};colorBackground[]={0,0,0,0.6};
							colorSelectBackground[]={0,0,0,1}; sizeEx=0.028;x = 0.328125 * safezoneW + safezoneX;
	y = 0.313073 * safezoneH + safezoneY;
	w = 0.108854 * safezoneW;
	h = 0.0219914 * safezoneH;
	onLBSelChanged = __EVAL("[4] execVM '"+MCCPATH+"mcc\pop_menu\faction.sqf'");};
class unit_type : faction {idc=MCC_UNIT_TYPE; x = 0.328125 * safezoneW + safezoneX;
	y = 0.34606 * safezoneH + safezoneY;
	w = 0.108854 * safezoneW;
	h = 0.0219914 * safezoneH; sizeEx=0.028; onLBSelChanged=__EVAL ("[0] execVM '"+MCCPATH+"mcc\pop_menu\group_change3d.sqf'");};
class unit_Class : faction {idc=MCC_UNIT_CLASS;x = 0.328125 * safezoneW + safezoneX;
	y = 0.379047 * safezoneH + safezoneY;
	w = 0.108854 * safezoneW;
	h = 0.0219914 * safezoneH; sizeEx=0.028;};
class setting_Empty : faction {idc=MCC_SETTING_EMPTY; x = 0.328125 * safezoneW + safezoneX;
	y = 0.412034 * safezoneH + safezoneY;
	w = 0.108854 * safezoneW;
	h = 0.0219914 * safezoneH;};
class nameBox : MCC_RscText {idc = MCC_NAMEBOX;type = MCCCT_EDIT;style = MCCST_MULTI;colorBackground[] = {0,0,0,0};colorText[] = {1,1,1,1};colorSelection[] = {1,1,1,1};colorBorder[] = { 1, 1, 1, 1 };
		BorderSize = 0.01;autocomplete = true;x = 0.328125 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.108854 * safezoneW;
	h = 0.0219914 * safezoneH;sizeEx = 0.028;text = "";};
class initBox : nameBox {idc = MCC_INITBOX;x = 0.328125 * safezoneW + safezoneX;
	y = 0.478009 * safezoneH + safezoneY;
	w = 0.108854 * safezoneW;
	h = 0.0549786 * safezoneH;sizeEx = 0.028;text = "";};
class presetsCombo : faction {idc=MCC_PRESETS;x = 0.328125 * safezoneW + safezoneX;
	y = 0.543983 * safezoneH + safezoneY;
	w = 0.06875 * safezoneW;
	h = 0.0219914 * safezoneH;};
//-------------------------------------------Titels-----------------------------------------
class factionTittle : MCC_RscText {idc = -1; style=MCCST_LEFT; colorBackground[]={1,1,1,0}; colorText[]={1,1,1,1};
	x = 0.288021 * safezoneW + safezoneX;
	y = 0.313073 * safezoneH + safezoneY;
	w = 0.0859375 * safezoneW;
	h = 0.0219914 * safezoneH;	sizeEx=0.03; text = "Faction:";};
class mcc3DTitle : factionTittle {colorText[]={0,1,1,1};x = 0.288021 * safezoneW + safezoneX;
	y = 0.26909 * safezoneH + safezoneY;
	w = 0.0859375 * safezoneW;
	h = 0.0219914 * safezoneH; text="MCC 3D Editor:";};							
class UnitTitle : factionTittle {	x = 0.288021 * safezoneW + safezoneX;
	y = 0.34606 * safezoneH + safezoneY;
	w = 0.0859375 * safezoneW;
	h = 0.0219914 * safezoneH; text="Type:";};
class UnitTypeTitle : UnitTitle {x = 0.288021 * safezoneW + safezoneX;
	y = 0.379047 * safezoneH + safezoneY;
	w = 0.0859375 * safezoneW;
	h = 0.0219914 * safezoneH; text="Class:";};
class EmptyTitle : UnitTitle {x = 0.288021 * safezoneW + safezoneX;
	y = 0.412034 * safezoneH + safezoneY;
	w = 0.0859375 * safezoneW;
	h = 0.0219914 * safezoneH; text="Empty:";};
class unitNameTitle : UnitTitle {x = 0.288021 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.0859375 * safezoneW;
	h = 0.0219914 * safezoneH; text="Name:";};
class initTitle : UnitTitle {x = 0.288021 * safezoneW + safezoneX;
	y = 0.478009 * safezoneH + safezoneY;
	w = 0.0859375 * safezoneW;
	h = 0.0219914 * safezoneH; text="Init:";};
class presetsTitle : UnitTitle {x = 0.288021 * safezoneW + safezoneX;
	y = 0.543983 * safezoneH + safezoneY;
	w = 0.0859375 * safezoneW;
	h = 0.0219914 * safezoneH; text="Presets:";};
class Zone_LocTitle : UnitTitle {x = 0.288021 * safezoneW + safezoneX;
	y = 0.57697 * safezoneH + safezoneY;
	w = 0.0859375 * safezoneW;
	h = 0.0219914 * safezoneH; text="Spawn:";}; // New

//-------------------------------------------Buttons----------------------------------------
class Zone_Loc : faction {idc=MCC_ZONE_LOC;x = 0.328125 * safezoneW + safezoneX;
	y = 0.57697 * safezoneH + safezoneY;
	w = 0.103125 * safezoneW;
	h = 0.0219914 * safezoneH;}; // New
class change : MCC_RscButton {idc=-1; colorDisabled[]={1,0.4,0.3,0.8};x = 0.288021 * safezoneW + safezoneX;
	y = 0.609957 * safezoneH + safezoneY;
	w = 0.0572917 * safezoneW;
	h = 0.0329871 * safezoneH; text="Apply"; onButtonClick=__EVAL ("[1] execVM '"+MCCPATH+"mcc\pop_menu\spawn_group3d.sqf'");};
class Close_dialog : MCC_RscButton {idc=-1; colorDisabled[]={1,0.4,0.3,0.8};x = 0.373958 * safezoneW + safezoneX;
	y = 0.609957 * safezoneH + safezoneY;
	w = 0.0572917 * safezoneW;
	h = 0.0329871 * safezoneH; text="Close"; onButtonClick="closeDialog 0";};
class addPresetButton : MCC_RscButton {idc=-1; colorDisabled[]={1,0.4,0.3,0.8};x = 0.402604 * safezoneW + safezoneX;
	y = 0.543983 * safezoneH + safezoneY;
	w = 0.0286458 * safezoneW;
	h = 0.0219914 * safezoneH;size=0.02; sizeEx=0.02; text="Add"; onButtonClick=__EVAL("[2] execVM '"+MCCPATH+"mcc\pop_menu\spawn_group3d.sqf'");};
};
