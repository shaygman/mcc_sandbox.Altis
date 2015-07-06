#define MCC_AIRDROPTYPE 1031
#define MCC_airdropClass 1032
#define MCC_airdropArray 1033

class MCC_airdropDialogControls:MCC_RscControlsGroup
{
	idc = 517;
	x = 0.186 * safezoneW + safezoneX;
	y = 0.18 * safezoneH + safezoneY;
	w = 0.280729 * safezoneW;
	h = 0.22 * safezoneH;

	class Controls
	{
		class MCC_airdropDialogFrame: MCC_RscText
		{
			idc = -1;
			colorBackground[] = {0,0,0,0.9};

			w = 0.280729 * safezoneW;
			h = 0.164936 * safezoneH;
		};
		class MCC_airdropTittle: MCC_RscText
		{
			idc = -1;

			text = "Supply Drop:"; //--- ToDo: Localize;
			x = 0.0687495 * safezoneW;
			y = 0.0109958 * safezoneH;
			w = 0.120313 * safezoneW;
			h = 0.0329871 * safezoneH;
			colorText[] = {0,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};

		class MCC_airdropInsertionType: MCC_RscToolbox
		{
			idc = 1037;
			strings[] = {" Parachute "," Slingload "};
			rows = 1;
			columns = 2;
			values[] = {0,1};
			onToolBoxSelChanged =  __EVAL("[3,(_this select 1)] execVM '"+MCCPATH+"mcc\general_scripts\cas\airdropReq.sqf'");

			x = 0.2 * safezoneW;
			y = 0.0109958 * safezoneH;
			w = 0.075 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
		};

		class MCC_airdropTypeCombo: MCC_RscCombo
		{
			idc = MCC_AIRDROPTYPE;
			x = 0.00572967 * safezoneW;
			y = 0.0549786 * safezoneH;
			w = 0.0802083 * safezoneW;
			h = 0.0219914 * safezoneH;
			onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\cas\airdropReq.sqf'");
		};
		class MCC_airdropClassCombo: MCC_RscCombo
		{
			idc = MCC_airdropClass;
			x = 0.0916667 * safezoneW;
			y = 0.0549786 * safezoneH;
			w = 0.120313 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_airdropArrayCombo: MCC_RscCombo
		{
			idc = MCC_airdropArray;
			x = 0.0916667 * safezoneW;
			y = 0.0879657 * safezoneH;
			w = 0.120313 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class MCC_airdropArrayTittle: MCC_RscText
		{
			idc = 1034;

			text = "Current Airdrop:"; //--- ToDo: Localize;
			x = 0.00572967 * safezoneW;
			y = 0.0879657 * safezoneH;
			w = 0.0802083 * safezoneW;
			h = 0.0219914 * safezoneH;
			colorText[] = {1,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_airdropAdd: MCC_RscButton
		{
			idc = 1035; // idc set to allow hiding button when no mcc_console available
			text = "Add"; //--- ToDo: Localize;
			x = 0.217709 * safezoneW;
			y = 0.0549786 * safezoneH;
			w = 0.0572917 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Add this item to the current airdrop list"; //--- ToDo: Localize;
			onButtonClick = __EVAL ("[1] execVM '"+MCCPATH+"mcc\general_scripts\cas\airdropReq.sqf'");
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_airdropClear: MCC_RscButton
		{
			idc = 1036;
			text = "Clear"; //--- ToDo: Localize;
			x = 0.217709 * safezoneW;
			y = 0.0879657 * safezoneH;
			w = 0.0572917 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Clear the current airdrop list"; //--- ToDo: Localize;
			onButtonClick = __EVAL ("[2] execVM '"+MCCPATH+"mcc\general_scripts\cas\airdropReq.sqf'");
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_airdropCall: MCC_RscButton
		{
			idc = -1;
			text = "Call"; //--- ToDo: Localize;
			x = 0.217709 * safezoneW;
			y = 0.120953 * safezoneH;
			w = 0.0572917 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Call the current airdrop"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\cas\cas_request.sqf'");
		};
		class MCC_airdropAddConsole: MCC_RscButton
		{
			idc = -1;

			text = "Add Console"; //--- ToDo: Localize;
			x = 0.154688 * safezoneW;
			y = 0.120953 * safezoneH;
			w = 0.0572917 * safezoneW;
			h = 0.0329871 * safezoneH;
			onButtonClick = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\cas\cas_request.sqf'");
			tooltip = "Add the current airdrop to the player's console"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_CSClose: MCC_RscButtonMenu
		{
			idc = -1;
			text = "Close"; //--- ToDo: Localize;
			onButtonClick = "((uiNamespace getVariable 'MCC_groupGen_Dialog') displayCtrl 517) ctrlShow false";

			x = 0.00572967 * safezoneW;
			y = 0.120953 * safezoneH;
			w = 0.0572917 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
	};
};

