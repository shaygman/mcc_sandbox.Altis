#define RESISTANCE_HOSTILE 8401 
#define T2T_AD 8402

#define MCC_MSCONSOLEGPS 8407
#define MCC_MSCONSOLESHOWFRIENDS 8408
#define MCC_MSCONSOLECOMMANDAI 8409
#define MCC_IDCNAMETAGS 8410
#define mcc_artilleryTitleIDC 8411
#define mcc_saveGearComboIDC 8412
#define mcc_showGRPMarkerComboIDC 8413
#define mcc_showMessagesComboIDC 8414
#define MCC_timeExcelIDC 8419
#define mcc_deletePlayerBodyIDC 8425

class rscMCCSettings: MCC_RscControlsGroupNoScrollbars
{
	idc = -1;
	x = 0.133906 * safezoneW + safezoneX;
	y = 0.192 * safezoneH + safezoneY;
	w = 0.665156 * safezoneW;
	h = 0.176 * safezoneH;
	
	class controls
	{
		class missionSettingsTittle: MCC_RscText
		{
			idc = -1;

			text = "Mission Settings:"; //--- ToDo: Localize;
			x = 0.293907 * safezoneW;
			y = 2.04891e-008 * safezoneH;
			w = 0.133125 * safezoneW;
			h = 0.0299633 * safezoneH;
			colorText[] = {0,1,1,1};
			colorBackground[] = {1,1,1,0};
		};
		class resistanceHostileTittle: MCC_RscText
		{
			idc = -1;

			text = "Resistance Hostility:"; //--- ToDo: Localize;
			x = 0.00515599 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class resistanceHostileCombo: MCC_RscCombo
		{
			idc = RESISTANCE_HOSTILE;

			x = 0.118594 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.0687499 * safezoneW;
			h = 0.0211735 * safezoneH;
			tooltip = "Change only once before placing any units"; //--- ToDo: Localize;
		};
		class t2tTittle: MCC_RscText
		{
			idc = -1;

			text = "Teleport To Team:"; //--- ToDo: Localize;
			x = 0.00515597 * safezoneW;
			y = 0.077 * safezoneH;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class t2tCombo: MCC_RscCombo
		{
			idc = T2T_AD;

			x = 0.118593 * safezoneW;
			y = 0.077 * safezoneH;
			w = 0.0687499 * safezoneW;
			h = 0.0211735 * safezoneH;
			tooltip = "Enable/Disable Teleport to team for all player"; //--- ToDo: Localize;
		};
		class ConsoleGPSTittle: MCC_RscText
		{
			idc = -1;

			text = "Console - Show units without GPS:"; //--- ToDo: Localize;
			x = 0.386719 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.177604 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class ConsoleGPS: MCC_RscCombo
		{
			idc = MCC_MSCONSOLEGPS;

			x = 0.572344 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "If disabled groups without GPS will not be shown in the Player's Console"; //--- ToDo: Localize;
		};
		class ConsoleShowFriendlyWPTittle: MCC_RscText
		{
			idc = -1;

			text = "Console - Show Freindly WP:"; //--- ToDo: Localize;
			x = 0.386719 * safezoneW;
			y = 0.077 * safezoneH;
			w = 0.177604 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class ConsoleShowFriendlyWP: MCC_RscCombo
		{
			idc = MCC_MSCONSOLESHOWFRIENDS;

			x = 0.572344 * safezoneW;
			y = 0.077 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "If enabled friendly AI and players' WP will be shown in the Player's Console"; //--- ToDo: Localize;
		};
		class ConsoleCanCommandAI: MCC_RscCombo
		{
			idc = MCC_MSCONSOLECOMMANDAI;

			x = 0.572344 * safezoneW;
			y = 0.11 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "If enabled players can use the handheld console to control AI groups spawned with default BIS behavior."; //--- ToDo: Localize;
		};
		class ConsoleCanCommandAITittle: MCC_RscText
		{
			idc = -1;

			text = "Console - Can Command AI:"; //--- ToDo: Localize;
			x = 0.386719 * safezoneW;
			y = 0.11 * safezoneH;
			w = 0.177604 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class deletePlayerBody: MCC_RscCombo
		{
			idc = mcc_deletePlayerBodyIDC;

			x = 0.572344 * safezoneW;
			y = 0.143 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Delete players body after respawn."; //--- ToDo: Localize;
		};
		class deletePlayerBodyTittle: MCC_RscText
		{
			idc = -1;

			text = "Delete Players Body:"; //--- ToDo: Localize;
			x = 0.386719 * safezoneW;
			y = 0.143 * safezoneH;
			w = 0.177604 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class mcc_nameTags: MCC_RscText
		{
			idc = -1;

			text = "Name Tags:"; //--- ToDo: Localize;
			x = 0.195938 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class mcc_nameTagsCombo: MCC_RscCombo
		{
			idc = MCC_IDCNAMETAGS;

			x = 0.309375 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Disable/Enable name tags for all players."; //--- ToDo: Localize;
		};
		class mcc_artilleryTitle: MCC_RscText
		{
			idc = -1;

			text = "Artillery Computer:"; //--- ToDo: Localize;
			x = 0.195938 * safezoneW;
			y = 0.077 * safezoneH;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class mcc_artilleryCombo: MCC_RscCombo
		{
			idc = mcc_artilleryTitleIDC;

			x = 0.309375 * safezoneW;
			y = 0.077 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Disable/Enable the artillery computer to all players"; //--- ToDo: Localize;
		};
		class mcc_saveGearTitle: MCC_RscText
		{
			idc = -1;

			text = "Save Gear:"; //--- ToDo: Localize;
			x = 0.00515597 * safezoneW;
			y = 0.11 * safezoneH;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class mcc_saveGearCombo: MCC_RscCombo
		{
			idc = mcc_saveGearComboIDC;

			x = 0.118593 * safezoneW;
			y = 0.11 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Disable/Enable MCC save gear (keep it disabled if you are using any medical system"; //--- ToDo: Localize;
		};
		class mcc_showGRPMarkerTitle: MCC_RscText
		{
			idc = -1;

			text = "Groups Marker(Roles):"; //--- ToDo: Localize;
			x = 0.195938 * safezoneW;
			y = 0.11 * safezoneH;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class mcc_showGRPMarkerCombo: MCC_RscCombo
		{
			idc = mcc_showGRPMarkerComboIDC;

			x = 0.309375 * safezoneW;
			y = 0.11 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Disable/Enable group markers when playing with role selection"; //--- ToDo: Localize;
		};
		class mcc_showMessages: MCC_RscText
		{
			idc = -1;

			text = "Show MCC Messages"; //--- ToDo: Localize;
			x = 0.00515597 * safezoneW;
			y = 0.143 * safezoneH;
			w = 0.108854 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class mcc_showMessagesCombo: MCC_RscCombo
		{
			idc = mcc_showMessagesComboIDC;

			x = 0.118594 * safezoneW;
			y = 0.143 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Disable/Enable MCC's Messages"; //--- ToDo: Localize;
		};
		class mcc_TimeExcelTitle: MCC_RscText
		{
			idc = -1;

			text = "Time acceleration"; //--- ToDo: Localize;
			x = 0.195938 * safezoneW;
			y = 0.143 * safezoneH;
			w = 0.108854 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class mcc_TimeExcelCombo: MCC_RscCombo
		{
			idc = MCC_timeExcelIDC;

			x = 0.309375 * safezoneW;
			y = 0.143 * safezoneH;
			w = 0.06875 * safezoneW;
			h = 0.0219914 * safezoneH;
			tooltip = "Accelerate time example: x12 means 24 game hours will be passed in 2 real time hours"; //--- ToDo: Localize;
		};
	};
};