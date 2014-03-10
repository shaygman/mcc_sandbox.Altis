class MCC_evacDialogControls:MCC_RscControlsGroup
{
	idc = 507;
	x = 0.186 * safezoneW + safezoneX;
	y = 0.16 * safezoneH + safezoneY;
	w = 0.223438 * safezoneW;
	h = 0.285889 * safezoneH;

	class Controls
	{
		class MCC_evacDialogFrame: MCC_RscText
		{
			idc = -1;
			colorBackground[] = {0,0,0,0.9};
			
			w = 0.223438 * safezoneW;
			h = 0.285889 * safezoneH;
		};
		
		class MCC_evacTittle: MCC_RscText
		{
			idc = -1;

			text = "Evac:"; //--- ToDo: Localize;
			x = 0.0630208 * safezoneW;
			y = 0.0109958 * safezoneH;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
			colorText[] = {0,1,1,1};
		};
		
		class MCC_evacTypeTitle: MCC_RscText
		{
			idc = -1;

			text = "Type:"; //--- ToDo: Localize;
			x = 0.00572967 * safezoneW;
			y = 0.0439828 * safezoneH;
			w = 0.0515625 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_evacClassTitle: MCC_RscText
		{
			idc = -1;

			text = "Class:"; //--- ToDo: Localize;
			x = 0.00572967 * safezoneW;
			y = 0.07697 * safezoneH;
			w = 0.0515625 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_evacType: MCC_RscCombo
		{
			idc = 40;
			onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\evac\evac_change.sqf'");

			x = 0.0630208 * safezoneW;
			y = 0.0439828 * safezoneH;
			w = 0.103125 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_evacClass: MCC_RscCombo
		{
			idc = 41;

			x = 0.0630208 * safezoneW;
			y = 0.07697 * safezoneH;
			w = 0.103125 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_evacSpawn: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\evac\request_heli.sqf'");

			text = "Spawn"; //--- ToDo: Localize;
			x = 0.171875 * safezoneW;
			y = 0.0439828 * safezoneH;
			w = 0.0458333 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Spawn Evac Vehicle on map click"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_evacSelected: MCC_RscCombo
		{
			idc = 42;
			onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\evac\evac_focus.sqf'");

			x = 0.0630208 * safezoneW;
			y = 0.142944 * safezoneH;
			w = 0.103125 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_evacSelectedTitle: MCC_RscText
		{
			idc = -1;

			text = "Evac:"; //--- ToDo: Localize;
			x = 0.00572967 * safezoneW;
			y = 0.142944 * safezoneH;
			w = 0.0515625 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_evacWp: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[] execVM '"+MCCPATH+"mcc\general_scripts\evac\add_wp_heli.sqf'");

			text = "1 WP"; //--- ToDo: Localize;
			x = 0.171875 * safezoneW;
			y = 0.197923 * safezoneH;
			w = 0.0458333 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Add Evac WP"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_evac3Wp: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[] execVM '"+MCCPATH+"mcc\general_scripts\evac\move_heli.sqf'");

			text = "3 WP"; //--- ToDo: Localize;
			x = 0.171875 * safezoneW;
			y = 0.142944 * safezoneH;
			w = 0.0458333 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Add 3 Evac way points"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_evacInsertionTitle: MCC_RscText
		{
			idc = -1;

			text = "Insertion:"; //--- ToDo: Localize;
			x = 0.00572967 * safezoneW;
			y = 0.175932 * safezoneH;
			w = 0.0515625 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_evacInsertion: MCC_RscCombo
		{
			idc = 43;

			x = 0.0630208 * safezoneW;
			y = 0.175932 * safezoneH;
			w = 0.103125 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_evacDelHeli: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\evac\delete_heli.sqf'");

			text = "Del. Evac"; //--- ToDo: Localize;
			x = 0.0572917 * safezoneW;
			y = 0.109957 * safezoneH;
			w = 0.0458333 * safezoneW;
			h = 0.0219914 * safezoneH;
			colorText[] = {1,0,0,0.7};
			tooltip = "Delete the evac vehicle"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_evacFlightHightTitle: MCC_RscText
		{
			idc = -1;

			text = "F. Height:"; //--- ToDo: Localize;
			x = 0.00572967 * safezoneW;
			y = 0.208919 * safezoneH;
			w = 0.0515625 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_evacFlightHight: MCC_RscCombo
		{
			idc = 44;

			x = 0.0630208 * safezoneW;
			y = 0.208919 * safezoneH;
			w = 0.103125 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_evacDelPilot: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\evac\delete_heli.sqf'");

			text = "Del. Driver"; //--- ToDo: Localize;
			x = 0.131771 * safezoneW;
			y = 0.109957 * safezoneH;
			w = 0.0458333 * safezoneW;
			h = 0.0219914 * safezoneH;
			colorText[] = {1,0,0,0.7};
			tooltip = "Delete the evac driver"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_evacResHeli: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\evac\delete_heli.sqf'");

			text = "Res. Driver"; //--- ToDo: Localize;
			x = 0.171875 * safezoneW;
			y = 0.07697 * safezoneH;
			w = 0.0458333 * safezoneW;
			h = 0.0219914 * safezoneH;
			colorText[] = {0,1,0,0.7};
			tooltip = "Revive the evac driver"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_evacClose: MCC_RscButtonMenu
		{
			idc = -1;
			onButtonClick = "((uiNamespace getVariable 'MCC_groupGen_Dialog') displayCtrl 507) ctrlShow false";

			text = "Close"; //--- ToDo: Localize;
			x = 0.0859375 * safezoneW;
			y = 0.241906 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
	};
};