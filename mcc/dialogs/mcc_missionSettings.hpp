// By: Shay_gman
// Version: 1.1 (September 2011)
#define missionSettings_IDD 2997

//-----------------------------------------------------------------------------
// Main dialog
//-----------------------------------------------------------------------------
class missionSettings
{
	idd = missionSettings_IDD;
	movingEnable = true;

	controlsBackground[] =
	{
	};

	objects[] =
	{
	};

	class controls
	{
		class RscPicture_1200: MCC_RscText
		{
			idc = -1;
			moving = true;
			x = 0.12875 * safezoneW + safezoneX;
			y = 0.17 * safezoneH + safezoneY;
			w = 0.670312 * safezoneW;
			h = 0.583 * safezoneH;
			text = "";
			colorBackground[] = { 0, 0, 0, 0.8 };
		};

		class CancelButton: MCC_RscButton
		{
			idc = -1;
			action = "closeDialog 0";

			text = "Cancel"; //--- ToDo: Localize;
			x = 0.133906 * safezoneW + safezoneX;
			y = 0.698 * safezoneH + safezoneY;
			w = 0.120313 * safezoneW;
			h = 0.0439828 * safezoneH;
		};

		class MissionSettingsButton: MCC_RscButton
		{
			idc = -1;
			action = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\mission_settings\mission_settings_change.sqf'");

			text = "Mission Settings";
			x = 0.3 * safezoneW + safezoneX;
			y = 0.2 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.05 * safezoneH;
		};

		class UISettingsButton: MCC_RscButton
		{
			idc = -1;
			action = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\mission_settings\mission_settings_change.sqf'");

			text = "UI Settings";
			x = 0.3 * safezoneW + safezoneX;
			y = 0.26 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.05 * safezoneH;
		};

		class classMechanicsSettingsButton: MCC_RscButton
		{
			idc = -1;
			action = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\mission_settings\mission_settings_change.sqf'");

			text = "Mechanics Settings";
			x = 0.3 * safezoneW + safezoneX;
			y = 0.32 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.05 * safezoneH;
		};

		class classMedicalSettingsButton: MCC_RscButton
		{
			idc = -1;
			action = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\mission_settings\mission_settings_change.sqf'");

			text = "Medical System Settings";
			x = 0.3 * safezoneW + safezoneX;
			y = 0.38 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.05 * safezoneH;
		};

		class classRSSettingsButton: MCC_RscButton
		{
			idc = -1;
			action = __EVAL("[4] execVM '"+MCCPATH+"mcc\general_scripts\mission_settings\mission_settings_change.sqf'");

			text = "Role Selection Settings";
			x = 0.3 * safezoneW + safezoneX;
			y = 0.44 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.05 * safezoneH;
		};

		class classGAIASettingsButton: MCC_RscButton
		{
			idc = -1;
			action = __EVAL("[5] execVM '"+MCCPATH+"mcc\general_scripts\mission_settings\mission_settings_change.sqf'");

			text = "GAIA Settings";
			x = 0.3 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.25 * safezoneW;
			h = 0.05 * safezoneH;
		};
	};
};
