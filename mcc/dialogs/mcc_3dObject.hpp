class mcc_3dObject
{
	idd = -1;
	movingEnable = false;
	enableSimulation = true;
	duration = 1e+100;
	fadeIn = 0;
	fadeOut = 0;
	name = "MCC_3dObject";
	onLoad = "uiNamespace setVariable [""MCC_3dObject"", _this select 0]";

	class Objects
	{
		class object0
		{
			idc = 0;
			type = 82;
			model = "\A3\ui_f\objects\radio.p3d";
			scale = 1;
 			direction[] = {0, 1, 0};
			up[] = {1, 0, -1};

			positionBack[] = {0, 0,1};

			xBack = 0.5;
			yBack = 0.5;
			zBack = 1.2;

			inBack = 1;
			enableZoom = 1;
			zoomDuration = 0.5;


			x = 0.5;
			y = 0.5;
			z = 0.2;
		};
		class object1
		{
			idc = 1;
			type = 82;
			model = "\A3\ui_f\objects\radio.p3d";
			scale = 1;
 			direction[] = {0, 1, 0};
			up[] = {1, 0, -1};

			positionBack[] = {-0.3, -0.2,1};

			xBack = 0.5;
			yBack = 0.5;
			zBack = 1.2;

			inBack = 1;
			enableZoom = 1;
			zoomDuration = 0.5;

			x = 0.5;
			y = 0.5;
			z = 0.2;
		};
		class object2
		{
			idc = 2;
			type = 82;
			model = "\A3\ui_f\objects\radio.p3d";
			scale = 1;
 			direction[] = {0, 1, 0};
			up[] = {1, 0, -1};

			positionBack[] = {0.3, -0.2,1};

			xBack = 0.5;
			yBack = 0.5;
			zBack = 1.2;

			inBack = 1;
			enableZoom = 1;
			zoomDuration = 0.5;

			x = 0.5;
			y = 0.5;
			z = 0.2;
		};
	};

	class Controls
	{
		class text: MCC_RscText
		{
			idc = 3;
			style = MCCST_CENTER;
			text = "Hello";
			x = 0.365937 * safezoneW + safezoneX;
			y = 0.9 * safezoneH + safezoneY;
			w = 0.4 * safezoneW;
			h = 0.066 * safezoneH;
		};
	};
};


