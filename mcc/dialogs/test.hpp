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
//=========================== Jukebox =====================================================
class MCC_JukeboxTittle: MCC_RscText
{
	idc = -1;
	text = "Juke Box:"; //--- ToDo: Localize;
	x = 0.185 * safezoneW + safezoneX;
	y = 0.443988 * safezoneH + safezoneY;
	w = 0.0721875 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {0,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_JukeboxMusic: MCC_RscButton
{
	idc = -1;
	text = "Music"; //--- ToDo: Localize;
	x = 0.26375 * safezoneW + safezoneX;
	y = 0.443988 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	onButtonClick = __EVAL ("[6] execVM '"+MCCPATH+"mcc\general_scripts\jukebox\jukebox.sqf'");
	tooltip = "Switch to music tracks"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_JukeboxSound: MCC_RscButton
{
	idc = -1;
	text = "Sound"; //--- ToDo: Localize;
	x = 0.309687 * safezoneW + safezoneX;
	y = 0.443988 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	onButtonClick = __EVAL ("[7] execVM '"+MCCPATH+"mcc\general_scripts\jukebox\jukebox.sqf'");
	tooltip = "Switch to sound tracks"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_JukeboxTrackTittle: MCC_RscText
{
	idc = -1;
	text = "Track:"; //--- ToDo: Localize;
	x = 0.185 * safezoneW + safezoneX;
	y = 0.485997 * safezoneH + safezoneY;
	w = 0.0459375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_JukeboxVolumeTittle: MCC_RscText
{
	idc = -1;
	text = "Volume:"; //--- ToDo: Localize;
	x = 0.185 * safezoneW + safezoneX;
	y = 0.528006 * safezoneH + safezoneY;
	w = 0.0459375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_JukeboxActivateTittle: MCC_RscText
{
	idc = -1;
	text = "Activate:"; //--- ToDo: Localize;
	x = 0.185 * safezoneW + safezoneX;
	y = 0.570016 * safezoneH + safezoneY;
	w = 0.0459375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_JukeboxConditionTittle: MCC_RscText
{
	idc = -1;
	text = "Condition:"; //--- ToDo: Localize;
	x = 0.185 * safezoneW + safezoneX;
	y = 0.612025 * safezoneH + safezoneY;
	w = 0.0459375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.6)";
};
class MCC_JukeboxZoneTittle: MCC_RscText
{
	idc = -1;
	text = "Zone:"; //--- ToDo: Localize;
	x = 0.185 * safezoneW + safezoneX;
	y = 0.654034 * safezoneH + safezoneY;
	w = 0.0459375 * safezoneW;
	h = 0.0280062 * safezoneH;
	colorText[] = {1,1,1,1};
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_JukeboxLink: MCC_RscButton
{
	idc = -1;
	text = "Link"; //--- ToDo: Localize;
	x = 0.309687 * safezoneW + safezoneX;
	y = 0.654034 * safezoneH + safezoneY;
	w = 0.039375 * safezoneW;
	h = 0.0280062 * safezoneH;
	onButtonClick = __EVAL ("[5] execVM '"+MCCPATH+"mcc\general_scripts\jukebox\jukebox.sqf'");
	tooltip = "Link the sound or music to the selected zone"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_JukeboxVolume: MCC_RscSlider
{
	idc = MCC_JUKEBOX_VOLUME;
	x = 0.2375 * safezoneW + safezoneX;
	y = 0.528006 * safezoneH + safezoneY;
	w = 0.0590625 * safezoneW;
	h = 0.0280062 * safezoneH;
	onSliderPosChanged = __EVAL ("[4] execVM '"+MCCPATH+"mcc\general_scripts\jukebox\jukebox.sqf'");
};
class MCC_JukeboxTrack: MCC_RscCombo
{
	idc = MCC_JUKEBOX_TRACK;
	x = 0.2375 * safezoneW + safezoneX;
	y = 0.485997 * safezoneH + safezoneY;
	w = 0.111562 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_JukeboxActivate: MCC_RscCombo
{
	idc = MCC_JUKEBOX_ACTIVATE;
	x = 0.2375 * safezoneW + safezoneX;
	y = 0.570016 * safezoneH + safezoneY;
	w = 0.111562 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_JukeboxCondition: MCC_RscCombo
{
	idc = MCC_JUKEBOX_CONDITION;
	x = 0.2375 * safezoneW + safezoneX;
	y = 0.612025 * safezoneH + safezoneY;
	w = 0.111562 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_JukeboxZone: MCC_RscCombo
{
	idc = MCC_JUKEBOX_ZONE;
	x = 0.2375 * safezoneW + safezoneX;
	y = 0.654034 * safezoneH + safezoneY;
	w = 0.0590625 * safezoneW;
	h = 0.0280062 * safezoneH;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
};
class MCC_JukeboxPlay: MCC_RscButton
{
	idc = -1;
	text = ">"; //--- ToDo: Localize;
	x = 0.303125 * safezoneW + safezoneX;
	y = 0.528006 * safezoneH + safezoneY;
	w = 0.0196875 * safezoneW;
	h = 0.0280062 * safezoneH;
	onButtonClick = __EVAL ("[1] execVM '"+MCCPATH+"mcc\general_scripts\jukebox\jukebox.sqf'");
	tooltip = "Play track"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};
class MCC_JukeboxStop: MCC_RscButton
{
	idc = -1;
	text = "[]"; //--- ToDo: Localize;
	x = 0.329376 * safezoneW + safezoneX;
	y = 0.528006 * safezoneH + safezoneY;
	w = 0.0196875 * safezoneW;
	h = 0.0280062 * safezoneH;
	onButtonClick = __EVAL ("[3] execVM '"+MCCPATH+"mcc\general_scripts\jukebox\jukebox.sqf'");
	tooltip = "Stop track"; //--- ToDo: Localize;
	sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
};

	};
};