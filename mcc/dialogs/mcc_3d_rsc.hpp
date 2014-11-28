// Made By: Shay_gman
// Version: 1.1 (January 2014)

//-----------------------------------------------------------------------------
// IDD's & IDC's
//-----------------------------------------------------------------------------
#define MCC3D_IDD 8000

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class MCC3D_RSC
	{    
		idd = MCC3D_RSC_IDD;
		duration = 1;
		onLoad = __EVAL("[] execVM '"+MCCPATH+"mcc\dialogs\mcc_3d_init.sqf'");
		class controls
		{
			class ExampleControl
			{    
				idc = -1;
				type = 0;
				style = 0;
				x = 0; 
				y = 0;
				w = 1;
				h = 1;
				font = "EtelkaNarrowMediumPro";
				sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.5)";
				colorBackground[] = {0,0,0,1};
				colorText[] = {1,1,1,1};
				text = "Example Text";
			};  
		};	
	};
