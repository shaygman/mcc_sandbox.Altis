// By: Shay_gman

class MCC_VEHICLESPAWNER
{
	idd = -1;
	movingEnable = 1;
	onLoad = "uiNamespace setVariable [""MCC_VEHICLESPAWNER_IDD"", _this select 0]";

	controlsBackground[] =
	{
	};


	//---------------------------------------------
	objects[] =
	{
	};

	class controls
	{
		class frame: MCC_RscText
		{
			colorBackground[] = {0,0,0,0.9};
			idc = -1;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.417656 * safezoneW;
			h = 0.451 * safezoneH;
		};

		class vehicleClass: MCC_RscCombo
		{
			idc = 101;
			onLBSelChanged = "[0] spawn MCC_fnc_vehicleSpawner";
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.346 * safezoneH + safezoneY;
			w = 0.278437 * safezoneW;
			h = 0.055 * safezoneH;
		};

		class SpawnButton: MCC_RscButton
		{
			idc = 102;
			text = "Purchase";
			x = 0.319531 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.055 * safezoneH;
			onButtonClick = "[1] spawn MCC_fnc_vehicleSpawner";
		};

		class close: MCC_RscButton
		{
			idc = -1;
			text = "Close"; //--- ToDo: Localize;
			x = 0.639219 * safezoneW + safezoneX;
			y = 0.61 * safezoneH + safezoneY;
			w = 0.061875 * safezoneW;
			h = 0.055 * safezoneH;
			onButtonClick = "closeDialog 0;";
		};

		class ammoPic: MCC_RscPicture
		{
			idc = -1;
			text =  __EVAL(MCCPATH +"data\IconAmmo.paa");
			tooltip = "Ammo";
			x = 0.304062 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class repairPic: MCC_RscPicture
		{
			idc = -1;
			text = __EVAL(MCCPATH +"data\IconRepair.paa");
			tooltip = "Supplies";
			x = 0.37625 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class fuelPic: MCC_RscPicture
		{
			idc = -1;
			text = __EVAL(MCCPATH +"data\IconFuel.paa");
			tooltip = "Fuel";
			x = 0.448438 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class ammoText: MCC_RscText
		{
			idc = 1000;
			x = 0.329844 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class repairText: MCC_RscText
		{
			idc = 1001;
			x = 0.402031 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class fuelText: MCC_RscText
		{
			idc = 1002;
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class tittle: MCC_RscText
		{
			idc = -1;
			text = "Vehicle Spawn";
			x = 0.319531 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.170156 * safezoneW;
			h = 0.055 * safezoneH;
			colorText[] = {0,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		};

		class ValorPic: MCC_RscPicture
		{
			idc = -1;

			text = __EVAL(MCCPATH +"mcc\rts\data\valorIcon.paa");
			tooltip = "Fame";
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.0257812 * safezoneW;
			h = 0.044 * safezoneH;
		};

		class ValorText: MCC_RscText
		{
			idc = 1003;

			x = 0.546406 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.044 * safezoneH;
		};

		class availableResourcesTittle: MCC_RscText
		{
			idc = -1;

			text = "Available Resources";
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.055 * safezoneH;
			colorText[] = {0,1,1,1};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class MCC_ResourcesControlsGroup: MCC_RscControlsGroupNoScrollbars
		{
			idc = 80;
			x = 0.592812 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.108281 * safezoneW;
			h = 0.286 * safezoneH;
			class controls
			{
				class MCC_AmmoText: MCC_RscText
				{
					idc = 81;

					x = 0.0257812 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.04125 * safezoneW;
					h = 0.033 * safezoneH;
				};

				class MCC_RepairText: MCC_RscText
				{
					idc = 82;

					x = 0.0257812 * safezoneW;
					y = 0.055 * safezoneH;
					w = 0.04125 * safezoneW;
					h = 0.033 * safezoneH;
				};

				class MCC_FuelText: MCC_RscText
				{
					idc = 83;

					x = 0.0257812 * safezoneW;
					y = 0.099 * safezoneH;
					w = 0.04125 * safezoneW;
					h = 0.033 * safezoneH;
				};

				class MCC_Ammo: MCC_RscPicture
				{
					idc = -1;

					text =  __EVAL(MCCPATH +"data\IconAmmo.paa");
					tooltip = "Ammo";
					x = 0.00515625 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.0154688 * safezoneW;
					h = 0.033 * safezoneH;
				};
				class MCC_Repair: MCC_RscPicture
				{
					idc = -1;

					text = __EVAL(MCCPATH +"data\IconRepair.paa");
					tooltip = "Supplies";
					x = 0.00515625 * safezoneW;
					y = 0.055 * safezoneH;
					w = 0.0154688 * safezoneW;
					h = 0.033 * safezoneH;
				};
				class MCC_Fuel: MCC_RscPicture
				{
					idc = -1;

					text = __EVAL(MCCPATH +"data\IconFuel.paa");
					tooltip = "Fuel";
					x = 0.00515625 * safezoneW;
					y = 0.099 * safezoneH;
					w = 0.0154688 * safezoneW;
					h = 0.033 * safezoneH;
				};

				class MCC_ValorPic: MCC_RscPicture
				{
					idc = -1;

					text = __EVAL(MCCPATH +"mcc\rts\data\valorIcon.paa");
					tooltip = "Fame";
					x = 0.00515625 * safezoneW;
					y = 0.143 * safezoneH;
					w = 0.0154688 * safezoneW;
					h = 0.033 * safezoneH;
				};

				class MCC_ValorText: MCC_RscText
				{
					idc = 84;

					x = 0.0257812 * safezoneW;
					y = 0.143 * safezoneH;
					w = 0.04125 * safezoneW;
					h = 0.033 * safezoneH;
				};
			};
		};
	};
};
