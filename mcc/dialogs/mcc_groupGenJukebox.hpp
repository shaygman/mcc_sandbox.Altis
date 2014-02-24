#define MCC_JUKEBOX_VOLUME 3059
#define MCC_JUKEBOX_TRACK 3060
#define MCC_JUKEBOX_ACTIVATE 3061
#define MCC_JUKEBOX_CONDITION 3062
#define MCC_JUKEBOX_ZONE 3063

class MCC_jukeboxDialogControls: MCC_RscControlsGroup
{
	idc = 514;
	x = 0.685 * safezoneW + safezoneX;
	y = 0.28 * safezoneH + safezoneY;
	w = 0.171875 * safezoneW;
	h = 0.285889 * safezoneH;

	class Controls
	{			
		class MCC_jukeboxDialogFrame: MCC_RscText
		{
			idc = -1;
			colorBackground[] = {0,0,0,0.9};
			
			x = 0.270833 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.171875 * safezoneW;
			h = 0.285889 * safezoneH;
		};

		class MCC_JukeboxTittle: MCC_RscText
		{
			idc = -1;

			text = "Juke Box:"; //--- ToDo: Localize;
			x = 0.316667 * safezoneW + safezoneX;
			y = 0.236103 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.0280063 * safezoneH;
			colorText[] = {0,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_JukeboxMusic: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL ("[6] execVM '"+MCCPATH+"mcc\general_scripts\jukebox\jukebox.sqf'");

			text = "Music"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.26909 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Switch to music tracks"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_JukeboxSound: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL ("[7] execVM '"+MCCPATH+"mcc\general_scripts\jukebox\jukebox.sqf'");

			text = "Sound"; //--- ToDo: Localize;
			x = 0.356771 * safezoneW + safezoneX;
			y = 0.26909 * safezoneH + safezoneY;
			w = 0.0802083 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Switch to sound tracks"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_JukeboxTrackTittle: MCC_RscText
		{
			idc = -1;

			text = "Track:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.302077 * safezoneH + safezoneY;
			w = 0.0459375 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_JukeboxVolumeTittle: MCC_RscText
		{
			idc = -1;

			text = "Volume:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.335064 * safezoneH + safezoneY;
			w = 0.0459375 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_JukeboxActivateTittle: MCC_RscText
		{
			idc = -1;

			text = "Activate:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.368051 * safezoneH + safezoneY;
			w = 0.0459375 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_JukeboxConditionTittle: MCC_RscText
		{
			idc = -1;

			text = "Condition:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.401039 * safezoneH + safezoneY;
			w = 0.0459375 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_JukeboxZoneTittle: MCC_RscText
		{
			idc = -1;

			text = "Zone:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.434026 * safezoneH + safezoneY;
			w = 0.0459375 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_JukeboxLink: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL ("[5] execVM '"+MCCPATH+"mcc\general_scripts\jukebox\jukebox.sqf'");

			text = "Link"; //--- ToDo: Localize;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.434026 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.0280063 * safezoneH;
			tooltip = "Link the sound or music to the selected zone"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_JukeboxVolume: MCC_RscSlider
		{
			idc = MCC_JUKEBOX_VOLUME;
			onSliderPosChanged = __EVAL ("[4] execVM '"+MCCPATH+"mcc\general_scripts\jukebox\jukebox.sqf'");

			x = 0.328125 * safezoneW + safezoneX;
			y = 0.335064 * safezoneH + safezoneY;
			w = 0.0590624 * safezoneW;
			h = 0.0280063 * safezoneH;
		};
		class MCC_JukeboxTrack: MCC_RscCombo
		{
			idc = MCC_JUKEBOX_TRACK;

			x = 0.328125 * safezoneW + safezoneX;
			y = 0.302077 * safezoneH + safezoneY;
			w = 0.111562 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_JukeboxActivate: MCC_RscCombo
		{
			idc = MCC_JUKEBOX_ACTIVATE;

			x = 0.328125 * safezoneW + safezoneX;
			y = 0.368051 * safezoneH + safezoneY;
			w = 0.111562 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_JukeboxCondition: MCC_RscCombo
		{
			idc = MCC_JUKEBOX_CONDITION;

			x = 0.328125 * safezoneW + safezoneX;
			y = 0.401039 * safezoneH + safezoneY;
			w = 0.111562 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_JukeboxZone: MCC_RscCombo
		{
			idc = MCC_JUKEBOX_ZONE;

			x = 0.328125 * safezoneW + safezoneX;
			y = 0.434026 * safezoneH + safezoneY;
			w = 0.0590624 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_JukeboxPlay: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL ("[1] execVM '"+MCCPATH+"mcc\general_scripts\jukebox\jukebox.sqf'");

			text = ">"; //--- ToDo: Localize;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.335064 * safezoneH + safezoneY;
			w = 0.0196875 * safezoneW;
			h = 0.0280063 * safezoneH;
			tooltip = "Play track"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class MCC_JukeboxStop: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL ("[3] execVM '"+MCCPATH+"mcc\general_scripts\jukebox\jukebox.sqf'");

			text = "[]"; //--- ToDo: Localize;
			x = 0.419792 * safezoneW + safezoneX;
			y = 0.335064 * safezoneH + safezoneY;
			w = 0.0196875 * safezoneW;
			h = 0.0280063 * safezoneH;
			tooltip = "Stop track"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		
		class MCC_jukeboxClose: MCC_RscButtonMenu
		{
			idc = -1;
			onButtonClick = __EVAL("[13] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");

			text = "Close"; //--- ToDo: Localize;
			x = 0.328125 * safezoneW + safezoneX;
			y = 0.467013 * safezoneH + safezoneY;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Link the sound or music to the selected zone"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
	};
};

