class MCC_convoyDialogControls:MCC_RscControlsGroup
{
	idc = 509;
	x = 0.186 * safezoneW + safezoneX;
	y = 0.18 * safezoneH + safezoneY;
	w = 0.292188 * safezoneW;
	h = 0.274893 * safezoneH;

	class Controls
	{		
		class MCC_convoyDialogFrame: MCC_RscText
		{
			idc = -1;
			colorBackground[] = {0,0,0,0.9};
				
			x = 0.270833 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.292188 * safezoneW;
			h = 0.274893 * safezoneH;
		};
		class MCC_ConvoyTittle: MCC_RscText
		{
			idc = -1;

			text = "Convoy:"; //--- ToDo: Localize;
			x = 0.373958 * safezoneW + safezoneX;
			y = 0.236103 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0329871 * safezoneH;
			colorText[] = {0,1,1,1};
		};
		class MCC_ConvoyCar1Tittle: MCC_RscText
		{
			idc = -1;

			text = "Car1:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_ConvoyCar2Tittle: MCC_RscText
		{
			idc = -1;

			text = "Car2:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.313073 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_ConvoyCar3Tittle: MCC_RscText
		{
			idc = -1;

			text = "Car3:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.34606 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_ConvoyCar4Tittle: MCC_RscText
		{
			idc = -1;

			text = "Car4:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.379047 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_ConvoyCar5Tittle: MCC_RscText
		{
			idc = -1;

			text = "Car5:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.412034 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_ConvoyCar1: MCC_RscCombo
		{
			idc = 50;

			x = 0.316667 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.091875 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_ConvoyCar2: MCC_RscCombo
		{
			idc = 51;

			x = 0.316667 * safezoneW + safezoneX;
			y = 0.313073 * safezoneH + safezoneY;
			w = 0.091875 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_ConvoyCar3: MCC_RscCombo
		{
			idc = 52;

			x = 0.316667 * safezoneW + safezoneX;
			y = 0.34606 * safezoneH + safezoneY;
			w = 0.091875 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_ConvoyCar4: MCC_RscCombo
		{
			idc = 53;

			x = 0.316667 * safezoneW + safezoneX;
			y = 0.379047 * safezoneH + safezoneY;
			w = 0.091875 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_ConvoyCar5: MCC_RscCombo
		{
			idc = 54;

			x = 0.316667 * safezoneW + safezoneX;
			y = 0.412034 * safezoneH + safezoneY;
			w = 0.091875 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_ConvoyHVTTittle: MCC_RscText
		{
			idc = -1;

			text = "HVT:"; //--- ToDo: Localize;
			x = 0.425521 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.039375 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_ConvoyHVTCarTittle: MCC_RscText
		{
			idc = -1;

			text = "HVT Car:"; //--- ToDo: Localize;
			x = 0.425521 * safezoneW + safezoneX;
			y = 0.313073 * safezoneH + safezoneY;
			w = 0.0401042 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.65)";
		};
		class MCC_ConvoyHVT: MCC_RscCombo
		{
			idc = 55;

			x = 0.465625 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.091875 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_ConvoyHVTCar: MCC_RscCombo
		{
			idc = 56;

			x = 0.465625 * safezoneW + safezoneX;
			y = 0.313073 * safezoneH + safezoneY;
			w = 0.091875 * safezoneW;
			h = 0.0280063 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_convoySpawn: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\convoy\make_convoy_WP.sqf'");

			text = "Spawn"; //--- ToDo: Localize;
			x = 0.459896 * safezoneW + safezoneX;
			y = 0.357056 * safezoneH + safezoneY;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Spawn convoy and set WP"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_convoyReset: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\convoy\reset_convoy_WP.sqf'");

			text = "Reset"; //--- ToDo: Localize;
			x = 0.425521 * safezoneW + safezoneX;
			y = 0.401039 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Reset convoy's waypoints"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_convoyStart: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[3] execVM '"+MCCPATH+"mcc\general_scripts\convoy\start_convoy.sqf'");

			text = "Start"; //--- ToDo: Localize;
			x = 0.5 * safezoneW + safezoneX;
			y = 0.401039 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0329871 * safezoneH;
			tooltip = "Start convoy movement"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
		};
		class MCC_convoyClose: MCC_RscButton
		{
			idc = -1;
			onButtonClick = __EVAL("[9] execVM '"+MCCPATH+"mcc\general_scripts\groupGen\controlsHandle.sqf'");

			text = "Close"; //--- ToDo: Localize;
			x = 0.391146 * safezoneW + safezoneX;
			y = 0.456017 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0329871 * safezoneH;
		};
	};
};