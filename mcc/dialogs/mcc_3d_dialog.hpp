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
	movingEnable = false;
	onLoad = __EVAL("_this execVM '"+MCCPATH+"mcc\dialogs\mcc_3d_init.sqf'");

	controlsBackground[] = 
	{
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
		unit_type,
		unit_Class,
		setting_Empty,
		nameBox,
		initBox,
		presetsCombo,
		factionTittle,
		mcc3DTitle,
		UnitTitle,
		UnitTypeTitle,
		EmptyTitle,
		unitNameTitle,
		initTitle,
		presetsTitle,
		Zone_LocTitle,
		Zone_Loc,
		addPresetButton,
		MCC3DOpenComp,
		MCC_3DCompssaveList,
		MCC_3DCompssaveDescription,
		MCC_3DCsaveName,
		MCC_3DCompsaveNameTittle,
		MCC_3DCompsaveUIButton,
		MCC_3DComploadUIButton,
		MCC_ConsoleCompassMapBackground,
		MCC_ConsoleCompassMap,
		MCC_3DClose
	};
	
	 //========================================= Background======================================
	class MCC_Bckgrnd : MCC_RscText {idc = -1; 
		x = -0.00416669 * safezoneW + safezoneX;
		y = -0.00580276 * safezoneH + safezoneY;
		w = 0.194792 * safezoneW;
		h = 1.01161 * safezoneH;
		text = "";colorBackground[] = {0,0,0,0.7};};
	class nameBackground : MCC_RscText {idc = -1;moving = true;colorBackground[] = { 0, 0, 0, 1 };colorText[] = { 1, 1, 1, 0 };
		x = 0.053125 * safezoneW + safezoneX;
		y = 0.225107 * safezoneH + safezoneY;
		w = 0.120313 * safezoneW;
		h = 0.0549786 * safezoneH;
		sizeEx = 0.028;text = "";};
	class initBackground : nameBackground {idc = -1;
		x = 0.053125 * safezoneW + safezoneX;
		y = 0.225107 * safezoneH + safezoneY;
		w = 0.120313 * safezoneW;
		h = 0.0549786 * safezoneH;
		sizeEx = 0.028;text = "";};
	 //========================================= Controls========================================
	 
	//-------------------------------------------ComboBox----------------------------------------
	class faction : MCC_RscCombo {idc=MCC_FACTION; style=MCCST_LEFT; colorText[]={1,1,1,1};colorSelect[]={1.0,0.35,0.3,1};colorBackground[]={0,0,0,1};
								colorSelectBackground[]={0,0,0,1}; sizeEx=0.028;
		x = 0.053125 * safezoneW + safezoneX;
		y = 0.0491758 * safezoneH + safezoneY;
		w = 0.120313 * safezoneW;
		h = 0.0219914 * safezoneH;
		onLBSelChanged = __EVAL("[1] execVM '"+MCCPATH+"mcc\pop_menu\faction.sqf'");};
		
	class unit_type : faction 
	{	idc=MCC_UNIT_TYPE; 
		x = 0.053125 * safezoneW + safezoneX;
		y = 0.0821629 * safezoneH + safezoneY;
		w = 0.120313 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx=0.028; 
		onLBSelChanged=__EVAL ("[0] execVM '"+MCCPATH+"mcc\pop_menu\group_change3d.sqf'");
	};
		
	class unit_Class : faction 
	{
		idc=MCC_UNIT_CLASS;
		x = 0.053125 * safezoneW + safezoneX;
		y = 0.11515 * safezoneH + safezoneY;
		w = 0.120313 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx=0.028;
		onLBSelChanged=__EVAL ("[1] execVM '"+MCCPATH+"mcc\pop_menu\spawn_group3d.sqf'");
	};
	
	class setting_Empty : faction 
	{	
		idc=MCC_SETTING_EMPTY; 
		x = 0.053125 * safezoneW + safezoneX;
		y = 0.148137 * safezoneH + safezoneY;
		w = 0.120313 * safezoneW;
		h = 0.0219914 * safezoneH;
		onLBSelChanged=__EVAL ("[1] execVM '"+MCCPATH+"mcc\pop_menu\spawn_group3d.sqf'");
	};
		
	class nameBox : MCC_RscText {idc = MCC_NAMEBOX;type = MCCCT_EDIT;style = MCCST_MULTI;colorBackground[] = {0,0,0,0};colorText[] = {1,1,1,1};colorSelection[] = {1,1,1,1};colorBorder[] = { 1, 1, 1, 1 };
			BorderSize = 0.01;autocomplete = true;
		x = 0.053125 * safezoneW + safezoneX;
		y = 0.181124 * safezoneH + safezoneY;
		w = 0.120313 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = 0.028;text = "";};
		
	class initBox : nameBox {idc = MCC_INITBOX;
		x = 0.053125 * safezoneW + safezoneX;
		y = 0.225107 * safezoneH + safezoneY;
		w = 0.120313 * safezoneW;
		h = 0.0549786 * safezoneH;
		sizeEx = 0.028;text = "";};
		
	class presetsCombo : faction {idc=MCC_PRESETS;
		colorBackground[] = {0,0,0,1};
		x = 0.053125 * safezoneW + safezoneX;
		y = 0.291081 * safezoneH + safezoneY;
		w = 0.0916667 * safezoneW;
		h = 0.0219914 * safezoneH;
		};
	//-------------------------------------------Titels-----------------------------------------
	class factionTittle : MCC_RscText {idc = -1; style=MCCST_LEFT; colorBackground[]={1,1,1,0}; colorText[]={1,1,1,1};
		x = 0.00156247 * safezoneW + safezoneX;
		y = 0.0491758 * safezoneH + safezoneY;
		w = 0.0458333 * safezoneW;
		h = 0.0219914 * safezoneH;	
		sizeEx=0.03; text = "Faction:";};
	class mcc3DTitle : factionTittle {colorText[]={0,1,1,1};
		x = 0.00729163 * safezoneW + safezoneX;
		y = 0.00519296 * safezoneH + safezoneY;
		w = 0.0859375 * safezoneW;
		h = 0.0219914 * safezoneH;
		text="MCC 3D Editor:";};							
	class UnitTitle : factionTittle {	
		x = 0.00156247 * safezoneW + safezoneX;
		y = 0.0821629 * safezoneH + safezoneY;
		w = 0.0458333 * safezoneW;
		h = 0.0219914 * safezoneH;
		text="Type:";};
	class UnitTypeTitle : UnitTitle {
		x = 0.00156247 * safezoneW + safezoneX;
		y = 0.11515 * safezoneH + safezoneY;
		w = 0.0458333 * safezoneW;
		h = 0.0219914 * safezoneH;
		text="Class:";};
	class EmptyTitle : UnitTitle 
	{
		x = 0.00156247 * safezoneW + safezoneX;
		y = 0.148137 * safezoneH + safezoneY;
		w = 0.0458333 * safezoneW;
		h = 0.0219914 * safezoneH;
		text="Empty:";
	};
	class unitNameTitle : UnitTitle {
		x = 0.00156247 * safezoneW + safezoneX;
		y = 0.181124 * safezoneH + safezoneY;
		w = 0.0458333 * safezoneW;
		h = 0.0219914 * safezoneH;
		text="Name:";};
	class initTitle : UnitTitle {
		x = 0.00156247 * safezoneW + safezoneX;
		y = 0.225107 * safezoneH + safezoneY;
		w = 0.0401042 * safezoneW;
		h = 0.0219914 * safezoneH;
		text="Init:";};
	class presetsTitle : UnitTitle {
		x = 0.00156247 * safezoneW + safezoneX;
		y = 0.291081 * safezoneH + safezoneY;
		w = 0.0458333 * safezoneW;
		h = 0.0219914 * safezoneH;
		text="Presets:";};
	class Zone_LocTitle : UnitTitle {
		x = 0.00156247 * safezoneW + safezoneX;
		y = 0.324069 * safezoneH + safezoneY;
		w = 0.0458333 * safezoneW;
		h = 0.0219914 * safezoneH;
		text="Spawn:";}; // New

	//-------------------------------------------Buttons----------------------------------------
	class Zone_Loc : faction 
	{
		idc=MCC_ZONE_LOC;
		x = 0.053125 * safezoneW + safezoneX;
		y = 0.324069 * safezoneH + safezoneY;
		w = 0.108854 * safezoneW;
		h = 0.0219914 * safezoneH;
	}; // New

	class addPresetButton : MCC_RscButton 
	{
		idc=-1; colorDisabled[]={1,0.4,0.3,0.8};
		x = 0.150521 * safezoneW + safezoneX;
		y = 0.291081 * safezoneH + safezoneY;
		w = 0.0286458 * safezoneW;
		h = 0.0219914 * safezoneH;
		
		size=0.02; 
		sizeEx=0.02; 
		text="Add"; 
		onButtonClick=__EVAL("[2] execVM '"+MCCPATH+"mcc\pop_menu\spawn_group3d.sqf'");
	};
		
	class MCC3DOpenComp: MCC_RscButton
	{
		idc = MCC3DOpenCompIDC;
		colorDisabled[] = {1,0.4,0.3,0.8};
		onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\docobject\compositionManager.sqf'");
		sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		
		text = "->"; //--- ToDo: Localize;
		x = 0.167708 * safezoneW + safezoneX;
		y = 0.434026 * safezoneH + safezoneY;
		w = 0.0114583 * safezoneW;
		h = 0.0439828 * safezoneH;
	};
	
	class MCC_3DCompssaveList: MCC_RscListbox
	{
		idc = MCC_3DCompssaveListIDC;
		onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\docobject\compositionManagerChnage.sqf'");

		x = 0.196354 * safezoneW + safezoneX;
		y = 0.225107 * safezoneH + safezoneY;
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

		x = 0.299479 * safezoneW + safezoneX;
		y = 0.225107 * safezoneH + safezoneY;
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

		x = 0.322396 * safezoneW + safezoneX;
		y = 0.510996 * safezoneH + safezoneY;
		w = 0.131771 * safezoneW;
		h = 0.0329871 * safezoneH;
		sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	class MCC_3DCompsaveNameTittle: MCC_RscText
	{
		idc = MCC_3DCompsaveNameTittleIDC;

		text = "Name:"; //--- ToDo: Localize;
		x = 0.196354 * safezoneW + safezoneX;
		y = 0.510996 * safezoneH + safezoneY;
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
		x = 0.196354 * safezoneW + safezoneX;
		y = 0.554979 * safezoneH + safezoneY;
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
		x = 0.356771 * safezoneW + safezoneX;
		y = 0.554979 * safezoneH + safezoneY;
		w = 0.0973958 * safezoneW;
		h = 0.0329871 * safezoneH;
		tooltip = "Load a composition from the profile name space to the init line of the choosen vehicle- choose a slot from the above list first"; //--- ToDo: Localize;
		sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
	};
	
	class MCC_3DComploadBcg: MCC_RscText
	{
		idc = MCC_3DComploadBcgIDC;
		text = "";
		x = 0.190625 * safezoneW + safezoneX;
		y = 0.214111 * safezoneH + safezoneY;
		w = 0.269271 * safezoneW;
		h = 0.4 * safezoneH;
		colorBackground[] = {0,0,0,0.7};
	};

//---------------------- new ---------------------
	class MCC_ConsoleCompassMapBackground : MCC_RscText 
	{
		idc = -1;
		
		x = 0.78073 * safezoneW + safezoneX;
		y = 0.719914 * safezoneH + safezoneY;
		w = 0.223438 * safezoneW;
		h = 0.285889 * safezoneH;
		
		colorBackground[] = { 1, 1, 1, 1}; 
		colorText[] = { 1, 1, 1, 0};
		text = "";
	};
	
	class MCC_ConsoleCompassMap: MCC_RscMapControl
	{
		idc = 0;
		onMouseButtonDown =__EVAL("[_this,0] execVM '"+MCCPATH+"mcc\general_scripts\3Deditor\mouseDown.sqf'");
		onMouseButtonDblClick =  __EVAL("[_this,1] execVM '"+MCCPATH+"mcc\general_scripts\3Deditor\mouseDown.sqf'");
		onMouseButtonUp = __EVAL("[_this,1] execVM '"+MCCPATH+"mcc\general_scripts\3Deditor\mouseUp.sqf'");
		onMouseMoving = __EVAL("[_this,1] execVM '"+MCCPATH+"mcc\general_scripts\3Deditor\mouseMoving.sqf'");
		
		x = 0.78073 * safezoneW + safezoneX;
		y = 0.719914 * safezoneH + safezoneY;
		w = 0.223438 * safezoneW;
		h = 0.285889 * safezoneH;
	};
	class MCC_3DClose: MCC_RscButtonMenu
	{
		idc = -1;
		text = "Close";
		action = "closeDialog 0";
		x = 0.0932292 * safezoneW + safezoneX;
		y = 0.928833 * safezoneH + safezoneY;
		w = 0.0916667 * safezoneW;
		h = 0.0439828 * safezoneH;
	};

};