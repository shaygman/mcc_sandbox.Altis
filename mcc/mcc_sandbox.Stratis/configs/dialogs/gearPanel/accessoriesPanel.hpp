class CP_ACCESPANEL {
	  idd = -1;
	  movingEnable = false;
	  onLoad =  __EVAL("_this execVM '"+CPPATH+"configs\dialogs\gearPanel\accessPanel_init.sqf'");
	  
	  controlsBackground[] = 
	  {
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
		CP_uniformPanelBackButton,
		CP_accessoriesPanelOptics,
		CP_accessoriesPanelBarrel,
		CP_accessoriesPanelAttachment,
		CP_opticsTittle,
		CP_barrelTittle,
		CP_attachmentTittle,
		CP_gearPanelPiP,
		CP_gearPanelPiPFake,
		CP_InfoText
	  };

		class CP_uniformPanelBackButton: CP_RscButtonMenu
		{
			idc = -1;
			text = "Back"; //--- ToDo: Localize;
			x = 0.631771 * safezoneW + safezoneX;
			y = 0.247099 * safezoneH + safezoneY;
			w = 0.0973958 * safezoneW;
			h = 0.0439828 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			action = __EVAL("[4] execVM '"+CPPATH+"configs\dialogs\switchDialog.sqf'");
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
		class CP_accessoriesPanelOptics: CP_RscCombo
		{
			idc = 0;
			text = "Optics"; //--- ToDo: Localize;
			x = 0.415013 * safezoneW + safezoneX;
			y = 0.312991 * safezoneH + safezoneY;
			w = 0.300001 * safezoneW;
			h = 0.0879658 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			onLBSelChanged = __EVAL("[0] execVM '"+CPPATH+"configs\dialogs\gearPanel\accessPanel_cmd.sqf'");
		};
		class CP_accessoriesPanelBarrel: CP_RscCombo
		{
			idc = 1;
			text = "Barrel"; //--- ToDo: Localize;
			x = 0.415013 * safezoneW + safezoneX;
			y = 0.465998 * safezoneH + safezoneY;
			w = 0.300001 * safezoneW;
			h = 0.0879658 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			onLBSelChanged = __EVAL("[1] execVM '"+CPPATH+"configs\dialogs\gearPanel\accessPanel_cmd.sqf'");
		};
		class CP_accessoriesPanelAttachment: CP_RscCombo
		{
			idc = 2;
			text = "Attachment"; //--- ToDo: Localize;
			x = 0.415013 * safezoneW + safezoneX;
			y = 0.619005 * safezoneH + safezoneY;
			w = 0.300001 * safezoneW;
			h = 0.0879658 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
			onLBSelChanged = __EVAL("[2] execVM '"+CPPATH+"configs\dialogs\gearPanel\accessPanel_cmd.sqf'");
		};
		class CP_opticsTittle: CP_rscText
		{
			idc = -1;

			text = "Optics:"; //--- ToDo: Localize;
			x = 0.270534 * safezoneW + safezoneX;
			y = 0.312991 * safezoneH + safezoneY;
			w = 0.127481 * safezoneW;
			h = 0.0680031 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CP_barrelTittle: CP_rscText
		{
			idc = -1;

			text = "Barrel:"; //--- ToDo: Localize;
			x = 0.270534 * safezoneW + safezoneX;
			y = 0.465998 * safezoneH + safezoneY;
			w = 0.127481 * safezoneW;
			h = 0.0680031 * safezoneH;
			sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
		};
		class CP_attachmentTittle: CP_rscText
		{
			idc = -1;

			text = "Attachments:"; //--- ToDo: Localize;
			x = 0.270534 * safezoneW + safezoneX;
			y = 0.619005 * safezoneH + safezoneY;
			w = 0.127481 * safezoneW;
			h = 0.0680031 * safezoneH;
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
			idc = 3;
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