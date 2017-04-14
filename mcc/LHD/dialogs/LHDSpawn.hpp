class MCC_LHDSpawn
{
	idd = 1545784115;
	onLoad = "uiNamespace setVariable [""MCC_LHD_MENU"", _this select 0]";
	movingEnable = false;

	class controls
	{
		class spawnVehicle: MCC_RscControlsGroup
		{
			idc = 2300;
			x = 0.7 * safezoneW + safezoneX;
			y = 0.1 * safezoneH + safezoneY;
			w = 0 * safezoneW;	//w = 0.273281 * safezoneW;
			h = 0 * safezoneH;	//h = 0.154 * safezoneH;
			class Controls
			{
				class bckground: MCC_RscText
				{
					idc = -1;
					x = 0 * safezoneW;
					y = 0 * safezoneH;
					w = 0.273281 * safezoneW;
					h = 0.154 * safezoneH;
					colorBackground[] = {0,0,0,0.7};
				};

				class bckframe: MCC_RscFrame
				{
					idc = -1;
					x = 0 * safezoneW;
					y = 0 * safezoneH;
					w = 0.273281 * safezoneW;
					h = 0.154 * safezoneH;
				};

				class factionText: MCC_RscText
				{
					idc = -1;
					text = "Faction:"; //--- ToDo: Localize;
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
					x = 0.00515648 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.04125 * safezoneW;
					h = 0.022 * safezoneH;
				};
				class factionListbox: MCC_RscCombo
				{
					idc = 8008;
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
					onLBSelChanged = "['faction'] spawn MCC_fnc_LHDspawnVehicle;";

					x = 0.046406 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.12375 * safezoneW;
					h = 0.022 * safezoneH;
				};
				class typeListBox: MCC_RscCombo
				{
					idc = 1501;
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";

					x = 0.005156 * safezoneW;
					y = 0.044 * safezoneH;
					w = 0.04125 * safezoneW;
					h = 0.022 * safezoneH;
				};
				class classListBox: MCC_RscCombo
				{
					idc = 1502;
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
					x = 0.046406 * safezoneW;
					y = 0.044 * safezoneH;
					w = 0.12375 * safezoneW;
					h = 0.022 * safezoneH;
				};
				class infoText: MCC_RscPicture
				{
					idc = 1100;
					x = 0.175313 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.0928125 * safezoneW;
					h = 0.132 * safezoneH;
				};
				class spawnButton: MCC_RscButton
				{
					idc = 2400;
					text = "Spawn"; //--- ToDo: Localize;
					x = 0.051563 * safezoneW;
					y = 0.077 * safezoneH;
					w = 0.0773437 * safezoneW;
					h = 0.055 * safezoneH;
				};
				class closeButton: MCC_RscButtonMenu
				{
					idc = 2401;
					text = "X"; //--- ToDo: Localize;
					action = "['close'] spawn MCC_fnc_LHDspawnVehicle;";
					x = 0.252656 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.0154688 * safezoneW;
					h = 0.033 * safezoneH;
				};
			};
		};
	};
};