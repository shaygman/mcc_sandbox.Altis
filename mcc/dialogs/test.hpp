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
	{ 
	};

	class controls 
	{
class MCC_UMList: MCC_RscListbox
		{
			idc = MCC_UM_LIST;
			rowHeight = 0.022;
			colorBackground[] = { 0, 0, 0,1};
			onLBSelChanged = __EVAL("[4] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");
			onMouseButtonUp = __EVAL("[8,_this] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";

			x = 0.276563 * safezoneW + safezoneX;
			y = 0.26909 * safezoneH + safezoneY;
			w = 0.160417 * safezoneW;
			h = 0.109957 * safezoneH;
		};
		class MCC_UMUnits: MCC_RscToolbox
		{
			idc = -1;
			strings[] = {"Units","Groups"};
			rows = 1;
			columns = 2;
			values[] = {0,1};
			onToolBoxSelChanged = "MCC_UMUnit = (_this select 1); [] call MCC_fnc_groupGenUMRefresh;";

			x = 0.276563 * safezoneW + safezoneX;
			y = 0.236103 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Switch dispaly between units and groups from the given side"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_UMTeleport: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL ("[0] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");

			text = "Teleport"; //--- ToDo: Localize;
			x = 0.442708 * safezoneW + safezoneX;
			y = 0.258094 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Teleport selected units"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_UMHijak: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL ("[2] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");

			text = "Hijack"; //--- ToDo: Localize;
			x = 0.442708 * safezoneW + safezoneX;
			y = 0.324069 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Hijack selected unit, can only work on non-player units "; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_UMMark: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL ("[3] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");

			text = "Track units"; //--- ToDo: Localize;
			x = 0.442708 * safezoneW + safezoneX;
			y = 0.357056 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Toggle on and off tracking all units on mission maker map"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_UMbroadcast: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL ("[11] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");

			text = "Broadcast"; //--- ToDo: Localize;
			x = 0.442708 * safezoneW + safezoneX;
			y = 0.291081 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Broadcast the live feed to all players for 15 seconds"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_UMDelete: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL ("[12] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");

			text = "Delete"; //--- ToDo: Localize;
			x = 0.505729 * safezoneW + safezoneX;
			y = 0.291081 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Delete the selected unit or group"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_UMJoin: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL ("[13] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");

			text = "Join"; //--- ToDo: Localize;
			x = 0.505729 * safezoneW + safezoneX;
			y = 0.258094 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Join group or unit with another group or unit"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_UMHALO: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL ("[9] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");

			text = "H.A.L.O"; //--- ToDo: Localize;
			x = 0.505729 * safezoneW + safezoneX;
			y = 0.357056 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "HALO the current selected units"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_UMParachute: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL ("[10] execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um.sqf'");

			text = "Parachute"; //--- ToDo: Localize;
			x = 0.505729 * safezoneW + safezoneX;
			y = 0.324069 * safezoneH + safezoneY;
			w = 0.0515625 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Parachute the currently selected units"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_UMListFrame: MCC_RscFrame
		{
			idc = -1;

			x = 0.276563 * safezoneW + safezoneX;
			y = 0.26909 * safezoneH + safezoneY;
			w = 0.160417 * safezoneW;
			h = 0.109957 * safezoneH;
		};
		class MCC_UMhint: MCC_RscText
		{
			idc = -1;

			text = "*Hold Ctrl for multi-selection"; //--- ToDo: Localize;
			x = 0.35 * safezoneW + safezoneX;
			y = 0.236103 * safezoneH + safezoneY;
			w = 0.0916667 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.55)";
		};
		class MCC_PIPUm: MCC_RscPicture
		{
			idc = MCC_UM_PIC;
			colorBackground[] = { 0, 0, 0,1};
			
			text = "#(argb,256,256,1)r2t(rendertarget10,1.0);"; //--- ToDo: Localize;
			x = 0.563021 * safezoneW + safezoneX;
			y = 0.236103 * safezoneH + safezoneY;
			w = 0.171875 * safezoneW;
			h = 0.120953 * safezoneH;
		};
		class MCC_PIPUmFrame: MCC_RscFrame
		{
			idc = -1;

			x = 0.563021 * safezoneW + safezoneX;
			y = 0.236103 * safezoneH + safezoneY;
			w = 0.171875 * safezoneW;
			h = 0.120953 * safezoneH;
		};
		class MCC_PIPviewMod: MCC_RscToolbox
		{
			idc = -1;
			strings[] = {"Regular","Night Vision","Thermal"};
			rows = 1;
			columns = 3;
			values[] = {0,1,3};
			onToolBoxSelChanged = __EVAL("_this execVM '"+MCCPATH+"mcc\general_scripts\unitManage\um_camView.sqf'");

			x = 0.563021 * safezoneW + safezoneX;
			y = 0.359915 * safezoneH + safezoneY;
			w = 0.171875 * safezoneW;
			h = 0.0219914 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
	};
};