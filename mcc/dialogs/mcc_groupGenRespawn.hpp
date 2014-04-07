class MCC_respawnDialogControls:MCC_RscControlsGroup
{
	movingEnable = true;
	idc = 503;
	x = 0.56 * safezoneW + safezoneX;
	y = 0.104154 * safezoneH + safezoneY;
	w = 0.297917 * safezoneW;
	h = 0.23091 * safezoneH;

	class Controls
	{
	
		class MCC_respawnDialogframe: MCC_RscText
		{
			idc = -1;

			w = 0.297917 * safezoneW;
			h = 0.23091 * safezoneH;
			colorBackground[] = {0,0,0,0.9};
		};
		class MCC_respawnDialogTittle: MCC_RscText
		{
			idc = -1;
			text = "Start Locations:"; //--- ToDo: Localize;
			colorText[] = {0,1,1,1};
			
			x = 0.0744797 * safezoneW;
			y = 0.0109958 * safezoneH;
			w = 0.15 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.1)";
		};
		class MCC_respawnDialogConfirm: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[MCC_currentSide] execVM '"+MCCPATH+"mcc\general_scripts\mcc_start_location.sqf'");

			text = "Set"; //--- ToDo: Localize;
			x = 0.229167 * safezoneW;
			y = 0.186927 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_respawnSideTittle: MCC_RscText
		{
			idc = -1;
			text = "Side:"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.0549788 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_respawnSideCheck: MCC_RscToolbox
		{
			idc = -1;
			strings[]={"West","East","Resistance","Civilian"};
			rows=1;
			columns=4;
			values[] = {0, 1, 2, 3};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.9)";
			onToolBoxSelChanged = "MCC_currentSide = (_this select 1);";
			
			x = 0.0744797 * safezoneW;
			y = 0.0549788 * safezoneH;
			w = 0.217708 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_respawnteleportTittle: MCC_RscText
		{
			idc = -1;
			text = "Insertion:"; //--- ToDo: Localize;
			
			x = 0.00572965 * safezoneW;
			y = 0.142944 * safezoneH;
			w = 0.11 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_respawnteleportCombo: MCC_RscCombo
		{
			idc = 20;
			x = 0.129167 * safezoneW;
			y = 0.142944 * safezoneH;
			w = 0.12 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		
		class MCC_respawnFOBTittle: MCC_RscText
		{
			idc = -1;
			text = "Start:"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.9)";
			
			x = 0.00572965 * safezoneW;
			y = 0.0989618 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
		class MCC_respawnFOBCombo: MCC_RscCombo
		{
			idc = 21;
			x = 0.129167 * safezoneW;
			y = 0.0989618 * safezoneH;
			w = 0.12 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "If role selection is on then the position can be set as FOB (Optional respawn location)"; //--- ToDo: Localize;
		};
		
		class MCC_respawnDialogClose: MCC_RscButtonMenu
		{
			idc = -1;
			onButtonClick = "((uiNamespace getVariable 'MCC_groupGen_Dialog') displayCtrl 503) ctrlShow false";

			text = "Close"; //--- ToDo: Localize;
			x = 0.00572965 * safezoneW;
			y = 0.186927 * safezoneH;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
	};
};