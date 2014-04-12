#define MCC_3DDOCIDC 8017
#define MCC_3DCompssaveListIDC 8011
#define MCC_3DCompssaveDescriptionIDC 8012
#define MCC_3DCsaveNameIDC 8013

class MCC_3dDOCControls:MCC_RscControlsGroup
{
	idc = MCC_3DDOCIDC;
	x = 0.195 * safezoneW + safezoneX;
	y = 0.214111 * safezoneH + safezoneY;
	w = 0.275 * safezoneW;
	h = 0.38485 * safezoneH;

	class Controls
	{
		class MCC_3DComploadBcg: MCC_RscText
		{
			idc = -1;
			text = "";
			colorBackground[] = {0,0,0,0.7};
			
			w = 0.275 * safezoneW;
			h = 0.38485 * safezoneH;			
		};
		
		class MCC_3DCompssaveList: MCC_RscListbox
		{
			idc = MCC_3DCompssaveListIDC;
			colorBackground[] = {0,0,0,0.9};
			onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\docobject\compositionManagerChnage.sqf'");

			x = 0.00572965 * safezoneW;
			y = 0.0109958 * safezoneH;
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
			colorBackground[] = {0,0,0,0.9};

			x = 0.114584 * safezoneW;
			y = 0.0109958 * safezoneH;
			w = 0.154687 * safezoneW;
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
			colorBackground[] = {0,0,0,0.9};
			
			x = 0.0802087 * safezoneW;
			y = 0.296884 * safezoneH;
			w = 0.131771 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_3DCompsaveNameTittle: MCC_RscText
		{
			idc = -1;

			text = "Name:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.296884 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
			colorText[] = {0,1,1,1};
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_3DCompsaveUIButton: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\docobject\compositionManagerChnage.sqf'");

			text = "Save To Profile"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.340867 * safezoneH;
			w = 0.103125 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Save the composition as the player as an anchor point and radius 200 meters to the profile name space - choose a slot from the above list first"; //--- ToDo: Localize;
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_3DComploadUIButton: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\docobject\compositionManagerChnage.sqf'");

			text = "Load From Profile"; //--- ToDo: Localize;
			x = 0.171875 * safezoneW;
			y = 0.340867 * safezoneH;
			w = 0.0973958 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Load a composition from the profile name space to the init line of the choosen vehicle- choose a slot from the above list first"; //--- ToDo: Localize;
			sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
	};
};
		
