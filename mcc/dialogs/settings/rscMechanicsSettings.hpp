class rscMechanicsSettings: MCC_RscControlsGroupNoScrollbars
{
	idc = -1;
	x = 0.133906 * safezoneW + safezoneX;
	y = 0.544 * safezoneH + safezoneY;
	w = 0.665156 * safezoneW;
	h = 0.143 * safezoneH;

	class controls
	{
		class mechanicsTittle: MCC_RscText
		{
			idc = -1;
			text = "Game mechanics"; //--- ToDo: Localize;
			x = 0.28875 * safezoneW;
			y = 0.011 * safezoneH;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			colorText[] = {0,1,1,1};
		};
		class Interaction: MCC_RscText
		{
			idc = -1;
			text = "Interaction:"; //--- ToDo: Localize;
			x = 0.005156 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.0670312 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class InteractionCombo: MCC_RscCombo
		{
			idc = 8427;
			x = 0.077344 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Enable interaction menu - requires key bind"; //--- ToDo: Localize;
		};
		class interactionUIText: MCC_RscText
		{
			idc = -1;
			text = "Interaction UI:"; //--- ToDo: Localize;
			x = 0.00515647 * safezoneW;
			y = 0.077 * safezoneH;
			w = 0.0670312 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class interactionUICombo: MCC_RscCombo
		{
			idc = 8434;
			x = 0.077344 * safezoneW;
			y = 0.077 * safezoneH;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Enables interction in-game UI"; //--- ToDo: Localize;
		};
		class actionMenu: MCC_RscText
		{
			idc = -1;
			text = "Action Menu:"; //--- ToDo: Localize;
			x = 0.170156 * safezoneW;
			y = 0.077 * safezoneH;
			w = 0.0670312 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class CoverUICombo: MCC_RscCombo
		{
			idc = 8430;
			x = 0.242344 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Enables cover UI"; //--- ToDo: Localize;
		};
		class Cover: MCC_RscText
		{
			idc = -1;
			text = "Cover:"; //--- ToDo: Localize;
			x = 0.00515647 * safezoneW;
			y = 0.11 * safezoneH;
			w = 0.0670312 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class CoverCombo: MCC_RscCombo
		{
			idc = 8429;
			x = 0.077344 * safezoneW;
			y = 0.11 * safezoneH;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Enables MCC cover system"; //--- ToDo: Localize;
		};
		class Vault: MCC_RscText
		{
			idc = -1;
			text = "Vault:"; //--- ToDo: Localize;
			x = 0.170156 * safezoneW;
			y = 0.11 * safezoneH;
			w = 0.0670312 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class actionMenuCombo: MCC_RscCombo
		{
			idc = 8431;
			x = 0.242344 * safezoneW;
			y = 0.077 * safezoneH;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Show MCC's options in the action menu";
		};
		class VaultCombo: MCC_RscCombo
		{
			idc = 8432;
			x = 0.242344 * safezoneW;
			y = 0.11 * safezoneH;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Enables players to climb/vault over obstacles"; //--- ToDo: Localize;
		};
		class CoverUI: MCC_RscText
		{
			idc = -1;
			text = "CoverUI:"; //--- ToDo: Localize;
			x = 0.170156 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.0670312 * safezoneW;
			h = 0.022 * safezoneH;
		};

		class weaponsBinds: MCC_RscText
		{
			idc = -1;
			text = "Weapons binds:"; //--- ToDo: Localize;
			x = 0.335156 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.0670312 * safezoneW;
			h = 0.022 * safezoneH;
		};

		class weaponsBindsCombo: MCC_RscCombo
		{
			idc = 8433;
			x = 0.407344 * safezoneW;
			y = 0.044 * safezoneH;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Quick weapons selection with the 1-5 buttons"; //--- ToDo: Localize;
		};

		class Survival: MCC_RscText
		{
			idc = -1;
			text = "Survival:"; //--- ToDo: Localize;
			x = 0.335156 * safezoneW;
			y = 0.077 * safezoneH;
			w = 0.0670312 * safezoneW;
			h = 0.022 * safezoneH;
		};
		class SurvivalCombo: MCC_RscCombo
		{
			idc = 8428;
			x = 0.407344 * safezoneW;
			y = 0.077 * safezoneH;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Enables survival mode - search map items foor lot every 24 hours"; //--- ToDo: Localize;
		};

		class RTSText: MCC_RscText
		{
			idc = -1;
			text = "RTS:"; //--- ToDo: Localize;
			x = 0.335156 * safezoneW;
			y = 0.11 * safezoneH;
			w = 0.0670312 * safezoneW;
			h = 0.022 * safezoneH;
		};

		class RTSCombo: MCC_RscCombo
		{
			idc = 8435;
			x = 0.407344 * safezoneW;
			y = 0.11 * safezoneH;
			w = 0.0825 * safezoneW;
			h = 0.022 * safezoneH;
			tooltip = "Enables RTS interfac";
		};
	};
};