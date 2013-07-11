class CP_SQUADPANEL {
	  idd = -1;
	  movingEnable = false;
	  onLoad =  __EVAL("_this execVM '"+CPPATH+"configs\dialogs\gearPanel\squadPanel_init.sqf'");
	  
	  controlsBackground[] = 
	  {
	  	  CP_respawnPanelBckg
	  };
	  

	  //---------------------------------------------
	  objects[] = 
	  { 
	  };
	  
	  controls[] = 
	  {
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
	  CP_tittle
	  };

		class CP_respawnPanelButton: CP_RscButtonMenu
		{
			idc = -1;
			text = "Respawn"; //--- ToDo: Localize;
			x = 0.270833 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			action = __EVAL("[0] execVM '"+CPPATH+"configs\dialogs\switchDialog.sqf'");
		};
		class CP_squadPanelButton: CP_RscButtonMenu
		{
			idc = -1;
			text = "Squad"; //--- ToDo: Localize;
			x = 0.373958 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CP_gearPanelButton: CP_RscButtonMenu
		{
			idc = -1;
			text = "Gear"; //--- ToDo: Localize;
			x = 0.477083 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			action = __EVAL("[2] execVM '"+CPPATH+"configs\dialogs\switchDialog.sqf'");
		};
		class CP_squadPanelSquadList: CP_RscListbox
		{
			idc = 0;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.335063 * safezoneH + safezoneY;
			w = 0.194792 * safezoneW;
			h = 0.285889 * safezoneH;
			colorBackground[] = {0,0,0,0.7};
			onLBSelChanged = __EVAL("[0] execVM '"+CPPATH+"configs\dialogs\gearPanel\squadPanel_cmd.sqf'");
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.4)";
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
		class CP_squadsPanelSquadsTittle: CP_RscText
		{
			idc = -1;
			text = "Squads:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.280086 * safezoneH + safezoneY;
			w = 0.194792 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		};
		class CP_squadPanelPlayersList: CP_RscListbox
		{
			idc = 1;
			x = 0.511458 * safezoneW + safezoneX;
			y = 0.379047 * safezoneH + safezoneY;
			w = 0.194792 * safezoneW;
			h = 0.241906 * safezoneH;
			colorBackground[] = {0,0,0,0.7};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CP_squadsPanelActiveSquadTittle: CP_RscText
		{
			idc = 2;
			text = "Active Squad:"; //--- ToDo: Localize;
			x = 0.511458 * safezoneW + safezoneX;
			y = 0.335064 * safezoneH + safezoneY;
			w = 0.194792 * safezoneW;
			h = 0.0439828 * safezoneH;
			colorBackground[] = {0.7,0.3,0.3,0.7};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		};
		class CP_squadPanelJoinButton: CP_RscButtonMenu
		{
			idc = 3;
			text = "Join Squad"; //--- ToDo: Localize;
			x = 0.608854 * safezoneW + safezoneX;
			y = 0.631948 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			tooltip = "Join this squad"; //--- ToDo: Localize;
			action = __EVAL("[1] execVM '"+CPPATH+"configs\dialogs\gearPanel\squadPanel_cmd.sqf'");
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CP_squadPanelSwitchSidesButton: CP_RscButtonMenu
		{
			idc = -1;
			text = "Switch Side"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.664936 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			tooltip = "Switch to the opposite side"; //--- ToDo: Localize;
			action = __EVAL("[2] execVM '"+CPPATH+"configs\dialogs\gearPanel\squadPanel_cmd.sqf'");
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CP_squadPanelCreateSquadButton: CP_RscButtonMenu
		{
			idc = 5;
			text = "Create Squad"; //--- ToDo: Localize;
			x = 0.385417 * safezoneW + safezoneX;
			y = 0.664936 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			tooltip = "Create a new squad - up to 8 squads allowed. Type the name of your new squad bellow"; //--- ToDo: Localize;
			action = __EVAL("[3] execVM '"+CPPATH+"configs\dialogs\gearPanel\squadPanel_cmd.sqf'");
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CP_squadPanelCreateSquadTittle: CP_RscText
		{
			idc = -1;
			text = "Squad Name:"; //--- ToDo: Localize;
			x = 0.276563 * safezoneW + safezoneX;
			y = 0.719914 * safezoneH + safezoneY;
			w = 0.0744792 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
		};
		class CP_squadPanelCreateSquadText: CP_RscText
		{
			idc = 4;
			type = CPCT_EDIT;
			style = CPST_MULTI;
			x = 0.356771 * safezoneW + safezoneX;
			y = 0.719914 * safezoneH + safezoneY;
			w = 0.126042 * safezoneW;
			h = 0.0439828 * safezoneH;
			colorBackground[] = {0,0,0,0.7};
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CP_gearPanelPiP: CP_RscPicture
		{
			idc = 6;
			text = "#(argb,512,512,1)r2t(rendertarget10,1.0);";
			x = 0.74 * safezoneW + safezoneX;
			y = 0.291081 * safezoneH + safezoneY;
			w = 0.250521 * safezoneW;
			h = 0.47 * safezoneH;
		};
		class CP_gearPanelPiPFake: CP_RscListBox
		{
			idc = -1;
			x = 0.74 * safezoneW + safezoneX;
			y = 0.291081 * safezoneH + safezoneY;
			w = 0.250521 * safezoneW;
			h = 0.47 * safezoneH;
			onMouseZChanged = __EVAL("['MouseZChanged',_this] execVM '"+CPPATH+"configs\dialogs\gearPanel\camMouseMoving.sqf'");
			onMouseMoving = __EVAL("['mousemoving',_this] execVM '"+CPPATH+"configs\dialogs\gearPanel\camMouseMoving.sqf'");
			onMouseButtonDown = __EVAL("['MouseButtonDown',_this] execVM '"+CPPATH+"configs\dialogs\gearPanel\camMouseMoving.sqf'");
			onMouseButtonUp = __EVAL("['MouseButtonUp',_this] execVM '"+CPPATH+"configs\dialogs\gearPanel\camMouseMoving.sqf'");
		};
		class CP_InfoText: CP_RscText
		{
			idc = 7;
			x = 0.1 * safezoneW + safezoneX;
			y = 0.225107 * safezoneH + safezoneY;
			w = 0.161476 * safezoneW;
			h = 0.544025 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
			colorBackground[] = {0,0,0,0.8};
		};
		class CP_tittle: CP_RscPicture
		{
			idc = -1;
			x = 0.22804 * safezoneW + safezoneX;
			y = 0.0409789 * safezoneH + safezoneY;
			w = 0.492927 * safezoneW;
			h = 0.153007 * safezoneH;
			text = __EVAL(CPPATH+"configs\data\chockpoints.paa");
		};
	};
