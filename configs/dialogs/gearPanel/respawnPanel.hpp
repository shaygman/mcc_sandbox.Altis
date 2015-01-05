class CP_RESPAWNPANEL {
	  idd = -1;
	  movingEnable = false;
	  onLoad =  __EVAL("_this execVM '"+CPPATH+"configs\dialogs\gearPanel\respawnPanel_init.sqf'");

	  controlsBackground[] =
	  {
	  	  bckg,
	  	  CP_respawnPanelBckg,
		  CP_tittle,
		  CP_sglogo
	  };


	  //---------------------------------------------
	  objects[] =
	  {
	  };

	  controls[] =
	  {
		CP_exitButton,
		CP_respawnPanelButton,
		CP_squadPanelButton,
		CP_gearPanelButton,
		CP_respawnPointsList,
		CP_deployPanelMiniMap,
		CP_deployPanelButton,
		CP_respawnPanelRoleTittle,
		CP_respawnPanelRoleCombo,
		CP_respawnPanelSpawnpointsTittle,
		CP_gearPanelPiP,
		CP_gearPanelPiPFake,
		CP_InfoText,
		CP_flag,
		CP_side1,
		CP_side1Score,
		CP_side2,
		CP_side2Score,
		CP_side3,
		CP_side3Score,
		MCC_ResourcesControlsGroup,
		CP_RscMainXPUI,
		CP_ItemsLoad,
		timeLeft
	  };

	  	#include "RscControlsGroupItemsLoad.hpp"

	  	class bckg: CP_RscText
		{
			idc = 999;
			x = -0.00531252 * safezoneW + safezoneX;
			y = -0.00599999 * safezoneH + safezoneY;
			w = 1.01063 * safezoneW;
			h = 1.012 * safezoneH;
			colorBackground[] = {0,0,0,1};
		};

		class timeLeft: CP_RscText
		{
			idc = 1919;
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		};

		class CP_exitButton: CP_RscButtonMenu
		{
			idc = -1;

			text = "Exit Game"; //--- ToDo: Localize;
			x = 0.872396 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			action = "endMission 'END1' ";
		};
		class CP_respawnPanelButton: CP_RscButtonMenu
		{
			idc = 27;
			type = 16;
			text = "Respawn"; //--- ToDo: Localize;
			x = 0.15625 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CP_squadPanelButton: CP_RscButtonMenu
		{
			idc = 28;
			type = 16;
			text = "Squad"; //--- ToDo: Localize;
			x = 0.259375 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			action = __EVAL("[1] execVM '"+CPPATH+"configs\dialogs\switchDialog.sqf'");
		};
		class CP_gearPanelButton: CP_RscButtonMenu
		{
			idc = 29;
			type = 16;
			text = "Gear"; //--- ToDo: Localize;
			x = 0.3625 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			action = __EVAL("[2] execVM '"+CPPATH+"configs\dialogs\switchDialog.sqf'");
		};
		class CP_respawnPointsList: CP_RscListbox
		{
			idc = 0;
			x = 0.156284 * safezoneW + safezoneX;
			y = 0.33478 * safezoneH + safezoneY;
			w = 0.103125 * safezoneW;
			h = 0.374 * safezoneH;
			colorBackground[] = {0,0,0,0.8};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			onLBSelChanged = __EVAL("[0] execVM '"+CPPATH+"configs\dialogs\gearPanel\respawnPanel_cmd.sqf'");
		};
		class CP_deployPanelMiniMap: CP_RscMapControl
		{
			idc = 4;
			text = "#(argb,8,8,3)color(1,1,1,1)";
			x = 0.262812 * safezoneW + safezoneX;
			y = 0.33478 * safezoneH + safezoneY;
			w = 0.345469 * safezoneW;
			h = 0.374 * safezoneH;
		};
		class CP_deployPanelButton: CP_RscButtonMenu
		{
			idc = 32;
			text = "Deploy"; //--- ToDo: Localize;
			colorBackground[] = {1,0,0,0.3};

			x = 0.505729 * safezoneW + safezoneX;
			y = 0.741906 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			tooltip = "Press Deploy to get into the action"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			action = __EVAL("[1] execVM '"+CPPATH+"configs\dialogs\gearPanel\respawnPanel_cmd.sqf'");
		};
		class CP_respawnPanelRoleTittle: CP_RscText
		{
			idc = 31;
			text = "Role:"; //--- ToDo: Localize;
			x = 0.3625 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.0572917 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		};
		class CP_respawnPanelRoleCombo: CP_RscCombo
		{
			idc = 99;
			x = 0.425544 * safezoneW + safezoneX;
			y = 0.28 * safezoneH + safezoneY;
			w = 0.185625 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "Select your role in the battlefield"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			onLBSelChanged = __EVAL("[2,_this] execVM '"+CPPATH+"configs\dialogs\gearPanel\respawnPanel_cmd.sqf'");
		};
		class CP_respawnPanelBckg: CP_RscText
		{
			idc = -1;
			x = 0 * safezoneW + safezoneX;
			y = 0.2 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 0.6 * safezoneH;
			colorBackground[] = {1,1,1,0.2};
		};
		class CP_respawnPanelSpawnpointsTittle: CP_RscText
		{
			idc = -1;
			text = "Spawn Points:"; //--- ToDo: Localize;
			x = 0.15625 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.194792 * safezoneW;
			h = 0.0439828 * safezoneH;
			tooltip = "Select a valid spawn point and press Deploy"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		};
		class CP_gearPanelPiP: CP_RscPicture
		{
			idc = 5;
			text = "#(argb,512,512,1)r2t(rendertarget7,1.0);";
			x = 0.614583 * safezoneW + safezoneX;
			y = 0.291081 * safezoneH + safezoneY;
			w = 0.273281 * safezoneW;
			h = 0.418 * safezoneH;
		};
		class CP_gearPanelPiPFake: CP_RscListBox
		{
			idc = 30;
			x = 0.614583 * safezoneW + safezoneX;
			y = 0.291081 * safezoneH + safezoneY;
			w = 0.273281 * safezoneW;
			h = 0.418 * safezoneH;
			onMouseZChanged = __EVAL("['MouseZChanged',_this] execVM '"+CPPATH+"configs\dialogs\gearPanel\camMouseMoving.sqf'");
			onMouseMoving = __EVAL("['mousemoving',_this] execVM '"+CPPATH+"configs\dialogs\gearPanel\camMouseMoving.sqf'");
			onMouseButtonDown = __EVAL("['MouseButtonDown',_this] execVM '"+CPPATH+"configs\dialogs\gearPanel\camMouseMoving.sqf'");
			onMouseButtonUp = __EVAL("['MouseButtonUp',_this] execVM '"+CPPATH+"configs\dialogs\gearPanel\camMouseMoving.sqf'");
		};
		class CP_InfoText: CP_RscText
		{
			idc = 6;
			x = 0.15625 * safezoneW + safezoneX;
			y = 0.19212 * safezoneH + safezoneY;
			w = 0.200521 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		};
		class CP_tittle: CP_RscPicture
		{
			idc = -1;
			x = 0.22804 * safezoneW + safezoneX;
			y = 0.0409789 * safezoneH + safezoneY;
			w = 0.492927 * safezoneW;
			h = 0.153007 * safezoneH;
			text = __EVAL(CPPATH+"configs\data\chockpoints.paa");
			colorText[] = {1,1,1,1.8};
		};
		class CP_sglogo: CP_RscPicture
		{
			idc = -1;
			x = 0.01 * safezoneW + safezoneX;
			y = 0.65 * safezoneH + safezoneY;
			w = 0.114583 * safezoneW;
			h = 0.142944 * safezoneH;
			text = __EVAL(CPPATH+"configs\data\sgLogo.paa");
			colorText[] = {1,1,1,1.8};
		};

		class CP_flag: CP_RscPicture
		{
			idc = 20;

			x = 0.614583 * safezoneW + safezoneX;
			y = 0.207514 * safezoneH + safezoneY;
			w = 0.0916667 * safezoneW;
			h = 0.07697 * safezoneH;
		};
		class CP_side1: CP_RscText
		{
			idc = 21;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			colorText[] = {0,1,1,1};

			x = 0.711979 * safezoneW + safezoneX;
			y = 0.214111 * safezoneH + safezoneY;
			w = 0.034375 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class CP_side1Score: CP_RscText
		{
			idc = 22;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";

			x = 0.711979 * safezoneW + safezoneX;
			y = 0.240501 * safezoneH + safezoneY;
			w = 0.034375 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class CP_side2: CP_RscText
		{
			idc = 23;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			colorText[] = {0,1,1,1};

			x = 0.757813 * safezoneW + safezoneX;
			y = 0.214111 * safezoneH + safezoneY;
			w = 0.034375 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class CP_side2Score: CP_RscText
		{
			idc = 24;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";

			x = 0.757813 * safezoneW + safezoneX;
			y = 0.240501 * safezoneH + safezoneY;
			w = 0.034375 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class CP_side3: CP_RscText
		{
			idc = 25;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
			colorText[] = {0,1,1,1};

			x = 0.803646 * safezoneW + safezoneX;
			y = 0.214111 * safezoneH + safezoneY;
			w = 0.034375 * safezoneW;
			h = 0.0219914 * safezoneH;
		};
		class CP_side3Score: CP_RscText
		{
			idc = 26;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";

			x = 0.803646 * safezoneW + safezoneX;
			y = 0.240501 * safezoneH + safezoneY;
			w = 0.034375 * safezoneW;
			h = 0.0219914 * safezoneH;
		};

		class MCC_ResourcesControlsGroup: MCC_RscControlsGroupNoScrollbars
		{
			idc = 80;
			x = 0.02 * safezoneW + safezoneX;
			y = 0.22 * safezoneH + safezoneY;
			w = 0.0721875 * safezoneW;
			h = 0.231 * safezoneH;
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
				class MCC_FoodText: MCC_RscText
				{
					idc = 84;

					x = 0.0257812 * safezoneW;
					y = 0.143 * safezoneH;
					w = 0.04125 * safezoneW;
					h = 0.033 * safezoneH;
				};
				class MCC_MedText: MCC_RscText
				{
					idc = 85;

					x = 0.0257812 * safezoneW;
					y = 0.187 * safezoneH;
					w = 0.04125 * safezoneW;
					h = 0.033 * safezoneH;
				};
				class MCC_Ammo: MCC_RscPicture
				{
					idc = -1;

					text =  __EVAL(MCCPATH +"data\IconAmmo.paa");
					x = 0.00515625 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.0154688 * safezoneW;
					h = 0.033 * safezoneH;
				};
				class MCC_Repair: MCC_RscPicture
				{
					idc = -1;

					text = __EVAL(MCCPATH +"data\IconRepair.paa");
					x = 0.00515625 * safezoneW;
					y = 0.055 * safezoneH;
					w = 0.0154688 * safezoneW;
					h = 0.033 * safezoneH;
				};
				class MCC_Fuel: MCC_RscPicture
				{
					idc = -1;

					text = __EVAL(MCCPATH +"data\IconFuel.paa");
					x = 0.00515625 * safezoneW;
					y = 0.099 * safezoneH;
					w = 0.0154688 * safezoneW;
					h = 0.033 * safezoneH;
				};
				class MCC_FoodPic: MCC_RscPicture
				{
					idc = -1;

					text = __EVAL(MCCPATH +"data\IconFood.paa");
					x = 0.00515625 * safezoneW;
					y = 0.143 * safezoneH;
					w = 0.0154688 * safezoneW;
					h = 0.033 * safezoneH;
				};
				class MCC_MedPic: MCC_RscPicture
				{
					idc = -1;

					text = __EVAL(MCCPATH +"data\IconMed.paa");
					x = 0.00515625 * safezoneW;
					y = 0.187 * safezoneH;
					w = 0.0154688 * safezoneW;
					h = 0.033 * safezoneH;
				};
			};
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
