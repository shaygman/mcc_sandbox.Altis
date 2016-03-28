class MCC_hud_compass {
	idd = -1;
	movingEnable = false;
	enableSimulation = true;
	duration = 1e+100;
	fadeIn = 0;
	fadeOut = 0;
	name = "MCC_hud_compass";

	onLoad = "uiNamespace setVariable [""MCC_hud_compass"", _this select 0]";

	class Controls {
		class Group : MCC_RscControlsGroupNoScrollbars
		{
			idc = 1;
			x = 0.27;
			y = safeZoneY + safeZoneH - (2.5/(2048/64)*(4/3));
			w = 0.46;
			h = 2.5/(2048/64)*(4/3);

			class Controls
			{
				class CompassStripe : MCC_RscPicture
				{
					idc = 3;
					x = -1.02;
					y = 0;
					w = 2.5;
					h = 2.5/(2048/64)*(4/3);
					text = __EVAL(MCCPATH +"mcc\compassHUD\data\compass.paa");
				};
				class ObjectiveMarker : MCC_RscPicture
				{
					idc = 4;
					x = 0;
					y = 0;
					w = 0.023;
					h = 0.03 * (4/3);
					text = __EVAL(MCCPATH +"mcc\compassHUD\data\needleGreen.paa");
					colorText[] = {1,1,1,1};
				};
				class Needle : MCC_RscPicture
				{
					idc = -1;
					x = 0.21;
					y =  0.04;
					w = 0.023;
					h = 0.03 * (4/3);
					text = __EVAL(MCCPATH +"mcc\compassHUD\data\needle.paa");
					colorText[] = {1,1,1,1};
				};
			};
		};

	};
};