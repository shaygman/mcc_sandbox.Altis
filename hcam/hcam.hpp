
class RscHcamDialog {
	idd = -1;
	onLoad = "_this call hcam_ui_init";
	movingEnable = 0;
	enableSimulation = 1;
	enableDisplay = 1;
	duration = 99999999;
	fadein = 0;
	fadeout = 0;
	class controls { 
		class RscHcamBack: MCC_RscPicture {
			idc = 2;
			type = 0;
			style = 48;
			text = __EVAL(MCCPATH+"hcam\back.paa");
			x = 0.78 * safezoneW + safezoneX;
			y = 0.67 * safezoneH + safezoneY;
			w = 0.22 * safezoneW;
			h = 0.17 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0, 0, 0, 0};
			font = "TahomaB";
				sizeEx = 0;
				lineSpacing = 0;
				fixedWidth = 0;
				shadow = 0;
		};
		class RscHcamCam: MCC_RscPicture {
			idc = 0;
			type = 0;
			style = 48;
			text = "";
			x = 0.80 * safezoneW + safezoneX;
			y = 0.68 * safezoneH + safezoneY;
			w = 0.18 * safezoneW;
			h = 0.15 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0, 0, 0, 0.3};
			font = "TahomaB";
				sizeEx = 0;
				lineSpacing = 0;
				fixedWidth = 0;
				shadow = 0;
		};
		class HcamText
		{
			idc = 1;
			type  = 0;          // statisch 
			style = 0x01;       // zentriert
			x = 0.80 * safezoneW + safezoneX;
			y = 0.81 * safezoneH + safezoneY;
			w = 0.18 * safezoneW;
			h = 0.02 * safezoneH;
			colorText[]       = {0,0,0,0.75};
			colorBackground[] = {1, 1, 1, 0.2}; // kein Hintergrund
			font = "TahomaB";
				sizeEx = 0.02;
				text="";
		};
		
		class RscHcamFront: MCC_RscPicture {
			idc = 3;
			type = 0;
			style = 48;
			text = __EVAL(MCCPATH+"hcam\front.paa");
			x = 0.80 * safezoneW + safezoneX;
			y = 0.68 * safezoneH + safezoneY;
			w = 0.18 * safezoneW;
			h = 0.15 * safezoneH;
			colorText[] = {1,1,1,1};
			colorBackground[] = {0, 0, 0, 0};
			font = "TahomaB";
				sizeEx = 0;
				lineSpacing = 0;
				fixedWidth = 0;
				shadow = 0;
		};		

	};
};
