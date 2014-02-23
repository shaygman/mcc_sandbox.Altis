class MCC_CASDialogControls:MCC_RscControlsGroup
{
	idc = 500;
	x = 0.186 * safezoneW + safezoneX;
	y = 0.12 * safezoneH + safezoneY;
	w = 0.24 * safezoneW;
	h = 0.219914 * safezoneH;

	class Controls
	{
		class MCC_CASDialog: MCC_RscText
		{
			idc = -1;
			colorBackground[] = {0,0,0,0.9};
				
			x = 0.270833 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.24 * safezoneW;
			h = 0.219914 * safezoneH;
		};

		class MCC_CASTitle: MCC_RscText
		{
			idc = -1;

			text = "Close Air Support:"; //--- ToDo: Localize;
			x = 0.310938 * safezoneW + safezoneX;
			y = 0.236103 * safezoneH + safezoneY;
			w = 0.160417 * safezoneW;
			h = 0.0329871 * safezoneH;
			colorText[] = {0,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.2)";
		};
		class MCC_CASPlaneTitle: MCC_RscText
		{
			idc = -1;

			text = "Plane:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_CASPlaneType: MCC_RscCombo
		{
			idc = 25;

			x = 0.356771 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.148958 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_CASTypeTitle: MCC_RscText
		{
			idc = -1;

			text = "Type:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.313073 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_CASType: MCC_RscCombo
		{
			idc = 26;

			x = 0.356771 * safezoneW + safezoneX;
			y = 0.313073 * safezoneH + safezoneY;
			w = 0.148958 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_CASCall: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\cas\cas_request.sqf'");

			text = "Call"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.34606 * safezoneH + safezoneY;
			w = 0.0802083 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Call CAS - drag and draw a line on the minimap to call CAS"; //--- ToDo: Localize;
		};
		class MCC_CASAdd: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\cas\cas_request.sqf'");

			text = "Add"; //--- ToDo: Localize;
			x = 0.419792 * safezoneW + safezoneX;
			y = 0.34606 * safezoneH + safezoneY;
			w = 0.0802083 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Add CAS to MCC Console"; //--- ToDo: Localize;
		};

		class MCC_CASClose: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[4] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");

			text = "Close"; //--- ToDo: Localize;
			x = 0.345313 * safezoneW + safezoneX;
			y = 0.390043 * safezoneH + safezoneY;
			w = 0.0802083 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Call CAS - drag and draw a line on the minimap to call CAS"; //--- ToDo: Localize;
		};
	};
};
 

