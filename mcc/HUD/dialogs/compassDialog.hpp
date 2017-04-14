class MCC_hud {
	idd = -1;
	movingEnable = false;
	enableSimulation = true;
	duration = 1e+100;
	fadeIn = 0;
	fadeOut = 0;
	name = "MCC_hud";

	onLoad = "uiNamespace setVariable [""MCC_hud"", _this select 0]";

	class Controls {
		class Group : MCC_RscControlsGroupNoScrollbars
		{
			idc = 10;
			x = 0.27;
			y = safeZoneY + safeZoneH - (2.5/(2048/64)*(4/3));
			w = 0; //0.46;
			h = 0; //2.5/(2048/64)*(4/3);

			class Controls
			{
				class CompassStripe : MCC_RscPicture
				{
					idc = 13;
					x = -1.02;
					y = 0;
					w = 2.5;
					h = 2.5/(2048/64)*(4/3);
					text = __EVAL(MCCPATH +"mcc\HUD\data\compass.paa");
				};
				class ObjectiveMarker : MCC_RscPicture
				{
					idc = 14;
					x = 0;
					y = 0;
					w = 0.023;
					h = 0.03 * (4/3);
					text = __EVAL(MCCPATH +"mcc\HUD\data\needleGreen.paa");
					colorText[] = {1,1,1,1};
				};
				class Needle : MCC_RscPicture
				{
					idc = -1;
					x = 0.21;
					y =  0.04;
					w = 0.023;
					h = 0.03 * (4/3);
					text = __EVAL(MCCPATH +"mcc\HUD\data\needle.paa");
					colorText[] = {1,1,1,1};
				};
			};
		};

		class MCC_captureProgressCTG: MCC_RscControlsGroup
		{
			idc = 20;
			x = 0.298906 * safezoneW + safezoneX;
			y = 0.118 * safezoneH + safezoneY;
			w = 0 * safezoneW;
			h = 0 * safezoneH;

			class controls
			{
				class MCC_captureProgressPRBarBG: MCC_RscText
				{
					idc = -1;
					x = 0 * safezoneW;
					y = 0 * safezoneH;
					w = 0.4 * safezoneW;
					h = 0.02 * safezoneH;
					colorBackground[] = {0.8,0,0,0.5};
				};

				class MCC_captureProgressPRBar: MCC_RscProgress
				{
					idc = 21;
					x = 0 * safezoneW;
					y =0 * safezoneH;
					w = 0.4 * safezoneW;
					h = 0.02 * safezoneH;
					colorBar[] = {0,0,0.8,1};
					colorFrame[] = {1,1,1,0.8};
					colorBackground[] = {0.8,0,0,0.6};
				};

				class MCC_captureProgressText: MCC_RscText
				{
					idc = 22;
					style = 0x02;
					sizeEx ="(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
					colorText[] = {1,1,1,1};
					x = 0.15 * safezoneW;
					y = 0 * safezoneH;
					w = 0.1 * safezoneW;
					h = 0.018 * safezoneH;
				};

				class sMCC_captureProgressFrame: MCC_RscFrame
				{
					idc = -1;
					colorText[] = {0,0,0,1};
					shadow = 2;
					sizeEx = 0.1;

					x = 0 * safezoneW;
					y = 0 * safezoneH;
					w = 0.4 * safezoneW;
					h = 0.02 * safezoneH;
				};
			};
		};

		class MCC_rivalSide1: MCC_RscControlsGroup
		{
			idc = 30;
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0 * safezoneW;	// w = 0.04125 * safezoneW;
			h = 0 * safezoneH;		// h = 0.11 * safezoneH;
			class Controls
			{
				class side1Flag: MCC_RscPicture
				{
					idc = 32;
					text = "\a3\Data_f\Flags\flag_nato_co.paa";
					x = 0.00515624 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.0309375 * safezoneW;
					h = 0.044 * safezoneH;
				};
				class side1FlagFrame: MCC_RscFrame
				{
					idc = 31;
					colorText[] = {0,0,1,1};
					shadow = 2;
					sizeEx = 0.1;

					x = 0.00515602 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.0309375 * safezoneW;
					h = 0.044 * safezoneH;
				};
				class side1Name: MCC_RscText
				{
					idc = 33;
					text = "NATO";
					sizeEx ="(((((safezoneW / safezoneH) min 0.9) / 0.9) / 25) * 0.9)";
					x = 0.00515602 * safezoneW;
					y = 0.055 * safezoneH;
					w = 0.0309375 * safezoneW;
					h = 0.022 * safezoneH;
				};
				class side1Score: MCC_RscText
				{
					idc = 34;
					text = "50";
					x = 0.00515602 * safezoneW;
					y = 0.077 * safezoneH;
					w = 0.0309375 * safezoneW;
					h = 0.022 * safezoneH;
				};
			};
		};

		class MCC_rivalSide2: MCC_RscControlsGroup
		{
			idc = 40;
			x = 0.474219 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0 * safezoneW;	// w = 0.04125 * safezoneW;
			h = 0 * safezoneH;		// h = 0.11 * safezoneH;
			class Controls
			{
				class side2Flag: MCC_RscPicture
				{
					idc = 42;
					text = "\a3\Data_f\Flags\flag_CSAT_co.paa";
					x = 0.00515624 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.0309375 * safezoneW;
					h = 0.044 * safezoneH;
				};
				class side2FlagFrame: MCC_RscFrame
				{
					idc = 41;
					colorText[] = {1,0,0,1};
					shadow = 2;
					sizeEx = 0.1;

					x = 0.00515602 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.0309375 * safezoneW;
					h = 0.044 * safezoneH;
				};
				class side2Name: MCC_RscText
				{
					idc = 43;
					text = "CSAT";
					sizeEx ="(((((safezoneW / safezoneH) min 0.9) / 0.9) / 25) * 0.9)";
					x = 0.00515602 * safezoneW;
					y = 0.055 * safezoneH;
					w = 0.0309375 * safezoneW;
					h = 0.022 * safezoneH;
				};
				class side2Score: MCC_RscText
				{
					idc = 44;
					text = "50";
					x = 0.00515602 * safezoneW;
					y = 0.077 * safezoneH;
					w = 0.0309375 * safezoneW;
					h = 0.022 * safezoneH;
				};
			};
		};

		class MCC_rivalSide3: MCC_RscControlsGroup
		{
			idc = 50;
			x = 0.520625 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0 * safezoneW;	// w = 0.04125 * safezoneW;
			h = 0 * safezoneH;		// h = 0.11 * safezoneH;
			class Controls
			{
				class side3Flag: MCC_RscPicture
				{
					idc = 52;
					text = "\a3\Data_f\Flags\flag_AAF_co.paa";
					x = 0.00515624 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.0309375 * safezoneW;
					h = 0.044 * safezoneH;
				};
				class side3FlagFrame: MCC_RscFrame
				{
					idc = 51;
					colorText[] = {0,1,0,1};
					shadow = 2;
					sizeEx = 0.1;

					x = 0.00515602 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.0309375 * safezoneW;
					h = 0.044 * safezoneH;
				};
				class side3Name: MCC_RscText
				{
					idc = 53;
					text = "AAF";
					sizeEx ="(((((safezoneW / safezoneH) min 0.9) / 0.9) / 25) * 0.9)";
					x = 0.00515602 * safezoneW;
					y = 0.055 * safezoneH;
					w = 0.0309375 * safezoneW;
					h = 0.022 * safezoneH;
				};
				class side3Score: MCC_RscText
				{
					idc = 54;
					text = "50";
					x = 0.00515602 * safezoneW;
					y = 0.077 * safezoneH;
					w = 0.0309375 * safezoneW;
					h = 0.022 * safezoneH;
				};
			};
		};

		class MCC_timeLeft:  MCC_RscText
		{
			idc = 60;
			text = "";
			sizeEx ="(((((safezoneW / safezoneH) min 1.1) / 1) / 25) * 0.9)";
			x = 0.381406 * safezoneW + safezoneX;
			y = 0.016 * safezoneH + safezoneY;
			w = 0.04125 * safezoneW;
			h = 0.033 * safezoneH;
		};
	};
};