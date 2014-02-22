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
	
class MCC_artilleryDialogFrame: MCC_RscText
{
	idc = 78;
	colorBackground[] = {0,0,0,0.9};
	
	x = 0.385417 * safezoneW + safezoneX;
	y = 0.214111 * safezoneH + safezoneY;
	w = 0.20625 * safezoneW;
	h = 0.274893 * safezoneH;
};

class MCC_artilleryTitle: MCC_RscText
{
	idc = 66;
	text = "Artillery:"; //--- ToDo: Localize;
	colorText[] = {0,1,1,1};
	
	x = 0.45 * safezoneW + safezoneX;
	y = 0.225107 * safezoneH + safezoneY;
	w = 0.154688 * safezoneW;
	h = 0.0329871 * safezoneH;
};
class MCC_artilleryTypeTitle: MCC_RscText
{
	idc = 67;

	text = "Type:"; //--- ToDo: Localize;
	x = 0.391146 * safezoneW + safezoneX;
	y = 0.26909 * safezoneH + safezoneY;
	w = 0.06875 * safezoneW;
	h = 0.0219914 * safezoneH;
};
class MCC_artillerySpreadTitle: MCC_RscText
{
	idc = 68;

	text = "Spread:"; //--- ToDo: Localize;
	x = 0.391146 * safezoneW + safezoneX;
	y = 0.302077 * safezoneH + safezoneY;
	w = 0.06875 * safezoneW;
	h = 0.0219914 * safezoneH;
};
class MCC_artilleryNumberTitle: MCC_RscText
{
	idc = 69;

	text = "N. of Shells:"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	
	x = 0.391146 * safezoneW + safezoneX;
	y = 0.335064 * safezoneH + safezoneY;
	w = 0.06875 * safezoneW;
	h = 0.0219914 * safezoneH;
};
class MCC_artilleryType: MCC_RscCombo
{
	idc = 70;

	x = 0.465625 * safezoneW + safezoneX;
	y = 0.26909 * safezoneH + safezoneY;
	w = 0.120313 * safezoneW;
	h = 0.0219914 * safezoneH;
};
class MCC_artillerySpread: MCC_RscCombo
{
	idc = 71;

	x = 0.465625 * safezoneW + safezoneX;
	y = 0.302077 * safezoneH + safezoneY;
	w = 0.120313 * safezoneW;
	h = 0.0219914 * safezoneH;
};
class MCC_artilleryNumber: MCC_RscCombo
{
	idc = 72;

	x = 0.465625 * safezoneW + safezoneX;
	y = 0.335064 * safezoneH + safezoneY;
	w = 0.120313 * safezoneW;
	h = 0.0219914 * safezoneH;
};
class MCC_artilleryDelayText: MCC_RscText
{
	idc = 73;

	text = "Delay:"; //--- ToDo: Localize;
	x = 0.391146 * safezoneW + safezoneX;
	y = 0.368051 * safezoneH + safezoneY;
	w = 0.06875 * safezoneW;
	h = 0.0219914 * safezoneH;
};
class MCC_artilleryDelayCombo: MCC_RscCombo
{
	idc = 74;

	x = 0.465625 * safezoneW + safezoneX;
	y = 0.368051 * safezoneH + safezoneY;
	w = 0.120313 * safezoneW;
	h = 0.0219914 * safezoneH;
};
class MCC_artilleryCall: MCC_RscButton
{
	idc = 75;
	onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\artillery\artillery_request.sqf'");

	text = "Call"; //--- ToDo: Localize;
	x = 0.391146 * safezoneW + safezoneX;
	y = 0.401039 * safezoneH + safezoneY;
	w = 0.0859375 * safezoneW;
	h = 0.0329871 * safezoneH;
	tooltip = "Call Artillery on map position"; //--- ToDo: Localize;
};
class MCC_artilleryAdd: MCC_RscButton
{
	idc = 76;
	onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\artillery\artillery_request.sqf'");

	text = "Add"; //--- ToDo: Localize;
	x = 0.5 * safezoneW + safezoneX;
	y = 0.401039 * safezoneH + safezoneY;
	w = 0.0859375 * safezoneW;
	h = 0.0329871 * safezoneH;
	tooltip = "Add artillery to MCC Console "; //--- ToDo: Localize;
};
class MCC_artilleryDialogClose: MCC_RscButton
{
	idc = 77;
	onButtonClick = __EVAL("[5] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");

	text = "Close"; //--- ToDo: Localize;
	x = 0.448438 * safezoneW + safezoneX;
	y = 0.445021 * safezoneH + safezoneY;
	w = 0.0859375 * safezoneW;
	h = 0.0329871 * safezoneH;
};
	};
};