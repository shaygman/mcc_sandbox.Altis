class MCC_3DEditor: MCC_RscButton 
{
	idc = -1; text = "3D Editor"; 
	x = 0.110417 * safezoneW + safezoneX;
	y = 0.0931586 * safezoneH + safezoneY;
	w = 0.06875 * safezoneW;
	h = 0.0329871 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Open 3D editor"; 
	onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\pop_menu\spawn_group3d.sqf'");
};

class MCC_boxGenerator: MCC_RscButton
{
	idc = -1;
	text = "Box Generator"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Open Box Generator"; 
	onButtonClick = "if (mcc_missionmaker == (name player)) then {createDialog 'boxGen';} else {player globalchat 'Access Denied'};";
	
	x = 0.110417 * safezoneW + safezoneX;
	y = 0.137141 * safezoneH + safezoneY;	//0.0439824
	w = 0.06875 * safezoneW;
	h = 0.0329871 * safezoneH;
};

class MCC_callCASButton: MCC_RscButton
{
	idc = -1;
	text = "CAS"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Open Close Air Support Generator"; 
	onButtonClick = __EVAL("[4] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
	
	x = 0.110417 * safezoneW + safezoneX;
	y = 0.1811234 * safezoneH + safezoneY;
	w = 0.06875 * safezoneW;
	h = 0.0329871 * safezoneH;
};

class MCC_callArtilleryButton: MCC_RscButton
{
	idc = -1;
	text = "Artillery"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Open artillery Generator"; 
	onButtonClick = __EVAL("[5] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
	
	x = 0.110417 * safezoneW + safezoneX;
	y = 0.2251058 * safezoneH + safezoneY;
	w = 0.06875 * safezoneW;
	h = 0.0329871 * safezoneH;
};

class MCC_callEvacButton: MCC_RscButton
{
	idc = -1;
	text = "Evac"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
	tooltip = "Open Evac Generator"; 
	onButtonClick = __EVAL("[6] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
	
	x = 0.110417 * safezoneW + safezoneX;
	y = 0.2690882 * safezoneH + safezoneY;
	w = 0.06875 * safezoneW;
	h = 0.0329871 * safezoneH;
};