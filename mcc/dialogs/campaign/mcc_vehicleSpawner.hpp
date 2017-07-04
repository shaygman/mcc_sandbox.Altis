// By: Shay_gman

class MCC_VEHICLESPAWNER
{
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable [""MCC_VEHICLESPAWNER_IDD"", _this select 0]";

	class controlsBackground
	{
		class RscFrame_1: MCC_RscText
		{
			colorBackground[] = {0,0,0,0.8};
			idc = -1;
			x = 0.288594 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.417656 * safezoneW;
			h = 0.385 * safezoneH;
		};

		class RscFrame_2: MCC_RscFrame
		{
			idc = -1;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.293906 * safezoneW;
			h = 0.363 * safezoneH;
		};
		class RscFrame_3: MCC_RscFrame
		{
			idc = -1;
			x = 0.587656 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.363 * safezoneH;
		};
	};


	//---------------------------------------------
	objects[] =
	{
	};

	class controls
	{
		class vehicleClass: MCC_RscCombo
		{
			idc = 101;
			onLBSelChanged = "[0] spawn MCC_fnc_vehicleSpawner";
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.379 * safezoneH + safezoneY;
			w = 0.283594 * safezoneW;
			h = 0.055 * safezoneH;
		};

		class SpawnButton: MCC_RscButton
		{
			idc = 102;
			text = "Purchase";
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.055 * safezoneH;
			onButtonClick = "[1] spawn MCC_fnc_vehicleSpawner";
		};

		class close: MCC_RscButton
		{
			idc = -1;
			text = "Close"; //--- ToDo: Localize;
			x = 0.515469 * safezoneW + safezoneX;
			y = 0.544 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.055 * safezoneH;
			onButtonClick = "closeDialog 0;";
		};

		class ammoPic: MCC_RscPicture
		{
			idc = 1100;
			text =  __EVAL(MCCPATH +"data\IconAmmo.paa");
			tooltip = "Ammo";
			colorText[] = { 0.9, 0, 0, 1 };

			x = 0.298906 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class repairPic: MCC_RscPicture
		{
			idc = 1101;
			colorText[] = { 0, 0.5, 0.9, 10 };
			text = __EVAL(MCCPATH +"data\IconRepair.paa");
			tooltip = "Supplies";
			x = 0.371094 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class fuelPic: MCC_RscPicture
		{
			idc = 1102;
			text = __EVAL(MCCPATH +"data\IconFuel.paa");
			tooltip = "Fuel";
			colorText[] = { 0, 0.9, 0.5, 1 };

			x = 0.443281 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class ValorPic: MCC_RscPicture
		{
			idc = 1103;

			text = __EVAL(MCCPATH +"mcc\rts\data\valorIcon.paa");
			tooltip = "Valor";
			x = 0.515469 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class ammoText: MCC_RscText
		{
			idc = 1000;
			x = 0.324687 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class repairText: MCC_RscText
		{
			idc = 1001;
			x = 0.396875 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class fuelText: MCC_RscText
		{
			idc = 1002;
			x = 0.469062 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class ValorText: MCC_RscText
		{
			idc = 1003;

			x = 0.54125 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class tittle: MCC_RscText
		{
			idc = -1;
			text = "Available Assets";
			x = 0.355625 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.170156 * safezoneW;
			h = 0.055 * safezoneH;
			colorText[] = {1,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		};
		class availableResourcesTittle: MCC_RscText
		{
			idc = -1;

			text = "Available Resources";
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.055 * safezoneH;
			colorText[] = {1,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class MCC_ResourcesControlsGroup: MCC_RscControlsGroupNoScrollbars
		{
			idc = 80;
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.324 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.275 * safezoneH;
			class controls
			{
				class MCC_AmmoText: MCC_RscText
				{
					idc = 81;

					x = 0.0257812 * safezoneW;
					y = 0.055 * safezoneH;
					w = 0.04125 * safezoneW;
					h = 0.033 * safezoneH;
				};

				class MCC_RepairText: MCC_RscText
				{
					idc = 82;

					x = 0.0257812 * safezoneW;
					y = 0.099 * safezoneH;
					w = 0.04125 * safezoneW;
					h = 0.033 * safezoneH;
				};

				class MCC_FuelText: MCC_RscText
				{
					idc = 83;

					x = 0.0257812 * safezoneW;
					y = 0.143 * safezoneH;
					w = 0.04125 * safezoneW;
					h = 0.033 * safezoneH;
				};

				class MCC_ValorText: MCC_RscText
				{
					idc = 84;

					x = 0.0257812 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.04125 * safezoneW;
					h = 0.033 * safezoneH;
				};

				class MCC_Ammo: MCC_RscPicture
				{
					idc = 91;

					text =  __EVAL(MCCPATH +"data\IconAmmo.paa");
					tooltip = "Ammo";
					colorText[] = { 0.9, 0, 0, 1 };

					x = 0.00515625 * safezoneW;
					y = 0.055 * safezoneH;
					w = 0.0154688 * safezoneW;
					h = 0.033 * safezoneH;
				};
				class MCC_Repair: MCC_RscPicture
				{
					idc = 92;
					colorText[] = { 0, 0.5, 0.9, 10 };
					text = __EVAL(MCCPATH +"data\IconRepair.paa");
					tooltip = "Supplies";
					x = 0.00515625 * safezoneW;
					y = 0.099 * safezoneH;
					w = 0.0154688 * safezoneW;
					h = 0.033 * safezoneH;
				};
				class MCC_Fuel: MCC_RscPicture
				{
					idc = 93;

					text = __EVAL(MCCPATH +"data\IconFuel.paa");
					tooltip = "Fuel";
					colorText[] = { 0, 0.9, 0.5, 1 };

					x = 0.00515625 * safezoneW;
					y = 0.143 * safezoneH;
					w = 0.0154688 * safezoneW;
					h = 0.033 * safezoneH;
				};

				class MCC_ValorPic: MCC_RscPicture
				{
					idc = 94;
					tooltip = "Valor";
					text = __EVAL(MCCPATH +"mcc\rts\data\valorIcon.paa");
					colorText[] = { 0.9, 0.9, 0, 1 };

					x = 0.00515625 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.0154688 * safezoneW;
					h = 0.033 * safezoneH;
				};
			};
		};
	};
};
