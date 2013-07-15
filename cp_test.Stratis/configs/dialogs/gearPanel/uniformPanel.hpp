class CP_UNIFORMSPANEL {
	  idd = -1;
	  movingEnable = false;
	  onLoad =  __EVAL("_this execVM '"+CPPATH+"configs\dialogs\gearPanel\uniformsPanel_init.sqf'");
	  
	  controlsBackground[] = 
	  {
		CP_respawnPanelBckg,
		CP_tittle
	  };
	  

	  //---------------------------------------------
	  objects[] = 
	  { 
	  };
	  
	  controls[] = 
	  {
		CP_uniformPanelBackButton,
		CP_uniformPanelNV,
		CP_uniformPanelHead,
		CP_uniformPanelGoggles,
		CP_uniformPanelVest,
		CP_uniformPanelBackpack,
		CP_uniformPanelUniforms,
		CP_NVTittle,
		CP_gogglesTittle,
		CP_headgearTittle,
		CP_vestTittle,
		CP_backpackTittle,
		CP_uniformsTittle,
		CP_gearPanelPiP,
		CP_gearPanelPiPFake,
		CP_InfoText
	  };

	class CP_uniformPanelBackButton: CP_RscButtonMenu
	{
		idc = -1;
		text = "Back"; //--- ToDo: Localize;
		x = 0.63598 * safezoneW + safezoneX;
		y = 0.227987 * safezoneH + safezoneY;
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
	class CP_uniformPanelNV: CP_RscCombo
	{
		idc = 0;
		text = "NV"; //--- ToDo: Localize;
		x = 0.43201 * safezoneW + safezoneX;
		y = 0.27899 * safezoneH + safezoneY;
		w = 0.300001 * safezoneW;
		h = 0.0659743 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		onLBSelChanged = __EVAL("[0] execVM '"+CPPATH+"configs\dialogs\gearPanel\uniformPanel_cmd.sqf'");
	};
	class CP_uniformPanelHead: CP_RscCombo
	{
		idc = 1;
		text = "Head Gear"; //--- ToDo: Localize;
		x = 0.43201 * safezoneW + safezoneX;
		y = 0.363994 * safezoneH + safezoneY;
		w = 0.300001 * safezoneW;
		h = 0.0659743 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		onLBSelChanged = __EVAL("[1] execVM '"+CPPATH+"configs\dialogs\gearPanel\uniformPanel_cmd.sqf'");
	};
	class CP_uniformPanelGoggles: CP_RscCombo
	{
		idc = 2;
		text = "Goggles"; //--- ToDo: Localize;
		x = 0.43201 * safezoneW + safezoneX;
		y = 0.448998 * safezoneH + safezoneY;
		w = 0.300001 * safezoneW;
		h = 0.0659743 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		onLBSelChanged = __EVAL("[2] execVM '"+CPPATH+"configs\dialogs\gearPanel\uniformPanel_cmd.sqf'");
	};
	class CP_uniformPanelVest: CP_RscCombo
	{
		idc = 3;
		text = "Vest"; //--- ToDo: Localize;
		x = 0.43201 * safezoneW + safezoneX;
		y = 0.534002 * safezoneH + safezoneY;
		w = 0.300001 * safezoneW;
		h = 0.0659743 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		onLBSelChanged = __EVAL("[3] execVM '"+CPPATH+"configs\dialogs\gearPanel\uniformPanel_cmd.sqf'");
	};
	class CP_uniformPanelBackpack: CP_RscCombo
	{
		idc = 4;
		text = "Backpack"; //--- ToDo: Localize;
		x = 0.43201 * safezoneW + safezoneX;
		y = 0.619005 * safezoneH + safezoneY;
		w = 0.300001 * safezoneW;
		h = 0.0659743 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		onLBSelChanged = __EVAL("[4] execVM '"+CPPATH+"configs\dialogs\gearPanel\uniformPanel_cmd.sqf'");
	};
	class CP_uniformPanelUniforms: CP_RscCombo
	{
		idc = 5;
		text = "Uniforms"; //--- ToDo: Localize;
		x = 0.43201 * safezoneW + safezoneX;
		y = 0.704009 * safezoneH + safezoneY;
		w = 0.300001 * safezoneW;
		h = 0.0659743 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		onLBSelChanged = __EVAL("[5] execVM '"+CPPATH+"configs\dialogs\gearPanel\uniformPanel_cmd.sqf'");
	};
		class CP_NVTittle: CP_rscText
	{
		idc = -1;

		text = "N/V:"; //--- ToDo: Localize;
		x = 0.270534 * safezoneW + safezoneX;
		y = 0.27899 * safezoneH + safezoneY;
		w = 0.152977 * safezoneW;
		h = 0.0680031 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class CP_gogglesTittle: CP_rscText
	{
		idc = -1;

		text = "Goggles:"; //--- ToDo: Localize;
		x = 0.270534 * safezoneW + safezoneX;
		y = 0.448998 * safezoneH + safezoneY;
		w = 0.152977 * safezoneW;
		h = 0.0680031 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class CP_headgearTittle: CP_rscText
	{
		idc = -1;

		text = "Head Gear:"; //--- ToDo: Localize;
		x = 0.270534 * safezoneW + safezoneX;
		y = 0.363994 * safezoneH + safezoneY;
		w = 0.152977 * safezoneW;
		h = 0.0680031 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class CP_vestTittle: CP_rscText
	{
		idc = -1;

		text = "Vest:"; //--- ToDo: Localize;
		x = 0.270534 * safezoneW + safezoneX;
		y = 0.534002 * safezoneH + safezoneY;
		w = 0.152977 * safezoneW;
		h = 0.0680031 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class CP_backpackTittle: CP_rscText
	{
		idc = -1;

		text = "Backpack:"; //--- ToDo: Localize;
		x = 0.270534 * safezoneW + safezoneX;
		y = 0.619005 * safezoneH + safezoneY;
		w = 0.152977 * safezoneW;
		h = 0.0680031 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
	};
	class CP_uniformsTittle: CP_rscText
	{
		idc = -1;

		text = "Uniforms:"; //--- ToDo: Localize;
		x = 0.270534 * safezoneW + safezoneX;
		y = 0.704009 * safezoneH + safezoneY;
		w = 0.152977 * safezoneW;
		h = 0.0680031 * safezoneH;
		sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
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