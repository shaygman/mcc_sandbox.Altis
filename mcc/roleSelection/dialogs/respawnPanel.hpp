class CP_RESPAWNPANEL {
	idd = -1;
	movingEnable = false;
	onLoad =  __EVAL("_this execVM '"+CPPATH+"mcc\roleSelection\scripts\respawnPanel_init.sqf'");
	onUnLoad = "missionNameSpace setvariable ['CP_respawnPanelOpen',false];";

	controlsBackground[] =
	{
	};


	//---------------------------------------------
	objects[] =
	{
	};

	class controls
	{
		class CP_respawnPanelBckg1: CP_RscText
		{
			idc = -1;
			x = 0.005 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.149531 * safezoneW;
			h = 1.001 * safezoneH;
			colorBackground[] = {0.192,0.192,0.192,0.9};
		};

		class upperCtrlsGroup: MCC_RscControlsGroupNoScrollbars
		{
			idc = 2300;
			x = 0.164844 * safezoneW + safezoneX;
			y = 0.00500001 * safezoneH + safezoneY;
			w = 0.840469 * safezoneW;
			h = 0.11 * safezoneH;
			class controls
			{

				class upperBckg1: CP_RscText
				{
					idc = -1;
					x = 0 * safezoneW;
					y = 0 * safezoneH;
					w = 0.840469 * safezoneW;
					h = 0.11 * safezoneH;
					colorBackground[] = {0.192,0.192,0.192,0.9};
				};
				class CP_missionName: CP_RscText
				{
					idc = 1021;

					x = 0.00515628 * safezoneW;
					y = 0.055 * safezoneH;
					w = 0.175313 * safezoneW;
					h = 0.033 * safezoneH;
				};

				class commanderTittle: CP_RscPicture
				{
					idc = -1;
					text = "\A3\Ui_f\data\GUI\Cfg\Ranks\colonel_gs.paa";
					tooltip = "Commander";
					x = 0.00515628 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.04 * safezoneW;
					h = 0.044 * safezoneH;
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
					colorBackground[] = {0,1,1,1};
				};
				class commanderName: CP_RscText
				{
					idc = 919191;
					x = 0.045 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.0928125 * safezoneW;
					h = 0.044 * safezoneH;
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
					colorText[] = {0,1,1,1};
				};
				class commanderButton: CP_RscButtonMenu
				{
					idc = 919192;
					text = "Take";
					style = 2;
					action =  "0 spawn MCC_fnc_RSTakeCommander";
					x = 0.144375 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.05 * safezoneW;
					h = 0.044 * safezoneH;
				};

				class CP_exitButton: CP_RscButtonMenu
				{
					action = "endMission 'END1' ";

					idc = 1006;
					text = "Exit Game";
					x = 0.737343 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.0928125 * safezoneW;
					h = 0.044 * safezoneH;
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
				};

				class CP_flag: CP_RscPicture
				{
					idc = 20;

					x = 0.567187 * safezoneW;
					y = 0.066 * safezoneH;
					w = 0.0567187 * safezoneW;
					h = 0.033 * safezoneH;
				};
				class CP_side1: CP_RscText
				{
					idc = 21;

					x = 0.53625 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.034375 * safezoneW;
					h = 0.0219914 * safezoneH;
					colorText[] = {0,1,1,1};
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
				};
				class CP_side1Score: CP_RscText
				{
					idc = 22;
					style = 2;

					x = 0.53625 * safezoneW;
					y = 0.033 * safezoneH;
					w = 0.034375 * safezoneW;
					h = 0.0219914 * safezoneH;
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
				};
				class CP_side2: CP_RscText
				{
					idc = 23;

					x = 0.5775 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.034375 * safezoneW;
					h = 0.0219914 * safezoneH;
					colorText[] = {0,1,1,1};
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
				};
				class CP_side2Score: CP_RscText
				{
					idc = 24;
					style = 2;

					x = 0.5775 * safezoneW;
					y = 0.033 * safezoneH;
					w = 0.034375 * safezoneW;
					h = 0.0219914 * safezoneH;
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
				};
				class CP_side3: CP_RscText
				{
					idc = 25;

					x = 0.61875 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.034375 * safezoneW;
					h = 0.0219914 * safezoneH;
					colorText[] = {0,1,1,1};
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
				};
				class CP_side3Score: CP_RscText
				{
					idc = 26;
					style = 2;

					x = 0.61875 * safezoneW;
					y = 0.033 * safezoneH;
					w = 0.034375 * safezoneW;
					h = 0.0219914 * safezoneH;
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
				};

				class MCC_ResourcesControlsGroup: MCC_RscControlsGroupNoScrollbars
				{
					idc = 80;

					x = 0.226875 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.268125 * safezoneW;
					h = 0.088 * safezoneH;
					class controls
					{
						class MCC_AmmoText: MCC_RscText
						{
							idc = 81;
							style = 2;
							sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";

							x = 0 * safezoneW;
							y = 0.033 * safezoneH;
							w = 0.0360937 * safezoneW;
							h = 0.033 * safezoneH;
						};

						class MCC_RepairText: MCC_RscText
						{
							idc = 82;
							style = 2;
							sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";

							x = 0.04125 * safezoneW;
							y = 0.033 * safezoneH;
							w = 0.0360937 * safezoneW;
							h = 0.033 * safezoneH;
						};

						class MCC_FuelText: MCC_RscText
						{
							idc = 83;
							style = 2;
							sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";

							x = 0.0825002 * safezoneW;
							y = 0.033 * safezoneH;
							w = 0.0360937 * safezoneW;
							h = 0.033 * safezoneH;
						};
						class MCC_FoodText: MCC_RscText
						{
							idc = 84;
							style = 2;
							sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";

							x = 0.12375 * safezoneW;
							y = 0.033 * safezoneH;
							w = 0.0360937 * safezoneW;
							h = 0.033 * safezoneH;
						};
						class MCC_MedText: MCC_RscText
						{
							idc = 85;
							style = 2;
							sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";

							x = 0.165 * safezoneW;
							y = 0.033 * safezoneH;
							w = 0.0360937 * safezoneW;
							h = 0.033 * safezoneH;
						};
						class MCC_Ammo: MCC_RscPicture
						{
							idc = -1;

							text =  __EVAL(MCCPATH +"data\IconAmmo.paa");
							x = 0.010313 * safezoneW;
							y = 0 * safezoneH;
							w = 0.0154689 * safezoneW;
							h = 0.033 * safezoneH;
						};
						class MCC_Repair: MCC_RscPicture
						{
							idc = -1;

							text = __EVAL(MCCPATH +"data\IconRepair.paa");
							x = 0.0515627 * safezoneW;
							y = -1.63913e-008 * safezoneH;
							w = 0.0154689 * safezoneW;
							h = 0.033 * safezoneH;
						};
						class MCC_Fuel: MCC_RscPicture
						{
							idc = -1;

							text = __EVAL(MCCPATH +"data\IconFuel.paa");
							x = 0.0928127 * safezoneW;
							y = -1.63913e-008 * safezoneH;
							w = 0.0154689 * safezoneW;
							h = 0.033 * safezoneH;
						};
						class MCC_FoodPic: MCC_RscPicture
						{
							idc = -1;

							text = __EVAL(MCCPATH +"data\IconFood.paa");
							x = 0.134063 * safezoneW;
							y = -1.63913e-008 * safezoneH;
							w = 0.0154689 * safezoneW;
							h = 0.033 * safezoneH;
						};
						class MCC_MedPic: MCC_RscPicture
						{
							idc = -1;

							text = __EVAL(MCCPATH +"data\IconMed.paa");
							x = 0.175313 * safezoneW;
							y = -1.63913e-008 * safezoneH;
							w = 0.0154689 * safezoneW;
							h = 0.033 * safezoneH;
						};
					};
				};
			};
		};

		class CP_deployPanelMiniMapBckg: CP_RscText
		{
			idc = 44;
			colorBackground[] = {0.192,0.192,0.192,0.9};

			x = 0.1648 * safezoneW + safezoneX;
			y = 0.115 * safezoneH + safezoneY;
			w = 0.835312 * safezoneW;
			h = 0.793 * safezoneH;
		};

		class CP_deployPanelMiniMap: CP_RscMapControl
		{
			idc = 4;
			text = "#(argb,8,8,3)color(1,1,1,1)";

			x = 0.17 * safezoneW + safezoneX;
			y = 0.117 * safezoneH + safezoneY;
			w = 0.81 * safezoneW;
			h = 0.79 * safezoneH;
		};

		class bottomCtrlsGroup: MCC_RscControlsGroupNoScrollbars
		{
			idc = 2301;
			x = 0.164844 * safezoneW + safezoneX;
			y = 0.907 * safezoneH + safezoneY;
			w = 0.840469 * safezoneW;
			h = 0.11 * safezoneH;
			class controls
			{
				class bottomBckg: CP_RscText
				{
					idc = -1;
					x = 0 * safezoneW;
					y = 0 * safezoneH;
					w = 0.840469 * safezoneW;
					h = 0.11 * safezoneH;
					colorBackground[] = {0.192,0.192,0.192,0.9};
				};
				class CP_feedback: CP_RscText
				{
					idc = 9999;
					style = 2;

					x = 0.0721875 * safezoneW;
					y = 0.008 * safezoneH;
					w = 0.324844 * safezoneW;
					h = 0.066 * safezoneH;
					colorText[] = {1,0,0,0.8};
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
				};
				class timeLeft: CP_RscText
				{
					idc = 1919;

					x = 0.427969 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.149531 * safezoneW;
					h = 0.044 * safezoneH;
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
				};

				class CP_deployPanelButton: CP_RscButton
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

				class CP_XPProgress: MCC_RscProgress
				{
					idc = 104;
					style = 2;

					x = 0.0721875 * safezoneW;
					y = 0.052 * safezoneH;
					w = 0.324844 * safezoneW;
					h = 0.022 * safezoneH;
					colorText[] = {1,0,0,0.8};
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
					colorFrame[] = {1,1,1,0.8};
					colorBackground[] = {0,0,0,0.3};
				};
				class RscText_1005: CP_RscStructuredText
				{
					idc = 102;
					style = 2;

					x = 0.0721875 * safezoneW;
					y = 0.074 * safezoneH;
					w = 0.324844 * safezoneW;
					h = 0.033 * safezoneH;
					colorText[] = {1,0,0,0.8};
					sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
				};
				class CP_XP: CP_RscText
				{
					idc = 103;
					text = "XP";
					x = 0.04125 * safezoneW;
					y = 0.049 * safezoneH;
					w = 0.0257812 * safezoneW;
					h = 0.033 * safezoneH;
				};
			};
		};


		class CP_sglogo: CP_RscPicture
		{
			idc = -1;
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.016 * safezoneH + safezoneY;
			w = 0.139219 * safezoneW;
			h = 0.099 * safezoneH;
			text = __EVAL(CPPATH+"mcc\roleSelection\data\sgLogo.paa");
			colorText[] = {1,1,1,1.8};
		};


		class CP_squadPanelButton: CP_RscButtonMenu
		{
			idc = 28;
			type = 16;
			text = "Squad"; //--- ToDo: Localize;
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.126 * safezoneH + safezoneY;
			w = 0.0670311 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			action = __EVAL("[0] execVM '"+CPPATH+"mcc\roleSelection\scripts\switchDialog.sqf'");
		};
		class CP_gearPanelButton: CP_RscButtonMenu
		{
			idc = 29;
			type = 16;
			text = "Role"; //--- ToDo: Localize;
			x = 0.0823437 * safezoneW + safezoneX;
			y = 0.126 * safezoneH + safezoneY;
			w = 0.0670311 * safezoneW;
			h = 0.044 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			action = __EVAL("[1] execVM '"+CPPATH+"mcc\roleSelection\scripts\switchDialog.sqf'");
		};

		class CP_squadList: MCC_RscControlsGroup
		{
			idc = 2302;
			x = 0.0101562 * safezoneW + safezoneX;
			y = 0.17 * safezoneH + safezoneY;
			w = 0.14 * safezoneW;
			h = 0.737 * safezoneH;
			class controls
			{
				class CP_squadListBckg: CP_RscText
				{
					idc = -1;

					x = 0 * safezoneW;
					y = 0 * safezoneH;
					w = 0.14 * safezoneW;
					h = 0.737 * safezoneH;
					colorBackground[] = {0,0,0,0.7};
				};
			};

		};

		class CreateSquad: CP_RscButtonMenu
		{
			idc = -1;
			text = "Create Squad";
			style = 2;
			onButtonClick = "_this spawn MCC_fnc_RSSquadCreate";
			x = 0.0410937 * safezoneW + safezoneX;
			y = 0.951 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.033 * safezoneH;
		};
	};
};
