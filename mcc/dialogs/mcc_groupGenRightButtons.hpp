#define MCC_buttonsSpace 0.0769695
class MCC_rightButtonsControls: MCC_RscControlsGroup
{
	idc = -1;
	x = 0.866667 * safezoneW + safezoneX;
	y = 0.0931586 * safezoneH + safezoneY;	//0.0439824
	w = 0.06875 * safezoneW;
	h = 0.52 * safezoneH;	

	class Controls
	{	
		class MCC_MissionSettings: MCC_RscButton
		{
			idc = -1;
			text = "Mission Settings";
			tooltip = "Open Mission Settings Menu"; //--- ToDo: Localize;
			onButtonClick = "if (mcc_missionmaker == (name player)) then {MCC_button createDialog 'missionSettings';} else {player globalchat 'Access Denied'};";
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			
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
			
			y = MCC_buttonsSpace * 1;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
				
		class MCC_setWeatherButton: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[0] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			text = "Set Weather"; //--- ToDo: Localize;
			tooltip = "Open Weather Menu"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			
			y = MCC_buttonsSpace * 2;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;

		};

		class MCC_setTimeButton: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[1] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			text = "Set Time"; //--- ToDo: Localize;
			tooltip = "Open Time Menu"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			
			y = MCC_buttonsSpace * 3;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;		
		};

		class MCC_StartLocation: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[2] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			text = "Start Locations"; //--- ToDo: Localize;
			tooltip = "Open Locations Menu"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			
			y = MCC_buttonsSpace * 4;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;			
		};

		class MCC_debugButton: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			text = "Debug"; //--- ToDo: Localize;
			tooltip = "Open Debug Menu"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			
			y = MCC_buttonsSpace * 5;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_markersCallButton: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[10] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			text = "Markers"; //--- ToDo: Localize;
			tooltip = "Open Markers Menu"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			
			y = MCC_buttonsSpace * 6;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_briefingCallButton: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[11] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			text = "Briefing"; //--- ToDo: Localize;
			tooltip = "Open Briefing Menu"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			
			y = MCC_buttonsSpace * 7;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_tasksCallButton: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[12] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			text = "Tasks"; //--- ToDo: Localize;
			tooltip = "Open Tasks Menu"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			
			y = MCC_buttonsSpace * 8;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
		class MCC_triggersCallButton: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[14] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			text = "Triggers"; //--- ToDo: Localize;
			tooltip = "Open Triggers Menu"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			
			y = MCC_buttonsSpace * 9;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
		class MCC_jukeBoxCallButton: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[13] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			text = "Jukebox"; //--- ToDo: Localize;
			tooltip = "Open Jukebox Menu"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			
			y = MCC_buttonsSpace * 10;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
		class MCC_clientSideCallButton: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[15] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			text = "Client Side"; //--- ToDo: Localize;
			tooltip = "Open Client Side Menu"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
			
			y = MCC_buttonsSpace * 11;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
	};
};