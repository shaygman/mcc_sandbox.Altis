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
		initBackground
	};


	//---------------------------------------------
	objects[] = 
	{ 
	};

	class controls 
	{
		 //========================================= Controls========================================
		//-------------------------------------------ComboBox----------------------------------------
		class faction : MCC_RscCombo 
		{
			idc=MCC_FACTION; 
			style=MCCST_LEFT; 
			colorText[]={1,1,1,1};
			colorSelect[]={1.0,0.35,0.3,1};
			colorBackground[]={0,0,0,1};
			colorSelectBackground[]={0,0,0,1}; 
			sizeEx=0.028;
			
			x = 0.053125 * safezoneW + safezoneX;
			y = 0.0491758 * safezoneH + safezoneY;
			w = 0.120313 * safezoneW;
			h = 0.0219914 * safezoneH;
			onLBSelChanged = __EVAL("[1] execVM '"+MCCPATH+"mcc\pop_menu\faction.sqf'");
		};
			
		class unit_type : MCC_RscCombo 
		{	
			idc=MCC_UNIT_TYPE; 
			x = 0.053125 * safezoneW + safezoneX;
			y = 0.0821629 * safezoneH + safezoneY;
			w = 0.120313 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx=0.028; 
			onLBSelChanged=__EVAL ("[0] execVM '"+MCCPATH+"mcc\pop_menu\group_change3d.sqf'");
		};
			
		class unit_Class : MCC_RscCombo 
		{
			idc=MCC_UNIT_CLASS;
			x = 0.053125 * safezoneW + safezoneX;
			y = 0.11515 * safezoneH + safezoneY;
			w = 0.120313 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx=0.028;
			onLBSelChanged=__EVAL ("[1] execVM '"+MCCPATH+"mcc\pop_menu\spawn_group3d.sqf'");
		};
		
		class setting_Empty : MCC_RscCombo 
		{	
			idc=MCC_SETTING_EMPTY; 
			sizeEx=0.028;
			x = 0.053125 * safezoneW + safezoneX;
			y = 0.148137 * safezoneH + safezoneY;
			w = 0.120313 * safezoneW;
			h = 0.0219914 * safezoneH;
			onLBSelChanged=__EVAL ("[1] execVM '"+MCCPATH+"mcc\pop_menu\spawn_group3d.sqf'");
		};
			
		class nameBox : MCC_RscText 
		{
			idc = MCC_NAMEBOX;
			type = MCCCT_EDIT;
			style = MCCST_MULTI;
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			colorSelection[] = {1,1,1,1};
			colorBorder[] = { 1, 1, 1, 1 };
			BorderSize = 0.01;
			autocomplete = true;
			
			x = 0.053125 * safezoneW + safezoneX;
			y = 0.181124 * safezoneH + safezoneY;
			w = 0.120313 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = 0.028;text = "";
		};
			
		class initBox : MCC_RscText
		{
			idc = MCC_INITBOX;
			type = MCCCT_EDIT;
			style = MCCST_MULTI;
			colorBackground[] = {0,0,0,0};
			colorText[] = {1,1,1,1};
			colorSelection[] = {1,1,1,1};
			colorBorder[] = { 1, 1, 1, 1 };
			BorderSize = 0.01;
			autocomplete = true;
			
			x = 0.053125 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.120313 * safezoneW;
			h = 0.0549786 * safezoneH;
			sizeEx = 0.028;
			text = "";
		};
			
		class presetsCombo : MCC_RscCombo 
		{
			idc=MCC_PRESETS;
			colorBackground[] = {0,0,0,1};
			sizeEx=0.028;
			x = 0.053125 * safezoneW + safezoneX;
			y = 0.291081 * safezoneH + safezoneY;
			w = 0.0916667 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		//-------------------------------------------Titels-----------------------------------------
		class factionTittle : MCC_RscText 
		{
			idc = -1; 
			style=MCCST_LEFT; 
			colorBackground[]={1,1,1,0}; 
			colorText[]={0,1,1,1};
			sizeEx=0.03; 
			x = 0.00156247 * safezoneW + safezoneX;
			y = 0.0491758 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0219914 * safezoneH;	
			text = "Faction:";
		};
		
		class mcc3DTitle : MCC_RscText 
		{
			idc = -1; 
			colorText[]={0,1,1,1};
			sizeEx=0.04; 
			x = 0.00729163 * safezoneW + safezoneX;
			y = 0.00519296 * safezoneH + safezoneY;
			w = 0.0859375 * safezoneW;
			h = 0.0219914 * safezoneH;
			text="MCC 3D Editor:";
		};	
		
		class UnitTitle : MCC_RscText 
		{	
			idc = -1; 
			colorText[]={0,1,1,1};
			sizeEx=0.03; 
			x = 0.00156247 * safezoneW + safezoneX;
			y = 0.0821629 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0219914 * safezoneH;
			text="Type:";
		};
		
		class UnitTypeTitle : MCC_RscText 
		{
			idc = -1; 
			colorText[]={0,1,1,1};
			sizeEx=0.03; 
			x = 0.00156247 * safezoneW + safezoneX;
			y = 0.11515 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0219914 * safezoneH;
			text="Class:";
		};
		class EmptyTitle : MCC_RscText 
		{
			idc = -1; 
			colorText[]={0,1,1,1};
			sizeEx=0.03; 
			x = 0.00156247 * safezoneW + safezoneX;
			y = 0.148137 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0219914 * safezoneH;
			text="Empty:";
		};
		class unitNameTitle : MCC_RscText 
		{
			idc = -1; 
			colorText[]={0,1,1,1};
			sizeEx=0.03; 
			x = 0.00156247 * safezoneW + safezoneX;
			y = 0.181124 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0219914 * safezoneH;
			text="Name:";
		};
		
		class initTitle : MCC_RscText 
		{
			idc = -1; 
			colorText[]={0,1,1,1};
			sizeEx=0.03; 
			x = 0.00156247 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.0401042 * safezoneW;
			h = 0.0219914 * safezoneH;
			text="Init:";
		};
		
		class presetsTitle : MCC_RscText 
		{
			idc = -1; 
			colorText[]={0,1,1,1};
			sizeEx=0.03; 
			x = 0.00156247 * safezoneW + safezoneX;
			y = 0.291081 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0219914 * safezoneH;
			text="Presets:";
		};
		
		class Zone_LocTitle : MCC_RscText 
		{
			idc = -1; 
			colorText[]={0,1,1,1};
			sizeEx=0.03; 
			x = 0.00156247 * safezoneW + safezoneX;
			y = 0.324069 * safezoneH + safezoneY;
			w = 0.0458333 * safezoneW;
			h = 0.0219914 * safezoneH;
			text="Spawn:";
		}; 

		//-------------------------------------------Buttons----------------------------------------
		class Zone_Loc : MCC_RscCombo 
		{
			idc=MCC_ZONE_LOC;
			sizeEx=0.028;
			x = 0.053125 * safezoneW + safezoneX;
			y = 0.324069 * safezoneH + safezoneY;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
		}; 

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
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			tooltip = "Open DOC Generator"; 
			
			text = "DOC -->"; //--- ToDo: Localize;
			x = 0.107708 * safezoneW + safezoneX;
			y = 0.43 * safezoneH + safezoneY;
			w = 0.0714583 * safezoneW;
			h = 0.03 * safezoneH;
		};
		
		class MCC3DOpenCargo: MCC_RscButton
		{
			idc = -1;
			colorDisabled[] = {1,0.4,0.3,0.8};
			onButtonClick = __EVAL("_this execVM '"+MCCPATH+"mcc\general_scripts\boxGen\mcc_boxGen_init.sqf'");
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			tooltip = "Open Cargo Generator"; 
			
			text = "Cargo -->"; //--- ToDo: Localize;
			x = 0.107708 * safezoneW + safezoneX;
			y = 0.465 * safezoneH + safezoneY;
			w = 0.0714583 * safezoneW;
			h = 0.03 * safezoneH;
		};
		

		class MCC3DOpenTask: MCC_RscButton
		{
			idc = -1;
			colorDisabled[] = {1,0.4,0.3,0.8};
			onButtonClick = __EVAL("_this execVM '"+MCCPATH+"mcc\general_scripts\tasks\tasks_init.sqf'");
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			tooltip = "Open Task Generator"; 
			
			text = "Tasks -->"; //--- ToDo: Localize;
			x = 0.107708 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.0714583 * safezoneW;
			h = 0.03 * safezoneH;
		};

		#include "mcc_boxGen.hpp"
		#include "mcc_3dDOC.hpp"
		#include "mcc_3dTasks.hpp"

		//---------------------- new ---------------------
		
		class MCC_3DCompassMapBackground : MCC_RscText 
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
		
		class MCC_3DCompassMap: MCC_RscMapControl
		{
			idc = 0;
			onMouseButtonDblClick =  __EVAL("[_this,1] execVM '"+MCCPATH+"mcc\general_scripts\3Deditor\mouseDown.sqf'");
		
			x = 0.78073 * safezoneW + safezoneX;
			y = 0.719914 * safezoneH + safezoneY;
			w = 0.223438 * safezoneW;
			h = 0.285889 * safezoneH;
		};
		
		class MCC3DOpenCurator: MCC_RscButtonMenu
		{
			idc = -1;
			colorDisabled[] = {1,0.4,0.3,0.8};
			onButtonClick = __EVAL("_this execVM '"+MCCPATH+"mcc\general_scripts\3Deditor\openZeus.sqf'");
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.9)";
			tooltip = "Open Zeus"; 
			
			text = "Zeus"; //--- ToDo: Localize;
			x = 0.0932292 * safezoneW + safezoneX;
			y = 0.87 * safezoneH + safezoneY;
			w = 0.0916667 * safezoneW;
			h = 0.0439828 * safezoneH;
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
	class initBackground : MCC_RscText {idc = -1;
		x = 0.053125 * safezoneW + safezoneX;
		y = 0.225107 * safezoneH + safezoneY;
		w = 0.120313 * safezoneW;
		h = 0.0549786 * safezoneH;
		sizeEx = 0.028;text = "";};
};