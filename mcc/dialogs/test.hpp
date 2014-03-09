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
class MCC_leftButtonsControlsFrame: MCC_RscText
		{
			idc = -1;
			text = "";
			x = 0.105 * safezoneW + safezoneX;
			y = 0.0711672 * safezoneH + safezoneY;	//0.0439824
			w = 0.0802083 * safezoneW;
			h = 0.53879 * safezoneH;
			colorBackground[] = { 0.120, 0.120, 0.120,1};
		};
			
		class MCC_groupGenSpawnButton: MCC_RscButton 
		{
			idc = -1; 
			text = "Spawn"; 
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			tooltip = "Spawn units or groups"; 
			onButtonClick = __EVAL("[6] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.236103 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_boxGenerator: MCC_RscButton
		{
			idc = -1;
			text = "Box Generator"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			tooltip = "Open Box Generator"; 
			onButtonClick = "if (mcc_missionmaker == (name player)) then {createDialog 'boxGen';} else {player globalchat 'Access Denied'};";
			
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_callCASButton: MCC_RscButton
		{
			idc = -1;
			text = "CAS"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			tooltip = "Open Close Air Support Menu"; 
			onButtonClick = __EVAL("[4] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.324069 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
		class MCC_airdropButton: MCC_RscButton
		{
			idc = -1;
			text = "Supply Drop"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			tooltip = "Open Supply Drop Menu";
			onButtonClick = __EVAL("[16] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.368051 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
		class MCC_callArtilleryButton: MCC_RscButton
		{
			idc = -1;
			text = "Artillery"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			tooltip = "Open artillery Menu"; 
			onButtonClick = __EVAL("[5] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.412034 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_callEvacButton: MCC_RscButton
		{
			idc = -1;
			text = "Evac"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			tooltip = "Open Evac Menu"; 
			onButtonClick = __EVAL("[7] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.456017 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_callIEDButton: MCC_RscButton
		{
			idc = -1;
			text = "IED"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			tooltip = "Open IEDs Menu"; 
			onButtonClick = __EVAL("[8] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.5 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};

		class MCC_callConvoyButton: MCC_RscButton
		{
			idc = -1;
			text = "Convoy"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			tooltip = "Open Convoy Menu"; 
			onButtonClick = __EVAL("[9] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.543983 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
		class MCC_AC130Button: MCC_RscButton
		{
			idc = -1;
			text = "AC-130"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			tooltip = "Spawn AC-130 (use MCC console to control it)"; 
			onButtonClick = __EVAL ("[0] execVM '"+MCCPATH+"mcc\general_scripts\uav\uavSpawn.sqf'");
			
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.587966 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
		class MCC_DeleteButton: MCC_RscButton
		{
			idc = -1;
			text = "Delete"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			tooltip = "Open Delete Menu"; 
			onButtonClick = __EVAL("[17] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");
			
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.631949 * safezoneH + safezoneY;
			w = 0.06875 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
	};
};