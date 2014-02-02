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

#define MCC3DOpenCompIDC 8010
#define MCC_3DCompssaveListIDC 8011
#define MCC_3DCompssaveDescriptionIDC 8012
#define MCC_3DCsaveNameIDC 8013
#define MCC_3DCompsaveNameTittleIDC 8014
#define MCC_3DCompsaveUIButtonIDC 8015
#define MCC_3DComploadUIButtonIDC 8016
#define MCC_3DComploadBcgIDC 8017
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
	initBackground,
	MCC_3DComploadBcg
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
	Zone_LocTitle,
	MCC3DOpenComp,
	MCC_3DCompssaveList,
	MCC_3DCompssaveDescription,
	MCC_3DCsaveName,
	MCC_3DCompsaveNameTittle,
	MCC_3DCompsaveUIButton,
	MCC_3DComploadUIButton
  };
  
 //========================================= Background======================================
class MCC_pic : MCC_RscPicture {idc = -1; moving = true; 
	x = 0.265104 * safezoneW + safezoneX;
	y = 0.225107 * safezoneH + safezoneY;
	w = 0.194792 * safezoneW;
	h = 0.505803 * safezoneH; 
	text = __EVAL(MCCPATH +"mcc\dialogs\mcc_background.paa");
	colorBackground[] = {0,0,0,0.5};};
class MCC_Bckgrnd : MCC_RscText {idc = -1; moving = true; 
	x = 0.282292 * safezoneW + safezoneX;
	y = 0.26909 * safezoneH + safezoneY;
	w = 0.160417 * safezoneW;
	h = 0.428833 * safezoneH; 
	text = "";colorBackground[] = {0,0,0,0.7};};
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
	colorBackground[] = {0,0,0,1};
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
class change : MCC_RscButton {idc=-1; colorDisabled[]={1,0.4,0.3,0.8};
	x = 0.288021 * safezoneW + safezoneX;
	y = 0.642944 * safezoneH + safezoneY;
	w = 0.0572917 * safezoneW;
	h = 0.0329871 * safezoneH;
	text="Apply"; onButtonClick=__EVAL ("[1] execVM '"+MCCPATH+"mcc\pop_menu\spawn_group3d.sqf'");};
class Close_dialog : MCC_RscButton {idc=-1; colorDisabled[]={1,0.4,0.3,0.8};
	x = 0.379688 * safezoneW + safezoneX;
	y = 0.642944 * safezoneH + safezoneY;
	w = 0.0572917 * safezoneW;
	h = 0.0329871 * safezoneH;
	text="Close"; onButtonClick="closeDialog 0";};
class addPresetButton : MCC_RscButton {idc=-1; colorDisabled[]={1,0.4,0.3,0.8};x = 0.402604 * safezoneW + safezoneX;
	y = 0.543983 * safezoneH + safezoneY;
	w = 0.0286458 * safezoneW;
	h = 0.0219914 * safezoneH;size=0.02; sizeEx=0.02; text="Add"; onButtonClick=__EVAL("[2] execVM '"+MCCPATH+"mcc\pop_menu\spawn_group3d.sqf'");
	};
	
	class MCC3DOpenComp: MCC_RscButton
	{
		idc = MCC3DOpenCompIDC;
		colorDisabled[] = {1,0.4,0.3,0.8};
		onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\docobject\compositionManager.sqf'");
		sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		
		text = "->"; //--- ToDo: Localize;
		x = 0.444313 * safezoneW + safezoneX;
		y = 0.452718 * safezoneH + safezoneY;
		w = 0.0114583 * safezoneW;
		h = 0.0439828 * safezoneH;
	};
	
	class MCC_3DCompssaveList: MCC_RscListbox
	{
		idc = MCC_3DCompssaveListIDC;
		onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\docobject\compositionManagerChnage.sqf'");

		x = 0.465625 * safezoneW + safezoneX;
		y = 0.26909 * safezoneH + safezoneY;
		w = 0.0973958 * safezoneW;
		h = 0.274893 * safezoneH;
		sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_3DCompssaveDescription: MCC_RscText
	{
		idc = MCC_3DCompssaveDescriptionIDC;
		text = "";
		type = MCCCT_EDIT;
		style = MCCST_MULTI;
		autocomplete = false;
		access = ReadAndWrite;

		x = 0.56875 * safezoneW + safezoneX;
		y = 0.26909 * safezoneH + safezoneY;
		w = 0.154688 * safezoneW;
		h = 0.274893 * safezoneH;
		sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_3DCsaveName: MCC_RscText
	{
		idc = MCC_3DCsaveNameIDC;
		text = "";
		type = MCCCT_EDIT;
		style = MCCST_MULTI;
		autocomplete = false;
		access = ReadAndWrite;

		x = 0.591667 * safezoneW + safezoneX;
		y = 0.554979 * safezoneH + safezoneY;
		w = 0.131771 * safezoneW;
		h = 0.0329871 * safezoneH;
		sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_3DCompsaveNameTittle: MCC_RscText
	{
		idc = MCC_3DCompsaveNameTittleIDC;

		text = "Name:"; //--- ToDo: Localize;
		x = 0.465625 * safezoneW + safezoneX;
		y = 0.554979 * safezoneH + safezoneY;
		w = 0.06875 * safezoneW;
		h = 0.0329871 * safezoneH;
		colorText[] = {0,1,1,1};
		sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_3DCompsaveUIButton: MCC_RscButton
	{
		idc = MCC_3DCompsaveUIButtonIDC;
		onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\docobject\compositionManagerChnage.sqf'");

		text = "Save To Profile"; //--- ToDo: Localize;
		x = 0.465625 * safezoneW + safezoneX;
		y = 0.598961 * safezoneH + safezoneY;
		w = 0.103125 * safezoneW;
		h = 0.0329871 * safezoneH;
		tooltip = "Save the composition as the player as an anchor point and radius 200 meters to the profile name space - choose a slot from the above list first"; //--- ToDo: Localize;
		sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_3DComploadUIButton: MCC_RscButton
	{
		idc = MCC_3DComploadUIButtonIDC;
		onButtonClick = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\docobject\compositionManagerChnage.sqf'");

		text = "Load From Profile"; //--- ToDo: Localize;
		x = 0.626042 * safezoneW + safezoneX;
		y = 0.598961 * safezoneH + safezoneY;
		w = 0.0973958 * safezoneW;
		h = 0.0329871 * safezoneH;
		tooltip = "Load a composition from the profile name space to the init line of the choosen vehicle- choose a slot from the above list first"; //--- ToDo: Localize;
		sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_3DComploadBcg: MCC_RscText
	{
		idc = MCC_3DComploadBcgIDC;
		text = "";
		x = 0.461 * safezoneW + safezoneX;
		y = 0.24 * safezoneH + safezoneY;
		w = 0.269271 * safezoneW;
		h = 0.4 * safezoneH;
		colorBackground[] = {0,0,0,0.7};
	};
};
