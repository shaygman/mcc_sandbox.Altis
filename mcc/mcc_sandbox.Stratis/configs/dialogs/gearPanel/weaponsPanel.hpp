class CP_WEAPONSPANEL {
	  idd = -1;
	  movingEnable = false;
	  onLoad =  __EVAL("_this execVM '"+CPPATH+"configs\dialogs\gearPanel\weaponsPanel_init.sqf'");
	  
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
		CP_weaponsPanelBackButton,
		CP_weaponsPanelPrimary,
		CP_weaponsPanelPrimaryAccessories,
		CP_weaponsPanelSecondary,
		CP_weaponsPanelHandgun,
		CP_weaponsPanelItem1,
		CP_weaponsPanelItem2,
		CP_weaponsPanelItem3,
		CP_PrimaryTittle,
		CP_SecondaryTittle,
		CP_HandgunTittle,
		CP_item1Tittle,
		CP_item2Tittle,
		CP_item3Tittle,
		CP_gearPanelPiP,
		CP_gearPanelPiPFake,
		CP_InfoText,
		CP_tittle
	  };

	class CP_weaponsPanelBackButton: CP_RscButtonMenu
	{
		idc = -1;
		text = "Back"; //--- ToDo: Localize;
		x = 0.618982 * safezoneW + safezoneX;
		y = 0.210987 * safezoneH + safezoneY;
		w = 0.0973958 * safezoneW;
		h = 0.0439827 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		action = __EVAL("[2] execVM '"+CPPATH+"configs\dialogs\switchDialog.sqf'");
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
	class CP_weaponsPanelPrimary: CP_RscCombo
	{
		idc = 0;
		text = "Primary"; //--- ToDo: Localize;
		x = 0.43201 * safezoneW + safezoneX;
		y = 0.261989 * safezoneH + safezoneY;
		w = 0.263461 * safezoneW;
		h = 0.0680031 * safezoneH;
		colorBackground[] = {0,0,0,0.8};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		onLBSelChanged = __EVAL("[0] execVM '"+CPPATH+"configs\dialogs\gearPanel\weaponsPanel_cmd.sqf'");
	};
	class CP_weaponsPanelPrimaryAccessories: CP_RscButtonMenu
	{
		idc = -1;
		text = "Accessories"; //--- ToDo: Localize;
		x = 0.491501 * safezoneW + safezoneX;
		y = 0.329992 * safezoneH + safezoneY;
		w = 0.199999 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.3)";
		action = __EVAL("[3] execVM '"+CPPATH+"configs\dialogs\switchDialog.sqf'");
	};
	class CP_weaponsPanelSecondary: CP_RscCombo
	{
		idc = 1;
		text = "Secondary"; //--- ToDo: Localize;
		x = 0.43201 * safezoneW + safezoneX;
		y = 0.363994 * safezoneH + safezoneY;
		w = 0.263461 * safezoneW;
		h = 0.0680031 * safezoneH;
		colorBackground[] = {0,0,0,0.8};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		onLBSelChanged = __EVAL("[1] execVM '"+CPPATH+"configs\dialogs\gearPanel\weaponsPanel_cmd.sqf'");
	};
	class CP_weaponsPanelHandgun: CP_RscCombo
	{
		idc = 2;
		text = "Handgun"; //--- ToDo: Localize;
		x = 0.43201 * safezoneW + safezoneX;
		y = 0.448998 * safezoneH + safezoneY;
		w = 0.263461 * safezoneW;
		h = 0.0680031 * safezoneH;
		colorBackground[] = {0,0,0,0.8};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		onLBSelChanged = __EVAL("[2] execVM '"+CPPATH+"configs\dialogs\gearPanel\weaponsPanel_cmd.sqf'");
	};
	class CP_weaponsPanelItem1: CP_RscCombo
	{
		idc = 3;
		text = "Item1"; //--- ToDo: Localize;
		x = 0.43201 * safezoneW + safezoneX;
		y = 0.534002 * safezoneH + safezoneY;
		w = 0.263461 * safezoneW;
		h = 0.0680031 * safezoneH;
		colorBackground[] = {0,0,0,0.8};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		onLBSelChanged = __EVAL("[3] execVM '"+CPPATH+"configs\dialogs\gearPanel\weaponsPanel_cmd.sqf'");
	};
	class CP_weaponsPanelItem2: CP_RscCombo
	{
		idc = 4;
		text = "Item2"; //--- ToDo: Localize;
		x = 0.43201 * safezoneW + safezoneX;
		y = 0.619005 * safezoneH + safezoneY;
		w = 0.263461 * safezoneW;
		h = 0.0680031 * safezoneH;
		colorBackground[] = {0,0,0,0.8};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		onLBSelChanged = __EVAL("[4] execVM '"+CPPATH+"configs\dialogs\gearPanel\weaponsPanel_cmd.sqf'");
	};
	class CP_weaponsPanelItem3: CP_RscCombo
	{
		idc = 5;
		text = "Item3"; //--- ToDo: Localize;
		x = 0.43201 * safezoneW + safezoneX;
		y = 0.704009 * safezoneH + safezoneY;
		w = 0.263461 * safezoneW;
		h = 0.0680031 * safezoneH;
		colorBackground[] = {0,0,0,0.8};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		onLBSelChanged = __EVAL("[5] execVM '"+CPPATH+"configs\dialogs\gearPanel\weaponsPanel_cmd.sqf'");
	};
	class CP_PrimaryTittle: CP_RscText
	{
		idc = -1;
		text = "Primary: "; //--- ToDo: Localize;
		x = 0.313028 * safezoneW + safezoneX;
		y = 0.261989 * safezoneH + safezoneY;
		w = 0.101985 * safezoneW;
		h = 0.0510023 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class CP_SecondaryTittle: CP_RscText
	{
		idc = -1;

		text = "Secondary: "; //--- ToDo: Localize;
		x = 0.313028 * safezoneW + safezoneX;
		y = 0.363994 * safezoneH + safezoneY;
		w = 0.101985 * safezoneW;
		h = 0.0510023 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class CP_HandgunTittle: CP_RscText
	{
		idc = -1;

		text = "Handgun: "; //--- ToDo: Localize;
		x = 0.313028 * safezoneW + safezoneX;
		y = 0.448998 * safezoneH + safezoneY;
		w = 0.101985 * safezoneW;
		h = 0.0510023 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class CP_item1Tittle: CP_RscText
	{
		idc = -1;

		text = "Item 1:"; //--- ToDo: Localize;
		x = 0.313028 * safezoneW + safezoneX;
		y = 0.534002 * safezoneH + safezoneY;
		w = 0.101985 * safezoneW;
		h = 0.0510023 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class CP_item2Tittle: CP_RscText
	{
		idc = -1;

		text = "Item 2:"; //--- ToDo: Localize;
		x = 0.313028 * safezoneW + safezoneX;
		y = 0.619005 * safezoneH + safezoneY;
		w = 0.101985 * safezoneW;
		h = 0.0510023 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class CP_item3Tittle: CP_RscText
	{
		idc = -1;

		text = "Item 3:"; //--- ToDo: Localize;
		x = 0.313028 * safezoneW + safezoneX;
		y = 0.704009 * safezoneH + safezoneY;
		w = 0.101985 * safezoneW;
		h = 0.0510023 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class CP_gearPanelPiP: CP_RscPicture
	{
		idc = -1;
		text = "#(argb,512,512,1)r2t(rendertarget7,1.0);";
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
	class CP_InfoText: CP_RscStructuredText
	{
		idc = 6;
		x = 0.1 * safezoneW + safezoneX;
		y = 0.225107 * safezoneH + safezoneY;
		w = 0.1 * safezoneW;
		h = 0.1 * safezoneH;
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
};
