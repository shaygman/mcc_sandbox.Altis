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
	
//=====================Convoy=================================================================
class MCC_ConvoyTittle: MCC_RscText
{
	idc = -1;
	text = "Convoy:"; //--- ToDo: Localize;
	x = 0.355625 * safezoneW + safezoneX;
	y = 0.415981 * safezoneH + safezoneY;
	w = 0.065625 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyCar1Tittle: MCC_RscText
{
	idc = -1;
	text = "Car1:"; //--- ToDo: Localize;
	x = 0.355625 * safezoneW + safezoneX;
	y = 0.457991 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyCar2Tittle: MCC_RscText
{
	idc = -1;
	text = "Car2:"; //--- ToDo: Localize;
	x = 0.355625 * safezoneW + safezoneX;
	y = 0.5 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyCar3Tittle: MCC_RscText
{
	idc = -1;
	text = "Car3:"; //--- ToDo: Localize;
	x = 0.355625 * safezoneW + safezoneX;
	y = 0.542009 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyCar4Tittle: MCC_RscText
{
	idc = -1;
	text = "Car4:"; //--- ToDo: Localize;
	x = 0.355625 * safezoneW + safezoneX;
	y = 0.584019 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyCar5Tittle: MCC_RscText
{
	idc = -1;
	text = "Car5:"; //--- ToDo: Localize;
	x = 0.355625 * safezoneW + safezoneX;
	y = 0.626028 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyCar1: MCC_RscCombo
{
	idc = MCC_CONVOY_CAR1;
	x = 0.408125 * safezoneW + safezoneX;
	y = 0.457991 * safezoneH + safezoneY;
	w = 0.091875 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyCar2: MCC_RscCombo
{
	idc = MCC_CONVOY_CAR2;
	x = 0.408125 * safezoneW + safezoneX;
	y = 0.5 * safezoneH + safezoneY;
	w = 0.091875 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyCar3: MCC_RscCombo
{
	idc = MCC_CONVOY_CAR3;
	x = 0.408125 * safezoneW + safezoneX;
	y = 0.542009 * safezoneH + safezoneY;
	w = 0.091875 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyCar4: MCC_RscCombo
{
	idc = MCC_CONVOY_CAR4;
	x = 0.408125 * safezoneW + safezoneX;
	y = 0.584019 * safezoneH + safezoneY;
	w = 0.091875 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyCar5: MCC_RscCombo
{
	idc = MCC_CONVOY_CAR5;
	x = 0.408125 * safezoneW + safezoneX;
	y = 0.626028 * safezoneH + safezoneY;
	w = 0.091875 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyHVTTittle: MCC_RscText
{
	idc = -1;
	text = "HVT:"; //--- ToDo: Localize;
	x = 0.355625 * safezoneW + safezoneX;
	y = 0.668037 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyHVTCarTittle: MCC_RscText
{
	idc = -1;
	text = "HVT Car:"; //--- ToDo: Localize;
	x = 0.355625 * safezoneW + safezoneX;
	y = 0.710047 * safezoneH + safezoneY;
	w = 0.0459375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
};
class MCC_ConvoyHVT: MCC_RscCombo
{
	idc = MCC_CONVOY_HVT;
	x = 0.408125 * safezoneW + safezoneX;
	y = 0.668037 * safezoneH + safezoneY;
	w = 0.091875 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_ConvoyHVTCar: MCC_RscCombo
{
	idc = MCC_CONVOY_HVTCAR;
	x = 0.408125 * safezoneW + safezoneX;
	y = 0.710047 * safezoneH + safezoneY;
	w = 0.091875 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_convoySpawn: MCC_RscButton
{
	idc = -1;
	text = "Spawn"; //--- ToDo: Localize;
	onButtonClick = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\convoy\make_convoy_WP.sqf'");
	x = 0.355625 * safezoneW + safezoneX;
	y = 0.752056 * safezoneH + safezoneY;
	w = 0.0459375 * safezoneW;
	h = 0.0280062 * safezoneH;
	tooltip = "Spawn convoy and set WP"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_convoyReset: MCC_RscButton
{
	idc = -1;
	text = "Reset"; //--- ToDo: Localize;
	onButtonClick = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\convoy\reset_convoy_WP.sqf'");
	x = 0.408125 * safezoneW + safezoneX;
	y = 0.752056 * safezoneH + safezoneY;
	w = 0.0459375 * safezoneW;
	h = 0.0280062 * safezoneH;
	tooltip = "Reset convoy's waypoints"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_convoyStart: MCC_RscButton
{
	idc = -1;
	text = "Start"; //--- ToDo: Localize;
	onButtonClick = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\convoy\start_convoy.sqf'");
	x = 0.460625 * safezoneW + safezoneX;
	y = 0.752056 * safezoneH + safezoneY;
	w = 0.0459375 * safezoneW;
	h = 0.0280062 * safezoneH;
	tooltip = "Start convoy movement"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
	};
};