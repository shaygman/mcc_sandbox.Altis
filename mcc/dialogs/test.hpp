class mcc_test
{
	idd = 9999999;
	movingEnable = true;
	onLoad ="";

	controlsBackground[] = 
	{
	};


	//---------------------------------------------
	objects[] = 
	{ 	//(0.671875 * safezoneW + safezoneX) / safezoneW -X
	};	//(0.478009 * safezoneH + safezoneY) / safezoneH - Y

	class controls 
	{
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
	};
};