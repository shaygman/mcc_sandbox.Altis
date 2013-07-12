class CP_WEAPONSPANEL {
	  idd = -1;
	  movingEnable = false;
	  onLoad =  __EVAL("_this execVM '"+CPPATH+"configs\dialogs\gearPanel\weaponsPanel_init.sqf'");
	  
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
		CP_weaponsPanelBackButton,
		CP_weaponsPanelPrimary,
		CP_weaponsPanelPrimaryAccessories,
		CP_weaponsPanelSecondary,
		CP_weaponsPanelHandgun,
		CP_weaponsPanelItem1,
		CP_weaponsPanelItem2,
		CP_weaponsPanelItem3,
		CP_gearPanelPiP,
		CP_gearPanelPiPFake,
		CP_InfoText,
		CP_tittle
	  };

	class CP_weaponsPanelBackButton: CP_RscButtonMenu
	{
		idc = -1;
		text = "Back"; //--- ToDo: Localize;
		x = 0.631771 * safezoneW + safezoneX;
		y = 0.247099 * safezoneH + safezoneY;
		w = 0.0973958 * safezoneW;
		h = 0.0439828 * safezoneH;
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
	class CP_weaponsPanelPrimary: CP_RscListbox
	{
		idc = 0;
		text = "Primary"; //--- ToDo: Localize;
		x = 0.29375 * safezoneW + safezoneX;
		y = 0.291081 * safezoneH + safezoneY;
		w = 0.3 * safezoneW;
		h = 0.0659743 * safezoneH;
		colorBackground[] = {0,0,0,0.8};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		onLBSelChanged = __EVAL("[0] execVM '"+CPPATH+"configs\dialogs\gearPanel\weaponsPanel_cmd.sqf'");
	};
	class CP_weaponsPanelPrimaryAccessories: CP_RscButtonMenu
	{
		idc = -1;
		text = "Accessories"; //--- ToDo: Localize;
		x = 0.351042 * safezoneW + safezoneX;
		y = 0.357056 * safezoneH + safezoneY;
		w = 0.2 * safezoneW;
		h = 0.0219914 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class CP_weaponsPanelSecondary: CP_RscListbox
	{
		idc = 1;
		text = "Secondary"; //--- ToDo: Localize;
		x = 0.29375 * safezoneW + safezoneX;
		y = 0.390043 * safezoneH + safezoneY;
		w = 0.3 * safezoneW;
		h = 0.0659743 * safezoneH;
		colorBackground[] = {0,0,0,0.8};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		onLBSelChanged = __EVAL("[1] execVM '"+CPPATH+"configs\dialogs\gearPanel\weaponsPanel_cmd.sqf'");
	};
	class CP_weaponsPanelHandgun: CP_RscListbox
	{
		idc = 2;
		text = "Handgun"; //--- ToDo: Localize;
		x = 0.29375 * safezoneW + safezoneX;
		y = 0.467013 * safezoneH + safezoneY;
		w = 0.3 * safezoneW;
		h = 0.0659743 * safezoneH;
		colorBackground[] = {0,0,0,0.8};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		onLBSelChanged = __EVAL("[2] execVM '"+CPPATH+"configs\dialogs\gearPanel\weaponsPanel_cmd.sqf'");
	};
	class CP_weaponsPanelItem1: CP_RscListbox
	{
		idc = 3;
		text = "Item1"; //--- ToDo: Localize;
		x = 0.29375 * safezoneW + safezoneX;
		y = 0.543983 * safezoneH + safezoneY;
		w = 0.3 * safezoneW;
		h = 0.0659743 * safezoneH;
		colorBackground[] = {0,0,0,0.8};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
		onLBSelChanged = __EVAL("[3] execVM '"+CPPATH+"configs\dialogs\gearPanel\weaponsPanel_cmd.sqf'");
	};
	class CP_weaponsPanelItem2: CP_RscListbox
	{
		idc = 4;
		text = "Item2"; //--- ToDo: Localize;
		x = 0.29375 * safezoneW + safezoneX;
		y = 0.620953 * safezoneH + safezoneY;
		w = 0.3 * safezoneW;
		h = 0.0659743 * safezoneH;
		colorBackground[] = {0,0,0,0.8};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
	};
	class CP_weaponsPanelItem3: CP_RscListbox
	{
		idc = 5;
		text = "Item3"; //--- ToDo: Localize;
		x = 0.29375 * safezoneW + safezoneX;
		y = 0.697923 * safezoneH + safezoneY;
		w = 0.3 * safezoneW;
		h = 0.0659743 * safezoneH;
		colorBackground[] = {0,0,0,0.8};
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.5)";
	};
	class CP_gearPanelPiP: CP_RscPicture
	{
		idc = -1;
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
		idc = 6;
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
