class CP_SQUADPANEL {
	  idd = -1;
	  movingEnable = false;
	  onLoad =  __EVAL("_this execVM '"+MCCPATH+"configs\dialogs\gearPanel\squadPanel_init.sqf'");

	  controlsBackground[] =
	  {
	  	  CP_respawnPanelBckg,
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
		CP_squadPanelSquadList,
		CP_squadsPanelSquadsTittle,
		CP_squadPanelPlayersList,
		CP_squadsPanelActiveSquadTittle,
		CP_squadPanelJoinButton,
		CP_squadPanelSwitchSidesButton,
		CP_squadPanelCreateSquadButton,
		CP_squadPanelCreateSquadTittle,
		CP_squadPanelCreateSquadText,
		CP_gearPanelPiP,
		CP_gearPanelPiPFake,
		CP_InfoText,
		CP_tittle,
		CP_LockSquadPic,
		CP_LockSquad,
		CP_Teleport,
		CP_Mutiny,
		CP_commanderName,
		CP_commander,
		CP_respawnPanelRoleTittle,
		CP_respawnPanelRoleCombo,
		CP_deployPanelButton,
		CP_flag,
		CP_side1,
		CP_side1Score,
		CP_side2,
		CP_side2Score,
		CP_side3,
		CP_side3Score,
		MCC_ResourcesControlsGroup,
		CP_RscMainXPUI
	  };

		class CP_exitButton: CP_RscButtonMenu
		{
			idc = 8;

			text = "Exit"; //--- ToDo: Localize;
			x = 0.872396 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			action = "endMission 'END1' ";
		};
		class CP_respawnPanelButton: CP_RscButtonMenu
		{
			idc = 9;
			text = "Respawn"; //--- ToDo: Localize;
			x = 0.15625 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			action = __EVAL("[0] execVM '"+MCCPATH+"configs\dialogs\switchDialog.sqf'");
		};
		class CP_squadPanelButton: CP_RscButtonMenu
		{
			idc = 10;
			text = "Squad"; //--- ToDo: Localize;
			x = 0.259375 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CP_gearPanelButton: CP_RscButtonMenu
		{
			idc = 11;
			text = "Gear"; //--- ToDo: Localize;
			x = 0.3625 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			action = __EVAL("[2] execVM '"+MCCPATH+"configs\dialogs\switchDialog.sqf'");
		};
		class CP_squadPanelSquadList: CP_RscListbox
		{
			idc = 0;
			x = 0.15625 * safezoneW + safezoneX;
			y = 0.335064 * safezoneH + safezoneY;
			w = 0.194792 * safezoneW;
			h = 0.285889 * safezoneH;
			colorBackground[] = {0,0,0,0.7};
			onLBSelChanged = __EVAL("[0] execVM '"+MCCPATH+"configs\dialogs\gearPanel\squadPanel_cmd.sqf'");
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.4)";
		};
		class CP_respawnPanelBckg: CP_RscText
		{
			idc = 13;
			x = 0 * safezoneW + safezoneX;
			y = 0.2 * safezoneH + safezoneY;
			w = 1 * safezoneW;
			h = 0.6 * safezoneH;
			colorBackground[] = {1,1,1,0.2};
		};
		class CP_squadsPanelSquadsTittle: CP_RscText
		{
			idc = -1;
			text = "Squads:"; //--- ToDo: Localize;
			x = 0.15625 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.194792 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		};
		class CP_squadPanelPlayersList: CP_RscListbox
		{
			idc = 1;
			x = 0.3625 * safezoneW + safezoneX;
			y = 0.379047 * safezoneH + safezoneY;
			w = 0.240625 * safezoneW;
			h = 0.241906 * safezoneH;
			colorBackground[] = {0,0,0,0.7};
			onLBSelChanged = __EVAL("[4] execVM '"+MCCPATH+"configs\dialogs\gearPanel\squadPanel_cmd.sqf'");
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CP_squadsPanelActiveSquadTittle: CP_RscText
		{
			idc = 2;
			text = "Active Squad:"; //--- ToDo: Localize;
			x = 0.3625 * safezoneW + safezoneX;
			y = 0.335064 * safezoneH + safezoneY;
			w = 0.240625 * safezoneW;
			h = 0.0439828 * safezoneH;
			colorBackground[] = {0.7,0.3,0.3,0.7};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		};
		class CP_squadPanelJoinButton: CP_RscButtonMenu
		{
			idc = 3;
			text = "Join Squad"; //--- ToDo: Localize;
			x = 0.505729 * safezoneW + safezoneX;
			y = 0.631949 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			action = __EVAL("[1] execVM '"+MCCPATH+"configs\dialogs\gearPanel\squadPanel_cmd.sqf'");
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CP_squadPanelSwitchSidesButton: CP_RscButtonMenu
		{
			idc = 12;
			text = "Switch Side"; //--- ToDo: Localize;
			x = 0.15625 * safezoneW + safezoneX;
			y = 0.664936 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			tooltip = "Switch to the opposite side"; //--- ToDo: Localize;
			action = __EVAL("[2] execVM '"+MCCPATH+"configs\dialogs\gearPanel\squadPanel_cmd.sqf'");
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CP_squadPanelCreateSquadButton: CP_RscButtonMenu
		{
			idc = 5;
			text = "Create Squad"; //--- ToDo: Localize;
			x = 0.259375 * safezoneW + safezoneX;
			y = 0.664936 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			tooltip = "Create a new squad. Type the name of your new squad bellow"; //--- ToDo: Localize;
			action = __EVAL("[3] execVM '"+MCCPATH+"configs\dialogs\gearPanel\squadPanel_cmd.sqf'");
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CP_squadPanelCreateSquadTittle: CP_RscText
		{
			idc = -1;
			text = "Squad Name:"; //--- ToDo: Localize;
			x = 0.158542 * safezoneW + safezoneX;
			y = 0.626011 * safezoneH + safezoneY;
			w = 0.0630208 * safezoneW;
			h = 0.0329871 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class CP_squadPanelCreateSquadText: CP_RscText
		{
			idc = 4;
			type = CPCT_EDIT;
			style = CPST_MULTI;
			x = 0.22374 * safezoneW + safezoneX;
			y = 0.62733 * safezoneH + safezoneY;
			w = 0.126042 * safezoneW;
			h = 0.0329871 * safezoneH;

			colorBackground[] = {0,0,0,0.7};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CP_gearPanelPiP: CP_RscPicture
		{
			idc = 6;
			text = "#(argb,512,512,1)r2t(rendertarget7,1.0);";
			x = 0.614583 * safezoneW + safezoneX;
			y = 0.291081 * safezoneH + safezoneY;
			w = 0.275 * safezoneW;
			h = 0.46182 * safezoneH;
		};
		class CP_gearPanelPiPFake: CP_RscListBox
		{
			idc = -1;
			x = 0.614583 * safezoneW + safezoneX;
			y = 0.291081 * safezoneH + safezoneY;
			w = 0.275 * safezoneW;
			h = 0.46182 * safezoneH;
			onMouseZChanged = __EVAL("['MouseZChanged',_this] execVM '"+MCCPATH+"configs\dialogs\gearPanel\camMouseMoving.sqf'");
			onMouseMoving = __EVAL("['mousemoving',_this] execVM '"+MCCPATH+"configs\dialogs\gearPanel\camMouseMoving.sqf'");
			onMouseButtonDown = __EVAL("['MouseButtonDown',_this] execVM '"+MCCPATH+"configs\dialogs\gearPanel\camMouseMoving.sqf'");
			onMouseButtonUp = __EVAL("['MouseButtonUp',_this] execVM '"+MCCPATH+"configs\dialogs\gearPanel\camMouseMoving.sqf'");
		};
		class CP_InfoText: CP_RscText
		{
			idc = 7;
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
			text = __EVAL(MCCPATH+"configs\data\chockpoints.paa");
		};
		class CP_sglogo: CP_RscPicture
		{
			idc = -1;
			x = 0.01 * safezoneW + safezoneX;
			y = 0.65 * safezoneH + safezoneY;
			w = 0.114583 * safezoneW;
			h = 0.142944 * safezoneH;
			text = __EVAL(MCCPATH+"configs\data\sgLogo.paa");
			colorText[] = {1,1,1,1.8};
		};

		class CP_LockSquadPic: CP_RscPicture
		{
			idc = 14;
			colorBackground[] = {0,0,0,0};

			x = 0.574479 * safezoneW + safezoneX;
			y = 0.335064 * safezoneH + safezoneY;
			w = 0.0229167 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		};

		class CP_LockSquad: CP_RscButtonMenu
		{
			idc = -1;
			colorBackground[] = {0,0,0,0};
			action =  __EVAL("[5] execVM '"+MCCPATH+"configs\dialogs\gearPanel\squadPanel_cmd.sqf'");

			x = 0.574479 * safezoneW + safezoneX;
			y = 0.335064 * safezoneH + safezoneY;
			w = 0.0229167 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		};

		class CP_Teleport: CP_RscButtonMenu
		{
			idc = 15;
			action =  __EVAL("[6] execVM '"+MCCPATH+"configs\dialogs\gearPanel\squadPanel_cmd.sqf'");

			text = "Teleport"; //--- ToDo: Localize;
			x = 0.3625 * safezoneW + safezoneX;
			y = 0.631949 * safezoneH + safezoneY;
			w = 0.0916667 * safezoneW;
			h = 0.0439828 * safezoneH;
			tooltip = "Teleport to the selected unit position or vehicle"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		};

		class CP_commander: CP_RscText
		{
			idc = -1;
			text = "Commander:";
			colorBackground[] = {0,0,0,0.7};
			x = 0.15625 * safezoneW + safezoneX;
			y = 0.741906 * safezoneH + safezoneY;
			w = 0.0859375 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CP_commanderName: CP_RscText
		{
			idc = 16;
			colorBackground[] = {0,0,0,0.7};
			x = 0.242188 * safezoneW + safezoneX;
			y = 0.741906 * safezoneH + safezoneY;
			w = 0.108854 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CP_Mutiny: CP_RscButtonMenu
		{
			idc = 17;
			action =  __EVAL("[7] execVM '"+MCCPATH+"configs\dialogs\gearPanel\squadPanel_cmd.sqf'");

			text = "Mutiny"; //--- ToDo: Localize;
			x = 0.3625 * safezoneW + safezoneX;
			y = 0.741906 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};

		class CP_respawnPanelRoleTittle: CP_RscText
		{
			idc = 27;
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
			x = 0.425521 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.177604 * safezoneW;
			h = 0.0439828 * safezoneH;
			tooltip = "Select your role in the battlefield"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			//onLBSelChanged = __EVAL("[2] execVM '"+MCCPATH+"configs\dialogs\gearPanel\respawnPanel_cmd.sqf'");
		};

		class CP_deployPanelButton: CP_RscButtonMenu
		{
			idc = 98;
			text = "Deploy"; //--- ToDo: Localize;
			colorBackground[] = {1,0,0,0.3};

			x = 0.505729 * safezoneW + safezoneX;
			y = 0.741906 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			tooltip = "Press Deploy to get into the action"; //--- ToDo: Localize;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			action = __EVAL("[1] execVM '"+MCCPATH+"configs\dialogs\gearPanel\respawnPanel_cmd.sqf'");
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
			w = 0.0916667 * safezoneW;
			h = 0.143 * safezoneH;
			class controls
			{
				class MCC_RepairText: MCC_RscText
				{
					idc = 81;

					x = 0.310937 * safezoneW + safezoneX;
					y = 0.28 * safezoneH + safezoneY;
					w = 0.0458333 * safezoneW;
					h = 0.033 * safezoneH;
				};
				class MCC_SuppliesText: MCC_RscText
				{
					idc = 82;

					x = 0.310937 * safezoneW + safezoneX;
					y = 0.236 * safezoneH + safezoneY;
					w = 0.0458333 * safezoneW;
					h = 0.033 * safezoneH;
				};
				class MCC_FuelText: MCC_RscText
				{
					idc = 83;

					x = 0.310937 * safezoneW + safezoneX;
					y = 0.324 * safezoneH + safezoneY;
					w = 0.0458333 * safezoneW;
					h = 0.033 * safezoneH;
				};
				class MCC_Supplies: MCC_RscPicture
				{
					idc = -1;

					text =  __EVAL(MCCPATH +"data\IconAmmo.paa"); //--- ToDo: Localize;
					x = 0.276563 * safezoneW + safezoneX;
					y = 0.236 * safezoneH + safezoneY;
					w = 0.03 * safezoneW;
					h = 0.033 * safezoneH;
				};
				class MCC_Repair: MCC_RscPicture
				{
					idc = -1;

					text = __EVAL(MCCPATH +"data\IconRepair.paa"); //--- ToDo: Localize;
					x = 0.276563 * safezoneW + safezoneX;
					y = 0.28 * safezoneH + safezoneY;
					w = 0.03 * safezoneW;
					h = 0.033 * safezoneH;
				};
				class MCC_Fuel: MCC_RscPicture
				{
					idc = -1;

					text = __EVAL(MCCPATH +"data\IconFuel.paa"); //--- ToDo: Localize;
					x = 0.276563 * safezoneW + safezoneX;
					y = 0.324 * safezoneH + safezoneY;
					w = 0.03 * safezoneW;
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
