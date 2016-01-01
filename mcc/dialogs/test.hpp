class mcc_test
{
	idd = 9999999;
	movingEnable = true;
	onLoad ="";

	controlsBackground[] =
	{
	};


	//---------------------------------------------
	objects[] =
	{ 	//(0.671875 * safezoneW + safezoneX) / safezoneW -X
	};	//(0.478009 * safezoneH + safezoneY) / safezoneH - Y

	class controls
	{
		class bottomBckg: MCC_RscText
		{
			idc = -1;
			x = 0 * safezoneW;
			y = 0 * safezoneH;
			w = 0.840469 * safezoneW;
			h = 0.11 * safezoneH;
			colorBackground[] = {0.192,0.192,0.192,0.9};
		};
		class CP_feedback: MCC_RscText
		{
			idc = 9999;
			style = 2;

			x = 0.0721872 * safezoneW;
			y = 0.011 * safezoneH;
			w = 0.324844 * safezoneW;
			h = 0.066 * safezoneH;
			colorText[] = {1,0,0,0.8};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class timeLeft: MCC_RscText
		{
			idc = 1919;

			x = 0.427969 * safezoneW;
			y = 0.011 * safezoneH;
			w = 0.149531 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};

		class CP_deployPanelButton: MCC_RscButton
		{
			idc = 32;
			text = "Deploy"; //--- ToDo: Localize;
			colorBackground[] = {1,0,0,0.3};

			x = 0.675468 * safezoneW;
			y = 0.011 * safezoneH;
			w = 0.139219 * safezoneW;
			h = 0.066 * safezoneH;
			tooltip = "Press Deploy to get into the action"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			action = __EVAL("[1] execVM '"+CPPATH+"mcc\roleSelection\scripts\respawnPanel_cmd.sqf'");
		};

		class CP_RscMainXPUI: MCC_RscControlsGroupNoScrollbars
		{
			idc = 101;
			x = "25 * 			(			((safezoneW / safezoneH) min 1.2) / 40) + 			(safezoneX)";
			y = "(safezoneY + (safezoneH*0.9))";
			w = "23 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "6 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class controls
			{
				class bckg: MCC_RscText
				{
					idc =-1;
					text = "";
					w = "23 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "6 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0,0,0,0.4};
				}

				class messeges: MCC_RscStructuredText
				{
					idc =102;
					text = "";
					x = "2.1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "0.5 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "20 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "2 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};

				class XPTitle: MCC_RscText
				{
					idc =103;
					text = "XP";
					x = "-0.2 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "2 * 			(			((safezoneW / safezoneH) min 1.2) / 60)";
					h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
				};

				class XPValue: MCC_RscProgress
				{
					idc = 104;
					x = "2.1 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "3 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "20 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBar[] = {0,0,0.8,0.6};
					colorFrame[] = {1,1,1,0.8};
					colorBackground[] = {0,0,0,0.3};
				};
			};
		};
	};
};
