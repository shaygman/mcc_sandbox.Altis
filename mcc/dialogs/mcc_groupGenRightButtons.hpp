class MCC_MissionSettings: MCC_RscButton
{
	idc = -1;
	text = "Mission Settings";
	onButtonClick = "if (mcc_missionmaker == (name player)) then {MCC_button createDialog 'missionSettings';} else {player globalchat 'Access Denied'};";
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	
	x = 0.866667 * safezoneW + safezoneX; //866667
	y = 0.0931586 * safezoneH + safezoneY;
	w = 0.06875 * safezoneW;
	h = 0.0329871 * safezoneH;
};
class MCC_StartDisableRespawn: MCC_RscButton
{
	idc = 2;
	text = "Disable Respawn"; 
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Disable respawn to all players"; 
	action = __EVAL("[4] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");
	
	x = 0.866667 * safezoneW + safezoneX;
	y = 0.181124 * safezoneH + safezoneY;
	w = 0.06875 * safezoneW;
	h = 0.0329871 * safezoneH;
};
		
class MCC_setWeatherButton: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
	text = "Set Weather"; //--- ToDo: Localize;
	tooltip = "Set weather to all players"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	
	x = 0.866667 * safezoneW + safezoneX;
	y = 0.225107 * safezoneH + safezoneY;
	w = 0.06875 * safezoneW;
	h = 0.0329871 * safezoneH;

};

class MCC_setTimeButton: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
	text = "Set Time"; //--- ToDo: Localize;
	tooltip = "Sets time to all players"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	
	x = 0.866667 * safezoneW + safezoneX;
	y = 0.26909 * safezoneH + safezoneY;
	w = 0.06875 * safezoneW;
	h = 0.0329871 * safezoneH;		
};

class MCC_StartLocation: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
	text = "Start Locations"; //--- ToDo: Localize;
	tooltip = "Handle respawns to all players"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	
	x = 0.866667 * safezoneW + safezoneX;
	y = 0.137141 * safezoneH + safezoneY;
	w = 0.06875 * safezoneW;
	h = 0.0329871 * safezoneH;			
};

class MCC_debugButton: MCC_RscButton
{
	idc = -1;
	onButtonClick = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
	text = "Debug"; //--- ToDo: Localize;
	tooltip = "Open Debug options"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	
	x = 0.866667 * safezoneW + safezoneX;
	y = 0.313073 * safezoneH + safezoneY;
	w = 0.06875 * safezoneW;
	h = 0.0329871 * safezoneH;
};